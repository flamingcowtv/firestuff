<!--# set var="title" value="Getting network-manager to forget" -->
<!--# set var="date" value="November 15, 2006" -->

<!--# include file="include/top.html" -->

I made the mistake of associating with the access point in the hotel across the street from the office once to do some testing. From then on, network-manager seemed to prefer that AP, perhaps because the office APs have security enabled. There doesn’t seem to be a UI to make it forget that it likes a certain network. To do so, run gconf-editor and navigate to /system/networking/wireless/networks. SSIDs are folders within this; navigate into the one you want to forget and unset all the keys inside it.

<!--# include file="include/bottom.html" -->