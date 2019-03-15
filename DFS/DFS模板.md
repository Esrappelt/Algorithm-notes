## 1. 最简单模板
```
void dfs(){
    if(满足路径条件或其它条件){
        flag = 1;//找到结果
        return;
    }
    
    进行方向选择:
        if(满足边界条件或题目条件){
            vis = 1;//置为访问
            res.push_back();//这里是把路径装进去
            dfs();
            vis = 0;//恢复
            res.pop_back();//恢复
            if(flag) return;//如果已经找到了，那么直接一路返回，不需要进行剩下的查找
        }
}
```
    
## 2.判断方向的

```
void dfs(int dep) {
    if(达到某个条件){
        flag = 1;
        return;
    }
    进行方向选择：
        if(满足边界条件) {
            res.push_back();//记录路径
            vis = 1;//置为访问
            然后进行选择递归
            if(满足某个条件){
                dfs(dep+6);
            } else {
                dfs(dep+1);
            }
            vis = 0;//恢复访问
            res.pop_back();//恢复路径，以记录多条
            if(flag) return;//一路返回
        }
}
```
