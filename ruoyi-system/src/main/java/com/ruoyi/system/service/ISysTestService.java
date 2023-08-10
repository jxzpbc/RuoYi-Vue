package com.ruoyi.system.service;

import com.ruoyi.system.domain.SysTest;

import java.util.List;

/**
 * 公告 服务层
 * 
 * @author ruoyi
 */
public interface ISysTestService
{
    /**
     * 查询公告信息
     * 
     * @param id 公告ID
     * @return 公告信息
     */
    public SysTest selectTestById(Long id);

    /**
     * 查询公告列表
     * 
     * @param test 公告信息
     * @return 公告集合
     */
    public List<SysTest> selectTestList(SysTest test);

    /**
     * 新增公告
     * 
     * @param test 公告信息
     * @return 结果
     */
    public int insertTest(SysTest test);

    /**
     * 修改公告
     * 
     * @param test 公告信息
     * @return 结果
     */
    public int updateTest(SysTest test);

    /**
     * 删除公告信息
     * 
     * @param id 公告ID
     * @return 结果
     */
    public int deleteTestById(Long id);
    
    /**
     * 批量删除公告信息
     * 
     * @param ids 需要删除的公告ID
     * @return 结果
     */
    public int deleteTestByIds(Long[] ids);
}
