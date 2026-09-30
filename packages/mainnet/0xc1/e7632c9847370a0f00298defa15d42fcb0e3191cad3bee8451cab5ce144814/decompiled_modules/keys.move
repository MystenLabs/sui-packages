module 0xc1e7632c9847370a0f00298defa15d42fcb0e3191cad3bee8451cab5ce144814::keys {
    struct OracleKey has copy, drop, store {
        pos0: u16,
    }

    public(friend) fun oracle_key(arg0: u16) : OracleKey {
        OracleKey{pos0: arg0}
    }

    // decompiled from Move bytecode v7
}

