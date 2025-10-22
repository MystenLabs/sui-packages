module 0x2377de485d8fc4d4f0e8e2e93f36b02ea30c6e3118a2af86b5839984867f14ce::scallop_checker {
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

