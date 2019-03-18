## 模板

```
int bfs() {
    queue qu;//定义队列
    qu.push(初始条件);
    标记初始起点
    vis[起点] = 1;
    while(栈不为空) {
        if(达到终点) return 长度;
        对可以走的方向进行循环:
            if(满足边界条件以及题目条件) {
                标记这个点
                如果有其它限制条件{
                    if(满足一个条件)，将这个条件入队
                    else 将另一个条件入队
                }
            }
    }
}
```
## hdu1242题

```
#include<bits/stdc++.h>
using namespace std;
int sx,sy,vis[210][210],n,m,dir[4][2] = { {1,0},{0,1},{-1,0},{0,-1}};//定义方向
char maze[210][210];
struct node {
	int x,y,time;
	bool operator<(const node &b) const {return time > b.time;}
};
//判断边界条件以及限制条件
bool ok(int x,int y) {return (x >= 0 && y >= 0 && x < n && y < m && !vis[x][y] && maze[x][y] != '#');}
int bfs() {
	memset(vis,0,sizeof(vis));
	priority_queue<node> qu;//定义优先队列
	qu.push({sx,sy,0});
	vis[sx][sy] = 1;
	while(!qu.empty()) {
		node cur = qu.top();qu.pop();//出队
		//这里满足了条件，退出
		if(maze[cur.x][cur.y] == 'r') return cur.time;
		//循环走
		for(int i = 0; i < 4; i++) {
			int xx = cur.x + dir[i][0],yy = cur.y + dir[i][1];
			if(!ok(xx,yy)) continue;
			vis[xx][yy] = 1;
			//有两个条件，则不同的条件值就不同
			qu.push({xx,yy,maze[xx][yy] == 'x' ? cur.time + 2 : cur.time + 1});
		}
	}
	return -1;
}
int main() {
	while(cin >> n >> m) {
		for(int i = 0; i < n; i++) {
			for(int j = 0; j < m; j++) {
				cin >> maze[i][j];
				if(maze[i][j] == 'a') sx = i,sy = j;
			}
		}
		int ans = bfs();
		if(ans == -1) printf("Poor ANGEL has to stay in the prison all his life.\n");
		else printf("%d\n",ans);
	}
	return 0;
}

```

## hdu1072 记忆化搜索+BFS

```
#include<bits/stdc++.h>
using namespace std;
int n,m,sx,sy,ex,ey;
int maze[10][10],vis[10][10][10],dir[4][2] = { {1,0},{-1,0},{0,1},{0,-1} };
//定义三维数组，第三维是代表的值，若值相同则不走这条
struct path {
	int x,y,time,res;
};
//判断边界条件和限制条件
bool ok(int x,int y) {
	return x >= 0 && x < n && y >= 0 && y < m && maze[x][y];
}


int bfs(int sx,int sy) {
	vis[sx][sy][6] = 1;
	queue<path> qu;
	qu.push({sx,sy,6,0});
	while(!qu.empty()) {
		path p = qu.front(); qu.pop();
		int time = 0;
		for(int i = 0; i < 4; i++){
			int xx = p.x + dir[i][0],yy = p.y + dir[i][1];
			if(!ok(xx,yy)) continue;
			if(p.time <= 1) continue;
			time = maze[xx][yy] == 1 ? p.time - 1 : 6;
			if(vis[xx][yy][time]) continue;
			//算出时间后，如果这个时间刚才到达过，那么就不走
			vis[xx][yy][time] = 1;//记忆化搜索,第三变量是时间 
			//如果找到了，则退出
			if(xx == ex && yy == ey) return p.res + 1;
			//将新的值，入队
			qu.push({xx,yy,time,p.res + 1});
		}
	}
	return -1;
} 


int main() {
	int T;
	scanf("%d",&T);
	while(T--){
		scanf("%d%d",&n,&m);
		memset(vis,0,sizeof(vis));
		for(int i = 0; i < n; i++) {
			for(int j = 0; j < m; j++) {
				scanf("%d",&maze[i][j]);
				if(maze[i][j] == 2) sx = i,sy = j;
				else if(maze[i][j] == 3) ex = i,ey = j;
			}
		}
		cout << bfs(sx,sy) << endl;
	}
	return 0;
}
```
