/**
 * SyntaxHighlighter
 * http://alexgorbatchev.com/SyntaxHighlighter
 *
 * SyntaxHighlighter is donationware. If you are using it, please donate.
 * http://alexgorbatchev.com/SyntaxHighlighter/donate.html
 *
 * @version
 * 3.0.??? (December 16 2011)
 * 
 * @copyright
 * Copyright (C) 2004-2010 Alex Gorbatchev.
 *
 * @license
 * Dual licensed under the MIT and GPL licenses.
 */
eval(function(p,a,c,k,e,d){e=function(c){return(c<a?'':e(parseInt(c/a)))+((c=c%a)>35?String.fromCharCode(c+29):c.toString(36))};if(!''.replace(/^/,String)){while(c--){d[e(c)]=k[c]||e(c)}k=[function(e){return d[e]}];e=function(){return'\\w+'};c=1};while(c--){if(k[c]){p=p.replace(new RegExp('\\b'+e(c)+'\\b','g'),k[c])}}return p}('K M;I(M)1T 2E("27\'t 4i M 5l 2d 37 5k 5j");(6(){6 r(f,e){I(!M.1P(f))1T 2Z("3h 18 5i");K a=f.1r;f=M(f.1l,t(f)+(e||""));I(a)f.1r={1l:a.1l,1a:a.1a?a.1a.1b(0):N};H f}6 t(f){H(f.1I?"g":"")+(f.5m?"i":"")+(f.5n?"m":"")+(f.5r?"x":"")+(f.3N?"y":"")}6 B(f,e,a,b){K c=u.L,d,g,h;v=R;5q{O(;c--;){h=u[c];I(a&h.3u&&(!h.2H||h.2H.W(b))){h.2z.11=e;I((g=h.2z.X(f))&&g.P===e){d={3Q:h.2j.W(b,g,a),1F:g};1Q}}}}5p(i){1T i}5o{v=12}H d}6 p(f,e,a){I(3v.Z.16)H f.16(e,a);O(a=a||0;a<f.L;a++)I(f[a]===e)H a;H-1}M=6(f,e){K a=[],b=M.1H,c=0,d,g;I(M.1P(f)){I(e!==1d)1T 2Z("27\'t 5h 5g 59 58 57 18 55 56");H r(f)}I(v)1T 2E("27\'t W 37 M 5b 5f 5e 5d 5c");e=e||"";O(d={2x:12,1a:[],2S:6(h){H e.16(h)>-1},3n:6(h){e+=h}};c<f.L;)I(g=B(f,c,b,d)){a.U(g.3Q);c+=g.1F[0].L||1}Y I(g=n.X.W(z[b],f.1b(c))){a.U(g[0]);c+=g[0].L}Y{g=f.3t(c);I(g==="[")b=M.2O;Y I(g==="]")b=M.1H;a.U(g);c++}a=18(a.1R(""),n.Q.W(e,w,""));a.1r={1l:f,1a:d.2x?d.1a:N};H a};M.3d="1.5.0";M.2O=1;M.1H=2;K C=/\\$(?:(\\d\\d?|[$&`\'])|{([$\\w]+)})/g,w=/[^5s]+|([\\s\\S])(?=[\\s\\S]*\\1)/g,A=/^(?:[?*+]|{\\d+(?:,\\d*)?})\\??/,v=12,u=[],n={X:18.Z.X,1s:18.Z.1s,1F:1t.Z.1F,Q:1t.Z.Q,1h:1t.Z.1h},x=n.X.W(/()??/,"")[1]===1d,D=6(){K f=/^/g;n.1s.W(f,"");H!f.11}(),y=6(){K f=/x/g;n.Q.W("x",f,"");H!f.11}(),E=18.Z.3N!==1d,z={};z[M.2O]=/^(?:\\\\(?:[0-3][0-7]{0,2}|[4-7][0-7]?|x[\\2b-29-f]{2}|u[\\2b-29-f]{4}|c[A-3K-z]|[\\s\\S]))/;z[M.1H]=/^(?:\\\\(?:0(?:[0-3][0-7]{0,2}|[4-7][0-7]?)?|[1-9]\\d*|x[\\2b-29-f]{2}|u[\\2b-29-f]{4}|c[A-3K-z]|[\\s\\S])|\\(\\?[:=!]|[?*+]\\?|{\\d+(?:,\\d*)?}\\??)/;M.1g=6(f,e,a,b){u.U({2z:r(f,"g"+(E?"y":"")),2j:e,3u:a||M.1H,2H:b||N})};M.2G=6(f,e){K a=f+"/"+(e||"");H M.2G[a]||(M.2G[a]=M(f,e))};M.3s=6(f){H r(f,"g")};M.5H=6(f){H f.Q(/[-[\\]{}()*+?.,\\\\^$|#\\s]/g,"\\\\$&")};M.5L=6(f,e,a,b){e=r(e,"g"+(b&&E?"y":""));e.11=a=a||0;f=e.X(f);H b?f&&f.P===a?f:N:f};M.3q=6(){M.1g=6(){1T 2E("27\'t 5P 1g 5O 3q")}};M.1P=6(f){H 5N.Z.1u.W(f)==="[2U 18]"};M.3p=6(f,e,a,b){O(K c=r(e,"g"),d=-1,g;g=c.X(f);){a.W(b,g,++d,f,c);c.11===g.P&&c.11++}I(e.1I)e.11=0};M.5G=6(f,e){H 6 a(b,c){K d=e[c].1C?e[c]:{1C:e[c]},g=r(d.1C,"g"),h=[],i;O(i=0;i<b.L;i++)M.3p(b[i],g,6(k){h.U(d.3o?k[d.3o]||"":k[0])});H c===e.L-1||!h.L?h:a(h,c+1)}([f],0)};18.Z.1w=6(f,e){H J.X(e[0])};18.Z.W=6(f,e){H J.X(e)};18.Z.X=6(f){K e=n.X.1w(J,14),a;I(e){I(!x&&e.L>1&&p(e,"")>-1){a=18(J.1l,n.Q.W(t(J),"g",""));n.Q.W(f.1b(e.P),a,6(){O(K c=1;c<14.L-2;c++)I(14[c]===1d)e[c]=1d})}I(J.1r&&J.1r.1a)O(K b=1;b<e.L;b++)I(a=J.1r.1a[b-1])e[a]=e[b];!D&&J.1I&&!e[0].L&&J.11>e.P&&J.11--}H e};I(!D)18.Z.1s=6(f){(f=n.X.W(J,f))&&J.1I&&!f[0].L&&J.11>f.P&&J.11--;H!!f};1t.Z.1F=6(f){M.1P(f)||(f=18(f));I(f.1I){K e=n.1F.1w(J,14);f.11=0;H e}H f.X(J)};1t.Z.Q=6(f,e){K a=M.1P(f),b,c;I(a&&1k e.5F()==="3e"&&e.16("${")===-1&&y)H n.Q.1w(J,14);I(a){I(f.1r)b=f.1r.1a}Y f+="";I(1k e==="6")c=n.Q.W(J,f,6(){I(b){14[0]=1i 1t(14[0]);O(K d=0;d<b.L;d++)I(b[d])14[0][b[d]]=14[d+1]}I(a&&f.1I)f.11=14[14.L-2]+14[0].L;H e.1w(N,14)});Y{c=J+"";c=n.Q.W(c,f,6(){K d=14;H n.Q.W(e,C,6(g,h,i){I(h)5y(h){2i"$":H"$";2i"&":H d[0];2i"`":H d[d.L-1].1b(0,d[d.L-2]);2i"\'":H d[d.L-1].1b(d[d.L-2]+d[0].L);5x:i="";h=+h;I(!h)H g;O(;h>d.L-3;){i=1t.Z.1b.W(h,-1)+i;h=1K.3r(h/10)}H(h?d[h]||"":"$")+i}Y{h=+i;I(h<=d.L-3)H d[h];h=b?p(b,i):-1;H h>-1?d[h+1]:g}})})}I(a&&f.1I)f.11=0;H c};1t.Z.1h=6(f,e){I(!M.1P(f))H n.1h.1w(J,14);K a=J+"",b=[],c=0,d,g;I(e===1d||+e<0)e=5w;Y{e=1K.3r(+e);I(!e)H[]}O(f=M.3s(f);d=f.X(a);){I(f.11>c){b.U(a.1b(c,d.P));d.L>1&&d.P<a.L&&3v.Z.U.1w(b,d.1b(1));g=d[0].L;c=f.11;I(b.L>=e)1Q}f.11===d.P&&f.11++}I(c===a.L){I(!n.1s.W(f,"")||g)b.U("")}Y b.U(a.1b(c));H b.L>e?b.1b(0,e):b};M.1g(/\\(\\?#[^)]*\\)/,6(f){H n.1s.W(A,f.2J.1b(f.P+f[0].L))?"":"(?:)"});M.1g(/\\((?!\\?)/,6(){J.1a.U(N);H"("});M.1g(/\\(\\?<([$\\w]+)>/,6(f){J.1a.U(f[1]);J.2x=R;H"("});M.1g(/\\\\k<([\\w$]+)>/,6(f){K e=p(J.1a,f[1]);H e>-1?"\\\\"+(e+1)+(4b(f.2J.3t(f.P+f[0].L))?"":"(?:)"):f[0]});M.1g(/\\[\\^?]/,6(f){H f[0]==="[]"?"\\\\b\\\\B":"[\\\\s\\\\S]"});M.1g(/^\\(\\?([5z]+)\\)/,6(f){J.3n(f[1]);H""});M.1g(/(?:\\s+|#.*)+/,6(f){H n.1s.W(A,f.2J.1b(f.P+f[0].L))?"":"(?:)"},M.1H,6(){H J.2S("x")});M.1g(/\\./,6(){H"[\\\\s\\\\S]"},M.1H,6(){H J.2S("s")})})();1k 2a!="1d"&&(2a.M=M);K 1x=6(){6 r(a,b){a.1m.16(b)!=-1||(a.1m+=" "+b)}6 t(a){H a.16("3m")==0?a:"3m"+a}6 B(a){H e.1Z.2w[t(a)]}6 p(a,b,c){I(a==N)H N;K d=c!=R?a.3i:[a.2D],g={"#":"1f",".":"1m"}[b.1o(0,1)]||"3g",h,i;h=g!="3g"?b.1o(1):b.5R();I((a[g]||"").16(h)!=-1)H a;O(a=0;d&&a<d.L&&i==N;a++)i=p(d[a],b,c);H i}6 C(a,b){K c={},d;O(d 2d a)c[d]=a[d];O(d 2d b)c[d]=b[d];H c}6 w(a,b,c,d){6 g(h){h=h||1N.4S;I(!h.1G){h.1G=h.4t;h.30=6(){J.4u=12}}c.W(d||1N,h)}a.3f?a.3f("4y"+b,g):a.4v(b,g,12)}6 A(a,b){K c=e.1Z.2p,d=N;I(c==N){c={};O(K g 2d e.1X){K h=e.1X[g];d=h.4z;I(d!=N){h.22=g.4w();O(h=0;h<d.L;h++)c[d[h]]=g}}e.1Z.2p=c}d=e.1X[c[a]];d==N&&b!=12&&1N.23(e.13.1v.23+(e.13.1v.3w+a));H d}6 v(a,b){O(K c=a.1h("\\n"),d=0;d<c.L;d++)c[d]=b(c[d],d);H c.1R("\\n")}6 u(a,b){I(a==N||a.L==0||a=="\\n")H a;a=a.Q(/</g,"&1y;");a=a.Q(/ {2,}/g,6(c){O(K d="",g=0;g<c.L-1;g++)d+=e.13.21;H d+" "});I(b!=N)a=v(a,6(c){I(c.L==0)H"";K d="";c=c.Q(/^(&2t;| )+/,6(g){d=g;H""});I(c.L==0)H d;H d+\'<15 1e="\'+b+\'">\'+c+"</15>"});H a}6 n(a,b){a.1h("\\n");O(K c="",d=0;d<50;d++)c+="                    ";H a=v(a,6(g){I(g.16("\\t")==-1)H g;O(K h=0;(h=g.16("\\t"))!=-1;)g=g.1o(0,h)+c.1o(0,b-h%b)+g.1o(h+1,g.L);H g})}6 x(a){H a.Q(/^\\s+|\\s+$/g,"")}6 D(a,b){I(a.P<b.P)H-1;Y I(a.P>b.P)H 1;Y I(a.L<b.L)H-1;Y I(a.L>b.L)H 1;H 0}6 y(a,b){6 c(k){H k[0]}O(K d=N,g=[],h=b.2M?b.2M:c;(d=b.1C.X(a))!=N;){K i=h(d,b);I(1k i=="3e")i=[1i e.2A(i,d.P,b.1W)];g=g.1M(i)}H g}6 E(a){K b=/(.*)((&1B;|&1y;).*)/;H a.Q(e.3B.3F,6(c){K d="",g=N;I(g=b.X(c)){c=g[1];d=g[2]}I(c.16("<")!=-1){g=c.25(0,c.16("<"));c=c.25(c.16("<"),c.L);d+=c;H\'<a 24="\'+g+\'">\'+g+"</a>"+d}Y H\'<a 24="\'+c+\'">\'+c+"</a>"+d})}6 z(){O(K a=1E.31("1j"),b=[],c=0;c<a.L;c++)a[c].3h=="1U"&&b.U(a[c]);H b}6 f(a){a=a.1G;K b=p(a,".1U",R);a=p(a,".4r",R);K c=1E.3Y("2W");I(!(!a||!b||p(a,"2W"))){B(b.1f);r(b,"1l");O(K d=a.3i,g=[],h=0;h<d.L;h++)g.U(d[h].4x||d[h].4s);g=g.1R("\\r");c.3l(1E.53(g));a.3l(c);c.2R();c.4o();4U("2W").4T("3k","3k");w(c,"4A",6(){c.2D.4Q(c);b.1m=b.1m.Q("1l","")})}}I(1k 3j!="1d"&&1k M=="1d")M=3j("M").M;K e={2K:{"1e-2g":"","2c-1A":1,"2L-1A-2N":12,1O:N,1n:N,"4a-42":R,"43-1Y":4,1q:R,17:R,"46-15":R,2s:12,"3Z-4l":R,2T:12,"1z-1j":12},13:{21:"&2t;",2Q:R,3U:12,40:12,32:"4R",1v:{1V:"4V 1l",2o:"?",23:"1x\\n\\n",3w:"4W\'t 52 1D O: ",4g:"51 4Z\'t 4X O 1z-1j 4Y: ",2Y:\'<!4P 1z 4O "-//4F//3x 4G 1.0 4E//4D" "1L://2q.3I.3L/4B/3J/3x/3J-4C.4H"><1z 4I="1L://2q.3I.3L/4M/4L"><3M><5S 1L-4K="5v-63" 76="2P/1z; 74=7a-8" /><1n>70 1x</1n></3M><3y 1S="2e-6O:6Y,6K,6T,6S-6R;6Q-2f:#6U;2f:#6V;2e-1Y:6W;2P-3P:3O;"><T 1S="2P-3P:3O;3H-3c:1.6I;"><T 1S="2e-1Y:6H-6F;">1x</T><T 1S="2e-1Y:.6J;3H-6N:6M;"><T>3d 3.0.6L (6Z 7c 3A)</T><T><a 24="1L://3G.2r/1x" 1G="34" 1S="2f:#3z">1L://3G.2r/1x</a></T><T>7e 15 7b 7d.</T><T>79 73-3A 72 71.</T></T><T>75 78 77 J 1j, 6X <a 24="3E://2q.68.2r/67-66/65?69=6a-6e&6d=6c" 1S="2f:#3z">64</a> 4q <2k/>6E 5W 5V!</T></T></3y></1z>\'}},1Z:{2p:N,2w:{}},1X:{},3B:{5U:/\\/\\*[\\s\\S]*?\\*\\//28,5T:/\\/\\/.*$/28,5X:/#.*$/28,5Y:/"([^\\\\"\\n]|\\\\.)*"/g,62:/\'([^\\\\\'\\n]|\\\\.)*\'/g,61:1i M(\'"([^\\\\\\\\"]|\\\\\\\\.)*"\',"3C"),60:1i M("\'([^\\\\\\\\\']|\\\\\\\\.)*\'","3C"),6f:/(&1y;|<)!--[\\s\\S]*?--(&1B;|>)/28,3F:/(6g|1L|3E):\\/\\/(\\w+:{0,1}\\w*@)?(\\S+)(:[0-9]+)?(\\/|\\/([\\w#!:.?+=&%@!\\-\\/]))?/g,6v:{19:/(&1y;|<)\\?=?/g,1c:/\\?(&1B;|>)/g},6u:{19:/(&1y;|<)%=?/g,1c:/%(&1B;|>)/g},6t:{19:/(&1y;|<)\\s*1j.*?(&1B;|>)/2m,1c:/(&1y;|<)\\/\\s*1j\\s*(&1B;|>)/2m}},17:{1J:6(a){6 b(i,k){H e.17.2n(i,k,e.13.1v[k])}O(K c=\'<T 1e="17">\',d=e.17.2C,g=d.3R,h=0;h<g.L;h++)c+=(d[g[h]].1J||b)(a,g[h]);c+="</T>";H c},2n:6(a,b,c){H\'<3D><a 24="#" 1e="6x 6y\'+b+" "+b+\'">\'+c+"</a></3D>"},2j:6(a){K b=a.1G,c=b.1m||"";b=B(p(b,".1U",R).1f);K d=6(g){H(g=18(g+"6A(\\\\w+)").X(c))?g[1]:N}("6z");b&&d&&e.17.2C[d].2u(b);a.30()},2C:{3R:["1V","2o"],1V:{1J:6(a){I(a.V("2s")!=R)H"";K b=a.V("1n");H e.17.2n(a,"1V",b?b:e.13.1v.1V)},2u:6(a){a=1E.6r(t(a.1f));a.1m=a.1m.Q("4j","")}},2o:{2u:6(){K a="6j=0";a+=", 19="+(36.38-3a)/2+", 3c="+(36.3b-35)/2+", 38=3a, 3b=35";a=a.Q(/^,/,"");a=1N.6h("","34",a);a.2R();K b=a.1E;b.6l(e.13.1v.2Y);b.6m();a.2R()}}}},33:6(a,b){K c;I(b)c=[b];Y{c=1E.31(e.13.32);O(K d=[],g=0;g<c.L;g++)d.U(c[g]);c=d}c=c;d=[];I(e.13.2Q)c=c.1M(z());I(c.L===0)H d;O(g=0;g<c.L;g++){O(K h=c[g],i=a,k=c[g].1m,j=3V 0,l={},m=1i M("^\\\\[(?<2y>(.*?))\\\\]$"),s=1i M("(?<2g>[\\\\w-]+)\\\\s*:\\\\s*(?<20>[\\\\w-%#]+|\\\\[.*?\\\\]|\\".*?\\"|\'.*?\')\\\\s*;?","g");(j=s.X(k))!=N;){K o=j.20.Q(/^[\'"]|[\'"]$/g,"");I(o!=N&&m.1s(o)){o=m.X(o);o=o.2y.L>0?o.2y.1h(/\\s*,\\s*/):[]}l[j.2g]=o}h={1G:h,1p:C(i,l)};h.1p.1D!=N&&d.U(h)}H d},1O:6(a,b){K c=J.33(a,b),d=N,g=e.13;I(c.L!==0)O(K h=0;h<c.L;h++){b=c[h];K i=b.1G,k=b.1p,j=k.1D,l;I(j!=N){I(k["1z-1j"]=="R"||e.2K["1z-1j"]==R){d=1i e.4h(j);j="6o"}Y I(d=A(j))d=1i d;Y 6n;l=i.49;I(g.2Q){l=l;K m=x(l),s=12;I(m.16("<![4J[")==0){m=m.25(9);s=R}K o=m.L;I(m.16("]]\\>")==o-3){m=m.25(0,o-3);s=R}l=s?m:l}I((i.1n||"")!="")k.1n=i.1n;k.1D=j;d.2F(k);b=d.2I(l);I((i.1f||"")!="")b.1f=i.1f;i.2D.6p(b,i)}}},2B:6(a){w(1N,"4i",6(){e.1O(a)})}};e.2B=e.2B;e.1O=e.1O;e.2A=6(a,b,c){J.20=a;J.P=b;J.L=a.L;J.1W=c;J.22=N};e.2A.Z.1u=6(){H J.20};e.4h=6(a){6 b(j,l){O(K m=0;m<j.L;m++)j[m].P+=l}K c=A(a),d,g=1i e.1X.6q,h=J,i="2I 1J 2F".1h(" ");I(c!=N){d=1i c;O(K k=0;k<i.L;k++)(6(){K j=i[k];h[j]=6(){H g[j].1w(g,14)}})();d.26==N?1N.23(e.13.1v.23+(e.13.1v.4g+a)):g.2v.U({1C:d.26.15,2M:6(j){O(K l=j.15,m=[],s=d.2v,o=j.P+j.19.L,F=d.26,q,G=0;G<s.L;G++){q=y(l,s[G]);b(q,o);m=m.1M(q)}I(F.19!=N&&j.19!=N){q=y(j.19,F.19);b(q,j.P);m=m.1M(q)}I(F.1c!=N&&j.1c!=N){q=y(j.1c,F.1c);b(q,j.P+j[0].6i(j.1c));m=m.1M(q)}O(j=0;j<m.L;j++)m[j].22=c.22;H m}})}};e.4d=6(){};e.4d.Z={V:6(a,b){K c=J.1p[a];c=c==N?b:c;K d={"R":R,"12":12}[c];H d==N?c:d},3S:6(a){H 1E.3Y(a)},44:6(a,b){K c=[];I(a!=N)O(K d=0;d<a.L;d++)I(1k a[d]=="2U")c=c.1M(y(b,a[d]));H J.3T(c.6k(D))},3T:6(a){O(K b=0;b<a.L;b++)I(a[b]!==N)O(K c=a[b],d=c.P+c.L,g=b+1;g<a.L&&a[b]!==N;g++){K h=a[g];I(h!==N)I(h.P>d)1Q;Y I(h.P==c.P&&h.L>c.L)a[b]=N;Y I(h.P>=c.P&&h.P<d)a[g]=N}H a},48:6(a){K b=[],c=2X(J.V("2c-1A"));v(a,6(d,g){b.U(g+c)});H b},4c:6(a){K b=J.V("1O",[]);I(1k b!="2U"&&b.U==N)b=[b];a:{a=a.1u();K c=3V 0;O(c=c=1K.6s(c||0,0);c<b.L;c++)I(b[c]==a){b=c;1Q a}b=-1}H b!=-1},2l:6(a,b,c){a=["1A","6B"+b,"P"+a,"6C"+(b%2==0?1:2).1u()];J.4c(b)&&a.U("6w");b==0&&a.U("1Q");H\'<T 1e="\'+a.1R(" ")+\'">\'+c+"</T>"},4p:6(a,b){K c="",d=a.1h("\\n").L,g=2X(J.V("2c-1A")),h=J.V("2L-1A-2N");I(h==R)h=(g+d-1).1u().L;Y I(4b(h)==R)h=0;O(K i=0;i<d;i++){K k=b?b[i]:g+i,j;I(k==0)j=e.13.21;Y{j=h;O(K l=k.1u();l.L<j;)l="0"+l;j=l}a=j;c+=J.2l(i,k,a)}H c},41:6(a,b){a=x(a);K c=a.1h("\\n");J.V("2L-1A-2N");K d=2X(J.V("2c-1A"));a="";O(K g=J.V("1D"),h=0;h<c.L;h++){K i=c[h],k=/^(&2t;|\\s)+/.X(i),j=N,l=b?b[h]:d+h;I(k!=N){j=k[0].1u();i=i.1o(j.L);j=j.Q(" ",e.13.21)}i=x(i);I(i.L==0)i=e.13.21;a+=J.2l(h,l,(j!=N?\'<15 1e="\'+g+\' 5Z">\'+j+"</15>":"")+i)}H a},4m:6(a){H a?"<4n>"+a+"</4n>":""},45:6(a,b){6 c(l){H(l=l?l.22||h:h)?l+" ":""}O(K d=0,g="",h=J.V("1D",""),i=0;i<b.L;i++){K k=b[i],j;I(!(k===N||k.L===0)){j=c(k);g+=u(a.1o(d,k.P-d),j+"4e")+u(k.20,j+k.1W);d=k.P+k.L+(k.6b||0)}}g+=u(a.1o(d),c()+"4e");H g},1J:6(a){K b="",c=["1U"],d;I(J.V("2T")==R)J.1p.17=J.1p.1q=12;1m="1U";J.V("2s")==R&&c.U("4j");I((1q=J.V("1q"))==12)c.U("6D");c.U(J.V("1e-2g"));c.U(J.V("1D"));a=a.Q(/^[ ]*[\\n]+|[\\n]*[ ]*$/g,"").Q(/\\r/g," ");b=J.V("43-1Y");I(J.V("4a-42")==R)a=n(a,b);Y{O(K g="",h=0;h<b;h++)g+=" ";a=a.Q(/\\t/g,g)}a=a;a:{b=a=a;g=/<2k\\s*\\/?>|&1y;2k\\s*\\/?&1B;/2m;I(e.13.3U==R)b=b.Q(g,"\\n");I(e.13.40==R)b=b.Q(g,"");b=b.Q(/&#39;/g,"\'");b=b.Q(/&6P;/g,\'"\');b=b.1h("\\n");g=/^\\s*/;h=6G;O(K i=0;i<b.L&&h>0;i++){K k=b[i];I(x(k).L!=0){k=g.X(k);I(k==N){a=a;1Q a}h=1K.4N(k[0].L,h)}}I(h>0)O(i=0;i<b.L;i++)b[i]=b[i].1o(h);a=b.1R("\\n")}I(1q)d=J.48(a);b=J.44(J.2v,a);b=J.45(a,b);b=J.41(b,d);I(J.V("3Z-4l"))b=E(b);1k 2V!="1d"&&2V.4k&&2V.4k.1F(/5B/)&&c.U("5C");H b=\'<T 1f="\'+t(J.1f)+\'" 1e="\'+c.1R(" ")+\'">\'+(J.V("17")?e.17.1J(J):"")+\'<3W 5D="0" 5E="0" 5A="0">\'+J.4m(J.V("1n"))+"<3X><4f>"+(1q?\'<2h 1e="1q">\'+J.4p(a)+"</2h>":"")+\'<2h 1e="15"><T 1e="4r" 1n="54: 5u-47 4q 4o 15">\'+b+"</T></2h></4f></3X></3W></T>"},2I:6(a){I(a===N)a="";J.15=a;K b=J.3S("T");b.49=J.1J(a);J.V("17")&&w(p(b,".17"),"47",e.17.2j);J.V("46-15")&&w(p(b,".15"),"5Q",f);H b},2F:6(a){J.1f=""+1K.5M(1K.5I()*5J).1u();e.1Z.2w[t(J.1f)]=J;J.1p=C(e.2K,a||{});I(J.V("2T")==R)J.1p.17=J.1p.1q=12},5K:6(a){a=a.Q(/^\\s+|\\s+$/g,"").Q(/\\s+/g,"|");H"\\\\b(?:"+a+")\\\\b"},5t:6(a){J.26={19:{1C:a.19,1W:"1j"},1c:{1C:a.1c,1W:"1j"},15:1i M("(?<19>"+a.19.1l+")(?<15>.*?)(?<1c>"+a.1c.1l+")","5a")}}};H e}();1k 2a!="1d"&&(2a.1x=1x);',62,449,'||||||function|||||||||||||||||||||||||||||||||||||return|if|this|var|length|XRegExp|null|for|index|replace|true||div|push|getParam|call|exec|else|prototype||lastIndex|false|config|arguments|code|indexOf|toolbar|RegExp|left|captureNames|slice|right|undefined|class|id|addToken|split|new|script|typeof|source|className|title|substr|params|gutter|_xregexp|test|String|toString|strings|apply|SyntaxHighlighter|lt|html|line|gt|regex|brush|document|match|target|OUTSIDE_CLASS|global|getHtml|Math|http|concat|window|highlight|isRegExp|break|join|style|throw|syntaxhighlighter|expandSource|css|brushes|size|vars|value|space|brushName|alert|href|substring|htmlScript|can|gm|Fa|exports|dA|first|in|font|color|name|td|case|handler|br|getLineHtml|gi|getButtonHtml|help|discoveredBrushes|www|com|collapse|nbsp|execute|regexList|highlighters|hasNamedCapture|values|pattern|Match|all|items|parentNode|Error|init|cache|trigger|getDiv|input|defaults|pad|func|numbers|INSIDE_CLASS|text|useScriptTags|focus|hasFlag|light|object|navigator|textarea|parseInt|aboutDialog|TypeError|preventDefault|getElementsByTagName|tagName|findElements|_blank|250|screen|the|width||500|height|top|version|string|attachEvent|nodeName|type|childNodes|require|readonly|appendChild|highlighter_|setFlag|backref|iterate|freezeTokens|floor|copyAsGlobal|charAt|scope|Array|noBrush|DTD|body|005896|2010|regexLib|gs|span|https|url|alexgorbatchev|margin|w3|xhtml1|Za|org|head|sticky|center|align|output|list|create|removeNestedMatches|bloggerMode|void|table|tbody|createElement|auto|stripBrs|getCodeLinesHtml|tabs|tab|findMatches|getMatchesHtml|quick|click|figureOutLineNumbers|innerHTML|smart|isNaN|isLineHighlighted|Highlighter|plain|tr|brushNotHtmlScript|HtmlScript|load|collapsed|userAgent|links|getTitleHtml|caption|select|getLineNumbersHtml|to|container|textContent|srcElement|returnValue|addEventListener|toLowerCase|innerText|on|aliases|blur|TR|transitional|EN|Transitional|W3C|XHTML|dtd|xmlns|CDATA|equiv|xhtml|1999|min|PUBLIC|DOCTYPE|removeChild|pre|event|attr|jQuery|expand|Can|configured|option|wasn||Brush|find|createTextNode|Hint|from|another|one|constructing|when|sgi|constructor|functions|definition|token|within|flags|supply|expected|frame|same|twice|ignoreCase|multiline|finally|catch|try|extended|gimy|forHtmlScript|double|Content|Infinity|default|switch|imsx|cellspacing|MSIE|ie|border|cellpadding|valueOf|matchChain|escape|random|1E6|getKeywords|execAt|round|Object|after|run|dblclick|toUpperCase|meta|singleLineCComments|multiLineCComments|active|development|singleLinePerlComments|doubleQuotedString|spaces|multiLineSingleQuotedString|multiLineDoubleQuotedString|singleQuotedString|Type|donate|webscr|bin|cgi|paypal|cmd|_s|offset|2930402|hosted_button_id|xclick|xmlComments|ftp|open|lastIndexOf|scrollbars|sort|write|close|continue|htmlscript|replaceChild|Xml|getElementById|max|scriptScriptTags|aspScriptTags|phpScriptTags|highlighted|toolbar_item|command_|command|_|number|alt|nogutter|keep|large|1E3|xx|5em|75em|Arial|83|3em|bottom|family|quot|background|serif|sans|Helvetica|fff|000|1em|please|Geneva|July|About|Gorbatchev|Alex|2004|charset|If|content|like|you|Copyright|utf|syntax|02|highlighter|JavaScript'.split('|'),0,{}))

