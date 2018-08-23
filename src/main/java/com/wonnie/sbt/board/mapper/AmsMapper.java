package com.wonnie.sbt.board.mapper;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.wonnie.sbt.board.domain.UserVO;
import com.wonnie.sbt.board.domain.GroupVO;
import com.wonnie.sbt.board.domain.AuthVO;
import com.wonnie.sbt.board.domain.CrudVO;
import com.wonnie.sbt.board.domain.MapVO;
import com.wonnie.sbt.board.domain.TeamVO;
import com.wonnie.sbt.board.domain.GroupMapVO;

@Repository("com.wonnie.sbt.board.mapper.AmsMapper")

public interface AmsMapper {
	  public String userInfo() throws Exception;
	  public List<UserVO> selectUserList() throws Exception;
	  public List<CrudVO> selectCrudList() throws Exception;
	  public List<MapVO> selectMapList1() throws Exception;
	  public List<MapVO> selectMapList2() throws Exception;
	  public List<TeamVO> selectTeamList() throws Exception;
	  public List<GroupVO> selectGroupList() throws Exception;
	  public List<GroupMapVO> selectGroupMapList1() throws Exception;
	  public List<GroupMapVO> selectGroupMapList2() throws Exception;
	  
	  public void insertCrud(CrudVO crudVO) throws Exception;
	  public void insertPerson(UserVO userVO) throws Exception;
	  public void insertMap(MapVO mapVO) throws Exception; 
	  public void insertGroup(GroupVO groupVO) throws Exception;
	  
	  public void deleteCrud(String id) throws Exception;
	  public void deletePerson(String id) throws Exception;
	  public void deleteMap(String person) throws Exception; 
	  public void deleteMap2(String group) throws Exception;
	  public void deleteGroup(String id) throws Exception;
}
