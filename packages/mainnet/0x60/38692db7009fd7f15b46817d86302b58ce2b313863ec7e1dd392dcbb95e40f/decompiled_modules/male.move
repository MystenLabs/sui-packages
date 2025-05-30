module 0x6038692db7009fd7f15b46817d86302b58ce2b313863ec7e1dd392dcbb95e40f::male {
    public(friend) fun select(arg0: u16) : 0x1::string::String {
        let v0 = arg0 % 34;
        let v1 = &v0;
        let v2 = if (*v1 == 0) {
            vector[b"Abdul", b"Adi", b"Audi", b"Agner", b"Ajax", b"Alan", b"Alyn", b"Alt", b"Alton", b"Altair"]
        } else if (*v1 == 1) {
            vector[b"Amp", b"Apple", b"Andon", b"Andy", b"Andrew", b"Ang", b"App", b"Arax", b"Arakan", b"Akira"]
        } else if (*v1 == 2) {
            vector[b"Akihero", b"Akihiko", b"Arin", b"Arp", b"Ash", b"Atsushi", b"Atto", b"Audio", b"Avi", b"Axis"]
        } else if (*v1 == 3) {
            vector[b"Batch", b"Baud", b"Balun", b"Bear", b"Ben", b"Beep", b"Bic", b"Bing", b"Bit", b"Blade"]
        } else if (*v1 == 4) {
            vector[b"Board", b"Bob", b"Boot", b"Bot", b"Botan", b"Box", b"Buddy", b"Bug", b"Bus", b"Biff"]
        } else if (*v1 == 5) {
            vector[b"Biffo", b"Bigun", b"Bingwen", b"Bo", b"Bryant", b"Byte", b"Cam", b"Cap", b"Cas", b"Case"]
        } else if (*v1 == 6) {
            vector[b"Cadium", b"Cadmium", b"Cael", b"Cap", b"Cell", b"Cermet", b"Charles", b"Chip", b"Chonglin", b"Chen"]
        } else if (*v1 == 7) {
            vector[b"Choi", b"Cipher", b"Claude", b"Clifford", b"Cloud", b"Click", b"Clip", b"Codec", b"Code", b"Coco"]
        } else if (*v1 == 8) {
            vector[b"Coil", b"Cord", b"Crash", b"Cron", b"Crypto", b"Cyber", b"Cybo", b"Cyrix", b"Cyke", b"Cyko"]
        } else if (*v1 == 9) {
            vector[b"Daemon", b"Dai", b"Daryl", b"Dash", b"David", b"Degauss", b"Del", b"Dell", b"Delun", b"Delboy"]
        } else if (*v1 == 10) {
            vector[b"Deming", b"Digit", b"Dirk", b"Diode", b"Ding", b"Dingdong", b"Dingbang", b"Donut", b"Dock", b"Donk"]
        } else if (*v1 == 11) {
            vector[b"Dong", b"Dom", b"Domdom", b"Dommy", b"Dyker", b"Dollar", b"Dyne", b"Edgar", b"Error", b"Enlai"]
        } else if (*v1 == 12) {
            vector[b"Eno", b"Eiko", b"Eldon", b"Fax", b"Fa", b"Fai", b"Far", b"Farwang", b"Flash", b"Frag"]
        } else if (*v1 == 13) {
            vector[b"Fragmeister", b"Fragman", b"Fu", b"Gan", b"Gaff", b"Gaffa", b"Gaffacake", b"Glitch", b"Glitchman", b"Glenjamin"]
        } else if (*v1 == 14) {
            vector[b"Genghis", b"Gort", b"Gram", b"Grep", b"Grid", b"Grit", b"Guang", b"Guoliang", b"Guowei", b"Guozhi"]
        } else if (*v1 == 15) {
            vector[b"Guy", b"Guybrush", b"Hai", b"Han", b"Hans", b"Hannibal", b"Hash", b"Hecto", b"Hub", b"Hud"]
        } else if (*v1 == 16) {
            vector[b"Ho", b"Hoho", b"Hong", b"Howie", b"Howin", b"Hu", b"Hui", b"Hung", b"Isaac", b"Indigo"]
        } else if (*v1 == 17) {
            vector[b"Jack", b"Jax", b"Jank", b"Jango", b"Jinx", b"Jiang", b"Jin", b"Jing", b"Jinghai", b"John"]
        } else if (*v1 == 18) {
            vector[b"Johnjohn", b"Jojo", b"Johnny", b"Ronseal", b"Silicon", b"Spider", b"Spizzo", b"Strobe", b"Kaiser", b"Kaizen"]
        } else if (*v1 == 19) {
            vector[b"Kaneda", b"Kang", b"Kilo", b"Kriz", b"Ky", b"Kyle", b"Kylo", b"Kade", b"Knox", b"Kirone"]
        } else if (*v1 == 20) {
            vector[b"Kid", b"Kei", b"Lan", b"Llan", b"Larry", b"Leo", b"Lee", b"Leon", b"Leonard", b"Len"]
        } else if (*v1 == 21) {
            vector[b"Lenny", b"Leonardo", b"Link", b"Lithium", b"Li", b"Ling", b"Lo", b"Lock", b"Loot", b"Lynx"]
        } else if (*v1 == 22) {
            vector[b"Lynk", b"Mac", b"Masaru", b"Masato", b"Masoto", b"Masala", b"Mic", b"Mike", b"Miles", b"Ming"]
        } else if (*v1 == 23) {
            vector[b"Mingli", b"Minzhe", b"M.M", b"Mod", b"Mortimer", b"Mylar", b"Nano", b"Nandez", b"Nate", b"Neo"]
        } else if (*v1 == 24) {
            vector[b"Neon", b"Nova", b"Nokia", b"Niander", b"Nike", b"Nezu", b"Nut", b"Oberon", b"Onyx", b"Orion"]
        } else if (*v1 == 25) {
            vector[b"Osson", b"Otto", b"Patch", b"Phase", b"Paradox", b"Phoenix", b"Pine", b"Piezo", b"Ping", b"Pingu"]
        } else if (*v1 == 26) {
            vector[b"Pluton", b"Proto", b"Peng", b"Pulse", b"Quad", b"Quail", b"Quade", b"Quaid", b"Quan", b"Rack"]
        } else if (*v1 == 27) {
            vector[b"Radian", b"Radius", b"Ray", b"Raze", b"Rexx", b"Ren", b"Renshu", b"Robby", b"Rom", b"Rick"]
        } else if (*v1 == 28) {
            vector[b"Rik", b"Rip", b"Ron", b"Router", b"Roy", b"Rye", b"Ryo", b"Ryuk", b"Ru", b"Ruse"]
        } else if (*v1 == 29) {
            vector[b"Rush", b"Rocket", b"Ryker", b"Skip", b"Slag", b"Sonny", b"Shen", b"Stack", b"Stephen", b"Syke"]
        } else if (*v1 == 30) {
            vector[b"Sike", b"Srike", b"Sike", b"Stryker", b"Superhans", b"Synch", b"Synchro", b"Tag", b"Taff", b"Taffy"]
        } else if (*v1 == 31) {
            vector[b"Tetsuo", b"Thread", b"Thomas", b"Thunk", b"Thyristor", b"Track", b"Troy", b"Tuple", b"Turbo", b"Turbotax"]
        } else if (*v1 == 32) {
            vector[b"Vax", b"Vaxen", b"Vector", b"Verizon", b"Voxel", b"Web", b"Wedge", b"Wire", b"Yukimasa", b"Yosuke"]
        } else {
            assert!(*v1 == 33, 13906834526530699263);
            vector[b"Zero", b"Zinc", b"Zippo", b"Zed", b"Zip"]
        };
        let v3 = v2;
        0x1::string::utf8(*0x1::vector::borrow<vector<u8>>(&v3, (arg0 as u64) % 0x1::vector::length<vector<u8>>(&v3)))
    }

    // decompiled from Move bytecode v6
}

