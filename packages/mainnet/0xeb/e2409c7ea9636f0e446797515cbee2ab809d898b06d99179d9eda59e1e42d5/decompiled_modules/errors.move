module 0xebe2409c7ea9636f0e446797515cbee2ab809d898b06d99179d9eda59e1e42d5::errors {
    public(friend) fun admin_module_invalid_exponent() : u64 {
        20003
    }

    public(friend) fun admin_module_invalid_name() : u64 {
        20001
    }

    public(friend) fun admin_module_invalid_price() : u64 {
        20002
    }

    public(friend) fun auth_last_owner() : u64 {
        22002
    }

    public(friend) fun auth_no_auth() : u64 {
        22001
    }

    public(friend) fun oracle_wrong_version() : u64 {
        21001
    }

    // decompiled from Move bytecode v7
}

