<!--# set var="title" value="BladeCenter power hurts my head" -->
<!--# set var="date" value="2006-06-28" -->

<!--# include file="include/top.html" -->

I’m posting this here hoping that someone will either confirm or correct it; here we go.

We use IBM [BladeCenters](http://www.cdw.com/shop/products/default.aspx?EDC=703139) for servers at [CORESense](http://www.coresense.com/). I’ve mentioned them here before: 7U units that hold 14 servers, for a maximum of 28 processors, 28 drives, redundant power supplies, redundant switches and redundant management/KVM modules in a very small space. However, they absolutely suck power. Each has two power domains, with a primary and redundant 2000W power supply in each. The two power domains in mine currently report using 1374W and 1571W, for a total of 2945W. They’re fed at Equinix by one primary and one redundant 30A/208V (6240VA) circuit. Each circuit goes into a [PDU](http://www.cdw.com/shop/products/default.aspx?EDC=506225) with 3 outputs. Each PDU has two of the outputs used, with 1 spare.

This looks to me like I can run 3 BladeCenters on two primary and two redundant circuits. I’ve got enough legit plugs, and even if all the power supplies were operating at full capacity, totalling 6000W, I’d have margin for a [power factor](http://en.wikipedia.org/wiki/Power_factor) of 0.96 before I maxed the circuit (assuming quality power equipment on the part of the hosting facility). This is probably safe, as these are high-end power supplies and probably have PF > 0.99, but that spec is hard to find anywhere.

Anyone care to explain to me if I’m being an idiot?

<!--# include file="include/bottom.html" -->
