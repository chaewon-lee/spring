<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>��ä�� final</title>
<link type="text/css" rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jsgrid/1.5.3/jsgrid-theme.min.css" />
<link type="text/css" rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jsgrid/1.5.3/jsgrid.min.css" />
</head>
<body>
<div style="display:flex;">
<div id="groupgrid" style="flex:1;"></div>
<div id="teamgrid" style="flex:1"></div>
</div>
<div id="jsgrid"></div>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jsgrid/1.5.3/jsgrid.min.js"></script>
<script>

function dataInitialize(){
	team = ${teamList};
	group= ${groupList};
	map= ${mapList}; //team group mapping -> group_map_tb
}

$(document).ready(function() {
	
	var count=0;
	dataInitialize();
	
	var teams=[ //�� ����
		{ItemName: "��ȹ 1��", teamCode: "team_plan1"},
		{ItemName: "��ȹ 2��", teamCode: "team_plan2"},
		{ItemName: "������",	teamCode: "team_buy1"},
		{ItemName: "�λ���",	teamCode: "team_hr1"},
		{ItemName: "IT��",	teamCode: "team_it1"}
	];
    
	$("#teamgrid").jsGrid({ //team
		width: "100%",
		height: "400px",
		sorting: true,
		filtering		:	false,
        editing			:	false,
        inserting		:	true,
        autoload		:	true,
        data			:	team,
        paging			:	true,
        pageSize		: 	7,
	    pageButtonCount	: 	5,
        deleteConfirm	:	"�����Ͻðڽ��ϱ�?",
        noDataContent	:	"No Data Content!",
        rowClick: function(args) {
        	console.log(args);
        	var id= Object.values(args)[0].id;
        	console.log(id);
        },
		fields:[
			{name: "id", type: "select" , width:100, items: teams, valueField: "teamCode", textField: "ItemName", validate: {message:	"���� �����Ͻʽÿ�.",	validator: function(value) {return true;}}}
		]
	});
	
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
	    pageButtonCount	: 	5,
        deleteConfirm	:	"�����Ͻðڽ��ϱ�?",
        noDataContent	:	"�׷� ������ �Է��Ͻʽÿ�.",
        rowClick: function(args) {
        	console.log(args);
        	var id= Object.values(args)[0].id;
        	console.log(id);
        },
        controller		:{
        	insertItem		:	function(args){
        		console.log("group insert");
        		$.ajax({ //data�� ��Ʈ�ѷ��� �Ѱ��ش� 
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
          		$.ajax({ //data�� ��Ʈ�ѷ��� �Ѱ��ش� 
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
	
	
	$("#jsgrid").jsGrid({ //���� Ŭ�� �� ���̺��� ����-��� mapping ����
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
        deleteConfirm	:	"�����Ͻðڽ��ϱ�?",
        noDataContent	:	"������ �����Ͻʽÿ�.",
        controller		:{
        	insertItem		:	function(args){
        		console.log("map insert");
        		$.ajax({ //data�� ��Ʈ�ѷ��� �Ѱ��ش� 
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
              		var val= args[Object.keys(args)[1]]; //���
              		console.log(val);
              		console.log(typeof(val));
              		//catch the ID and delete from DB
              		$.ajax({ //data�� ��Ʈ�ѷ��� �Ѱ��ش� 
            			dataType: "json",
            			data: val,
            			url: "/mapDeleteAction", 
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
			{name: "group_id", type: "text", width:150 }, 
			{name: "team", type: "select" , width:150, items: teams, valueField: "teamCode", textField: "ItemName", validate: {message:	"���� �����Ͻʽÿ�.",	validator: function(value) {return true;}}}, 
			{type: "control", editButton: false}
		]
	});
});
</script>
</body>
</html>