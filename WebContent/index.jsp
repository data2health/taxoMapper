<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>taxoMapper 1.0</title>
<style type="text/css" media="all">
@import "<util:applicationRoot/>/resources/style.css";
</style>
</head>
<body>
	<div id="content"><jsp:include page="/header.jsp" flush="true" />
		<jsp:include page="/menu.jsp" flush="true"><jsp:param
				name="caller" value="research" /></jsp:include>
		<div id="centerCol">
			Initial deployment of an app supporting creation of a taxonomy from
			CD2H research warehouse data and subsequent indexing in Lucene.

			<div id="contentBlock">
				<div id="contentBlock2">
					<h2>Facet Taxonomy</h2>
                    <jsp:include page="node.jsp" flush="true" />
				</div>
				<div id="contentBlock2">
					<h2>Indexing Calls</h2>
					<sql:query var="schemas" dataSource="jdbc/taxoMapper">
                        select distinct schema_name from taxonomy.entity order by 1;
                    </sql:query>
					<c:forEach items="${schemas.rows}" var="schema">
						<h3>${schema.schema_name }</h3>
	                    <sql:query var="tables" dataSource="jdbc/taxoMapper">
	                        select distinct table_name from taxonomy.entity where schema_name = ? order by 1;
	                        <sql:param>${schema.schema_name}</sql:param>
	                    </sql:query>
	                    <c:forEach items="${tables.rows}" var="table">
	                        <h4>${table.table_name }</h4>
	                        <sql:query var="entities" dataSource="jdbc/taxoMapper">
	                            select distinct path
	                            from taxonomy.entity natural join  taxonomy.mapping natural join taxonomy.facet
	                            where schema_name = ? and table_name = ? and attribute_name is null
	                            order by 1;
	                            <sql:param>${schema.schema_name}</sql:param>
                                <sql:param>${table.table_name}</sql:param>
	                        </sql:query>
	                        <ol class="bulletedList">
	                        <c:forEach items="${entities.rows}" var="entity">
	                            <li>${entity.path }</li>
	                        </c:forEach>
	                        </ol>
	                    </c:forEach>
					</c:forEach>
				</div>
			</div>
			<jsp:include page="/footer.jsp" flush="true" />
		</div>
	</div>
</body>
</html>

