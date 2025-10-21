module 0xd50a32ae860628d7f941e2b00dcb993661b2b2c87c2e4c3c0141422bc358528e::scallop_checker {
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

    // decompiled from Move bytecode v6
}

