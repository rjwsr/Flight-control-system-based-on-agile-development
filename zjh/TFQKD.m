clear
%%参数
alice = User;
bob = User;
N=1000000;
attackxishu = 1;

%% alice参数
alice.ba = generateRandom(1,N);

for k=1:N
    alice.Ja(k) = k;    
end
     
alice.Na =  random('poisson',0.1,1,N); 
alice.Sa = (0.49)^(1/2);
alice.Ea = alice.Na-alice.Sa;



bob.ba = generateRandom(1,N);
for k=1:N
    bob.Ja(k) = k;
end
bob.Na =  random('poisson',0.1,1,N);
bob.Sa = (0.49)^(1/2);
bob.Ea = bob.Na-bob.Sa;


%% 协议
j = 0;
for k=1:N
    if alice.Ja(k) == bob.Ja(k)
        if alice.Na(k) ~= 0 && bob.Na(k) ~= 0
            j=j+1;
            qkey(j) = alice.ba(k);
            c = xor(alice.ba(k),bob.ba(k));
            if c == 2
                bob.ba(k) = xor (bob.ba(k),1);
            end
        end
    end
end

attackkey = [];
if attackxishu == 1
    j1 = 0;
    j2 = 0;
    PP(1,:) = generateRandom(99,N)*0.01;
    PP(2,:) = generateRandom(99,N)*0.01;
    for k = 1:length(PP)
        if alice.Na(k) ~= 0 && bob.Na(k) ~= 0
            j1 = j1+1;
            if PP(1,k)<(1-alice.Sa) && PP(2,k)<(1-bob.Sa)
                j2 = j2+1;
                attackkey(1,j2) = j1;
                attackkey(2,j2) = alice.ba(k);
                attackkey(3,j2) = bob.ba(k);
            end
        end
    end
    for k = 1:length(attackkey)
        attackkey(4,k) = attackkey(2,k)
    end
end
po = 0;   
  


if length(attackkey) ~= 0
    for kk = 1:length(attackkey)
        if qkey(attackkey(1,kk)) == attackkey(4,kk)
            po = po+1;
        end
    end
 end
huitu = [length(qkey);po]
hold on;
bar(huitu);
set(gca,'XTickLabel',{' ',' ','Alice和bob',' ','攻击者',' ',' '})
ylabel('获取密钥位数')
hold off;