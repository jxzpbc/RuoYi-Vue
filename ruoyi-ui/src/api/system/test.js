import request from '@/utils/request'

// 查询公告列表
export function listTest(query) {
  return request({
    url: '/system/test/list',
    method: 'get',
    params: query
  })
}

// 查询公告详细
export function getTest(id) {
  return request({
    url: '/system/test/' + id,
    method: 'get'
  })
}

// 新增公告
export function addTest(data) {
  return request({
    url: '/system/test',
    method: 'post',
    data: data
  })
}

// 修改公告
export function updateTest(data) {
  return request({
    url: '/system/test',
    method: 'put',
    data: data
  })
}

// 删除公告
export function delTest(id) {
  return request({
    url: '/system/test/' + id,
    method: 'delete'
  })
}
