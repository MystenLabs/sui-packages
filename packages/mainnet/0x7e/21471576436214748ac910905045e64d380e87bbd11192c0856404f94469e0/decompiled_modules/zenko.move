module 0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::zenko {
    struct ZenkoRegistry has key {
        id: 0x2::object::UID,
        version: u64,
        handle_to_account: 0x2::table::Table<0x1::string::String, 0x2::object::ID>,
        authorized_oracles: 0x2::table::Table<vector<u8>, bool>,
        platform_fee_bps: u64,
        platform_paused: bool,
        paused_by: 0x1::option::Option<address>,
    }

    struct PlatformConfigUpdated has copy, drop {
        platform_fee_bps: u64,
        updated_by: address,
    }

    struct PlatformPauseToggled has copy, drop {
        paused: bool,
        updated_by: address,
    }

    struct HandleRegistered has copy, drop {
        handle: 0x1::string::String,
        account_id: 0x2::object::ID,
    }

    struct OracleRegistered has copy, drop {
        public_key: vector<u8>,
        registered_by: address,
    }

    struct OracleRevoked has copy, drop {
        public_key: vector<u8>,
        revoked_by: address,
    }

    public fun version(arg0: &ZenkoRegistry) : u64 {
        arg0.version
    }

    public fun assert_not_paused(arg0: &ZenkoRegistry) {
        assert!(!arg0.platform_paused, 1);
    }

    public fun assert_version(arg0: &ZenkoRegistry) {
        0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::version::assert_version_matches(arg0.version);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ZenkoRegistry{
            id                 : 0x2::object::new(arg0),
            version            : 1,
            handle_to_account  : 0x2::table::new<0x1::string::String, 0x2::object::ID>(arg0),
            authorized_oracles : 0x2::table::new<vector<u8>, bool>(arg0),
            platform_fee_bps   : 0,
            platform_paused    : false,
            paused_by          : 0x1::option::none<address>(),
        };
        0x2::transfer::share_object<ZenkoRegistry>(v0);
    }

    public fun is_handle_taken(arg0: &ZenkoRegistry, arg1: 0x1::string::String) : bool {
        0x2::table::contains<0x1::string::String, 0x2::object::ID>(&arg0.handle_to_account, arg1)
    }

    public fun is_oracle_authorized(arg0: &ZenkoRegistry, arg1: vector<u8>) : bool {
        0x2::table::contains<vector<u8>, bool>(&arg0.authorized_oracles, arg1) && *0x2::table::borrow<vector<u8>, bool>(&arg0.authorized_oracles, arg1)
    }

    public fun migrate_zenko_registry(arg0: &mut ZenkoRegistry, arg1: &0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::access::RoleRegistry, arg2: &0x2::tx_context::TxContext) {
        0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::access::assert_super_admin(arg1, arg2);
        0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::version::migrate(&mut arg0.version, 0x2::object::id<ZenkoRegistry>(arg0));
    }

    public fun original_package_id_bytes() : vector<u8> {
        0x2::address::to_bytes(0x1::type_name::original_id<ZenkoRegistry>())
    }

    public fun pause_platform(arg0: &mut ZenkoRegistry, arg1: &0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::access::RoleRegistry, arg2: &0x2::tx_context::TxContext) {
        assert_version(arg0);
        0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::access::assert_admin(arg1, arg2);
        assert!(!arg0.platform_paused, 1);
        arg0.platform_paused = true;
        arg0.paused_by = 0x1::option::some<address>(0x2::tx_context::sender(arg2));
        let v0 = PlatformPauseToggled{
            paused     : true,
            updated_by : 0x2::tx_context::sender(arg2),
        };
        0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::events::emit_event<PlatformPauseToggled>(v0);
    }

    public(friend) fun register_handle(arg0: &mut ZenkoRegistry, arg1: 0x1::string::String, arg2: 0x2::object::ID, arg3: &0x2::tx_context::TxContext) {
        assert!(!0x2::table::contains<0x1::string::String, 0x2::object::ID>(&arg0.handle_to_account, arg1), 2);
        0x2::table::add<0x1::string::String, 0x2::object::ID>(&mut arg0.handle_to_account, arg1, arg2);
        let v0 = HandleRegistered{
            handle     : arg1,
            account_id : arg2,
        };
        0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::events::emit_event<HandleRegistered>(v0);
    }

    public fun register_oracle(arg0: &mut ZenkoRegistry, arg1: &0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::access::RoleRegistry, arg2: vector<u8>, arg3: &0x2::tx_context::TxContext) {
        assert_version(arg0);
        0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::access::assert_super_admin(arg1, arg3);
        assert!(0x1::vector::length<u8>(&arg2) == 33, 6);
        assert!(!0x2::table::contains<vector<u8>, bool>(&arg0.authorized_oracles, arg2), 4);
        0x2::table::add<vector<u8>, bool>(&mut arg0.authorized_oracles, arg2, true);
        let v0 = OracleRegistered{
            public_key    : arg2,
            registered_by : 0x2::tx_context::sender(arg3),
        };
        0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::events::emit_event<OracleRegistered>(v0);
    }

    public fun revoke_oracle(arg0: &mut ZenkoRegistry, arg1: &0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::access::RoleRegistry, arg2: vector<u8>, arg3: &0x2::tx_context::TxContext) {
        assert_version(arg0);
        0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::access::assert_super_admin(arg1, arg3);
        assert!(0x2::table::contains<vector<u8>, bool>(&arg0.authorized_oracles, arg2), 5);
        0x2::table::remove<vector<u8>, bool>(&mut arg0.authorized_oracles, arg2);
        let v0 = OracleRevoked{
            public_key : arg2,
            revoked_by : 0x2::tx_context::sender(arg3),
        };
        0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::events::emit_event<OracleRevoked>(v0);
    }

    public fun set_platform_fee(arg0: &mut ZenkoRegistry, arg1: &0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::access::RoleRegistry, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert_version(arg0);
        0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::access::assert_admin(arg1, arg3);
        assert!(arg2 <= 10000, 8);
        arg0.platform_fee_bps = arg2;
        let v0 = PlatformConfigUpdated{
            platform_fee_bps : arg2,
            updated_by       : 0x2::tx_context::sender(arg3),
        };
        0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::events::emit_event<PlatformConfigUpdated>(v0);
    }

    public fun unpause_platform(arg0: &mut ZenkoRegistry, arg1: &0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::access::RoleRegistry, arg2: &0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert!(arg0.platform_paused, 1);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x1::option::is_some<address>(&arg0.paused_by) && (v0 == *0x1::option::borrow<address>(&arg0.paused_by) || 0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::access::is_super_admin(arg1, v0)) || 0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::access::has_pause_authority(arg1, v0), 7);
        arg0.platform_paused = false;
        arg0.paused_by = 0x1::option::none<address>();
        let v1 = PlatformPauseToggled{
            paused     : false,
            updated_by : v0,
        };
        0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::events::emit_event<PlatformPauseToggled>(v1);
    }

    public(friend) fun unregister_handle(arg0: &mut ZenkoRegistry, arg1: 0x1::string::String) {
        assert!(0x2::table::contains<0x1::string::String, 0x2::object::ID>(&arg0.handle_to_account, arg1), 3);
        0x2::table::remove<0x1::string::String, 0x2::object::ID>(&mut arg0.handle_to_account, arg1);
    }

    // decompiled from Move bytecode v7
}

