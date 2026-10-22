module 0xb43861086c8f85a23627c2aa6346dba8620dd2ea3147b3cdae4083912783a2ab::registry {
    struct OracleRegistry has key {
        id: 0x2::object::UID,
        version: u64,
        total_oracles: u64,
    }

    public fun version(arg0: &OracleRegistry) : u64 {
        arg0.version
    }

    public fun assert_version(arg0: &OracleRegistry) {
        assert!(arg0.version == 0xb43861086c8f85a23627c2aa6346dba8620dd2ea3147b3cdae4083912783a2ab::constants::version(), 0xb43861086c8f85a23627c2aa6346dba8620dd2ea3147b3cdae4083912783a2ab::errors::oracle_wrong_version());
    }

    public(friend) fun bump_total_oracles(arg0: &mut OracleRegistry) {
        arg0.total_oracles = arg0.total_oracles + 1;
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = OracleRegistry{
            id            : 0x2::object::new(arg0),
            version       : 0xb43861086c8f85a23627c2aa6346dba8620dd2ea3147b3cdae4083912783a2ab::constants::version(),
            total_oracles : 0,
        };
        0x2::transfer::share_object<OracleRegistry>(v0);
    }

    public(friend) fun migrate(arg0: &mut OracleRegistry) {
        assert!(arg0.version < 0xb43861086c8f85a23627c2aa6346dba8620dd2ea3147b3cdae4083912783a2ab::constants::version(), 0xb43861086c8f85a23627c2aa6346dba8620dd2ea3147b3cdae4083912783a2ab::errors::oracle_already_migrated());
        arg0.version = 0xb43861086c8f85a23627c2aa6346dba8620dd2ea3147b3cdae4083912783a2ab::constants::version();
    }

    public fun oracle_address(arg0: &OracleRegistry, arg1: u16) : address {
        0x2::derived_object::derive_address<0xb43861086c8f85a23627c2aa6346dba8620dd2ea3147b3cdae4083912783a2ab::keys::OracleKey>(0x2::object::uid_to_inner(&arg0.id), 0xb43861086c8f85a23627c2aa6346dba8620dd2ea3147b3cdae4083912783a2ab::keys::oracle_key(arg1))
    }

    public fun oracle_exists(arg0: &OracleRegistry, arg1: u16) : bool {
        0x2::derived_object::exists<0xb43861086c8f85a23627c2aa6346dba8620dd2ea3147b3cdae4083912783a2ab::keys::OracleKey>(&arg0.id, 0xb43861086c8f85a23627c2aa6346dba8620dd2ea3147b3cdae4083912783a2ab::keys::oracle_key(arg1))
    }

    public fun total_oracles(arg0: &OracleRegistry) : u64 {
        arg0.total_oracles
    }

    public(friend) fun uid_mut(arg0: &mut OracleRegistry) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    // decompiled from Move bytecode v7
}

