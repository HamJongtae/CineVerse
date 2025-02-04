<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<script src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<!-- include ckeditor js -->
<script src="${pageContext.request.contextPath}/js/ckeditor.js"></script>
<script src="${pageContext.request.contextPath}/js/uploadAdapter.js"></script>
<script type="text/javascript">
	document.addEventListener('DOMContentLoaded', function() {
		const myForm = document.getElementById('insert_form');
		//이벤트 연결
		myForm.onsubmit = function() {
			const items = document.querySelectorAll('.input-check');
			for (let i = 0; i < items.length; i++) {
				if (items[i].value.trim() == '') {
					const label = document.querySelector('label[for="'
							+ items[i].id + '"]');
					alert(label.textContent + ' 항목은 필수 입력입니다!');
					items[i].value = '';
					items[i].focus();
					return false;
				}
			}
		};
	});
</script>
<div class="page-container">
    <h2>영화관 및 상영관 등록</h2>
    <div class="insert_cinema_form">
        <form:form action="adminCinemaForm" method="post"
                   enctype="multipart/form-data" id="insert_form"
                   modelAttribute="cinemaVO">
            <ul>
                <li><form:label path="c_branch">지점명</form:label> <form:input
                        path="c_branch" id="c_branch" maxlength="100"
                        cssClass="input-check" /></li>
                <li><form:label path="c_location">지역</form:label> <form:select
                        path="c_location">
                        <form:option value="">지역 선택</form:option>
                        <form:option value="1">서울</form:option>
                        <form:option value="2">경기</form:option>
                        <form:option value="3">인천</form:option>
                        <form:option value="4">강원</form:option>
                        <form:option value="5">대전/충청</form:option>
                        <form:option value="6">경상</form:option>
                        <form:option value="7">광주/전라</form:option>
                    </form:select></li>
                <li><form:label path="c_address">주소</form:label> <form:input
                        path="c_address" type="text" class="input-check"
                        placeholder="주소를 입력하세요" /> <input type="button"
                        onclick="execDaumPostcode()" value="우편번호 찾기" class="default-btn" />
                </li>
                <li><form:label path="c_phone">전화번호</form:label> <form:input
                        path="c_phone" id="c_phone" cssClass="input-check" /></li>
                <li><form:label path="c_parkable">주차</form:label> <form:select
                        path="c_parkable">
                        <form:option value="1">가능</form:option>
                        <form:option value="0">불가능</form:option>
                    </form:select></li>

            <!-- 상영관 등록 부분 -->
            </ul>
            

            <h3>상영관 등록</h3>
            <div id="theater-section">
                <!-- 초기 상영관 폼 하나는 서버에서 렌더링하거나, JavaScript로 추가 가능 -->
            </div>
            <button type="button" onclick="addTheaterForm()">상영관 추가</button>

            <div class="btn_display_set">
                <form:button id="submit_btn">등록하기</form:button>
            </div>
            
        </form:form>
    </div>
</div>

<script>
    var theaterCount = 0;

    function addTheaterForm() {
        var theaterSection = document.getElementById('theater-section');
        var newTheaterForm = document.createElement('div');
        newTheaterForm.classList.add('theater-form');
        newTheaterForm.innerHTML = '';
        newTheaterForm.innerHTML += '<h4>' + (theaterCount + 1) + '번 상영관</h4>';
        newTheaterForm.innerHTML+= '<label>상영관 이름</label>';
        newTheaterForm.innerHTML+= '<input type="text" name="theaterList['+theaterCount+'].th_name" class="input-check" required>';
        theaterSection.appendChild(newTheaterForm);
        theaterCount++;
    }
</script>

<!-- 우편번호 시작 -->
<!-- iOS에서는 position:fixed 버그가 있음, 적용하는 사이트에 맞게 position:absolute 등을 이용하여 top,left값 조정 필요 -->
<div id="layer"
	style="display: none; position: fixed; overflow: hidden; z-index: 1; -webkit-overflow-scrolling: touch;">
	<img src="//t1.daumcdn.net/postcode/resource/images/close.png"
		id="btnCloseLayer"
		style="cursor: pointer; position: absolute; right: -3px; top: -3px; z-index: 1"
		onclick="closeDaumPostcode()" alt="닫기 버튼">
