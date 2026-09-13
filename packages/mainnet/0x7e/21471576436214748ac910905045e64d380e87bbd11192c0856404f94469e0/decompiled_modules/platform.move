module 0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::platform {
    struct PlatformRegistry has key {
        id: 0x2::object::UID,
        version: u64,
        active_claims: 0x2::table::Table<0x1::string::String, 0x2::object::ID>,
    }

    struct PlatformBinding has key {
        id: 0x2::object::UID,
        account_id: 0x1::option::Option<0x2::object::ID>,
        platform: 0x1::string::String,
        platform_uid: 0x1::string::String,
        username: 0x1::string::String,
        tagline: 0x1::string::String,
        region: 0x1::string::String,
        created_at: u64,
        updated_at: u64,
        connect_reward_granted: bool,
    }

    struct PlatformAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct PlatformBound has copy, drop {
        binding_id: 0x2::object::ID,
        account_id: 0x2::object::ID,
        platform: 0x1::string::String,
        platform_uid: 0x1::string::String,
        username: 0x1::string::String,
        is_rebind: bool,
    }

    struct PlatformReleased has copy, drop {
        binding_id: 0x2::object::ID,
        former_account_id: 0x2::object::ID,
        platform: 0x1::string::String,
        platform_uid: 0x1::string::String,
    }

    struct PlatformDisplayUpdated has copy, drop {
        binding_id: 0x2::object::ID,
        username: 0x1::string::String,
    }

    public fun assert_version(arg0: &PlatformRegistry) {
        0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::version::assert_version_matches(arg0.version);
    }

    public fun bind_platform(arg0: &mut 0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::account::Account, arg1: &0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::account::AccountAuth, arg2: &mut PlatformRegistry, arg3: &0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::zenko::ZenkoRegistry, arg4: &0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::config::ConfigStore, arg5: &0x2::clock::Clock, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: 0x1::string::String, arg10: 0x1::string::String, arg11: u64, arg12: u64, arg13: vector<u8>, arg14: vector<u8>, arg15: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert_version(arg2);
        0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::account::verify_auth(arg0, arg1);
        0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::oracle::verify_platform_bind_permit(arg3, arg4, arg5, 0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::account::id(arg0), arg6, arg7, arg11, arg12, arg13, arg14);
        0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::account::consume_nonce(arg0, arg11);
        create_binding_internal(arg0, arg2, arg6, arg7, arg8, arg9, arg10, arg5, arg15)
    }

    public fun binding_exists(arg0: &PlatformRegistry, arg1: &0x1::string::String, arg2: &0x1::string::String) : bool {
        0x2::derived_object::exists<0x1::string::String>(&arg0.id, build_claim_key(arg1, arg2))
    }

    fun build_claim_key(arg0: &0x1::string::String, arg1: &0x1::string::String) : 0x1::string::String {
        let v0 = *arg0;
        0x1::string::append_utf8(&mut v0, b":");
        0x1::string::append(&mut v0, *arg1);
        v0
    }

    fun claim_binding_internal(arg0: &mut 0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::account::Account, arg1: &mut PlatformRegistry, arg2: &mut PlatformBinding, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::account::id(arg0);
        assert!(!0x2::table::contains<0x1::string::String, 0x2::object::ID>(&arg1.active_claims, build_claim_key(&arg2.platform, &arg2.platform_uid)), 0);
        assert!(0x1::option::is_none<0x2::object::ID>(&arg2.account_id), 2);
        arg2.account_id = 0x1::option::some<0x2::object::ID>(v0);
        arg2.username = arg3;
        arg2.tagline = arg4;
        arg2.region = arg5;
        arg2.updated_at = 0x2::clock::timestamp_ms(arg6);
        0x2::table::add<0x1::string::String, 0x2::object::ID>(&mut arg1.active_claims, build_claim_key(&arg2.platform, &arg2.platform_uid), v0);
        0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::account::add_platform_binding(arg0, 0x2::object::id<PlatformBinding>(arg2), arg7);
        let v1 = 0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::config::rep_connect_gaming();
        if (v1 > 0 && !arg2.connect_reward_granted) {
            0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::account::adjust_reputation_(arg0, v1, true, 0x1::string::utf8(b"connect_gaming"), arg7);
            arg2.connect_reward_granted = true;
        };
        let v2 = PlatformBound{
            binding_id   : 0x2::object::id<PlatformBinding>(arg2),
            account_id   : v0,
            platform     : arg2.platform,
            platform_uid : arg2.platform_uid,
            username     : arg2.username,
            is_rebind    : true,
        };
        0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::events::emit_event<PlatformBound>(v2);
    }

    public fun claim_released(arg0: &mut 0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::account::Account, arg1: &0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::account::AccountAuth, arg2: &mut PlatformRegistry, arg3: &0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::zenko::ZenkoRegistry, arg4: &0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::config::ConfigStore, arg5: &0x2::clock::Clock, arg6: &mut PlatformBinding, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: 0x1::string::String, arg10: u64, arg11: u64, arg12: vector<u8>, arg13: vector<u8>, arg14: &mut 0x2::tx_context::TxContext) {
        assert_version(arg2);
        0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::account::verify_auth(arg0, arg1);
        0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::oracle::verify_platform_claim_permit(arg3, arg4, arg5, 0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::account::id(arg0), arg6.platform, arg6.platform_uid, arg10, arg11, arg12, arg13);
        0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::account::consume_nonce(arg0, arg10);
        claim_binding_internal(arg0, arg2, arg6, arg7, arg8, arg9, arg5, arg14);
    }

    fun create_binding_internal(arg0: &mut 0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::account::Account, arg1: &mut PlatformRegistry, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::account::id(arg0);
        let v1 = build_claim_key(&arg2, &arg3);
        let v2 = 0x2::clock::timestamp_ms(arg7);
        assert!(!0x2::table::contains<0x1::string::String, 0x2::object::ID>(&arg1.active_claims, v1), 0);
        let v3 = PlatformBinding{
            id                     : 0x2::derived_object::claim<0x1::string::String>(&mut arg1.id, v1),
            account_id             : 0x1::option::some<0x2::object::ID>(v0),
            platform               : arg2,
            platform_uid           : arg3,
            username               : arg4,
            tagline                : arg5,
            region                 : arg6,
            created_at             : v2,
            updated_at             : v2,
            connect_reward_granted : false,
        };
        let v4 = 0x2::object::id<PlatformBinding>(&v3);
        0x2::table::add<0x1::string::String, 0x2::object::ID>(&mut arg1.active_claims, build_claim_key(&v3.platform, &v3.platform_uid), v0);
        0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::account::add_platform_binding(arg0, v4, arg8);
        let v5 = 0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::config::rep_connect_gaming();
        if (v5 > 0) {
            0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::account::adjust_reputation_(arg0, v5, true, 0x1::string::utf8(b"connect_gaming"), arg8);
            v3.connect_reward_granted = true;
        };
        let v6 = PlatformBound{
            binding_id   : v4,
            account_id   : v0,
            platform     : v3.platform,
            platform_uid : v3.platform_uid,
            username     : v3.username,
            is_rebind    : false,
        };
        0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::events::emit_event<PlatformBound>(v6);
        0x2::transfer::share_object<PlatformBinding>(v3);
        v4
    }

    public fun derive_binding_address(arg0: &PlatformRegistry, arg1: &0x1::string::String, arg2: &0x1::string::String) : address {
        0x2::derived_object::derive_address<0x1::string::String>(0x2::object::id<PlatformRegistry>(arg0), build_claim_key(arg1, arg2))
    }

    public fun force_release_binding(arg0: &0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::access::RoleRegistry, arg1: &mut PlatformRegistry, arg2: &mut PlatformBinding, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert_version(arg1);
        0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::access::assert_operations(arg0, arg4);
        arg2.account_id = 0x1::option::none<0x2::object::ID>();
        arg2.updated_at = 0x2::clock::timestamp_ms(arg3);
        if (0x2::table::contains<0x1::string::String, 0x2::object::ID>(&arg1.active_claims, build_claim_key(&arg2.platform, &arg2.platform_uid))) {
            0x2::table::remove<0x1::string::String, 0x2::object::ID>(&mut arg1.active_claims, build_claim_key(&arg2.platform, &arg2.platform_uid));
        };
    }

    public fun get_active_owner(arg0: &PlatformRegistry, arg1: &0x1::string::String, arg2: &0x1::string::String) : 0x1::option::Option<0x2::object::ID> {
        if (0x2::table::contains<0x1::string::String, 0x2::object::ID>(&arg0.active_claims, build_claim_key(arg1, arg2))) {
            0x1::option::some<0x2::object::ID>(*0x2::table::borrow<0x1::string::String, 0x2::object::ID>(&arg0.active_claims, build_claim_key(arg1, arg2)))
        } else {
            0x1::option::none<0x2::object::ID>()
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = PlatformRegistry{
            id            : 0x2::object::new(arg0),
            version       : 0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::config::current_version(),
            active_claims : 0x2::table::new<0x1::string::String, 0x2::object::ID>(arg0),
        };
        0x2::transfer::share_object<PlatformRegistry>(v0);
        let v1 = PlatformAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<PlatformAdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun migrate_platform_registry(arg0: &mut PlatformRegistry, arg1: &0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::access::RoleRegistry, arg2: &0x2::tx_context::TxContext) {
        0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::access::assert_super_admin(arg1, arg2);
        0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::version::migrate(&mut arg0.version, 0x2::object::id<PlatformRegistry>(arg0));
    }

    public fun release_platform(arg0: &mut 0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::account::Account, arg1: &0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::account::AccountAuth, arg2: &mut PlatformRegistry, arg3: &mut PlatformBinding, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        assert_version(arg2);
        0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::account::verify_auth(arg0, arg1);
        let v0 = 0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::account::id(arg0);
        assert!(arg3.account_id == 0x1::option::some<0x2::object::ID>(v0), 1);
        let v1 = 0x2::object::id<PlatformBinding>(arg3);
        arg3.account_id = 0x1::option::none<0x2::object::ID>();
        arg3.updated_at = 0x2::clock::timestamp_ms(arg4);
        0x2::table::remove<0x1::string::String, 0x2::object::ID>(&mut arg2.active_claims, build_claim_key(&arg3.platform, &arg3.platform_uid));
        0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::account::remove_platform_binding(arg0, v1, arg5);
        let v2 = PlatformReleased{
            binding_id        : v1,
            former_account_id : v0,
            platform          : arg3.platform,
            platform_uid      : arg3.platform_uid,
        };
        0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::events::emit_event<PlatformReleased>(v2);
    }

    public fun update_display_info(arg0: &PlatformRegistry, arg1: &0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::account::Account, arg2: &0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::account::AccountAuth, arg3: &mut PlatformBinding, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: &0x2::clock::Clock, arg8: &0x2::tx_context::TxContext) {
        assert_version(arg0);
        0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::account::verify_auth(arg1, arg2);
        assert!(arg3.account_id == 0x1::option::some<0x2::object::ID>(0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::account::id(arg1)), 1);
        arg3.username = arg4;
        arg3.tagline = arg5;
        arg3.region = arg6;
        arg3.updated_at = 0x2::clock::timestamp_ms(arg7);
        let v0 = PlatformDisplayUpdated{
            binding_id : 0x2::object::id<PlatformBinding>(arg3),
            username   : arg4,
        };
        0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::events::emit_event<PlatformDisplayUpdated>(v0);
    }

    // decompiled from Move bytecode v7
}

