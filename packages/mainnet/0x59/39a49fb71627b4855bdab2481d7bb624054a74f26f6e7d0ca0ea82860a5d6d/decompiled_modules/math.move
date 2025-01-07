module 0x5939a49fb71627b4855bdab2481d7bb624054a74f26f6e7d0ca0ea82860a5d6d::math {
    public fun m_round_down(arg0: u64, arg1: u64) : u64 {
        arg0 - arg0 % arg1
    }

    // decompiled from Move bytecode v6
}

