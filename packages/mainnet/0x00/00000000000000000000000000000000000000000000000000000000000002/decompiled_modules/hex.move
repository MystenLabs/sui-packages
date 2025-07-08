module 0x2::hex {
    public fun decode(arg0: vector<u8>) : vector<u8> {
        let v0 = 0x1::vector::length<u8>(&arg0);
        let v1 = b"";
        let v2 = 0;
        assert!(v0 % 2 == 0, 0);
        while (v2 < v0) {
            0x1::vector::push_back<u8>(&mut v1, decode_byte(*0x1::vector::borrow<u8>(&arg0, v2)) * 16 + decode_byte(*0x1::vector::borrow<u8>(&arg0, v2 + 1)));
            v2 = v2 + 2;
        };
        v1
    }

    fun decode_byte(arg0: u8) : u8 {
        if (48 <= arg0 && arg0 < 58) {
            arg0 - 48
        } else if (65 <= arg0 && arg0 < 71) {
            10 + arg0 - 65
        } else {
            assert!(97 <= arg0 && arg0 < 103, 1);
            10 + arg0 - 97
        }
    }

    public fun encode(arg0: vector<u8>) : vector<u8> {
        let v0 = b"";
        let v1 = 0;
        let v2 = vector[b"00", b"01", b"02", b"03", b"04", b"05", b"06", b"07", b"08", b"09", b"0a", b"0b", b"0c", b"0d", b"0e", b"0f", b"10", b"11", b"12", b"13", b"14", b"15", b"16", b"17", b"18", b"19", b"1a", b"1b", b"1c", b"1d", b"1e", b"1f", b"20", b"21", b"22", b"23", b"24", b"25", b"26", b"27", b"28", b"29", b"2a", b"2b", b"2c", b"2d", b"2e", b"2f", b"30", b"31", b"32", b"33", b"34", b"35", b"36", b"37", b"38", b"39", b"3a", b"3b", b"3c", b"3d", b"3e", b"3f", b"40", b"41", b"42", b"43", b"44", b"45", b"46", b"47", b"48", b"49", b"4a", b"4b", b"4c", b"4d", b"4e", b"4f", b"50", b"51", b"52", b"53", b"54", b"55", b"56", b"57", b"58", b"59", b"5a", b"5b", b"5c", b"5d", b"5e", b"5f", b"60", b"61", b"62", b"63", b"64", b"65", b"66", b"67", b"68", b"69", b"6a", b"6b", b"6c", b"6d", b"6e", b"6f", b"70", b"71", b"72", b"73", b"74", b"75", b"76", b"77", b"78", b"79", b"7a", b"7b", b"7c", b"7d", b"7e", b"7f", b"80", b"81", b"82", b"83", b"84", b"85", b"86", b"87", b"88", b"89", b"8a", b"8b", b"8c", b"8d", b"8e", b"8f", b"90", b"91", b"92", b"93", b"94", b"95", b"96", b"97", b"98", b"99", b"9a", b"9b", b"9c", b"9d", b"9e", b"9f", b"a0", b"a1", b"a2", b"a3", b"a4", b"a5", b"a6", b"a7", b"a8", b"a9", b"aa", b"ab", b"ac", b"ad", b"ae", b"af", b"b0", b"b1", b"b2", b"b3", b"b4", b"b5", b"b6", b"b7", b"b8", b"b9", b"ba", b"bb", b"bc", b"bd", b"be", b"bf", b"c0", b"c1", b"c2", b"c3", b"c4", b"c5", b"c6", b"c7", b"c8", b"c9", b"ca", b"cb", b"cc", b"cd", b"ce", b"cf", b"d0", b"d1", b"d2", b"d3", b"d4", b"d5", b"d6", b"d7", b"d8", b"d9", b"da", b"db", b"dc", b"dd", b"de", b"df", b"e0", b"e1", b"e2", b"e3", b"e4", b"e5", b"e6", b"e7", b"e8", b"e9", b"ea", b"eb", b"ec", b"ed", b"ee", b"ef", b"f0", b"f1", b"f2", b"f3", b"f4", b"f5", b"f6", b"f7", b"f8", b"f9", b"fa", b"fb", b"fc", b"fd", b"fe", b"ff"];
        while (v1 < 0x1::vector::length<u8>(&arg0)) {
            0x1::vector::append<u8>(&mut v0, *0x1::vector::borrow<vector<u8>>(&v2, (*0x1::vector::borrow<u8>(&arg0, v1) as u64)));
            v1 = v1 + 1;
        };
        v0
    }

    // decompiled from Move bytecode v6
}

