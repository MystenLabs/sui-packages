module 0x4af6148a8d1e0593b108588e30f688644b408990df263f4d49cdbd7b17b889ce::math {
    public fun m_round_down(arg0: u64, arg1: u64) : u64 {
        arg0 - arg0 % arg1
    }

    // decompiled from Move bytecode v6
}

