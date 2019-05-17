<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%-- /////////////////////// EL / JSTL 적용으로 주석 처리 ////////////////////////
<%@ page import="java.util.*"  %>
<%@ page import="com.model2.mvc.service.domain.Product" %>
<%@ page import="com.model2.mvc.common.*" %>
<%@page import="com.model2.mvc.common.util.CommonUtil"%>


<%
	System.out.println("제발..... : "+request.getAttribute("list"));
	List<Purchase> list= (List<Purchase>)request.getAttribute("list");
	Page resultPage=(Page)request.getAttribute("resultPage");
	
	Search search = (Search)request.getAttribute("search");
	//==> null 을 ""(nullString)으로 변경
	String searchCondition = CommonUtil.null2str(search.getSearchCondition());
	String searchKeyword = CommonUtil.null2str(search.getSearchKeyword());
%>
/////////////////////// EL / JSTL 적용으로 주석 처리 //////////////////////// --%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="menu" value="request.param.menu" scope="page"/>

<html>
<head>
<title>구매 목록조회</title>

<link rel="stylesheet" href="/css/admin.css" type="text/css">

<script type="text/javascript">
<!--// 검색 / page 두가지 경우 모두 Form 전송을 위해 JavaScrpt 이용  
function fncGetList(currentPage) {
	document.getElementById("currentPage").value = currentPage;
   	document.detailForm.submit();		
}
-->
</script>
</head>

<body bgcolor="#ffffff" text="#000000">

<div style="width: 98%; margin-left: 10px;">

<form name="detailForm" action="/listPurchase.do?" method="post">
<table width="100%" height="37" border="0" cellpadding="0"	cellspacing="0">
	<tr>
		<td width="15" height="37"><img src="/images/ct_ttl_img01.gif"width="15" height="37"></td>
		<td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left: 10px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="93%" class="ct_ttl01">구매 목록조회</td>
				</tr>
			</table>
		</td>
		<td width="12" height="37"><img src="/images/ct_ttl_img03.gif"	width="12" height="37"></td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0"	style="margin-top: 10px;">
	<tr>
		<td colspan="11">전체 ${resultPage.totalCount} 건수, 현재 ${resultPage.currentPage} 페이지</td>
	</tr>
	<tr>
		<td class="ct_list_b" width="100">No</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">회원ID</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">회원명</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">전화번호</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">배송현황</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">정보수정</td>
	</tr>
	<tr>
		<td colspan="11" bgcolor="808285" height="1"></td>
	</tr>
	<%-- /////////////////////// EL / JSTL 적용으로 주석 처리 ////////////////////////
	<% 	
		int no=list.size();
		for(int i=0; i<list.size(); i++) {
			Purchase vo = (Purchase)list.get(i);
	%>
	<tr class="ct_list_pop">
		<td align="center">
			<a href="/getPurchase.do?tranNo=<%=vo.getTranNo()%>"><%=no</a>
		</td>
		<td></td>
		<td align="left">
			<a href="/getUser.do?userId=<%=vo.getBuyer().getUserId()%>"><%=vo.getBuyer().getUserId()%></a>
		</td>
		<td></td>
		<td align="left"><%=vo.getReceiverName()%></td>
		<td></td>
		<td align="left"><%=vo.getReceiverPhone()%></td>
		<td></td>
		<td align="left">현재
			<c:if test='<%=vo.getTranCode().equals("100")%>'>구매완료 </c:if>
			<c:if test='<%=vo.getTranCode().equals("200")%>'>배송중 </c:if>
			<c:if test='<%=vo.getTranCode().equals("300")%>'>배송완료 </c:if>
			상태입니다.</td>
		<td></td>
		<td align="left">
			<c:if test='<%=vo.getTranCode().equals("100")||vo.getTranCode().equals("200")%>'>
				<a href="/updateTranCode.do?tranNo=<%=vo.getTranNo()%>&tranCode=300">물건도착</a>
			</c:if>
		</td>
	</tr>
	<tr>
		<td colspan="11" bgcolor="D6D7D6" height="1"></td>
	</tr>
	<% } %>/////////////////////// EL / JSTL 적용으로 주석 처리 //////////////////////// --%>

	
		<c:set var="i" value="0" />
		<c:forEach var="purchase" items="${list}">
		<c:set var="i" value="${ i+1 }" />
		<tr class="ct_list_pop">
			<td align="left"><a href="/getPurchase.do?tranNo=${purchase.tranNo}">${i}</a></td>
			<td></td>
			<td align="left">${purchase.buyer.userId}</td>
			<td></td>
			<td align="left">${purchase.receiverName}</td>
			<td></td>
			<td align="left">${purchase.receiverPhone}</td>
			<td></td>		
			<td>구매완료</td>
		</tr>
		<tr>
		<td colspan="11" bgcolor="D6D7D6" height="1"></td>
		</tr>
	</c:forEach>
</table>


<!-- PageNavigation Start... -->
<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>
		<td align="center">
   <input type="hidden" id="currentPage" name="currentPage" value=""/>
			
    			<jsp:include page="../common/pageNavigator.jsp"/>
    	</td>
	</tr>
</table>
<!--  페이지 Navigator 끝 -->

</form>

</div>
</body>
</html>
