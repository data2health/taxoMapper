<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<c:choose>
	<c:when test="${empty param.slot0 and empty param.slot1 and empty param.slot2}">
		<sql:query var="slot0s" dataSource="jdbc/taxoMapper">
			select fid,path,slot0
			from taxonomy.facet
			where slot0 is not null and slot1 is null
			order by 3;
		</sql:query>
		<ol class="bulletedList">
		<c:forEach items="${slot0s.rows}" var="row" varStatus="rowCounter">
				<li>${row.slot0}
				<jsp:include page="node.jsp" flush="true">
					<jsp:param name="slot0" value="${row.slot0}" />
				</jsp:include>
				</li>
		</c:forEach>
		</ol>
	</c:when>
	<c:when test="${not empty param.slot0 and empty param.slot1}">
		<sql:query var="slot1s" dataSource="jdbc/taxoMapper">
			select fid,path,slot1
			from taxonomy.facet
			where slot0=? and slot1 is not null and slot2 is null
			order by 3;
			<sql:param>${param.slot0}</sql:param>
		</sql:query>
		<ol class="bulletedList">
		<c:forEach items="${slot1s.rows}" var="row" varStatus="rowCounter">
				<li>${row.slot1}
 				<jsp:include page="node.jsp" flush="true">
					<jsp:param name="slot0" value="${param.slot0}" />
					<jsp:param name="slot1" value="${row.slot1}" />
				</jsp:include>
				</li>
		</c:forEach>
		</ol>
	</c:when>
	<c:when test="${not empty param.slot0 and not empty param.slot1 and empty param.slot2}">
		<sql:query var="slot2s" dataSource="jdbc/taxoMapper">
			select fid,path,slot2
			from taxonomy.facet
			where slot0=? and slot1=? and slot2 is not null and slot3 is null
			order by 3;
			<sql:param>${param.slot0}</sql:param>
			<sql:param>${param.slot1}</sql:param>
		</sql:query>
		<ol class="bulletedList">
		<c:forEach items="${slot2s.rows}" var="row" varStatus="rowCounter">
				<li>${row.slot2}
 				</li>
		</c:forEach>
		</ol>
	</c:when>
</c:choose>
