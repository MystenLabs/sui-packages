module 0xc2ae6693383e4a81285136effc8190c7baaf0e75aafa36d1c69cd2170cfc3803::memo {
    public fun swap_in() : 0x1::string::String {
        0x1::string::utf8(b"psm_swap_in")
    }

    public fun swap_out() : 0x1::string::String {
        0x1::string::utf8(b"psm_swap_out")
    }

    // decompiled from Move bytecode v6
}

