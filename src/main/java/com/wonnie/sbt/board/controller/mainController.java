package com.wonnie.sbt.board.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import com.fasterxml.jackson.databind.ObjectMapper;

import java.util.List;
import java.util.Random;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.springframework.web.servlet.ModelAndView;
import com.wonnie.sbt.board.mapper.AmsMapper;

import com.wonnie.sbt.board.domain.UserVO;
import com.wonnie.sbt.board.domain.GroupVO;
import com.wonnie.sbt.board.domain.AuthVO;
import com.wonnie.sbt.board.domain.CrudVO;
import com.wonnie.sbt.board.domain.MapVO;
import com.wonnie.sbt.board.domain.TeamVO;
import com.wonnie.sbt.board.domain.GroupMapVO;

@Controller
public class mainController {

	 @Resource(name="com.wonnie.sbt.board.mapper.AmsMapper")
	    AmsMapper mapper;
	 
	 Random generator = new Random(); 
	 
	@RequestMapping("/")
	public ModelAndView home(HttpServletRequest request, HttpServletResponse response) throws Exception{
		ModelAndView mav = new ModelAndView("/dashboard");
	    return mav;
	}
	
	@RequestMapping("/personal")
	public ModelAndView person(HttpServletRequest request, HttpServletResponse response) throws Exception{
		ModelAndView mav = new ModelAndView("/personal");
		
		List<UserVO> userList = mapper.selectUserList();
		String userListJSON = new ObjectMapper().writeValueAsString(userList);
		mav.addObject("userList", userListJSON);	
		
		List<CrudVO> authList = mapper.selectCrudList();
		String crudListJSON = new ObjectMapper().writeValueAsString(authList);
		mav.addObject("crudList", crudListJSON);
		
		List<MapVO> mapList = mapper.selectMapList1();
		String mapListJSON = new ObjectMapper().writeValueAsString(mapList);
		mav.addObject("mapList", mapListJSON);
		
	    return mav;
	}
	
	@RequestMapping("/group")
	public ModelAndView group(HttpServletRequest request, HttpServletResponse response) throws Exception{
		ModelAndView mav = new ModelAndView("/group");
		
		List<GroupVO> groupList = mapper.selectGroupList(); //grouplist 구현하기
		String groupListJSON = new ObjectMapper().writeValueAsString(groupList);
		mav.addObject("groupList", groupListJSON);
		
		List<CrudVO> authList = mapper.selectCrudList();
		String crudListJSON = new ObjectMapper().writeValueAsString(authList);
		mav.addObject("crudList", crudListJSON);
		
		List<MapVO> mapList = mapper.selectMapList2();
		String mapListJSON = new ObjectMapper().writeValueAsString(mapList);
		mav.addObject("mapList", mapListJSON);
		
	    return mav;
	}
	
	@RequestMapping("/teamGroup")
	public ModelAndView team(HttpServletRequest request, HttpServletResponse response) throws Exception{
		ModelAndView mav = new ModelAndView("/teamGroup");
		
		List<TeamVO> teamList = mapper.selectTeamList();
		String teamListJSON = new ObjectMapper().writeValueAsString(teamList);
		mav.addObject("teamList", teamListJSON);	
		
		List<GroupVO> groupList = mapper.selectGroupList(); //grouplist 구현하기
		String groupListJSON = new ObjectMapper().writeValueAsString(groupList);
		mav.addObject("groupList", groupListJSON);
		
		List<GroupMapVO> mapList = mapper.selectGroupMapList1(); //팀 그룹 mapper
		String mapListJSON = new ObjectMapper().writeValueAsString(mapList);
		mav.addObject("mapList", mapListJSON);
		
	    return mav;
	}
	
	@RequestMapping("/personGroup")
	public ModelAndView personGroup(HttpServletRequest request, HttpServletResponse response) throws Exception{
		ModelAndView mav = new ModelAndView("/personGroup");
		
		List<UserVO> userList = mapper.selectUserList();
		String userListJSON = new ObjectMapper().writeValueAsString(userList);
		mav.addObject("userList", userListJSON);	
		
		List<GroupVO> groupList = mapper.selectGroupList(); //grouplist 구현하기
		String groupListJSON = new ObjectMapper().writeValueAsString(groupList);
		mav.addObject("groupList", groupListJSON);
		
		List<GroupMapVO> mapList = mapper.selectGroupMapList2(); //개인 그룹 mapper
		String mapListJSON = new ObjectMapper().writeValueAsString(mapList);
		mav.addObject("mapList", mapListJSON);
		
	    return mav;
	}
	
