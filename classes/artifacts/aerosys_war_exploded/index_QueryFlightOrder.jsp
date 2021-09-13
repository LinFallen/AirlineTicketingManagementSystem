<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="cn.jmu.po.ExFlight"%>
<%@ page import="java.util.*"%>
<%@ page import="cn.jmu.po.ExFlightProduct" %>
<%@ page import="java.sql.Time"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>机票查询</title>
<link rel="stylesheet" type="text/css" href="css/queryResult1.css">
</head>
<body>
<div id="header">
	<a href="index.jsp"><img alt="brand" src="img/brand.png"></a>
	<span id="personal">
		<a class="entrance" href="login.jsp">登录 </a>
		<a class="entrance" href="addUser.jsp">注册</a>
	</span>	
</div>

<div id="menubar">
	<div class="dropdown">
		<a href="index.jsp"><button class="dropbt">首页</button></a>
	</div>	

	<div class="dropdown">
		<button class="dropbt">云朵会员</button>
		<div class="content">
			<a href="#">我的账户</a>
			<a href="#">我的订单</a>

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
		List<ExFlight> allExFlightAndProduct=null;
		String exFlightDate=null;
		String departCity=null;
		String arriveCity=null;
		if(session.getAttribute("allExFlightAndProduct")==null&&request.getAttribute("exFlightDate")==null){
			%><jsp:forward page="exit2.do"></jsp:forward><%
		}
		if(session.getAttribute("allExFlightAndProduct")==null){
			allExFlightAndProduct=(List<ExFlight>)request.getAttribute("allExFlightAndProduct");
			exFlightDate=(String)request.getAttribute("exFlightDate");		
			departCity=(String)request.getAttribute("departCity");
			arriveCity=(String)request.getAttribute("arriveCity");
			session.setAttribute("allExFlightAndProduct", allExFlightAndProduct);
			session.setAttribute("exFlightDate", exFlightDate);
			session.setAttribute("departCity", departCity);
			session.setAttribute("arriveCity", arriveCity);
		}else{
			allExFlightAndProduct=(List<ExFlight>)session.getAttribute("allExFlightAndProduct");
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
	<%	
  		int pages;
	 	if(request.getParameter("page")==null){
	 		pages=1;
	 	}else{
	 		pages=Integer.parseInt(request.getParameter("page"));
	 		if(pages<=0)
	 			pages=1;
	 	}
	 	int rowCount = allExFlightAndProduct.size();
		int pageSize = 6;
		int pageCount = (rowCount+pageSize-1)/pageSize;	
		if(pages>pageCount){
			pages = pageCount;
		}
		int n=(pages-1)*pageSize;
 		while (n<pageSize*pages&&n<rowCount&&rowCount!=0){%>
	<div  class="yourSelect">
		<% 	
			String preDepartTime= allExFlightAndProduct.get(n).getFlight().getPreDepartTime().toString();
			String totalTime=allExFlightAndProduct.get(n).getFlight().getPreTotalTime();
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
			List<ExFlightProduct>  exFlightProduct = allExFlightAndProduct.get(n).getExFlightProduct();
			ExFlightProduct a = null;
			ExFlightProduct b = null;
			ExFlightProduct c = null;
			for(int i=0;i<exFlightProduct.size();++i){
				if(exFlightProduct.get(i).getFlightProductID().equals("A")){
					a = exFlightProduct.get(i);
				}
				if(exFlightProduct.get(i).getFlightProductID().equals("B")){
					b = exFlightProduct.get(i);
				}
				if(exFlightProduct.get(i).getFlightProductID().equals("C")){
					c = exFlightProduct.get(i);
				}
			}
		%>
	<form action="#" method="post">
		<table>
			<tr>
				<td><input type="hidden" name="departTime<%=n%>>"><%=allExFlightAndProduct.get(n).getFlight().getPreDepartTime()%></td>
				<td><input type="hidden" value="exFlightID<%=n%>"><%=allExFlightAndProduct.get(n).getFlightID()%></td>
				<td><input type="hidden" name="arriveTime<%=n%>"><%=t.toString()%></td>
				<td>头等舱(<%=c.getLeftTicketNum()%>)</td><td>商务舱(<%=b.getLeftTicketNum() %>)</td><td>经济舱(<%=a.getLeftTicketNum() %>)</td>
			</tr>
			<tr>
				<td><input type="hidden" name="departCity<%=n%>"><%=allExFlightAndProduct.get(n).getFlight().getDepartCity()%></td>
				<td><input type="hidden" name="totalTime<%=n%>"><%=allExFlightAndProduct.get(n).getFlight().getPreTotalTime().toString()%></td>
				<td><input type="hidden" name="arriveCity<%=n%>"><%=allExFlightAndProduct.get(n).getFlight().getArriveCity()%></td>
				<td><input type="radio" name="flihgtProductID<%=n%>" value="C">￥<input type="hidden" name="priceC<%=n%>" value="<%=c.getPrice() %>"><%=c.getPrice() %>
				<br/><input type="hidden" name="pointPricCe<%=n%>" value="<%=c.getPointPrice()%>">积分价格:<%=c.getPointPrice()%></td>                                       
				<td><input type="radio" name="flihgtProductID<%=n%>" value="B">￥<input type="hidden" name="priceB<%=n%>" value="<%=b.getPrice() %>"><%=b.getPrice() %>
				<br/><input type="hidden" name="pointPriceB<%=n%>" value="<%=b.getPointPrice()%>">积分价格:<%=b.getPointPrice()%></td>
				<td><input type="radio" name="flihgtProductID<%=n%>" value="A">￥<input type="hidden" name="priceA<%=n%>" value="<%=a.getPrice() %>"><%=a.getPrice() %>
				<br/><input type="hidden" name="pointPriceA<%=n%>" value="<%=a.getPointPrice()%>">积分价格:<%=a.getPointPrice()%></td>
				<td rowspan="2"><input type="button" value="提交" onclick="click1()"/></td>
			</tr>
		</table>
	</form>
	<%n++; }%>
		<form method="get" action="#"> 
			<p align="center">第<%=pages%>页 共<%=pageCount%>页 共<%=rowCount%>条 
			<%
			if(pageCount>1){%>
				<a href="index_QueryFlightOrder.jsp?page=<%=pages-1%>">上一页</a>
				<a href="index_QueryFlightOrder.jsp?page=<%=pages+1%>">下一页</a>
				<a href="index_QueryFlightOrder.jsp?page=<%=pageCount%>">尾页</a>
				跳到第<input type="text" name="page" size="4">页
				<input type="submit" name="submit" size="4" value="GO">
			<%}%> </p>
		</form>
	</div>
</div>
</body>
<script type="text/javascript">
	function click1(){
		alert("请先登录");
	}
</script>
</html>