<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<!-- 자주 묻는 질문 -->
<div id="support_main" class="">
	<h3>🤔 자주 찾는 질문</h3>
	<div class="faq-sub-info">
		회원님들께서 가장 자주하시는 질문을 모았습니다.<br>
		궁금하신 내용에 대해 검색해보세요.
	</div>
	<div class="support-search">
		<div class="search">
			<form action="faq" id="faq_search_form" method="get" style="margin-left: auto;">
			<input type="hidden" name="" value="">
			<input type="search" class="search-input" name="keyword" placeholder="검색어를 입력해 주세요" value="${param.keyword}">
			<button type="submit" class="search-button" aria-label="검색하기">검색</button>
			<%--<input type="image" src="${pageContext.request.contextPath}/images/kbm/search.png" width="20" alt="검색"> --%>
            </form>
        </div>
	</div>
	<table class="faq-table">
		<tr>
			<td class="faq-table-num">번호</td>
			<td class="faq-table-title">제목</td>
			<td class="faq-table-rdate">등록일</td>
			<td class="faq-table-hit">조회수</td>
		</tr>
		<c:if test="${count == 0}">
		<tr>
			<td colspan="5">
				<div style=" height:250px; display:flex; align-items:center; justify-content: center;">글이 존재하지 않습니다.</div>
			</td>
		</tr>
		</c:if>
		
		<c:if test="${count > 0}">
			<c:forEach var="faq" items="${list}">
			<tr>
				<td class="faq-table-num">${faq.f_num}</td>
				<td class="faq-table-title">
				 <c:choose>
                    <c:when test="${fn:length(faq.f_title) > 40}">
                        <a href="faqDetail?f_num=${faq.f_num}">${fn:substring(faq.f_title, 0, 40)}...</a>
                    </c:when>
                    <c:otherwise>
                        <a href="faqDetail?f_num=${faq.f_num}">${faq.f_title}</a>
                    </c:otherwise>
                </c:choose>
				</td>
				<td class="faq-table-rdate">${faq.f_reg_date}</td>
				<td class="faq-table-hit">${faq.f_hit}</td>
			</tr>
			</c:forEach>
		</c:if>	
	</table>
	<div class="align-center page-div">
			${page}
	</div>
</div>