/**
 * SyntaxHighlighter
 * http://alexgorbatchev.com/SyntaxHighlighter
 *
 * SyntaxHighlighter is donationware. If you are using it, please donate.
 * http://alexgorbatchev.com/SyntaxHighlighter/donate.html
 *
 * @version
 * 3.0.83 (July 02 2010)
 * 
 * @copyright
 * Copyright (C) 2004-2010 Alex Gorbatchev.
 *
 * @license
 * Dual licensed under the MIT and GPL licenses.
 */
eval(function(p,a,c,k,e,d){e=function(c){return(c<a?'':e(parseInt(c/a)))+((c=c%a)>35?String.fromCharCode(c+29):c.toString(36))};if(!''.replace(/^/,String)){while(c--){d[e(c)]=k[c]||e(c)}k=[function(e){return d[e]}];e=function(){return'\\w+'};c=1};while(c--){if(k[c]){p=p.replace(new RegExp('\\b'+e(c)+'\\b','g'),k[c])}}return p}('3 u={8:{}};u.8={A:4(c,k,l,m,n,o){4 d(a,b){2 a!=1?a:b}4 f(a){2 a!=1?a.E():1}c=c.I(":");3 g=c[0],e={};t={"r":K};M=1;5=8.5;9(3 j R c)e[c[j]]="r";k=f(d(k,5.C));l=f(d(l,5.D));m=f(d(m,5.s));o=f(d(o,5.Q));n=f(d(n,5["x-y"]));2{P:g,C:d(t[e.O],k),D:d(t[e.N],l),s:d({"r":r}[e.s],m),"x-y":d(4(a,b){9(3 h=T S("^"+b+"\\\\[(?<q>\\\\w+)\\\\]$","U"),i=1,p=0;p<a.7;p++)6((i=h.J(a[p]))!=1)2 i.q;2 1}(c,"G"),n)}},F:4(c,k,l,m,n,o){4 d(){9(3 a=H,b=0;b<a.7;b++)6(a[b]!==1){6(z a[b]=="L"&&a[b]!="")2 a[b]+"";6(z a[b]=="X"&&a[b].q!="")2 a[b].q+""}2 1}4 f(a,b,h){h=12.13(h);9(3 i=0;i<h.7;i++)h[i].V("15")==b&&a.Y(h[i])}3 g=[];f(g,c,"Z");f(g,c,"W");6(g.7!==0)9(c=0;c<g.7;c++){3 e=g[c],j=d(e.B["14"],e.10,e.B.v,e.v);6(j!==1){j=u.8.A(j,k,l,m,n,o);8.11(j,e)}}}};',62,68,'|null|return|var|function|defaults|if|length|SyntaxHighlighter|for|||||||||||||||||value|true|collapse|reverse|dp|language||first|line|typeof|parseParams|attributes|gutter|toolbar|toString|HighlightAll|firstline|arguments|split|exec|false|string|result|nocontrols|nogutter|brush|ruler|in|XRegExp|new|gi|getAttribute|textarea|object|push|pre|className|highlight|document|getElementsByTagName|class|name'.split('|'),0,{}))

AJS.toInit( function() {
	try {
		if (window.SyntaxHighlighter && window.SyntaxHighlighter.config) {
			var contextRoot = (document.getElementById("confluence-context-path").content || "");
			var clipboardUrl =  contextRoot + '/s/2.0.10/_/download/resources/com.atlassian.confluence.ext.newcode-macro-plugin:clipboard/clipboard.swf';
		    window.SyntaxHighlighter.config.clipboardSwf = clipboardUrl;
		}
		window.SyntaxHighlighter.highlight();
	} catch (err) {
		AJS.log(err);
	}
});

