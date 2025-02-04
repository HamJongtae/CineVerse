<%@ page language="java" contentType="text/html; charset=UTF-8"
	    pageEncoding="UTF-8"%>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
	
	<script src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
<script src="${pageContext.request.contextPath}/js/product.fav.js"></script>
	<!-- 벌스샵 디테일 시작 -->
	<div class="main_content">
	    <div class="product-main">
	        <div class="product-img">
	            <img src="${pageContext.request.contextPath}/upload/${product.p_filename}">
	        </div>
	        <div class="product-info">
	        	<h1>
					<c:if test="${product.p_category == 1}"> MARVEL </c:if>
					<c:if test="${product.p_category == 2}"> DISNEY </c:if>
					<c:if test="${product.p_category == 3}"> DISNEY PRINCESS </c:if>
					<c:if test="${product.p_category == 4}"> PIXAR </c:if>
					<c:if test="${product.p_category == 5}"> Studio GHIBLI </c:if>
					<c:if test="${product.p_category == 6}"> Warner Bros. </c:if>
					<c:if test="${product.p_category == 7}"> Universal Studio </c:if>
					<c:if test="${product.p_category == 8}"> ETC </c:if>
				</h1>
	            <p>
	            <c:if test="${product.p_quantity==0}">
	            <span style="color:#FF5151;">(품절)</span>
	            </c:if>
	            ${product.p_name}
	            </p>
	            <span class="product-price">${product.p_price}</span>원
	            <div class="buy-form">
	                <form id="productForm" action="${pageContext.request.contextPath}/shop/addToCartOrBuyNow" method="post">
					    <input type="hidden" id="p_num" name="p_num" value="${product.p_num}">
					    <span>수량</span>
					    <div class="quantity-controls">
					        <button type="button" class="quantity-down">-</button>
					        <input type="number" id="pb_quantity" name="pb_quantity" min="1" value="1" max="100" readonly class="quantity-input"/>
					        <button type="button" class="quantity-up">+</button>
					    </div>
					    <div class="showPrice">
					        총 상품 금액 <span>${product.p_price}</span>원
					    </div>
					    <div class="shop-submit">
					        <button id="output_fav" data-num="${product.p_num}"><span class="fav">♡</span> 관심 상품 <span class="output_fcount"> </span></button>
					        <button id="addToCartBtn" type="submit" data-action="addToCart">장바구니</button>
					        <button id="buyNowBtn" type="submit" data-action="buyNow">바로 구매하기</button>
					    </div>
					</form>
	            </div>
	        </div>
	    </div>
	    
	    <div class="product-detail">
		     <ul>
	            <li>
	                <a href="?page=detail&p_num=${product.p_num}">
	                    <c:if test="${param.page == 'detail' || param.page == null}">
	                        <b style="color:black;">상세 정보</b>
	                    </c:if>
	                    <c:if test="${param.page != 'detail' && param.page != null}">
	                        상세 정보
	                    </c:if>
	                </a>
	            </li>
	            <li>
	                <a href="?page=review&p_num=${product.p_num}">
	                    <c:if test="${param.page == 'review'}">
	                        <b style="color:black;">리뷰</b>
	                    </c:if>
	                    <c:if test="${param.page != 'review'}">
	                        리뷰
	                    </c:if>
	                </a>
	            </li>
	            <li>
	                <a href="?page=info&p_num=${product.p_num}">
	                    <c:if test="${param.page == 'info'}">
	                        <b style="color:black;">반품/교환 정보</b>
	                    </c:if>
	                    <c:if test="${param.page != 'info'}">
	                        반품/교환 정보
	                    </c:if>
	                </a>
	            </li>
	        </ul>
	        <!-- 상세정보 -->
	        <c:if test="${param.page == 'detail' || param.page == null}">
		        <div class="product-detail-info">
		        	${product.p_content}
		        </div>
	        </c:if>
	        <!-- 리뷰 -->
	        
			

				
	        <c:if test="${param.page == 'review'}">
				<c:if test="${count==0}">
					작성된 리뷰가 없습니다.
				</c:if>
				<c:if test="${count>0}">	
					
					
			        	<div class="product-review">
			        		<div class="bookMark_box" style="margin-bottom:70px;">
			        			<br><span>사용자 총 평점</span>
			        			<div class="review-star">
									<c:if test="${review_grade>=1}"> 
			        					<img src=${pageContext.request.contextPath}/images/cje/star_yes.png class="reStar">
									</c:if>
									<c:if test="${review_grade<1}">
										<img src=${pageContext.request.contextPath}/images/cje/star_no.png class="reStar">
									</c:if>
									
									<c:if test="${review_grade>=2}"> 
			        					<img src=${pageContext.request.contextPath}/images/cje/star_yes.png class="reStar">
									</c:if>
									<c:if test="${review_grade<2}">
										<img src=${pageContext.request.contextPath}/images/cje/star_no.png class="reStar">
									</c:if>
									
									<c:if test="${review_grade>=3}"> 
			        					<img src=${pageContext.request.contextPath}/images/cje/star_yes.png class="reStar">
									</c:if>
									<c:if test="${review_grade<3}">
										<img src=${pageContext.request.contextPath}/images/cje/star_no.png class="reStar">
									</c:if>
									
									<c:if test="${review_grade>=4}"> 
			        					<img src=${pageContext.request.contextPath}/images/cje/star_yes.png class="reStar">
									</c:if>
									<c:if test="${review_grade<4}">
										<img src=${pageContext.request.contextPath}/images/cje/star_no.png class="reStar">
									</c:if>
									
									<c:if test="${review_grade>=5}"> 
										<img src=${pageContext.request.contextPath}/images/cje/star_yes.png class="reStar">
									</c:if>
									<c:if test="${review_grade<5}">
										<img src=${pageContext.request.contextPath}/images/cje/star_no.png class="reStar">
									</c:if>
									${review_grade}점
			        			</div>
			        		</div>
							<c:forEach var="review" items="${reviewList}">
								<div class="bookMark_box_1" style="margin-bottom: 20px;">
								            <div class="bk_content">
								            <div class="review_fav_date">
								            	<div class="my_photo_img">
								            		<img src="${pageContext.request.contextPath}/myPage/viewProfile?mem_num=${review.mem_num}" width="18" height="18" class="my-photo">
								            	</div>
								            	<div class="my_review_idall">
												
												<div class="my_board_type">
														<c:if test="${review.pr_grade>=1}"> 
															<img src=${pageContext.request.contextPath}/images/cje/star_yes.png class="userReStar">
														</c:if>
														<c:if test="${review.pr_grade<1}">
															<img src=${pageContext.request.contextPath}/images/cje/star_no.png class="userReStar">
														</c:if>
														
														<c:if test="${review.pr_grade>=2}"> 
															<img src=${pageContext.request.contextPath}/images/cje/star_yes.png class="userReStar">
														</c:if>
														<c:if test="${review.pr_grade<2}">
															<img src=${pageContext.request.contextPath}/images/cje/star_no.png class="userReStar">
														</c:if>
														
														<c:if test="${review.pr_grade>=3}"> 
															<img src=${pageContext.request.contextPath}/images/cje/star_yes.png class="userReStar">
														</c:if>
														<c:if test="${review.pr_grade<3}">
															<img src=${pageContext.request.contextPath}/images/cje/star_no.png class="userReStar">
														</c:if>
														
														<c:if test="${review.pr_grade>=4}"> 
															<img src=${pageContext.request.contextPath}/images/cje/star_yes.png class="userReStar">
														</c:if>
														<c:if test="${review.pr_grade<4}">
															<img src=${pageContext.request.contextPath}/images/cje/star_no.png class="userReStar">
														</c:if>
														
														<c:if test="${review.pr_grade>=5}"> 
															<img src=${pageContext.request.contextPath}/images/cje/star_yes.png class="userReStar">
														</c:if>
														<c:if test="${review.pr_grade<5}">
															<img src=${pageContext.request.contextPath}/images/cje/star_no.png class="userReStar">
														</c:if>
														 ${review.pr_grade}
								                    </div>
								                    
								                    <div class="id_regdate">
												${review.mem_id} · ${review.pr_reg_date}
												</div>
								                    </div>
								            </div>
								                <div class="my_board_bk">
								                
								                    
								                    <div class="my_boardWrite_bk">${review.pr_content}</div>
								                </div>
								                <div class="bk_delete_btn">
								                    
								                </div>
								            </div>
								            
								        </div>
								        </c:forEach>
				    		</div>
					
				</c:if>
	        </c:if>
	        <!-- 반품 교환 정모 -->
	        <c:if test="${param.page == 'info'}">
	        	<div class="deliver">
	        		<img src=${pageContext.request.contextPath}/images/cje/info_pic.png>
	        	</div>
	        </c:if>
	    </div>
	    
	</div>
	
	<script>
		document.addEventListener("DOMContentLoaded", function() {
		    const quantityInput = document.querySelector(".quantity-input");
		    const quantityDownBtn = document.querySelector(".quantity-down");
		    const quantityUpBtn = document.querySelector(".quantity-up");
		    const productPrice = document.querySelector(".product-price"); 
		    const totalPriceSpan = document.querySelector(".showPrice span"); 
		    let totalPrice = parseInt(productPrice.textContent.replace(/[^0-9]/g, '')); // 숫자만 추출하여 정수로 변환

		    // 함수: 3단위 쉼표 추가
		    function addCommas(number) {
		        return number.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
		    }

		    // 초기화 시 쉼표 추가
		    totalPriceSpan.textContent = addCommas(totalPrice);
		    productPrice.textContent = addCommas(parseInt(productPrice.textContent.replace(/[^0-9]/g, ''))); // p_price에도 적용

		    quantityDownBtn.addEventListener("click", function() {
		        const currentValue = parseInt(quantityInput.value);
		        if (currentValue > 1) {
		            quantityInput.value = currentValue - 1;
		            totalPrice -= parseInt(productPrice.textContent.replace(/[^0-9]/g, '')); 
		            totalPriceSpan.textContent = addCommas(totalPrice); 
		        }
		    });

		    quantityUpBtn.addEventListener("click", function() {
		        const currentValue = parseInt(quantityInput.value);
		        quantityInput.value = currentValue + 1;
		        totalPrice += parseInt(productPrice.textContent.replace(/[^0-9]/g, '')); 
		        totalPriceSpan.textContent = addCommas(totalPrice); 
		    });
		    

	        document.getElementById('addToCartBtn').addEventListener('click', function(e) {
	            e.preventDefault();
	            document.getElementById('productForm').setAttribute('action', '${pageContext.request.contextPath}/shop/addToCart');
	            document.getElementById('productForm').submit();
	        });

	        document.getElementById('buyNowBtn').addEventListener('click', function(e) {
	            e.preventDefault(); 
	            document.getElementById('productForm').setAttribute('action', '${pageContext.request.contextPath}/shop/buyNow');
	            document.getElementById('productForm').submit();
	        });
		});

	</script>
	<!-- 벌스샵 디테일 끝-->
