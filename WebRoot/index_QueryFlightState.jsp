<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="cn.jmu.po.ExFlight"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.Time"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>机票查询</title>
<link rel="stylesheet" type="text/css" href="css/queryResult1_1.css">
</head>
<body>
<div id="header">
	<a href="index.jsp"><img alt="brand" src="img/brand.png"></a>
	<a class="entrance" href="login.jsp">登录 </a>
	<a class="entrance" href="addUser.jsp">注册</a>	
</div>

<div id="menubar">
	<div class="dropdown">
		<a href="index.jsp"><button class="dropbt">首页</button></a>
	</div>	

	<div class="dropdown">
		<button class="dropbt">云朵会员</button>
		<div class="content">
			<a href="myAccount.jsp">我的账户</a>
			<a href="myOrder.jsp">我的订单</a>

		</div>
	</div>
	<div class="dropdown">
		<button class="dropbt">出行帮助</button>
		<div class="content">
			<a href="rules.jsp">购票服务</a>

		</div>
	</div>
<hr>
</div>
<div id="middle">
	<% 
		List<ExFlight> allExFlight=null;
		String exFlightDate=null;
		String departCity=null;
		String arriveCity=null;
		if(session.getAttribute("allExFlight")==null&&request.getAttribute("exFlightDate")==null){
			%><jsp:forward page="exit2.do"></jsp:forward><%
		}
		if(session.getAttribute("allExFlight")==null){
			allExFlight=(List<ExFlight>)request.getAttribute("allExFlight");
			exFlightDate=(String)request.getAttribute("exFlightDate");		
			departCity=(String)request.getAttribute("departCity");
			arriveCity=(String)request.getAttribute("arriveCity");
			session.setAttribute("allExFlight", allExFlight);
			session.setAttribute("exFlightDate", exFlightDate);
			session.setAttribute("departCity", departCity);
			session.setAttribute("arriveCity", arriveCity);
		}else{
			allExFlight=(List<ExFlight>)session.getAttribute("allExFlight");
			exFlightDate=(String)session.getAttribute("exFlightDate");		
			departCity=(String)session.getAttribute("departCity");
			arriveCity=(String)session.getAttribute("arriveCity");
		}
	%>
	<div class="yourSelect">
		<h3>单程</h3>
		<label>出发城市:<span style="color:blue"><%=departCity %></span>
		&nbsp;&nbsp;到达城市:<span style="color:blue"><%=arriveCity %></span>&nbsp;&nbsp;
		出发日期:<span style="color:blue"><%=exFlightDate %></span></label>
	</div>
	<hr/>
	<div class="yourSelect">
		<table>
			<tr><td>航班号</td><td>航程</td><td>日期</td><td>起飞时间</td><td>到达时间</td><td>航班状态</td></tr>
			<%	int pages;
			 	if(request.getParameter("page")==null){
			 		pages=1;
			 	}else{
			 		pages=Integer.parseInt(request.getParameter("page"));
			 		if(pages<=0)
			 			pages=1;
			 	}
			 	int rowCount = allExFlight.size();
				int pageSize = 6;
				int pageCount = (rowCount+pageSize-1)/pageSize;	
				if(pages>pageCount){
					pages = pageCount;
				}
				int n=(pages-1)*pageSize;
		 		while (n<pageSize*pages&&n<rowCount&&rowCount!=0){%>
				<tr>
				<% 	
					String preDepartTime= allExFlight.get(n).getFlight().getPreDepartTime().toString();
					String totalTime=allExFlight.get(n).getFlight().getPreTotalTime();
					String[] timeList1 = preDepartTime.split(":");
					String[] timeList2 = totalTime.split(":");
					String preArriveTime ="";
					for(int i=0;i<timeList1.length;++i) {
						timeList1[i] = String.valueOf(Integer.valueOf(timeList1[i])+Integer.valueOf(timeList2[i]));
						preArriveTime += timeList1[i];
						if(i!=2) {
							preArriveTime += ":";
						}
					}
					Time t = Time.valueOf(preArriveTime);
				%>
				<td><%=allExFlight.get(n).getFlightID()%></td>
				<td><%=allExFlight.get(n).getFlight().getDepartCity()%>-<%=allExFlight.get(n).getFlight().getArriveCity()%></td>
				<td><%=allExFlight.get(n).getExFlightDate()%></td>
				<td>预计:<%=allExFlight.get(n).getDepartTime().toString() %></td>
				<td>预计:<%=allExFlight.get(n).getArriveTime().toString()%></td>
				<%if(allExFlight.get(n).getFlightState().getFlightStateContext().equals("计划")){ %>
				<td>计划</td><%}else if(allExFlight.get(n).getFlightState().getFlightStateContext().equals("起飞")){%>
				<td>起飞</td><%}else if(allExFlight.get(n).getFlightState().getFlightStateContext().equals("延误")){%>
				<td>延误</td><%}else if(allExFlight.get(n).getFlightState().getFlightStateContext().equals("取消")){%>
				<td>取消</td><%}%>
				</tr>
				<tr>
					<td></td><td></td><td><td>计划:<%=allExFlight.get(n).getFlight().getPreDepartTime().toString()%></td>
					<td>计划:<%=t.toString()%></td>
				</tr>
			<%n++;}%>
		</table>
		<form method="get" action="#"> 
			<p align="center">第<%=pages%>页 共<%=pageCount%>页 共<%=rowCount%>条 
			<%
			if(pageCount>1){%>
				<a href="index_QueryFlightState.jsp?page=<%=pages-1%>">上一页</a>
				<a href="index_QueryFlightState.jsp?page=<%=pages+1%>">下一页</a>
				<a href="index_QueryFlightState.jsp?page=<%=pageCount%>">尾页</a>
				跳到第<input type="text" name="page" size="4">页
				<input type="submit" name="submit" size="4" value="GO">
			<%}%> </p>
		</form>
	</div>
</div>
</body>
</html>