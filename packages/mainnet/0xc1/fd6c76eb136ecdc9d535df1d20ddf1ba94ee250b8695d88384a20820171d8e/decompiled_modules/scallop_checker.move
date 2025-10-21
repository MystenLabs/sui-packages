module 0xc1fd6c76eb136ecdc9d535df1d20ddf1ba94ee250b8695d88384a20820171d8e::scallop_checker {
    public(friend) fun check(arg0: &0x1::ascii::String, arg1: u64) : u8 {
        if (arg1 == 0) {
            return 0
        };
        if (*arg0 == 0x1::ascii::string(b"0x854950aa624b1df59fe64e630b2ba7c550642e9342267a33061d59fb31582da5::scallop_usdc::SCALLOP_USDC")) {
            1
        } else {
            0
        }
    }

    public fun get_scallop_usdc_type() : 0x1::ascii::String {
        0x1::ascii::string(b"0x854950aa624b1df59fe64e630b2ba7c550642e9342267a33061d59fb31582da5::scallop_usdc::SCALLOP_USDC")
    }

    // decompiled from Move bytecode v6
}

