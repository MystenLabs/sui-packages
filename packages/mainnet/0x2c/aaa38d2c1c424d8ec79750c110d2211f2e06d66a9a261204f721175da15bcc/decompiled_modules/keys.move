module 0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::keys {
    struct OracleKey has copy, drop, store {
        pos0: u16,
    }

    public(friend) fun oracle_key(arg0: u16) : OracleKey {
        OracleKey{pos0: arg0}
    }

    // decompiled from Move bytecode v7
}

