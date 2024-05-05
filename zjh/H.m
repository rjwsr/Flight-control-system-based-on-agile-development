function r = H(x) % 随机生成0或者1
    u = 0.1;
    a = 0.001;
    l = 10000;
    Em = 0.01275;
    eotp = 0.03;
    n = (10)^(-(a*(l/2))/10);
    n1 = 0.03*n;
    Pdc = 0.00000001;
    Qu = 1-((1-Pdc)^2)*(exp(1))^(-(u*n1));
    Eu = 1/2+(1/(2*Qu))*(1-Pdc)*((exp(1))^(-(u*n1*(1-(eotp+Em))))-(exp(1))^(-(u*n1*(eotp+Em))));
    P(x) = Eu;   
    help log;
    log2(P(x));
    r = 0;
    for x = 1:10000
    r = P(x)*log2(P(x));
    end
    r;
end