module 0xebe2409c7ea9636f0e446797515cbee2ab809d898b06d99179d9eda59e1e42d5::keys {
    struct OracleKey has copy, drop, store {
        name: 0x1::string::String,
    }

    public(friend) fun oracle_key(arg0: 0x1::string::String) : OracleKey {
        OracleKey{name: arg0}
    }

    // decompiled from Move bytecode v7
}

