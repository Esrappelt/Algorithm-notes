## 算法原理

1. 将n个顶点，m条边的图G按权值从小到大排序，用sort
2. 从权值小的边开始选取，只要不形成回路(用并查集解决)，则选择这条边，否则，放弃这条边,直到选择的边数为m-1条。
3. 并查集主要解决产生回路的问题


```
#include <bits/stdc++.h>
using namespace std;
const int Maxsize = 1e4;
int pre[Maxsize],ans;
struct node
{
    int from,to,cost;
    node(int f,int t,int c): from(f),to(t),cost(c){}
    int operator<(const node &v) const
    {return cost < v.cost;}
};
vector<node> G;
int Find(int x) {return x == pre[x] ? x : pre[x] = Find(pre[x]);}//重要 ,且进行路径压缩
void Union(int i)
{
    int f1 = Find(G[i].from),f2 = Find(G[i].to);
    if(f1 != f2)
    {
        ans += G[i].cost;//求权值的最小和
        pre[f1] = f2;
    }
}
void Kruskal()
{
    for(int i = 0; i < Maxsize; ++i) pre[i] = i;
    int n,m,from,to,cost;
    scanf("%d%d",&n,&m);
    for(int i = 0; i < m; ++i)
    {
        scanf("%d%d%d",&from,&to,&cost);
        G.push_back(node(from,to,cost));
    }//按照边来存储  边的头 尾 和权值 
    sort(G.begin(),G.end());//要先排序  按照权值排序 
    for(int i = 0; i < m; ++i) Union(i);
}
int main()
{
    Kruskal();
    printf("mincost = %d\n",ans);
    return 0;
}
/*
5 7
0 1 100
0 2 30
0 4 10
2 1 60
2 3 60
3 1 10
4 3 50
*/
```