</div>

<script
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
		// 우편번호 찾기 화면을 넣을 element
		var element_layer = document.getElementById('layer');

		function closeDaumPostcode() {
			// iframe을 넣은 element를 안보이게 한다.
			element_layer.style.display = 'none';
		}

		function execDaumPostcode() {
			new daum.Postcode(
					{
						oncomplete : function(data) {
							// 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

							// 각 주소의 노출 규칙에 따라 주소를 조합한다.
							// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
							var addr = ''; // 주소 변수
							var extraAddr = ''; // 참고항목 변수

							//사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
							if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
								addr = data.roadAddress;
							} else { // 사용자가 지번 주소를 선택했을 경우(J)
								addr = data.jibunAddress;
							}

							// 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
							if (data.userSelectedType === 'R') {
								// 법정동명이 있을 경우 추가한다. (법정리는 제외)
								// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
								if (data.bname !== ''
										&& /[동|로|가]$/g.test(data.bname)) {
									extraAddr += data.bname;
								}
								// 건물명이 있고, 공동주택일 경우 추가한다.
								if (data.buildingName !== ''
										&& data.apartment === 'Y') {
									extraAddr += (extraAddr !== '' ? ', '
											+ data.buildingName
											: data.buildingName);
								}
								// 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
								if (extraAddr !== '') {
									extraAddr = ' (' + extraAddr + ')';
								}
								//(주의)address1에 참고항목이 보여지도록 수정
								// 조합된 참고항목을 해당 필드에 넣는다.
								//(수정) document.getElementById("address2").value = extraAddr;

							}
							//(수정) else {
							//(수정)    document.getElementById("address2").value = '';
							//(수정) }

							//(수정) + extraAddr를 추가해서 address1에 참고항목이 보여지도록 수정
							document.getElementById("c_address").value = addr
									+ extraAddr;
							// 커서를 상세주소 필드로 이동한다.
							document.getElementById("c_phone").focus();

							// iframe을 넣은 element를 안보이게 한다.
							// (autoClose:false 기능을 이용한다면, 아래 코드를 제거해야 화면에서 사라지지 않는다.)
							element_layer.style.display = 'none';
						},
						width : '100%',
						height : '100%',
						maxSuggestItems : 5
					}).embed(element_layer);

			// iframe을 넣은 element를 보이게 한다.
			element_layer.style.display = 'block';

			// iframe을 넣은 element의 위치를 화면의 가운데로 이동시킨다.
			initLayerPosition();
		}

		// 브라우저의 크기 변경에 따라 레이어를 가운데로 이동시키고자 하실때에는
		// resize이벤트나, orientationchange이벤트를 이용하여 값이 변경될때마다 아래 함수를 실행 시켜 주시거나,
		// 직접 element_layer의 top,left값을 수정해 주시면 됩니다.
		function initLayerPosition() {
			var width = 300; //우편번호서비스가 들어갈 element의 width
			var height = 400; //우편번호서비스가 들어갈 element의 height
			var borderWidth = 5; //샘플에서 사용하는 border의 두께

			// 위에서 선언한 값들을 실제 element에 넣는다.
			element_layer.style.width = width + 'px';
			element_layer.style.height = height + 'px';
			element_layer.style.border = borderWidth + 'px solid';
			// 실행되는 순간의 화면 너비와 높이 값을 가져와서 중앙에 뜰 수 있도록 위치를 계산한다.
			element_layer.style.left = (((window.innerWidth || document.documentElement.clientWidth) - width) / 2 - borderWidth)
					+ 'px';
			element_layer.style.top = (((window.innerHeight || document.documentElement.clientHeight) - height) / 2 - borderWidth)
					+ 'px';
		}
	</script>
<!-- 우편번호 끝 -->
</div>
