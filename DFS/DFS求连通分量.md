## 连通分量
连通分量：
1. 如果从一个点，进行深度优先搜索一直访问下去，如果一次访问完所有的点，那么连通分量数为1
2. 如果要进行2次或多次才能访问完，那么连通分量数就为2次或多次
```
#include <bits/stdc++.h>
using namespace std;
const int maxn = 100 + 5;
char pic[maxn][maxn];
int m,n,vis[maxn][maxn];
int dx[] = {-1,-1,-1,0,0,1,1,1};
int dy[] = {-1,0,1,-1,1,-1,0,1};
void dfs(int i,int j)
{
    if(i < 0 || j < 0 || i >= m || j >= n) return;
    if(vis[i][j] || pic[i][j] != '@') return;
    vis[i][j] = 1;
    for(int k = 0; k < 8; ++k) dfs(i + dx[k],j + dy[k]);
}
int main()
{
    while(scanf("%d%d", &m,&n) == 2 && m && n)
    {
        for(int i = 0; i < m; ++i)
            scanf("%s",pic[i]);
        int cnt = 0;
        memset(vis,0,sizeof(vis));
        for(int i = 0; i < m; ++i)
        {
            for(int j = 0; j < n; ++j)
            {
                if(!vis[i][j] && pic[i][j] == '@')
                {
                    ++cnt;
                    dfs(i,j);
                }
            }
        }
        printf("%d\n",cnt);//连通分量个数
    }
    return 0;
}
/*
5 5
****@
*@@*@
*@**@
@@@*@
@@**@
*/
```
