module 0x29c7ccdbf2e157e1d2fe14cd311ca876126600436e507468574dfd6c4de36c44::scallop_checker {
    public(friend) fun check(arg0: &0x1::ascii::String, arg1: u64) : u8 {
        if (arg1 == 0) {
            return 0
        };
        if (*arg0 == 0x1::ascii::string(b"854950aa624b1df59fe64e630b2ba7c550642e9342267a33061d59fb31582da5::scallop_usdc::SCALLOP_USDC")) {
            1
        } else {
            0
        }
    }

    public fun get_scallop_usdc_type() : 0x1::ascii::String {
        0x1::ascii::string(b"854950aa624b1df59fe64e630b2ba7c550642e9342267a33061d59fb31582da5::scallop_usdc::SCALLOP_USDC")
    }

    // decompiled from Move bytecode v6
}

