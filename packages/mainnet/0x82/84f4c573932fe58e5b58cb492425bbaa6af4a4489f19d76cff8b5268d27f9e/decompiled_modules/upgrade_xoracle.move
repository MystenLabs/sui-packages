module 0x8284f4c573932fe58e5b58cb492425bbaa6af4a4489f19d76cff8b5268d27f9e::upgrade_xoracle {
    struct XOracleUpgradeWish has copy, drop, store {
        policy: u8,
        digest: vector<u8>,
    }

    public fun migrate(arg0: &mut 0x8284f4c573932fe58e5b58cb492425bbaa6af4a4489f19d76cff8b5268d27f9e::governance::DragonBallCollector, arg1: &mut 0x660203619d4bdf97f39224f2555d0a3796d3525c1cfd1f4415704d3e061b2d54::x_oracle::XOracle, arg2: &mut 0x16a08a310237e82b2e8c29ab2a5ff1fbc3cf659bf8dc7b79211bbbac2a4c28e5::app::ProtocolApp, arg3: &mut 0x91214ba05fb203bcdadedb94878513a6bbeda0a8213a50727f20bc6977eeaed4::leverage_app::LeverageApp, arg4: &0x2::tx_context::TxContext) {
        0x8284f4c573932fe58e5b58cb492425bbaa6af4a4489f19d76cff8b5268d27f9e::governance::ensure_can_summon_shenron(arg0);
        0x8284f4c573932fe58e5b58cb492425bbaa6af4a4489f19d76cff8b5268d27f9e::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg4));
        migrate_inner(arg0, arg1, arg4);
        0x8284f4c573932fe58e5b58cb492425bbaa6af4a4489f19d76cff8b5268d27f9e::upgrade_protocol::migrate_inner(arg0, arg2, arg4);
        0x8284f4c573932fe58e5b58cb492425bbaa6af4a4489f19d76cff8b5268d27f9e::upgrade_leverage::migrate_inner(arg0, arg3, arg4);
        0x8284f4c573932fe58e5b58cb492425bbaa6af4a4489f19d76cff8b5268d27f9e::upgrade_self::migrate_inner(arg0, arg4);
    }

    fun migrate_inner(arg0: &0x8284f4c573932fe58e5b58cb492425bbaa6af4a4489f19d76cff8b5268d27f9e::governance::DragonBallCollector, arg1: &mut 0x660203619d4bdf97f39224f2555d0a3796d3525c1cfd1f4415704d3e061b2d54::x_oracle::XOracle, arg2: &0x2::tx_context::TxContext) {
        0x8284f4c573932fe58e5b58cb492425bbaa6af4a4489f19d76cff8b5268d27f9e::wish_event::emit_object_migrated(0, 0x660203619d4bdf97f39224f2555d0a3796d3525c1cfd1f4415704d3e061b2d54::oracle_admin::migrate(0x8284f4c573932fe58e5b58cb492425bbaa6af4a4489f19d76cff8b5268d27f9e::governance::x_oracle_admin_cap(arg0), arg1), 0x2::tx_context::sender(arg2));
    }

    public fun authorize_xoracle_upgrade(arg0: &mut 0x8284f4c573932fe58e5b58cb492425bbaa6af4a4489f19d76cff8b5268d27f9e::governance::DragonBallCollector, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) : 0x2::package::UpgradeTicket {
        0x8284f4c573932fe58e5b58cb492425bbaa6af4a4489f19d76cff8b5268d27f9e::governance::ensure_can_summon_shenron(arg0);
        0x8284f4c573932fe58e5b58cb492425bbaa6af4a4489f19d76cff8b5268d27f9e::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg2));
        let v0 = 0x8284f4c573932fe58e5b58cb492425bbaa6af4a4489f19d76cff8b5268d27f9e::governance::take_locked_update<0x8284f4c573932fe58e5b58cb492425bbaa6af4a4489f19d76cff8b5268d27f9e::time_lock::TimeLock<XOracleUpgradeWish>>(arg0, 0x1::type_name::with_defining_ids<XOracleUpgradeWish>());
        assert!(0x8284f4c573932fe58e5b58cb492425bbaa6af4a4489f19d76cff8b5268d27f9e::time_lock::is_active<XOracleUpgradeWish>(&v0, arg1), 0x8284f4c573932fe58e5b58cb492425bbaa6af4a4489f19d76cff8b5268d27f9e::errors::time_locked_not_active());
        let v1 = 0x8284f4c573932fe58e5b58cb492425bbaa6af4a4489f19d76cff8b5268d27f9e::time_lock::into_inner<XOracleUpgradeWish>(v0);
        0x8284f4c573932fe58e5b58cb492425bbaa6af4a4489f19d76cff8b5268d27f9e::wish_event::emit_fulfill_wish_event<XOracleUpgradeWish>(v1);
        let XOracleUpgradeWish {
            policy : v2,
            digest : v3,
        } = v1;
        0x2::package::authorize_upgrade(0x8284f4c573932fe58e5b58cb492425bbaa6af4a4489f19d76cff8b5268d27f9e::governance::x_oracle_package_upgrade_cap(arg0), v2, v3)
    }

    public fun commit_xoracle_upgrade(arg0: &mut 0x8284f4c573932fe58e5b58cb492425bbaa6af4a4489f19d76cff8b5268d27f9e::governance::DragonBallCollector, arg1: 0x2::package::UpgradeReceipt, arg2: &0x2::tx_context::TxContext) {
        0x8284f4c573932fe58e5b58cb492425bbaa6af4a4489f19d76cff8b5268d27f9e::governance::ensure_can_summon_shenron(arg0);
        0x8284f4c573932fe58e5b58cb492425bbaa6af4a4489f19d76cff8b5268d27f9e::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg2));
        0x2::package::commit_upgrade(0x8284f4c573932fe58e5b58cb492425bbaa6af4a4489f19d76cff8b5268d27f9e::governance::x_oracle_package_upgrade_cap(arg0), arg1);
    }

    public fun wish_authorize_xoracle_upgrade(arg0: &mut 0x8284f4c573932fe58e5b58cb492425bbaa6af4a4489f19d76cff8b5268d27f9e::governance::DragonBallCollector, arg1: u8, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        0x8284f4c573932fe58e5b58cb492425bbaa6af4a4489f19d76cff8b5268d27f9e::governance::ensure_can_summon_shenron(arg0);
        0x8284f4c573932fe58e5b58cb492425bbaa6af4a4489f19d76cff8b5268d27f9e::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg4));
        let v0 = XOracleUpgradeWish{
            policy : arg1,
            digest : arg2,
        };
        0x8284f4c573932fe58e5b58cb492425bbaa6af4a4489f19d76cff8b5268d27f9e::wish_event::emit_new_wish_event<XOracleUpgradeWish>(v0);
        0x8284f4c573932fe58e5b58cb492425bbaa6af4a4489f19d76cff8b5268d27f9e::governance::store_locked_update<0x8284f4c573932fe58e5b58cb492425bbaa6af4a4489f19d76cff8b5268d27f9e::time_lock::TimeLock<XOracleUpgradeWish>>(arg0, 0x1::type_name::with_defining_ids<XOracleUpgradeWish>(), 0x8284f4c573932fe58e5b58cb492425bbaa6af4a4489f19d76cff8b5268d27f9e::time_lock::new_time_locked<XOracleUpgradeWish>(v0, arg3, 0x8284f4c573932fe58e5b58cb492425bbaa6af4a4489f19d76cff8b5268d27f9e::governance::time_lock_duration_seconds(arg0), 0x8284f4c573932fe58e5b58cb492425bbaa6af4a4489f19d76cff8b5268d27f9e::governance::time_lock_expriration_seconds(arg0)));
    }

    // decompiled from Move bytecode v6
}

