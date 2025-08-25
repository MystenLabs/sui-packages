module 0xa563ace20f247f966b1819909d6cf24a52cc18c2ba14a72890c88d44be066545::memo {
    public fun swap_in() : 0x1::string::String {
        0x1::string::utf8(b"psm_swap_in")
    }

    public fun swap_out() : 0x1::string::String {
        0x1::string::utf8(b"psm_swap_out")
    }

    // decompiled from Move bytecode v6
}

