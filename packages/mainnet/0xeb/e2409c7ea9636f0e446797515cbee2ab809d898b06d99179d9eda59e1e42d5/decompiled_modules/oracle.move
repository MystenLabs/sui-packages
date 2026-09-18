module 0xebe2409c7ea9636f0e446797515cbee2ab809d898b06d99179d9eda59e1e42d5::oracle {
    struct Oracle has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        rate: u128,
        version: u64,
    }

    public fun version(arg0: &Oracle) : u64 {
        arg0.version
    }

    public(friend) fun assert_version(arg0: &Oracle) {
        assert!(arg0.version == 0xebe2409c7ea9636f0e446797515cbee2ab809d898b06d99179d9eda59e1e42d5::constants::version(), 0xebe2409c7ea9636f0e446797515cbee2ab809d898b06d99179d9eda59e1e42d5::errors::oracle_wrong_version());
    }

    public(friend) fun create(arg0: &mut 0xebe2409c7ea9636f0e446797515cbee2ab809d898b06d99179d9eda59e1e42d5::registry::OracleRegistry, arg1: 0x1::string::String, arg2: u128) : Oracle {
        0xebe2409c7ea9636f0e446797515cbee2ab809d898b06d99179d9eda59e1e42d5::registry::assert_name(&arg1);
        0xebe2409c7ea9636f0e446797515cbee2ab809d898b06d99179d9eda59e1e42d5::registry::increment_total(arg0);
        Oracle{
            id      : 0x2::derived_object::claim<0xebe2409c7ea9636f0e446797515cbee2ab809d898b06d99179d9eda59e1e42d5::keys::OracleKey>(0xebe2409c7ea9636f0e446797515cbee2ab809d898b06d99179d9eda59e1e42d5::registry::uid_mut(arg0), 0xebe2409c7ea9636f0e446797515cbee2ab809d898b06d99179d9eda59e1e42d5::keys::oracle_key(arg1)),
            name    : arg1,
            rate    : arg2,
            version : 0xebe2409c7ea9636f0e446797515cbee2ab809d898b06d99179d9eda59e1e42d5::constants::version(),
        }
    }

    public fun name(arg0: &Oracle) : 0x1::string::String {
        arg0.name
    }

    public fun rate(arg0: &Oracle) : u128 {
        arg0.rate
    }

    public(friend) fun set_rate(arg0: &mut Oracle, arg1: u128) {
        arg0.rate = arg1;
    }

    public(friend) fun share(arg0: Oracle) {
        0x2::transfer::share_object<Oracle>(arg0);
    }

    // decompiled from Move bytecode v7
}

