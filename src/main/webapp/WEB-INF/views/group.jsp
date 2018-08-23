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
	
	var authTypeList = [	//���� ����
        {	ItemName: "����",	authCode: "auth_code1"	},
        {	ItemName: "����",	authCode: "auth_code2"	},
        {	ItemName: "����",	authCode: "auth_code3"	},
        {	ItemName: "�λ�",	authCode: "auth_code4"	},
        {	ItemName: "����", authCode: "auth_code5"	},
    ];
	
	var crud=[  //crud yes no
		{ItemName: "��",		TypeCode: "1"	},
		{ItemName: "�ƴϿ�",	TypeCode: "0"	}
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
        deleteConfirm	:	"�����Ͻðڽ��ϱ�?",
        noDataContent	:	"�׷� ������ �߰��� �ֽʽÿ�.",
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
        deleteConfirm	:	"�����Ͻðڽ��ϱ�?",
        noDataContent	:	"���� ������ �Է��Ͻʽÿ�.",
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
        		
        		$.ajax({ //data�� ��Ʈ�ѷ��� �Ѱ��ش� 
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
              		$.ajax({ //data�� ��Ʈ�ѷ��� �Ѱ��ش� 
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
			{name: "auth_id", type: "select",  width:80, items: authTypeList, valueField: "authCode", textField: "ItemName",	validate: {message:	"���� ������ �����ϼ���",	validator: function(value) {return true;}}},
			{name: "c", type: "select",  width:80, items: crud, valueField: "TypeCode", textField: "ItemName",	validate: {message:	"C ���� ���θ� �����Ͻʽÿ�.",	validator: function(value) {return value >= 0;}}},
			{name: "r", type: "select",  width:80, items: crud, valueField: "TypeCode", textField: "ItemName",	validate: {message:	"R ���� ���θ� �����Ͻʽÿ�.",	validator: function(value) {return value >= 0;}}},
			{name: "u", type: "select",  width:80, items: crud, valueField: "TypeCode", textField: "ItemName",	validate: {message:	"U ���� ���θ� �����Ͻʽÿ�.",	validator: function(value) {return value >= 0;}}},
			{name: "d", type: "select",  width:80, items: crud, valueField: "TypeCode", textField: "ItemName",	validate: {message:	"D ���� ���θ� �����Ͻʽÿ�.",	validator: function(value) {return value >= 0;}}},
			{type: "control", editButton: false}
		]
	});
	
	$("#jsgrid").jsGrid({ //���� Ŭ�� �� ���̺� ����-��� mapping ����
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