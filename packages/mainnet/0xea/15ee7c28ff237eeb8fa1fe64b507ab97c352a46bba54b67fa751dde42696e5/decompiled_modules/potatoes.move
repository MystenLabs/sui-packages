module 0xea15ee7c28ff237eeb8fa1fe64b507ab97c352a46bba54b67fa751dde42696e5::potatoes {
    public fun decode(arg0: 0x1::string::String) : vector<u8> {
        let v0 = 0x1::string::into_bytes(arg0);
        let v1 = 0x1::vector::length<u8>(&v0);
        let v2 = b"";
        let v3 = 0;
        assert!(v1 % 2 == 0, 9223372273077977087);
        while (v3 < v1) {
            0x1::vector::push_back<u8>(&mut v2, decode_byte(*0x1::vector::borrow<u8>(&v0, v3)) * 16 + decode_byte(*0x1::vector::borrow<u8>(&v0, v3 + 1)));
            v3 = v3 + 2;
        };
        v2
    }

    fun decode_byte(arg0: u8) : u8 {
        if (48 <= arg0 && arg0 < 58) {
            arg0 - 48
        } else if (arg0 == 112 || arg0 == 80) {
            10
        } else if (arg0 == 111 || arg0 == 79) {
            11
        } else if (arg0 == 116 || arg0 == 84) {
            12
        } else if (arg0 == 97 || arg0 == 65) {
            13
        } else if (arg0 == 101 || arg0 == 69) {
            14
        } else {
            assert!(arg0 == 115 || arg0 == 83, 1);
            15
        }
    }

    public fun encode(arg0: vector<u8>) : 0x1::string::String {
        let v0 = vector[b"00", b"01", b"02", b"03", b"04", b"05", b"06", b"07", b"08", b"09", b"0p", b"0o", b"0t", b"0a", b"0e", b"0s", b"10", b"11", b"12", b"13", b"14", b"15", b"16", b"17", b"18", b"19", b"1p", b"1o", b"1t", b"1a", b"1e", b"1s", b"20", b"21", b"22", b"23", b"24", b"25", b"26", b"27", b"28", b"29", b"2p", b"2o", b"2t", b"2a", b"2e", b"2s", b"30", b"31", b"32", b"33", b"34", b"35", b"36", b"37", b"38", b"39", b"3p", b"3o", b"3t", b"3a", b"3e", b"3s", b"40", b"41", b"42", b"43", b"44", b"45", b"46", b"47", b"48", b"49", b"4p", b"4o", b"4t", b"4a", b"4e", b"4s", b"50", b"51", b"52", b"53", b"54", b"55", b"56", b"57", b"58", b"59", b"5p", b"5o", b"5t", b"5a", b"5e", b"5s", b"60", b"61", b"62", b"63", b"64", b"65", b"66", b"67", b"68", b"69", b"6p", b"6o", b"6t", b"6a", b"6e", b"6s", b"70", b"71", b"72", b"73", b"74", b"75", b"76", b"77", b"78", b"79", b"7p", b"7o", b"7t", b"7a", b"7e", b"7s", b"80", b"81", b"82", b"83", b"84", b"85", b"86", b"87", b"88", b"89", b"8p", b"8o", b"8t", b"8a", b"8e", b"8s", b"90", b"91", b"92", b"93", b"94", b"95", b"96", b"97", b"98", b"99", b"9p", b"9o", b"9t", b"9a", b"9e", b"9s", b"p0", b"p1", b"p2", b"p3", b"p4", b"p5", b"p6", b"p7", b"p8", b"p9", b"pp", b"po", b"pt", b"pa", b"pe", b"ps", b"o0", b"o1", b"o2", b"o3", b"o4", b"o5", b"o6", b"o7", b"o8", b"o9", b"op", b"oo", b"ot", b"oa", b"oe", b"os", b"t0", b"t1", b"t2", b"t3", b"t4", b"t5", b"t6", b"t7", b"t8", b"t9", b"tp", b"to", b"tt", b"ta", b"te", b"ts", b"a0", b"a1", b"a2", b"a3", b"a4", b"a5", b"a6", b"a7", b"a8", b"a9", b"ap", b"ao", b"at", b"aa", b"ae", b"as", b"e0", b"e1", b"e2", b"e3", b"e4", b"e5", b"e6", b"e7", b"e8", b"e9", b"ep", b"eo", b"et", b"ea", b"ee", b"es", b"s0", b"s1", b"s2", b"s3", b"s4", b"s5", b"s6", b"s7", b"s8", b"s9", b"sp", b"so", b"st", b"sa", b"se", b"ss"];
        let v1 = b"";
        0x1::vector::reverse<u8>(&mut arg0);
        while (!0x1::vector::is_empty<u8>(&arg0)) {
            let v2 = v1;
            0x1::vector::append<u8>(&mut v2, *0x1::vector::borrow<vector<u8>>(&v0, (0x1::vector::pop_back<u8>(&mut arg0) as u64)));
            v1 = v2;
        };
        0x1::vector::destroy_empty<u8>(arg0);
        0x1::string::utf8(v1)
    }

    // decompiled from Move bytecode v6
}

