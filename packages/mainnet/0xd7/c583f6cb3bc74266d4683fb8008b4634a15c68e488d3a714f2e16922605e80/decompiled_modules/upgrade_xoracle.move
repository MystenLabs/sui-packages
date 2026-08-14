module 0xd7c583f6cb3bc74266d4683fb8008b4634a15c68e488d3a714f2e16922605e80::upgrade_xoracle {
    struct XOracleUpgradeWish has copy, drop, store {
        policy: u8,
        digest: vector<u8>,
        super_admin_approved: bool,
    }

    public fun migrate(arg0: &mut 0xd7c583f6cb3bc74266d4683fb8008b4634a15c68e488d3a714f2e16922605e80::governance::DragonBallCollector, arg1: &mut 0xa9f3151ca9229c8bf46daa4d6be781d7f422d58a8bca7e1ac3f1861668ec47e9::x_oracle::XOracle, arg2: &mut 0xce265981a720274f6032324a42be65b2d9c280c8882243adb11d4222837444c0::app::ProtocolApp, arg3: &mut 0x95d6fed520da58fd4dfe45e5ac43022801fd22c85cd2141192162c3cb17754ca::leverage_app::LeverageApp, arg4: &0x2::tx_context::TxContext) {
        0xd7c583f6cb3bc74266d4683fb8008b4634a15c68e488d3a714f2e16922605e80::governance::ensure_can_summon_shenron(arg0);
        0xd7c583f6cb3bc74266d4683fb8008b4634a15c68e488d3a714f2e16922605e80::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg4));
        migrate_inner(arg0, arg1, arg4);
        0xd7c583f6cb3bc74266d4683fb8008b4634a15c68e488d3a714f2e16922605e80::upgrade_protocol::migrate_inner(arg0, arg2, arg4);
        0xd7c583f6cb3bc74266d4683fb8008b4634a15c68e488d3a714f2e16922605e80::upgrade_leverage::migrate_inner(arg0, arg3, arg4);
        0xd7c583f6cb3bc74266d4683fb8008b4634a15c68e488d3a714f2e16922605e80::upgrade_self::migrate_inner(arg0, arg4);
    }

    fun migrate_inner(arg0: &0xd7c583f6cb3bc74266d4683fb8008b4634a15c68e488d3a714f2e16922605e80::governance::DragonBallCollector, arg1: &mut 0xa9f3151ca9229c8bf46daa4d6be781d7f422d58a8bca7e1ac3f1861668ec47e9::x_oracle::XOracle, arg2: &0x2::tx_context::TxContext) {
        0xd7c583f6cb3bc74266d4683fb8008b4634a15c68e488d3a714f2e16922605e80::wish_event::emit_object_migrated(0, 0xa9f3151ca9229c8bf46daa4d6be781d7f422d58a8bca7e1ac3f1861668ec47e9::oracle_admin::migrate(0xd7c583f6cb3bc74266d4683fb8008b4634a15c68e488d3a714f2e16922605e80::governance::x_oracle_admin_cap(arg0), arg1), 0x2::tx_context::sender(arg2));
    }

    public fun authorize_xoracle_upgrade(arg0: &mut 0xd7c583f6cb3bc74266d4683fb8008b4634a15c68e488d3a714f2e16922605e80::governance::DragonBallCollector, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) : 0x2::package::UpgradeTicket {
        0xd7c583f6cb3bc74266d4683fb8008b4634a15c68e488d3a714f2e16922605e80::governance::ensure_functional(arg0);
        0xd7c583f6cb3bc74266d4683fb8008b4634a15c68e488d3a714f2e16922605e80::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg2));
        let v0 = 0xd7c583f6cb3bc74266d4683fb8008b4634a15c68e488d3a714f2e16922605e80::governance::take_locked_update<0xd7c583f6cb3bc74266d4683fb8008b4634a15c68e488d3a714f2e16922605e80::time_lock::TimeLock<XOracleUpgradeWish>>(arg0, 0x1::type_name::with_defining_ids<XOracleUpgradeWish>());
        assert!(0xd7c583f6cb3bc74266d4683fb8008b4634a15c68e488d3a714f2e16922605e80::time_lock::is_active<XOracleUpgradeWish>(&v0, arg1), 0xd7c583f6cb3bc74266d4683fb8008b4634a15c68e488d3a714f2e16922605e80::errors::time_locked_not_active());
        let v1 = 0xd7c583f6cb3bc74266d4683fb8008b4634a15c68e488d3a714f2e16922605e80::time_lock::into_inner<XOracleUpgradeWish>(v0);
        0xd7c583f6cb3bc74266d4683fb8008b4634a15c68e488d3a714f2e16922605e80::wish_event::emit_fulfill_wish_event<XOracleUpgradeWish>(v1);
        let XOracleUpgradeWish {
            policy               : v2,
            digest               : v3,
            super_admin_approved : v4,
        } = v1;
        assert!(v4, 0xd7c583f6cb3bc74266d4683fb8008b4634a15c68e488d3a714f2e16922605e80::errors::super_admin_not_approved());
        0x2::package::authorize_upgrade(0xd7c583f6cb3bc74266d4683fb8008b4634a15c68e488d3a714f2e16922605e80::governance::x_oracle_package_upgrade_cap(arg0), v2, v3)
    }

    public fun commit_xoracle_upgrade(arg0: &mut 0xd7c583f6cb3bc74266d4683fb8008b4634a15c68e488d3a714f2e16922605e80::governance::DragonBallCollector, arg1: 0x2::package::UpgradeReceipt, arg2: &0x2::tx_context::TxContext) {
        0xd7c583f6cb3bc74266d4683fb8008b4634a15c68e488d3a714f2e16922605e80::governance::ensure_functional(arg0);
        0xd7c583f6cb3bc74266d4683fb8008b4634a15c68e488d3a714f2e16922605e80::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg2));
        0x2::package::commit_upgrade(0xd7c583f6cb3bc74266d4683fb8008b4634a15c68e488d3a714f2e16922605e80::governance::x_oracle_package_upgrade_cap(arg0), arg1);
    }

    public fun update_upgrade_approval(arg0: &0xd7c583f6cb3bc74266d4683fb8008b4634a15c68e488d3a714f2e16922605e80::roles::SuperAdminRole, arg1: &mut 0xd7c583f6cb3bc74266d4683fb8008b4634a15c68e488d3a714f2e16922605e80::governance::DragonBallCollector, arg2: bool, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        0xd7c583f6cb3bc74266d4683fb8008b4634a15c68e488d3a714f2e16922605e80::governance::ensure_functional(arg1);
        let v0 = 0xd7c583f6cb3bc74266d4683fb8008b4634a15c68e488d3a714f2e16922605e80::governance::borrow_mut_wish<0xd7c583f6cb3bc74266d4683fb8008b4634a15c68e488d3a714f2e16922605e80::time_lock::TimeLock<XOracleUpgradeWish>>(arg1, 0x1::type_name::with_defining_ids<XOracleUpgradeWish>());
        assert!(!0xd7c583f6cb3bc74266d4683fb8008b4634a15c68e488d3a714f2e16922605e80::time_lock::is_expired<XOracleUpgradeWish>(v0, arg3), 0xd7c583f6cb3bc74266d4683fb8008b4634a15c68e488d3a714f2e16922605e80::errors::time_locked_expired());
        0xd7c583f6cb3bc74266d4683fb8008b4634a15c68e488d3a714f2e16922605e80::time_lock::inner_mut<XOracleUpgradeWish>(v0).super_admin_approved = arg2;
        0xd7c583f6cb3bc74266d4683fb8008b4634a15c68e488d3a714f2e16922605e80::wish_event::emit_upgrade_approval_changed(0, arg2, 0x2::tx_context::sender(arg4));
    }

    public fun wish_authorize_xoracle_upgrade(arg0: &mut 0xd7c583f6cb3bc74266d4683fb8008b4634a15c68e488d3a714f2e16922605e80::governance::DragonBallCollector, arg1: u8, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        0xd7c583f6cb3bc74266d4683fb8008b4634a15c68e488d3a714f2e16922605e80::governance::ensure_functional(arg0);
        0xd7c583f6cb3bc74266d4683fb8008b4634a15c68e488d3a714f2e16922605e80::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg4));
        let v0 = XOracleUpgradeWish{
            policy               : arg1,
            digest               : arg2,
            super_admin_approved : false,
        };
        0xd7c583f6cb3bc74266d4683fb8008b4634a15c68e488d3a714f2e16922605e80::wish_event::emit_new_wish_event<XOracleUpgradeWish>(v0);
        0xd7c583f6cb3bc74266d4683fb8008b4634a15c68e488d3a714f2e16922605e80::governance::store_locked_update<0xd7c583f6cb3bc74266d4683fb8008b4634a15c68e488d3a714f2e16922605e80::time_lock::TimeLock<XOracleUpgradeWish>>(arg0, 0x1::type_name::with_defining_ids<XOracleUpgradeWish>(), 0xd7c583f6cb3bc74266d4683fb8008b4634a15c68e488d3a714f2e16922605e80::time_lock::new_time_locked<XOracleUpgradeWish>(v0, arg3, 0xd7c583f6cb3bc74266d4683fb8008b4634a15c68e488d3a714f2e16922605e80::governance::time_lock_duration_seconds(arg0), 0xd7c583f6cb3bc74266d4683fb8008b4634a15c68e488d3a714f2e16922605e80::governance::time_lock_expriration_seconds(arg0)));
    }

    // decompiled from Move bytecode v6
}

