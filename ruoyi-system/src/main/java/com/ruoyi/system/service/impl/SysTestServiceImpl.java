package com.ruoyi.system.service.impl;

import com.ruoyi.system.domain.SysTest;
import com.ruoyi.system.mapper.SysTestMapper;
import com.ruoyi.system.service.ISysTestService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 公告 服务层实现
 * 
 * @author ruoyi
 */
@Service
public class SysTestServiceImpl implements ISysTestService
{
    @Autowired
    private SysTestMapper testMapper;

    /**
     * 查询公告信息
     * 
     * @param id 公告ID
     * @return 公告信息
     */
    @Override
    public SysTest selectTestById(Long id)
    {
        return testMapper.selectTestById(id);
    }

    /**
     * 查询公告列表
     * 
     * @param test 公告信息
     * @return 公告集合
     */
    @Override
    public List<SysTest> selectTestList(SysTest test)
    {
        return testMapper.selectTestList(test);
    }

    /**
     * 新增公告
     * 
     * @param test 公告信息
     * @return 结果
     */
    @Override
    public int insertTest(SysTest test)
    {
        return testMapper.insertTest(test);
    }

    /**
     * 修改公告
     * 
     * @param test 公告信息
     * @return 结果
     */
    @Override
    public int updateTest(SysTest test)
    {
        return testMapper.updateTest(test);
    }

    /**
     * 删除公告对象
     * 
     * @param id 公告ID
     * @return 结果
     */
    @Override
    public int deleteTestById(Long id)
    {
        return testMapper.deleteTestById(id);
    }

    /**
     * 批量删除公告信息
     * 
     * @param ids 需要删除的公告ID
     * @return 结果
     */
    @Override
    public int deleteTestByIds(Long[] ids)
    {
        return testMapper.deleteTestByIds(ids);
    }
}
