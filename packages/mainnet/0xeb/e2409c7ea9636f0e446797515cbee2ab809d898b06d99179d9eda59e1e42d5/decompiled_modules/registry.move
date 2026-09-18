module 0xebe2409c7ea9636f0e446797515cbee2ab809d898b06d99179d9eda59e1e42d5::registry {
    struct OracleRegistry has key {
        id: 0x2::object::UID,
        version: u64,
        total_oracles: u64,
    }

    public fun version(arg0: &OracleRegistry) : u64 {
        arg0.version
    }

    public(friend) fun assert_name(arg0: &0x1::string::String) {
        let v0 = 0x1::vector::length<u8>(0x1::string::as_bytes(arg0));
        assert!(v0 > 0, 0xebe2409c7ea9636f0e446797515cbee2ab809d898b06d99179d9eda59e1e42d5::errors::admin_module_invalid_name());
        assert!(v0 <= 0xebe2409c7ea9636f0e446797515cbee2ab809d898b06d99179d9eda59e1e42d5::constants::max_oracle_name_length(), 0xebe2409c7ea9636f0e446797515cbee2ab809d898b06d99179d9eda59e1e42d5::errors::admin_module_invalid_name());
    }

    public(friend) fun assert_version(arg0: &OracleRegistry) {
        assert!(arg0.version == 0xebe2409c7ea9636f0e446797515cbee2ab809d898b06d99179d9eda59e1e42d5::constants::version(), 0xebe2409c7ea9636f0e446797515cbee2ab809d898b06d99179d9eda59e1e42d5::errors::oracle_wrong_version());
    }

    public(friend) fun increment_total(arg0: &mut OracleRegistry) {
        arg0.total_oracles = arg0.total_oracles + 1;
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = OracleRegistry{
            id            : 0x2::object::new(arg0),
            version       : 0xebe2409c7ea9636f0e446797515cbee2ab809d898b06d99179d9eda59e1e42d5::constants::version(),
            total_oracles : 0,
        };
        0x2::transfer::share_object<OracleRegistry>(v0);
    }

    public fun oracle_address(arg0: &OracleRegistry, arg1: 0x1::string::String) : address {
        0x2::derived_object::derive_address<0xebe2409c7ea9636f0e446797515cbee2ab809d898b06d99179d9eda59e1e42d5::keys::OracleKey>(0x2::object::uid_to_inner(&arg0.id), 0xebe2409c7ea9636f0e446797515cbee2ab809d898b06d99179d9eda59e1e42d5::keys::oracle_key(arg1))
    }

    public fun oracle_exists(arg0: &OracleRegistry, arg1: 0x1::string::String) : bool {
        0x2::derived_object::exists<0xebe2409c7ea9636f0e446797515cbee2ab809d898b06d99179d9eda59e1e42d5::keys::OracleKey>(&arg0.id, 0xebe2409c7ea9636f0e446797515cbee2ab809d898b06d99179d9eda59e1e42d5::keys::oracle_key(arg1))
    }

    public fun total_oracles(arg0: &OracleRegistry) : u64 {
        arg0.total_oracles
    }

    public(friend) fun uid_mut(arg0: &mut OracleRegistry) : &mut 0x2::object::UID {
        assert_version(arg0);
        &mut arg0.id
    }

    // decompiled from Move bytecode v7
}

