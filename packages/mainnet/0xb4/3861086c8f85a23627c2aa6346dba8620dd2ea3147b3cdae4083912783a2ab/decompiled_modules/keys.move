module 0xb43861086c8f85a23627c2aa6346dba8620dd2ea3147b3cdae4083912783a2ab::keys {
    struct OracleKey has copy, drop, store {
        pos0: u16,
    }

    public(friend) fun oracle_key(arg0: u16) : OracleKey {
        OracleKey{pos0: arg0}
    }

    // decompiled from Move bytecode v7
}

