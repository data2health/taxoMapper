<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

 <sql:query var="rows" dataSource="jdbc/taxoMapper">
     insert into taxonomy.entity(database_name,schema_name,table_name,attribute_name,value) values(?,?,?,?,?) returning eid;
     <sql:param>${param.database}</sql:param>
     <sql:param>${param.schema}</sql:param>
     <sql:param>${param.table}</sql:param>
     <sql:param>${param.attribute}</sql:param>
     <sql:param>${param.value}</sql:param>
 </sql:query>
 <c:forEach items="${rows.rows}" var="row">
     <c:redirect url="map.jsp?database=${param.database}&schema=${param.schema}&table=${param.table}&attribute=${param.attribute}&value=${param.value}&eid=${row.eid }"/>
</c:forEach>
