<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>이채원 final</title>
<link type="text/css" rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jsgrid/1.5.3/jsgrid-theme.min.css" />
<link type="text/css" rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jsgrid/1.5.3/jsgrid.min.css" />
</head>
<body>
<div style="display:flex;">
<div id="authgrid" style="flex:1;"></div>
<div id="groupgrid" style="flex:1"></div>
</div>
<div id="jsgrid"></div>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jsgrid/1.5.3/jsgrid.min.js"></script>
<script>

function dataInitialize(){
	group = ${groupList};
	auth= ${crudList};
	map= ${mapList};
}

$(document).ready(function() {
	
	var count=0;
	dataInitialize();
	
	var authTypeList = [	//권한 종류
        {	ItemName: "예산",	authCode: "auth_code1"	},
        {	ItemName: "실적",	authCode: "auth_code2"	},
        {	ItemName: "구매",	authCode: "auth_code3"	},
        {	ItemName: "인사",	authCode: "auth_code4"	},
        {	ItemName: "권한", authCode: "auth_code5"	},
    ];
	
	var crud=[  //crud yes no
		{ItemName: "예",		TypeCode: "1"	},
		{ItemName: "아니오",	TypeCode: "0"	}
	];
	
	$("#groupgrid").jsGrid({ //group
		width: "100%", 
		height: "400px",
		sorting: true,
		filtering		:	false,
        editing			:	false,
        inserting		:	true,
        autoload		:	true,
        data			:	group,
        paging			:	true,
        pageSize		: 	7,
	    pageButtonCount	:   5,
        deleteConfirm	:	"삭제하시겠습니까?",
        noDataContent	:	"그룹 정보를 추가해 주십시오.",
        rowClick: function(args) {
        	console.log(args);
        	var id= Object.values(args)[0].id;
        	console.log(id);
        },
        controller		:{
        	insertItem		:	function(args){
        		console.log("group insert");
        		$.ajax({ //data를 컨트롤러로 넘겨준다 
        			contentType : 'application/json',
        			dataType: "json",
        			data: JSON.stringify(args),
        			url: "/groupAction", 
        			type: "POST",
        			success: function(data){
        				if(data){
        					console.log("succeed");
        					dataInitialize();
        					}
        				}
        			});
        		
        		},
       		deleteItem		:	function(args){
           		console.log("group delete");
           		//catch the ID and delete from DB
           		var val= args[Object.keys(args)[1]];
          		console.log(val);
          		console.log(typeof(val));
          		//catch the ID and delete from DB
          		$.ajax({ //data를 컨트롤러로 넘겨준다 
        			dataType: "json",
        			data: val,
        			url: "/groupDeleteAction", 
        			type: "POST",
        			success: function(data){
        				if(data){
        					console.log("succeed");
        					dataInitialize();
        					}
        				}
        			});
           		}
        },
        
		fields:[
			{name: "name", type: "text", width:150},
			{name: "id", type: "text", width:150},
			{type: "control", editButton: false}
		]
	});
	
	$("#authgrid").jsGrid({
		width: "100%",
		height: "400px",
		sorting: true,
		filtering		:	false,
        editing			:	false,
        inserting		:	true,
        autoload		:	true,
        data			:	auth,
        paging			:	true,
        pageSize		: 	7,
	    pageButtonCount	: 	5,
        deleteConfirm	:	"삭제하시겠습니까?",
        noDataContent	:	"권한 정보를 입력하십시오.",
        rowClick: function(args) {
        	console.log(args);
        	var id= Object.values(args)[0].name;
        	console.log(id);
        },
        controller		:{
        	insertItem		:	function(args){
        		var val= Object.keys(args)[1]; //key == id
        		//console.log(val);
        		args[val]= count; //give a unique value to key
        		//console.log(args[val]);
        		count++;
        		console.log("auth insert");
        		console.log(JSON.stringify(args));
        		
        		$.ajax({ //data를 컨트롤러로 넘겨준다 
        			contentType : 'application/json',
        			dataType: "json",
        			data: JSON.stringify(args),
        			url: "/crudAction", 
        			type: "POST",
        			success: function(data){
        				if(data){
        					console.log("succeed");
        					dataInitialize();
        					}
        				}
        			});
        		},
       		deleteItem		:	function(args){
              		console.log("auth delete");
              		var val= args[Object.keys(args)[1]];
              		console.log(val);
              		console.log(typeof(val));
              		//catch the ID and delete from DB
              		$.ajax({ //data를 컨트롤러로 넘겨준다 
            			dataType: "json",
            			data: val,
            			url: "/crudDeleteAction", 
            			type: "POST",
            			success: function(data){
            				if(data){
            					console.log("succeed");
            					dataInitialize();
            					}
            				}
            			});
              		
              		}
        },
		
		fields:[
			{name: "name", type: "text", width:80},
			{name: "id", type: "invalid", width:80},
			{name: "auth_id", type: "select",  width:80, items: authTypeList, valueField: "authCode", textField: "ItemName",	validate: {message:	"권한 구분을 선택하세요",	validator: function(value) {return true;}}},
			{name: "c", type: "select",  width:80, items: crud, valueField: "TypeCode", textField: "ItemName",	validate: {message:	"C 권한 여부를 선택하십시오.",	validator: function(value) {return value >= 0;}}},
			{name: "r", type: "select",  width:80, items: crud, valueField: "TypeCode", textField: "ItemName",	validate: {message:	"R 권한 여부를 선택하십시오.",	validator: function(value) {return value >= 0;}}},
			{name: "u", type: "select",  width:80, items: crud, valueField: "TypeCode", textField: "ItemName",	validate: {message:	"U 권한 여부를 선택하십시오.",	validator: function(value) {return value >= 0;}}},
			{name: "d", type: "select",  width:80, items: crud, valueField: "TypeCode", textField: "ItemName",	validate: {message:	"D 권한 여부를 선택하십시오.",	validator: function(value) {return value >= 0;}}},
			{type: "control", editButton: false}
		]
	});
	
	$("#jsgrid").jsGrid({ //권한 클릭 시 테이블에 권한-사번 mapping 띄우기
		width: "100%",
		height: "400px",
		sorting: true,
		filtering		:	false,
        editing			:	false,
        inserting		:	true,
        autoload		:	true,
        data			:	map,
        paging			:	true,
        pageSize		: 	7,
	    pageButtonCount	: 	5,
        deleteConfirm	:	"삭제하시겠습니까?",
        noDataContent	:	"권한을 선택하십시오.",
        controller		:{
        	insertItem		:	function(args){
        		console.log("map insert");
        		$.ajax({ //data를 컨트롤러로 넘겨준다 
        			contentType : 'application/json',
        			dataType: "json",
        			data: JSON.stringify(args),
        			url: "/mapAction", 
        			type: "POST",
        			success: function(data){
        				if(data){
        					console.log("succeed");
        					dataInitialize();
        					}
        				}
        			});
        		},
       		deleteItem		:	function(args){
              		console.log("map delete");
              		//catch the ID and delete from DB
              		var val= args[Object.keys(args)[1]]; //사번
              		console.log(val);
              		console.log(typeof(val));
              		//catch the ID and delete from DB
              		$.ajax({ //data를 컨트롤러로 넘겨준다 
            			dataType: "json",
            			data: val,
            			url: "/mapDeleteActionGroup", 
            			type: "POST",
            			success: function(data){
            				if(data){
            					console.log("succeed");
            					dataInitialize();
            					}
            				}
            			});
              		}
        },
		
		fields:[
			{name: "auth", type: "text", width:150 }, 
			{name: "group_id", type: "text", width:150}, 
			{type: "control", editButton: false}
		]
	});
});
</script>
</body>
</html>