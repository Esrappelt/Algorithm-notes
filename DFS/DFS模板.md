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

关于最简单模板的应用：
[hdu1015](http://acm.hdu.edu.cn/showproblem.php?pid=1015)

```
#include<bits/stdc++.h>
using namespace std;
int target,flag = 0,vis[300] = {0};
string code;
vector<char> res;
bool cmp(int a,int b){ return a > b; }
void dfs(int dep) {
	if(dep == 5){
		//处理结果 
		int v = res[0] - 64,w = res[1] - 64,x = res[2] - 64,y = res[3] - 64,z = res[4] - 64;
		if( ( v - w * w + x * x * x - y * y * y * y + z * z * z * z * z )== target ) {
			for(int i = 0; i < res.size(); i++) printf("%c",res[i]);
			flag = 1; 
		} 
		return;
	}
	for(int i = 0; i < code.length(); i++) {
		if(!vis[i]) {
			vis[i] = 1;//标记
			res.push_back(code[i]);//记录路径
			dfs(dep + 1);//步数加一
			res.pop_back();//恢复路径
			vis[i] = 0;//恢复标记
			if(flag == 1) return;//只要找到条件了就一路退回去，不往下找了 
		}	
	}
}


int main() {
	while(1) {
		cin >> target >> code;
		if(target == 0 && code == "END") break;
		flag = 0;
		sort(code.begin(),code.end(),cmp);
		memset(vis,0,sizeof(vis));
		dfs(0);
		if(!flag) printf("no solution");
		printf("\n");
	}
	return 0;
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
## 关于DFS方向相同和不同问题的
以迷宫为例：
hdu1728：
给定一个m × n (m行, n列)的迷宫，迷宫中有两个位置，gloria想从迷宫的一个位置走到另外一个位置，当然迷宫中有些地方是空地，gloria可以穿越，有些地方是障碍，她必须绕行，从迷宫的一个位置，只能走到与它相邻的4个位置中,当然在行走过程中，gloria不能走到迷宫外面去。令人头痛的是，gloria是个没什么方向感的人，因此，她在行走过程中，不能转太多弯了，否则她会晕倒的。我们假定给定的两个位置都是空地，初始时，gloria所面向的方向未定，她可以选择4个方向的任何一个出发，而不算成一次转弯。gloria能从一个位置走到另外一个位置吗？

大概思路就是：

```
int dir[4][2] = {1,0,-1,0,1,0,-1};//定义上下左右四个方向
void dfs(int x,int y,int dic) {//这个dic参数就是方向的判断
    if(不满足条件) return;
    if(找到了解){
        flag = 1;//标志是找到了
        return;
    }
    //对于上下左右四个方向
    for(int i = 0; i < 4; i++) {
        int xx = x + dir[i][0],yy = y + dir[i][1];
        if(xx和yy满足边界条件以及限制条件) {
            vis[xx][yy] = 1;//置为访问
            if(dic == -1 || dic == i) {
                //dic == i说明的是上一次的方向与这一次相同
                //
                //然后做方向相同的处理
                dfs(xx,yy,i);
            }else {
                //做方向不同的处理
                dfs(xx,yy,i);
            }
            vis[xx][yy] = 0;//恢复访问
            if(flag) return;//如果找到了就一路返回,剪枝
        }
    }
    
}
```
[hdu 1728](http://acm.hdu.edu.cn/showproblem.php?pid=1728)：
关于转弯数的统计，利用二维数组进行存储,
设到达(x,y)点所需的转弯数为turns[x][y],
赋初始值为turns[x][y] = 0,其它为无穷大
,从起点开始深度优先搜索，方向为4个方向，
1. 如果方向相同，则转弯数是不变的
2. 如果方向不同，则转弯数加一
```
#include<bits/stdc++.h>
using namespace std;
int n,m,sx,sy,ex,ey,flag = 0,k;
char maze[110][110];
int dir[4][2] = { {-1,0},{1,0},{0,1},{0,-1} },vis[110][110],turns[110][110];
bool ok(int x,int y){
	return x >= 0 && y >= 0 && x < m && y < n && !vis[x][y] && maze[x][y] == '.';
}
void dfs(int x,int y,int dic) {
	if(turns[x][y] > k) return;
	if(turns[x][y] == k && x != ex && y != ey) return;
	if(x == ex && y == ey && turns[x][y] <= k) {
		flag = 1;
		return;
	}
	for(int i = 0; i < 4; i++) {
		int xx = x + dir[i][0],yy = y + dir[i][1];
		if(!ok(xx,yy)) continue;
		if(turns[xx][yy] < turns[x][y]) continue;
		if(dic != -1 && dic != i && turns[xx][yy] < turns[x][y] + 1) continue;//dic != i说明方向不同 
		if(dic == -1 || dic == i) turns[xx][yy] = turns[x][y];//turns[x][y]所到达这个点(x,y)的转弯数是多少 ，如果方向相同，下一个点即xx,yy这个点的转弯数就不变 
		else turns[xx][yy] = turns[x][y] + 1;
		vis[xx][yy] = 1;
		dfs(xx,yy,i); 
		vis[xx][yy] = 0;
		if(flag) return;//剪枝 
	}
}



int main() {
	int t;
	cin >> t;
	while(t--) {
		memset(vis,0,sizeof(vis));
		memset(turns,1000000,sizeof(turns));
		flag = 0;
		cin >> m >> n;
		for(int i = 0; i < m; i++) {
			for(int j = 0; j < n; j++) {
				cin >> maze[i][j];
			}
		}  
		cin >> k >> sy >> sx >> ey >> ex ;
		sx--,sy--,ex--,ey--;
		turns[sx][sy] = 0;
		dfs(sx,sy,-1);
		printf(flag ? "yes" : "no");
		cout << endl;
	}
	return 0;
}
```
