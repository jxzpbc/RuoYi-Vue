package com.ruoyi.web.controller.system;

import com.ruoyi.common.annotation.Log;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.page.TableDataInfo;
import com.ruoyi.common.enums.BusinessType;
import com.ruoyi.system.domain.SysTest;
import com.ruoyi.system.service.ISysTestService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * 公告 信息操作处理
 * 
 * @author ruoyi
 */
@RestController
@RequestMapping("/system/test")
public class SysTestController extends BaseController
{
    @Autowired
    private ISysTestService testService;

    /**
     * 获取通知公告列表
     */
    @PreAuthorize("@ss.hasPermi('system:test:list')")
    @GetMapping("/list")
    public TableDataInfo list(SysTest test)
    {
        startPage();
        List<SysTest> list = testService.selectTestList(test);
        return getDataTable(list);
    }

    /**
     * 根据通知公告编号获取详细信息
     */
    @PreAuthorize("@ss.hasPermi('system:test:query')")
    @GetMapping(value = "/{id}")
    public AjaxResult getInfo(@PathVariable Long id)
    {
        return success(testService.selectTestById(id));
    }

    /**
     * 新增通知公告
     */
    @PreAuthorize("@ss.hasPermi('system:test:add')")
    @Log(title = "通知公告", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@Validated @RequestBody SysTest test)
    {
        test.setCreateBy(getUsername());
        return toAjax(testService.insertTest(test));
    }

    /**
     * 修改通知公告
     */
    @PreAuthorize("@ss.hasPermi('system:test:edit')")
    @Log(title = "通知公告", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@Validated @RequestBody SysTest test)
    {
        test.setUpdateBy(getUsername());
        return toAjax(testService.updateTest(test));
    }

    /**
     * 删除通知公告
     */
    @PreAuthorize("@ss.hasPermi('system:test:remove')")
    @Log(title = "通知公告", businessType = BusinessType.DELETE)
    @DeleteMapping("/{ids}")
    public AjaxResult remove(@PathVariable Long[] ids)
    {
        return toAjax(testService.deleteTestByIds(ids));
    }
}
