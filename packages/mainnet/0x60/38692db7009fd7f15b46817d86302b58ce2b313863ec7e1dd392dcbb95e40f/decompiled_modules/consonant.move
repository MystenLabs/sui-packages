module 0x6038692db7009fd7f15b46817d86302b58ce2b313863ec7e1dd392dcbb95e40f::consonant {
    public(friend) fun select(arg0: u8, arg1: u8) : 0x1::string::String {
        let v0 = vector[b"B", b"Br", b"C", b"Cr", b"D", b"F", b"G", b"H", b"J", b"Jad", b"K", b"Kr", b"L", b"M", b"N", b"P", b"Pr", b"Qu", b"R", b"S", b"Sr", b"St", b"Sp", b"T", b"Tr", b"V", b"W", b"Wr", b"Y", b"Z"];
        let v1 = 0x1::string::utf8(*0x1::vector::borrow<vector<u8>>(&v0, ((arg0 % 30) as u64)));
        let v2 = vector[b"anson", b"urton", b"onic", b"all", b"acker", b"aban", b"aden", b"ark", b"brough", b"eyoun", b"ell", b"ellis", b"edex", b"etmer", b"ates", b"ideman", b"yler", b"illy", b"illiumson", b"oan", b"ostov", b"olotov", b"ozhenko", b"oss", b"omm", b"iker", b"ik", b"allister", b"onson", b"ogawa", b"ulan", b"ursor"];
        0x1::string::append_utf8(&mut v1, *0x1::vector::borrow<vector<u8>>(&v2, ((arg1 % 30) as u64)));
        v1
    }

    // decompiled from Move bytecode v6
}

