<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%-- /////////////////////// EL / JSTL �������� �ּ� ó�� ////////////////////////
<%@ page import="java.util.*"  %>
<%@ page import="com.model2.mvc.service.domain.Product" %>
<%@ page import="com.model2.mvc.common.*" %>
<%@page import="com.model2.mvc.common.util.CommonUtil"%>


<%
	System.out.println("����..... : "+request.getAttribute("list"));
	List<Purchase> list= (List<Purchase>)request.getAttribute("list");
	Page resultPage=(Page)request.getAttribute("resultPage");
	
	Search search = (Search)request.getAttribute("search");
	//==> null �� ""(nullString)���� ����
	String searchCondition = CommonUtil.null2str(search.getSearchCondition());
	String searchKeyword = CommonUtil.null2str(search.getSearchKeyword());
%>
/////////////////////// EL / JSTL �������� �ּ� ó�� //////////////////////// --%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="menu" value="request.param.menu" scope="page"/>

<html>
<head>
<title>���� �����ȸ</title>

<link rel="stylesheet" href="/css/admin.css" type="text/css">

<script type="text/javascript">
<!--// �˻� / page �ΰ��� ��� ��� Form ������ ���� JavaScrpt �̿�  
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
					<td width="93%" class="ct_ttl01">���� �����ȸ</td>
				</tr>
			</table>
		</td>
		<td width="12" height="37"><img src="/images/ct_ttl_img03.gif"	width="12" height="37"></td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0"	style="margin-top: 10px;">
	<tr>
		<td colspan="11">��ü ${resultPage.totalCount} �Ǽ�, ���� ${resultPage.currentPage} ������</td>
	</tr>
	<tr>
		<td class="ct_list_b" width="100">No</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">ȸ��ID</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">ȸ����</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">��ȭ��ȣ</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">�����Ȳ</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">��������</td>
	</tr>
	<tr>
		<td colspan="11" bgcolor="808285" height="1"></td>
	</tr>
	<%-- /////////////////////// EL / JSTL �������� �ּ� ó�� ////////////////////////
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
		<td align="left">����
			<c:if test='<%=vo.getTranCode().equals("100")%>'>���ſϷ� </c:if>
			<c:if test='<%=vo.getTranCode().equals("200")%>'>����� </c:if>
			<c:if test='<%=vo.getTranCode().equals("300")%>'>��ۿϷ� </c:if>
			�����Դϴ�.</td>
		<td></td>
		<td align="left">
			<c:if test='<%=vo.getTranCode().equals("100")||vo.getTranCode().equals("200")%>'>
				<a href="/updateTranCode.do?tranNo=<%=vo.getTranNo()%>&tranCode=300">���ǵ���</a>
			</c:if>
		</td>
	</tr>
	<tr>
		<td colspan="11" bgcolor="D6D7D6" height="1"></td>
	</tr>
	<% } %>/////////////////////// EL / JSTL �������� �ּ� ó�� //////////////////////// --%>

	
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
			<td>���ſϷ�</td>
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
<!--  ������ Navigator �� -->

</form>

</div>
</body>
</html>
