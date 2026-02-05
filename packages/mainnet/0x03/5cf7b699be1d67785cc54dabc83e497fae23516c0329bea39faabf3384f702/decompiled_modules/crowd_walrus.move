module 0x35cf7b699be1d67785cc54dabc83e497fae23516c0329bea39faabf3384f702::crowd_walrus {
    struct CROWD_WALRUS has drop {
        dummy_field: bool,
    }

    struct CrowdWalrusApp has drop {
        dummy_field: bool,
    }

    struct CampaignCreated has copy, drop {
        campaign_id: 0x2::object::ID,
        creator: address,
    }

    struct CrowdWalrus has key {
        id: 0x2::object::UID,
        policy_registry_id: 0x2::object::ID,
        profiles_registry_id: 0x2::object::ID,
        badge_config_id: 0x2::object::ID,
        revoked_verify_caps: 0x2::vec_set::VecSet<0x2::object::ID>,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
        crowd_walrus_id: 0x2::object::ID,
    }

    struct VerifyCap has key {
        id: 0x2::object::UID,
        crowd_walrus_id: 0x2::object::ID,
    }

    struct AdminCreated has copy, drop {
        crowd_walrus_id: 0x2::object::ID,
        admin_id: 0x2::object::ID,
        creator: address,
    }

    struct CampaignVerified has copy, drop {
        campaign_id: 0x2::object::ID,
        verifier: address,
    }

    struct CampaignDeleted has copy, drop {
        campaign_id: 0x2::object::ID,
        editor: address,
        timestamp_ms: u64,
    }

    struct VerifyCapRevoked has copy, drop {
        crowd_walrus_id: 0x2::object::ID,
        verify_cap_id: 0x2::object::ID,
        revoked_by: address,
    }

    struct PolicyRegistryCreated has copy, drop {
        crowd_walrus_id: 0x2::object::ID,
        policy_registry_id: 0x2::object::ID,
    }

    struct ProfilesRegistryCreated has copy, drop {
        crowd_walrus_id: 0x2::object::ID,
        profiles_registry_id: 0x2::object::ID,
    }

    struct TokenRegistryCreated has copy, drop {
        crowd_walrus_id: 0x2::object::ID,
        token_registry_id: 0x2::object::ID,
    }

    struct BadgeConfigCreated has copy, drop {
        crowd_walrus_id: 0x2::object::ID,
        badge_config_id: 0x2::object::ID,
    }

    struct TokenRegistryKey has copy, drop, store {
        dummy_field: bool,
    }

    struct TokenRegistrySlot has store {
        id: 0x2::object::ID,
    }

    public fun crowd_walrus_id(arg0: &AdminCap) : 0x2::object::ID {
        arg0.crowd_walrus_id
    }

    public fun add_field<T0: copy + drop + store, T1: store>(arg0: &mut CrowdWalrus, arg1: &AdminCap, arg2: T0, arg3: T1) {
        assert!(0x2::object::id<CrowdWalrus>(arg0) == arg1.crowd_walrus_id, 1);
        0x2::dynamic_field::add<T0, T1>(&mut arg0.id, arg2, arg3);
    }

    entry fun add_platform_policy(arg0: &mut 0x35cf7b699be1d67785cc54dabc83e497fae23516c0329bea39faabf3384f702::platform_policy::PolicyRegistry, arg1: &AdminCap, arg2: 0x1::string::String, arg3: u16, arg4: address, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        add_platform_policy_internal(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public(friend) fun add_platform_policy_internal(arg0: &mut 0x35cf7b699be1d67785cc54dabc83e497fae23516c0329bea39faabf3384f702::platform_policy::PolicyRegistry, arg1: &AdminCap, arg2: 0x1::string::String, arg3: u16, arg4: address, arg5: &0x2::clock::Clock) {
        assert_admin_cap_for(arg1, 0x35cf7b699be1d67785cc54dabc83e497fae23516c0329bea39faabf3384f702::platform_policy::registry_owner_id(arg0));
        0x35cf7b699be1d67785cc54dabc83e497fae23516c0329bea39faabf3384f702::platform_policy::add_policy(arg0, arg2, arg3, arg4, arg5);
    }

    entry fun add_token<T0>(arg0: &mut 0x35cf7b699be1d67785cc54dabc83e497fae23516c0329bea39faabf3384f702::token_registry::TokenRegistry, arg1: &AdminCap, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u8, arg5: vector<u8>, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        add_token_internal<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    public(friend) fun add_token_internal<T0>(arg0: &mut 0x35cf7b699be1d67785cc54dabc83e497fae23516c0329bea39faabf3384f702::token_registry::TokenRegistry, arg1: &AdminCap, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u8, arg5: vector<u8>, arg6: u64, arg7: &0x2::clock::Clock) {
        assert_admin_cap_for(arg1, 0x35cf7b699be1d67785cc54dabc83e497fae23516c0329bea39faabf3384f702::token_registry::registry_owner_id(arg0));
        0x35cf7b699be1d67785cc54dabc83e497fae23516c0329bea39faabf3384f702::token_registry::add_coin<T0>(arg0, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    public(friend) fun admin_cap_crowd_walrus_id(arg0: &AdminCap) : 0x2::object::ID {
        arg0.crowd_walrus_id
    }

    public(friend) fun assert_admin_cap_for(arg0: &AdminCap, arg1: 0x2::object::ID) {
        assert!(arg0.crowd_walrus_id == arg1, 1);
    }

    public fun badge_config_id(arg0: &CrowdWalrus) : 0x2::object::ID {
        arg0.badge_config_id
    }

    fun borrow_token_registry_slot(arg0: &CrowdWalrus) : &TokenRegistrySlot {
        0x2::dynamic_field::borrow<TokenRegistryKey, TokenRegistrySlot>(&arg0.id, token_registry_key())
    }

    entry fun create_campaign(arg0: &CrowdWalrus, arg1: &0x35cf7b699be1d67785cc54dabc83e497fae23516c0329bea39faabf3384f702::platform_policy::PolicyRegistry, arg2: &mut 0x35cf7b699be1d67785cc54dabc83e497fae23516c0329bea39faabf3384f702::profiles::ProfilesRegistry, arg3: &0x35cf7b699be1d67785cc54dabc83e497fae23516c0329bea39faabf3384f702::suins_manager::SuiNSManager, arg4: &mut 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::SuiNS, arg5: &0x2::clock::Clock, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: vector<0x1::string::String>, arg10: vector<0x1::string::String>, arg11: u64, arg12: address, arg13: 0x1::option::Option<0x1::string::String>, arg14: u64, arg15: u64, arg16: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(arg14 >= 0x2::clock::timestamp_ms(arg5), 0x35cf7b699be1d67785cc54dabc83e497fae23516c0329bea39faabf3384f702::campaign::e_start_date_in_past());
        let v0 = CrowdWalrusApp{dummy_field: false};
        assert!(0x2::object::id<0x35cf7b699be1d67785cc54dabc83e497fae23516c0329bea39faabf3384f702::platform_policy::PolicyRegistry>(arg1) == policy_registry_id(arg0), 1);
        assert!(arg12 != @0x0, 0x35cf7b699be1d67785cc54dabc83e497fae23516c0329bea39faabf3384f702::campaign::e_recipient_address_invalid());
        let (v1, v2) = 0x35cf7b699be1d67785cc54dabc83e497fae23516c0329bea39faabf3384f702::campaign::new<CrowdWalrusApp>(&v0, 0x2::object::id<CrowdWalrus>(arg0), arg6, arg7, arg8, 0x2::vec_map::from_keys_values<0x1::string::String, 0x1::string::String>(arg9, arg10), arg11, resolve_payout_policy(arg1, arg13, arg12), arg14, arg15, arg5, arg16);
        let v3 = v1;
        let v4 = 0x2::object::id<0x35cf7b699be1d67785cc54dabc83e497fae23516c0329bea39faabf3384f702::campaign::Campaign>(&v3);
        assert!(0x2::object::id<0x35cf7b699be1d67785cc54dabc83e497fae23516c0329bea39faabf3384f702::profiles::ProfilesRegistry>(arg2) == profiles_registry_id(arg0), 1);
        0x35cf7b699be1d67785cc54dabc83e497fae23516c0329bea39faabf3384f702::campaign_stats::create_for_campaign(&mut v3, arg5, arg16);
        0x35cf7b699be1d67785cc54dabc83e497fae23516c0329bea39faabf3384f702::profiles::create_or_get_profile_for_sender(arg2, arg5, arg16);
        0x35cf7b699be1d67785cc54dabc83e497fae23516c0329bea39faabf3384f702::suins_manager::register_subdomain<CrowdWalrusApp>(arg3, &v0, arg4, arg5, arg8, 0x2::object::id_to_address(&v4), arg16);
        0x35cf7b699be1d67785cc54dabc83e497fae23516c0329bea39faabf3384f702::campaign::share(v3);
        0x35cf7b699be1d67785cc54dabc83e497fae23516c0329bea39faabf3384f702::campaign::transfer_owner_cap(v2, 0x2::tx_context::sender(arg16));
        let v5 = CampaignCreated{
            campaign_id : v4,
            creator     : 0x2::tx_context::sender(arg16),
        };
        0x2::event::emit<CampaignCreated>(v5);
        v4
    }

    entry fun create_verify_cap(arg0: &CrowdWalrus, arg1: &AdminCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::object::id<CrowdWalrus>(arg0) == arg1.crowd_walrus_id, 1);
        let v0 = VerifyCap{
            id              : 0x2::object::new(arg3),
            crowd_walrus_id : 0x2::object::id<CrowdWalrus>(arg0),
        };
        0x2::transfer::transfer<VerifyCap>(v0, arg2);
    }

    public fun default_policy_name() : 0x1::string::String {
        default_policy_name_internal()
    }

    fun default_policy_name_internal() : 0x1::string::String {
        0x1::string::utf8(b"standard")
    }

    entry fun delete_campaign(arg0: &CrowdWalrus, arg1: &0x35cf7b699be1d67785cc54dabc83e497fae23516c0329bea39faabf3384f702::suins_manager::SuiNSManager, arg2: &mut 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::SuiNS, arg3: &mut 0x35cf7b699be1d67785cc54dabc83e497fae23516c0329bea39faabf3384f702::campaign::Campaign, arg4: 0x35cf7b699be1d67785cc54dabc83e497fae23516c0329bea39faabf3384f702::campaign::CampaignOwnerCap, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        assert!(0x35cf7b699be1d67785cc54dabc83e497fae23516c0329bea39faabf3384f702::campaign::admin_id(arg3) == 0x2::object::id<CrowdWalrus>(arg0), 1);
        0x35cf7b699be1d67785cc54dabc83e497fae23516c0329bea39faabf3384f702::campaign::assert_owner(arg3, &arg4);
        0x35cf7b699be1d67785cc54dabc83e497fae23516c0329bea39faabf3384f702::campaign::assert_not_deleted(arg3);
        let v0 = 0x2::clock::timestamp_ms(arg5);
        if (0x35cf7b699be1d67785cc54dabc83e497fae23516c0329bea39faabf3384f702::campaign::is_verified(arg3)) {
            let v1 = CrowdWalrusApp{dummy_field: false};
            0x35cf7b699be1d67785cc54dabc83e497fae23516c0329bea39faabf3384f702::campaign::set_verified<CrowdWalrusApp>(arg3, &v1, false);
            0x35cf7b699be1d67785cc54dabc83e497fae23516c0329bea39faabf3384f702::campaign::emit_campaign_unverified(arg3, 0x2::tx_context::sender(arg6));
        };
        let v2 = CrowdWalrusApp{dummy_field: false};
        0x35cf7b699be1d67785cc54dabc83e497fae23516c0329bea39faabf3384f702::suins_manager::remove_subdomain_for_app<CrowdWalrusApp>(arg1, &v2, arg2, arg5, 0x35cf7b699be1d67785cc54dabc83e497fae23516c0329bea39faabf3384f702::campaign::subdomain_name(arg3));
        0x35cf7b699be1d67785cc54dabc83e497fae23516c0329bea39faabf3384f702::campaign::mark_deleted(arg3, &arg4, v0);
        let v3 = CampaignDeleted{
            campaign_id  : 0x2::object::id<0x35cf7b699be1d67785cc54dabc83e497fae23516c0329bea39faabf3384f702::campaign::Campaign>(arg3),
            editor       : 0x2::tx_context::sender(arg6),
            timestamp_ms : v0,
        };
        0x2::event::emit<CampaignDeleted>(v3);
        0x35cf7b699be1d67785cc54dabc83e497fae23516c0329bea39faabf3384f702::campaign::delete_owner_cap(arg4);
    }

    entry fun destroy_revoked_verify_cap(arg0: &CrowdWalrus, arg1: VerifyCap, arg2: &0x2::tx_context::TxContext) {
        assert!(arg1.crowd_walrus_id == 0x2::object::id<CrowdWalrus>(arg0), 1);
        let v0 = 0x2::object::id<VerifyCap>(&arg1);
        assert!(0x2::vec_set::contains<0x2::object::ID>(&arg0.revoked_verify_caps, &v0), 6);
        let VerifyCap {
            id              : v1,
            crowd_walrus_id : _,
        } = arg1;
        0x2::object::delete(v1);
    }

    entry fun disable_platform_policy(arg0: &mut 0x35cf7b699be1d67785cc54dabc83e497fae23516c0329bea39faabf3384f702::platform_policy::PolicyRegistry, arg1: &AdminCap, arg2: 0x1::string::String, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        disable_platform_policy_internal(arg0, arg1, arg2, arg3);
    }

    public(friend) fun disable_platform_policy_internal(arg0: &mut 0x35cf7b699be1d67785cc54dabc83e497fae23516c0329bea39faabf3384f702::platform_policy::PolicyRegistry, arg1: &AdminCap, arg2: 0x1::string::String, arg3: &0x2::clock::Clock) {
        assert_admin_cap_for(arg1, 0x35cf7b699be1d67785cc54dabc83e497fae23516c0329bea39faabf3384f702::platform_policy::registry_owner_id(arg0));
        0x35cf7b699be1d67785cc54dabc83e497fae23516c0329bea39faabf3384f702::platform_policy::disable_policy(arg0, arg2, arg3);
    }

    entry fun enable_platform_policy(arg0: &mut 0x35cf7b699be1d67785cc54dabc83e497fae23516c0329bea39faabf3384f702::platform_policy::PolicyRegistry, arg1: &AdminCap, arg2: 0x1::string::String, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        enable_platform_policy_internal(arg0, arg1, arg2, arg3);
    }

    public(friend) fun enable_platform_policy_internal(arg0: &mut 0x35cf7b699be1d67785cc54dabc83e497fae23516c0329bea39faabf3384f702::platform_policy::PolicyRegistry, arg1: &AdminCap, arg2: 0x1::string::String, arg3: &0x2::clock::Clock) {
        assert_admin_cap_for(arg1, 0x35cf7b699be1d67785cc54dabc83e497fae23516c0329bea39faabf3384f702::platform_policy::registry_owner_id(arg0));
        0x35cf7b699be1d67785cc54dabc83e497fae23516c0329bea39faabf3384f702::platform_policy::enable_policy(arg0, arg2, arg3);
    }

    fun init(arg0: CROWD_WALRUS, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<CROWD_WALRUS>(arg0, arg1);
        let v0 = 0x2::object::new(arg1);
        let v1 = 0x2::object::uid_to_inner(&v0);
        let v2 = 0x35cf7b699be1d67785cc54dabc83e497fae23516c0329bea39faabf3384f702::platform_policy::create_registry(v1, arg1);
        0x35cf7b699be1d67785cc54dabc83e497fae23516c0329bea39faabf3384f702::platform_policy::add_policy_bootstrap(&mut v2, default_policy_name_internal(), 0, 0x2::tx_context::sender(arg1));
        let v3 = 0x2::object::id<0x35cf7b699be1d67785cc54dabc83e497fae23516c0329bea39faabf3384f702::platform_policy::PolicyRegistry>(&v2);
        0x35cf7b699be1d67785cc54dabc83e497fae23516c0329bea39faabf3384f702::platform_policy::share_registry(v2);
        let v4 = 0x35cf7b699be1d67785cc54dabc83e497fae23516c0329bea39faabf3384f702::token_registry::create_registry(v1, arg1);
        let v5 = 0x2::object::id<0x35cf7b699be1d67785cc54dabc83e497fae23516c0329bea39faabf3384f702::token_registry::TokenRegistry>(&v4);
        0x35cf7b699be1d67785cc54dabc83e497fae23516c0329bea39faabf3384f702::token_registry::share_registry(v4);
        let v6 = 0x35cf7b699be1d67785cc54dabc83e497fae23516c0329bea39faabf3384f702::profiles::create_registry(arg1);
        let v7 = 0x2::object::id<0x35cf7b699be1d67785cc54dabc83e497fae23516c0329bea39faabf3384f702::profiles::ProfilesRegistry>(&v6);
        0x35cf7b699be1d67785cc54dabc83e497fae23516c0329bea39faabf3384f702::profiles::share_registry(v6);
        let v8 = 0x35cf7b699be1d67785cc54dabc83e497fae23516c0329bea39faabf3384f702::badge_rewards::create_config(v1, arg1);
        let v9 = 0x2::object::id<0x35cf7b699be1d67785cc54dabc83e497fae23516c0329bea39faabf3384f702::badge_rewards::BadgeConfig>(&v8);
        0x35cf7b699be1d67785cc54dabc83e497fae23516c0329bea39faabf3384f702::badge_rewards::share_config(v8);
        let v10 = CrowdWalrus{
            id                   : v0,
            policy_registry_id   : v3,
            profiles_registry_id : v7,
            badge_config_id      : v9,
            revoked_verify_caps  : 0x2::vec_set::empty<0x2::object::ID>(),
        };
        let v11 = &mut v10;
        record_token_registry_id(v11, v5);
        let v12 = AdminCap{
            id              : 0x2::object::new(arg1),
            crowd_walrus_id : v1,
        };
        let v13 = AdminCreated{
            crowd_walrus_id : v1,
            admin_id        : 0x2::object::id<AdminCap>(&v12),
            creator         : 0x2::tx_context::sender(arg1),
        };
        0x2::event::emit<AdminCreated>(v13);
        let v14 = PolicyRegistryCreated{
            crowd_walrus_id    : v1,
            policy_registry_id : v3,
        };
        0x2::event::emit<PolicyRegistryCreated>(v14);
        let v15 = ProfilesRegistryCreated{
            crowd_walrus_id      : v1,
            profiles_registry_id : v7,
        };
        0x2::event::emit<ProfilesRegistryCreated>(v15);
        let v16 = TokenRegistryCreated{
            crowd_walrus_id   : v1,
            token_registry_id : v5,
        };
        0x2::event::emit<TokenRegistryCreated>(v16);
        let v17 = BadgeConfigCreated{
            crowd_walrus_id : v1,
            badge_config_id : v9,
        };
        0x2::event::emit<BadgeConfigCreated>(v17);
        0x2::transfer::transfer<AdminCap>(v12, 0x2::tx_context::sender(arg1));
        0x2::transfer::share_object<CrowdWalrus>(v10);
        let v18 = CrowdWalrusApp{dummy_field: false};
        let (_, v20) = 0x35cf7b699be1d67785cc54dabc83e497fae23516c0329bea39faabf3384f702::suins_manager::new<CrowdWalrusApp>(&v18, arg1);
        0x2::transfer::public_transfer<0x35cf7b699be1d67785cc54dabc83e497fae23516c0329bea39faabf3384f702::suins_manager::AdminCap>(v20, 0x2::tx_context::sender(arg1));
    }

    public fun is_campaign_verified(arg0: &CrowdWalrus, arg1: &0x35cf7b699be1d67785cc54dabc83e497fae23516c0329bea39faabf3384f702::campaign::Campaign) : bool {
        0x35cf7b699be1d67785cc54dabc83e497fae23516c0329bea39faabf3384f702::campaign::is_verified(arg1)
    }

    public fun is_verify_cap_revoked(arg0: &CrowdWalrus, arg1: 0x2::object::ID) : bool {
        0x2::vec_set::contains<0x2::object::ID>(&arg0.revoked_verify_caps, &arg1)
    }

    entry fun migrate_token_registry(arg0: &mut CrowdWalrus, arg1: &AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<CrowdWalrus>(arg0);
        assert_admin_cap_for(arg1, v0);
        if (0x2::dynamic_field::exists_<TokenRegistryKey>(&arg0.id, token_registry_key())) {
            return
        };
        let v1 = 0x35cf7b699be1d67785cc54dabc83e497fae23516c0329bea39faabf3384f702::token_registry::create_registry(v0, arg2);
        let v2 = 0x2::object::id<0x35cf7b699be1d67785cc54dabc83e497fae23516c0329bea39faabf3384f702::token_registry::TokenRegistry>(&v1);
        0x35cf7b699be1d67785cc54dabc83e497fae23516c0329bea39faabf3384f702::token_registry::share_registry(v1);
        record_token_registry_id(arg0, v2);
        let v3 = TokenRegistryCreated{
            crowd_walrus_id   : v0,
            token_registry_id : v2,
        };
        0x2::event::emit<TokenRegistryCreated>(v3);
    }

    public fun policy_registry_id(arg0: &CrowdWalrus) : 0x2::object::ID {
        arg0.policy_registry_id
    }

    public fun profiles_registry_id(arg0: &CrowdWalrus) : 0x2::object::ID {
        arg0.profiles_registry_id
    }

    fun record_token_registry_id(arg0: &mut CrowdWalrus, arg1: 0x2::object::ID) {
        let v0 = TokenRegistrySlot{id: arg1};
        0x2::dynamic_field::add<TokenRegistryKey, TokenRegistrySlot>(&mut arg0.id, token_registry_key(), v0);
    }

    entry fun remove_badge_display_keys_with_admin(arg0: &mut 0x2::display::Display<0x35cf7b699be1d67785cc54dabc83e497fae23516c0329bea39faabf3384f702::badge_rewards::DonorBadge>, arg1: &AdminCap, arg2: 0x2::object::ID, arg3: vector<0x1::string::String>, arg4: 0x1::string::String, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert_admin_cap_for(arg1, arg2);
        0x35cf7b699be1d67785cc54dabc83e497fae23516c0329bea39faabf3384f702::badge_rewards::remove_badge_display_internal(arg0, arg3, arg4, arg5);
    }

    public fun remove_field<T0: copy + drop + store, T1: store>(arg0: &mut CrowdWalrus, arg1: &AdminCap, arg2: T0) : T1 {
        assert!(0x2::object::id<CrowdWalrus>(arg0) == arg1.crowd_walrus_id, 1);
        0x2::dynamic_field::remove<T0, T1>(&mut arg0.id, arg2)
    }

    entry fun remove_profile_subdomain(arg0: &0x35cf7b699be1d67785cc54dabc83e497fae23516c0329bea39faabf3384f702::suins_manager::SuiNSManager, arg1: &0x35cf7b699be1d67785cc54dabc83e497fae23516c0329bea39faabf3384f702::suins_manager::AdminCap, arg2: &mut 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::SuiNS, arg3: &mut 0x35cf7b699be1d67785cc54dabc83e497fae23516c0329bea39faabf3384f702::profiles::Profile, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        let v0 = 0x35cf7b699be1d67785cc54dabc83e497fae23516c0329bea39faabf3384f702::profiles::subdomain_name(arg3);
        assert!(0x1::option::is_some<0x1::string::String>(&v0), 0x35cf7b699be1d67785cc54dabc83e497fae23516c0329bea39faabf3384f702::profiles::subdomain_not_set_error_code());
        let v1 = 0x1::option::destroy_some<0x1::string::String>(v0);
        0x35cf7b699be1d67785cc54dabc83e497fae23516c0329bea39faabf3384f702::suins_manager::remove_subdomain(arg0, arg1, arg2, v1, arg4);
        0x35cf7b699be1d67785cc54dabc83e497fae23516c0329bea39faabf3384f702::profiles::clear_subdomain(arg3);
        0x35cf7b699be1d67785cc54dabc83e497fae23516c0329bea39faabf3384f702::profiles::emit_profile_subdomain_removed(0x2::object::id<0x35cf7b699be1d67785cc54dabc83e497fae23516c0329bea39faabf3384f702::profiles::Profile>(arg3), 0x35cf7b699be1d67785cc54dabc83e497fae23516c0329bea39faabf3384f702::profiles::owner(arg3), v1, 0x2::clock::timestamp_ms(arg4), 0x2::tx_context::sender(arg5));
    }

    fun resolve_payout_policy(arg0: &0x35cf7b699be1d67785cc54dabc83e497fae23516c0329bea39faabf3384f702::platform_policy::PolicyRegistry, arg1: 0x1::option::Option<0x1::string::String>, arg2: address) : 0x35cf7b699be1d67785cc54dabc83e497fae23516c0329bea39faabf3384f702::campaign::PayoutPolicy {
        if (0x1::option::is_some<0x1::string::String>(&arg1)) {
            let v0 = 0x1::option::destroy_some<0x1::string::String>(arg1);
            let v1 = 0x35cf7b699be1d67785cc54dabc83e497fae23516c0329bea39faabf3384f702::platform_policy::require_enabled_policy(arg0, &v0);
            return 0x35cf7b699be1d67785cc54dabc83e497fae23516c0329bea39faabf3384f702::campaign::new_payout_policy(0x35cf7b699be1d67785cc54dabc83e497fae23516c0329bea39faabf3384f702::platform_policy::policy_platform_bps(v1), 0x35cf7b699be1d67785cc54dabc83e497fae23516c0329bea39faabf3384f702::platform_policy::policy_platform_address(v1), arg2)
        };
        let v2 = default_policy_name_internal();
        let v3 = 0x35cf7b699be1d67785cc54dabc83e497fae23516c0329bea39faabf3384f702::platform_policy::require_enabled_policy(arg0, &v2);
        0x35cf7b699be1d67785cc54dabc83e497fae23516c0329bea39faabf3384f702::campaign::new_payout_policy(0x35cf7b699be1d67785cc54dabc83e497fae23516c0329bea39faabf3384f702::platform_policy::policy_platform_bps(v3), 0x35cf7b699be1d67785cc54dabc83e497fae23516c0329bea39faabf3384f702::platform_policy::policy_platform_address(v3), arg2)
    }

    entry fun revoke_verify_cap(arg0: &mut CrowdWalrus, arg1: &AdminCap, arg2: 0x2::object::ID, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<CrowdWalrus>(arg0);
        assert!(v0 == arg1.crowd_walrus_id, 1);
        if (!0x2::vec_set::contains<0x2::object::ID>(&arg0.revoked_verify_caps, &arg2)) {
            0x2::vec_set::insert<0x2::object::ID>(&mut arg0.revoked_verify_caps, arg2);
            let v1 = VerifyCapRevoked{
                crowd_walrus_id : v0,
                verify_cap_id   : arg2,
                revoked_by      : 0x2::tx_context::sender(arg3),
            };
            0x2::event::emit<VerifyCapRevoked>(v1);
        };
    }

    entry fun set_profile_subdomain(arg0: &mut 0x35cf7b699be1d67785cc54dabc83e497fae23516c0329bea39faabf3384f702::profiles::Profile, arg1: &0x35cf7b699be1d67785cc54dabc83e497fae23516c0329bea39faabf3384f702::suins_manager::SuiNSManager, arg2: &mut 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::SuiNS, arg3: 0x1::string::String, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        set_profile_subdomain_internal(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    fun set_profile_subdomain_internal(arg0: &mut 0x35cf7b699be1d67785cc54dabc83e497fae23516c0329bea39faabf3384f702::profiles::Profile, arg1: &0x35cf7b699be1d67785cc54dabc83e497fae23516c0329bea39faabf3384f702::suins_manager::SuiNSManager, arg2: &mut 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::SuiNS, arg3: 0x1::string::String, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(0x35cf7b699be1d67785cc54dabc83e497fae23516c0329bea39faabf3384f702::profiles::owner(arg0) == v0, 0x35cf7b699be1d67785cc54dabc83e497fae23516c0329bea39faabf3384f702::profiles::not_profile_owner_error_code());
        0x35cf7b699be1d67785cc54dabc83e497fae23516c0329bea39faabf3384f702::profiles::assert_subdomain_not_set(arg0);
        let v1 = CrowdWalrusApp{dummy_field: false};
        let v2 = 0x2::object::id<0x35cf7b699be1d67785cc54dabc83e497fae23516c0329bea39faabf3384f702::profiles::Profile>(arg0);
        0x35cf7b699be1d67785cc54dabc83e497fae23516c0329bea39faabf3384f702::suins_manager::register_subdomain<CrowdWalrusApp>(arg1, &v1, arg2, arg4, arg3, 0x2::object::id_to_address(&v2), arg5);
        0x35cf7b699be1d67785cc54dabc83e497fae23516c0329bea39faabf3384f702::profiles::set_subdomain(arg0, arg3);
        0x35cf7b699be1d67785cc54dabc83e497fae23516c0329bea39faabf3384f702::profiles::emit_profile_subdomain_set(v2, v0, arg3, 0x2::clock::timestamp_ms(arg4));
    }

    public fun set_profile_subdomain_public(arg0: &mut 0x35cf7b699be1d67785cc54dabc83e497fae23516c0329bea39faabf3384f702::profiles::Profile, arg1: &0x35cf7b699be1d67785cc54dabc83e497fae23516c0329bea39faabf3384f702::suins_manager::SuiNSManager, arg2: &mut 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::SuiNS, arg3: 0x1::string::String, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        set_profile_subdomain_internal(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    entry fun set_token_enabled<T0>(arg0: &mut 0x35cf7b699be1d67785cc54dabc83e497fae23516c0329bea39faabf3384f702::token_registry::TokenRegistry, arg1: &AdminCap, arg2: bool, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        set_token_enabled_internal<T0>(arg0, arg1, arg2, arg3);
    }

    public(friend) fun set_token_enabled_internal<T0>(arg0: &mut 0x35cf7b699be1d67785cc54dabc83e497fae23516c0329bea39faabf3384f702::token_registry::TokenRegistry, arg1: &AdminCap, arg2: bool, arg3: &0x2::clock::Clock) {
        assert_admin_cap_for(arg1, 0x35cf7b699be1d67785cc54dabc83e497fae23516c0329bea39faabf3384f702::token_registry::registry_owner_id(arg0));
        0x35cf7b699be1d67785cc54dabc83e497fae23516c0329bea39faabf3384f702::token_registry::set_enabled<T0>(arg0, arg2, arg3);
    }

    entry fun set_token_max_age<T0>(arg0: &mut 0x35cf7b699be1d67785cc54dabc83e497fae23516c0329bea39faabf3384f702::token_registry::TokenRegistry, arg1: &AdminCap, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        set_token_max_age_internal<T0>(arg0, arg1, arg2, arg3);
    }

    public(friend) fun set_token_max_age_internal<T0>(arg0: &mut 0x35cf7b699be1d67785cc54dabc83e497fae23516c0329bea39faabf3384f702::token_registry::TokenRegistry, arg1: &AdminCap, arg2: u64, arg3: &0x2::clock::Clock) {
        assert_admin_cap_for(arg1, 0x35cf7b699be1d67785cc54dabc83e497fae23516c0329bea39faabf3384f702::token_registry::registry_owner_id(arg0));
        0x35cf7b699be1d67785cc54dabc83e497fae23516c0329bea39faabf3384f702::token_registry::set_max_age_ms<T0>(arg0, arg2, arg3);
    }

    public fun token_registry_id(arg0: &CrowdWalrus) : 0x2::object::ID {
        assert!(0x2::dynamic_field::exists_<TokenRegistryKey>(&arg0.id, token_registry_key()), 4);
        borrow_token_registry_slot(arg0).id
    }

    fun token_registry_key() : TokenRegistryKey {
        TokenRegistryKey{dummy_field: false}
    }

    entry fun unverify_campaign(arg0: &CrowdWalrus, arg1: &VerifyCap, arg2: &mut 0x35cf7b699be1d67785cc54dabc83e497fae23516c0329bea39faabf3384f702::campaign::Campaign, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::object::id<CrowdWalrus>(arg0) == arg1.crowd_walrus_id, 1);
        let v0 = 0x2::object::id<VerifyCap>(arg1);
        assert!(!0x2::vec_set::contains<0x2::object::ID>(&arg0.revoked_verify_caps, &v0), 5);
        assert!(0x35cf7b699be1d67785cc54dabc83e497fae23516c0329bea39faabf3384f702::campaign::is_verified(arg2), 3);
        let v1 = CrowdWalrusApp{dummy_field: false};
        0x35cf7b699be1d67785cc54dabc83e497fae23516c0329bea39faabf3384f702::campaign::set_verified<CrowdWalrusApp>(arg2, &v1, false);
        0x35cf7b699be1d67785cc54dabc83e497fae23516c0329bea39faabf3384f702::campaign::emit_campaign_unverified(arg2, 0x2::tx_context::sender(arg3));
    }

    entry fun update_badge_config(arg0: &mut 0x35cf7b699be1d67785cc54dabc83e497fae23516c0329bea39faabf3384f702::badge_rewards::BadgeConfig, arg1: &AdminCap, arg2: vector<u64>, arg3: vector<u64>, arg4: vector<0x1::string::String>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        update_badge_config_internal(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public(friend) fun update_badge_config_internal(arg0: &mut 0x35cf7b699be1d67785cc54dabc83e497fae23516c0329bea39faabf3384f702::badge_rewards::BadgeConfig, arg1: &AdminCap, arg2: vector<u64>, arg3: vector<u64>, arg4: vector<0x1::string::String>, arg5: &0x2::clock::Clock) {
        assert_admin_cap_for(arg1, 0x35cf7b699be1d67785cc54dabc83e497fae23516c0329bea39faabf3384f702::badge_rewards::crowd_walrus_id(arg0));
        0x35cf7b699be1d67785cc54dabc83e497fae23516c0329bea39faabf3384f702::badge_rewards::set_config(arg0, arg2, arg3, arg4, arg5);
    }

    entry fun update_badge_display_with_admin(arg0: &mut 0x2::display::Display<0x35cf7b699be1d67785cc54dabc83e497fae23516c0329bea39faabf3384f702::badge_rewards::DonorBadge>, arg1: &AdminCap, arg2: 0x2::object::ID, arg3: vector<0x1::string::String>, arg4: vector<0x1::string::String>, arg5: 0x1::string::String, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert_admin_cap_for(arg1, arg2);
        0x35cf7b699be1d67785cc54dabc83e497fae23516c0329bea39faabf3384f702::badge_rewards::update_badge_display_internal(arg0, arg3, arg4, arg5, arg6);
    }

    entry fun update_platform_policy(arg0: &mut 0x35cf7b699be1d67785cc54dabc83e497fae23516c0329bea39faabf3384f702::platform_policy::PolicyRegistry, arg1: &AdminCap, arg2: 0x1::string::String, arg3: u16, arg4: address, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        update_platform_policy_internal(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public(friend) fun update_platform_policy_internal(arg0: &mut 0x35cf7b699be1d67785cc54dabc83e497fae23516c0329bea39faabf3384f702::platform_policy::PolicyRegistry, arg1: &AdminCap, arg2: 0x1::string::String, arg3: u16, arg4: address, arg5: &0x2::clock::Clock) {
        assert_admin_cap_for(arg1, 0x35cf7b699be1d67785cc54dabc83e497fae23516c0329bea39faabf3384f702::platform_policy::registry_owner_id(arg0));
        0x35cf7b699be1d67785cc54dabc83e497fae23516c0329bea39faabf3384f702::platform_policy::update_policy(arg0, arg2, arg3, arg4, arg5);
    }

    entry fun update_token_metadata<T0>(arg0: &mut 0x35cf7b699be1d67785cc54dabc83e497fae23516c0329bea39faabf3384f702::token_registry::TokenRegistry, arg1: &AdminCap, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u8, arg5: vector<u8>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        update_token_metadata_internal<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public(friend) fun update_token_metadata_internal<T0>(arg0: &mut 0x35cf7b699be1d67785cc54dabc83e497fae23516c0329bea39faabf3384f702::token_registry::TokenRegistry, arg1: &AdminCap, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u8, arg5: vector<u8>, arg6: &0x2::clock::Clock) {
        assert_admin_cap_for(arg1, 0x35cf7b699be1d67785cc54dabc83e497fae23516c0329bea39faabf3384f702::token_registry::registry_owner_id(arg0));
        0x35cf7b699be1d67785cc54dabc83e497fae23516c0329bea39faabf3384f702::token_registry::update_metadata<T0>(arg0, arg2, arg3, arg4, arg5, arg6);
    }

    entry fun verify_campaign(arg0: &CrowdWalrus, arg1: &VerifyCap, arg2: &mut 0x35cf7b699be1d67785cc54dabc83e497fae23516c0329bea39faabf3384f702::campaign::Campaign, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::object::id<CrowdWalrus>(arg0) == arg1.crowd_walrus_id, 1);
        let v0 = 0x2::object::id<VerifyCap>(arg1);
        assert!(!0x2::vec_set::contains<0x2::object::ID>(&arg0.revoked_verify_caps, &v0), 5);
        assert!(!0x35cf7b699be1d67785cc54dabc83e497fae23516c0329bea39faabf3384f702::campaign::is_verified(arg2), 2);
        0x35cf7b699be1d67785cc54dabc83e497fae23516c0329bea39faabf3384f702::campaign::assert_not_deleted(arg2);
        let v1 = CrowdWalrusApp{dummy_field: false};
        0x35cf7b699be1d67785cc54dabc83e497fae23516c0329bea39faabf3384f702::campaign::set_verified<CrowdWalrusApp>(arg2, &v1, true);
        let v2 = CampaignVerified{
            campaign_id : 0x2::object::id<0x35cf7b699be1d67785cc54dabc83e497fae23516c0329bea39faabf3384f702::campaign::Campaign>(arg2),
            verifier    : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<CampaignVerified>(v2);
    }

    // decompiled from Move bytecode v6
}