	@RequestMapping("/personAction")
	public @ResponseBody String personAction(@RequestBody UserVO userVO, HttpServletRequest request, 
			HttpServletResponse response) throws Exception{
		System.out.println("person");
		userVO.setGroup_id(null);
		mapper.insertPerson(userVO);
		return "person";
	}
	
	@RequestMapping("/crudAction")
	public @ResponseBody String crudAction(@RequestBody CrudVO crudVO, HttpServletRequest request, 
			HttpServletResponse response) throws Exception{
		System.out.println("crud");
		
		int codeNum= generator.nextInt(1000)+1; // 1부터 1000사이의 랜덤 정수
        codeNum += Integer.parseInt(crudVO.getId()); //고유 값을 주기 위해 id에 random 값을 더합니다
        String code= "code_"+ Integer.toString(codeNum);
        crudVO.setId(code);
        
        mapper.insertCrud(crudVO);
		return "crud";
	}
	
	@RequestMapping("/mapAction")
	public @ResponseBody String mapAction(MapVO mapVO, HttpServletRequest request, 
			HttpServletResponse response) throws Exception{
		System.out.println("map");
		mapVO.setGroup_id(null);
		mapper.insertMap(mapVO);
		return "map";
	}
	
	@RequestMapping(value="/crudDeleteAction", method=RequestMethod.POST)
	public @ResponseBody String crudDeleteAction(@RequestBody String id, HttpServletRequest request, 
			HttpServletResponse response) throws Exception{
		System.out.println("crud Delete");
		System.out.println(id);
		id = id.replace("=",""); //invalid token inside parameter
		mapper.deleteCrud(id);
		return "delete crud";
	}
	
	@RequestMapping(value="/personDeleteAction", method=RequestMethod.POST)
	public @ResponseBody String personDeleteAction(@RequestBody String id, HttpServletRequest request, 
			HttpServletResponse response) throws Exception{
		System.out.println("person Delete");
		System.out.println(id);
		id = id.replace("=",""); //invalid token inside parameter
		mapper.deletePerson(id);
		return "delete person";
	}
	
	@RequestMapping(value="/mapDeleteAction", method=RequestMethod.POST)
	public @ResponseBody String mapDeleteAction(@RequestBody String person, HttpServletRequest request, 
			HttpServletResponse response) throws Exception{
		System.out.println("map Delete");
		System.out.println(person);
		person = person.replace("=",""); //invalid token inside parameter
		mapper.deleteMap(person);
		return "delete map";
	}
	
	@RequestMapping(value="/mapDeleteActionGroup", method=RequestMethod.POST)
	public @ResponseBody String mapDeleteActionGroup(@RequestBody String group, HttpServletRequest request, 
			HttpServletResponse response) throws Exception{
		System.out.println("map Delete");
		System.out.println(group);
		group = group.replace("=",""); //invalid token inside parameter
		mapper.deleteMap2(group);
		return "delete map";
	}
	
	@RequestMapping("/groupAction")
	public @ResponseBody String groupAction(@RequestBody GroupVO groupVO, HttpServletRequest request, 
			HttpServletResponse response) throws Exception{
		System.out.println("group");
		//groupVO.setGroup_id(null);
		mapper.insertGroup(groupVO);
		return "person";
	}
	
	@RequestMapping(value="/groupDeleteAction", method=RequestMethod.POST)
	public @ResponseBody String groupDeleteAction(@RequestBody String id, HttpServletRequest request, 
			HttpServletResponse response) throws Exception{
		System.out.println("group Delete");
		System.out.println(id);
		id = id.replace("=",""); //invalid token inside parameter
		mapper.deleteGroup(id);
		return "delete group";
	}
}

//map action group
//teamAction
//teamDeleteAction
