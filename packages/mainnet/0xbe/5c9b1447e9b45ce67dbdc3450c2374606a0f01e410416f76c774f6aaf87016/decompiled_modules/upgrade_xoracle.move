module 0xbe5c9b1447e9b45ce67dbdc3450c2374606a0f01e410416f76c774f6aaf87016::upgrade_xoracle {
    struct XOracleUpgradeWish has copy, drop, store {
        policy: u8,
        digest: vector<u8>,
    }

    public fun migrate(arg0: &mut 0xbe5c9b1447e9b45ce67dbdc3450c2374606a0f01e410416f76c774f6aaf87016::governance::DragonBallCollector, arg1: &mut 0x8f470555f3bececd724527af2680830b545802a79f485a52efc8a310275869cf::x_oracle::XOracle, arg2: &mut 0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::app::ProtocolApp, arg3: &mut 0x81fefef907d775faab48dbfd64cb7d37596ea5565de1850937c8807c2ce33f40::leverage_app::LeverageApp, arg4: &0x2::tx_context::TxContext) {
        0xbe5c9b1447e9b45ce67dbdc3450c2374606a0f01e410416f76c774f6aaf87016::governance::ensure_can_summon_shenron(arg0);
        0xbe5c9b1447e9b45ce67dbdc3450c2374606a0f01e410416f76c774f6aaf87016::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg4));
        migrate_inner(arg0, arg1, arg4);
        0xbe5c9b1447e9b45ce67dbdc3450c2374606a0f01e410416f76c774f6aaf87016::upgrade_protocol::migrate_inner(arg0, arg2, arg4);
        0xbe5c9b1447e9b45ce67dbdc3450c2374606a0f01e410416f76c774f6aaf87016::upgrade_leverage::migrate_inner(arg0, arg3, arg4);
        0xbe5c9b1447e9b45ce67dbdc3450c2374606a0f01e410416f76c774f6aaf87016::upgrade_self::migrate_inner(arg0, arg4);
    }

    fun migrate_inner(arg0: &0xbe5c9b1447e9b45ce67dbdc3450c2374606a0f01e410416f76c774f6aaf87016::governance::DragonBallCollector, arg1: &mut 0x8f470555f3bececd724527af2680830b545802a79f485a52efc8a310275869cf::x_oracle::XOracle, arg2: &0x2::tx_context::TxContext) {
        0xbe5c9b1447e9b45ce67dbdc3450c2374606a0f01e410416f76c774f6aaf87016::wish_event::emit_object_migrated(0, 0x8f470555f3bececd724527af2680830b545802a79f485a52efc8a310275869cf::oracle_admin::migrate(0xbe5c9b1447e9b45ce67dbdc3450c2374606a0f01e410416f76c774f6aaf87016::governance::x_oracle_admin_cap(arg0), arg1), 0x2::tx_context::sender(arg2));
    }

    public fun authorize_xoracle_upgrade(arg0: &mut 0xbe5c9b1447e9b45ce67dbdc3450c2374606a0f01e410416f76c774f6aaf87016::governance::DragonBallCollector, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) : 0x2::package::UpgradeTicket {
        0xbe5c9b1447e9b45ce67dbdc3450c2374606a0f01e410416f76c774f6aaf87016::governance::ensure_functional(arg0);
        0xbe5c9b1447e9b45ce67dbdc3450c2374606a0f01e410416f76c774f6aaf87016::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg2));
        let v0 = 0xbe5c9b1447e9b45ce67dbdc3450c2374606a0f01e410416f76c774f6aaf87016::governance::take_locked_update<0xbe5c9b1447e9b45ce67dbdc3450c2374606a0f01e410416f76c774f6aaf87016::time_lock::TimeLock<XOracleUpgradeWish>>(arg0, 0x1::type_name::with_defining_ids<XOracleUpgradeWish>());
        assert!(0xbe5c9b1447e9b45ce67dbdc3450c2374606a0f01e410416f76c774f6aaf87016::time_lock::is_active<XOracleUpgradeWish>(&v0, arg1), 0xbe5c9b1447e9b45ce67dbdc3450c2374606a0f01e410416f76c774f6aaf87016::errors::time_locked_not_active());
        let v1 = 0xbe5c9b1447e9b45ce67dbdc3450c2374606a0f01e410416f76c774f6aaf87016::time_lock::into_inner<XOracleUpgradeWish>(v0);
        0xbe5c9b1447e9b45ce67dbdc3450c2374606a0f01e410416f76c774f6aaf87016::wish_event::emit_fulfill_wish_event<XOracleUpgradeWish>(v1);
        let XOracleUpgradeWish {
            policy : v2,
            digest : v3,
        } = v1;
        0x2::package::authorize_upgrade(0xbe5c9b1447e9b45ce67dbdc3450c2374606a0f01e410416f76c774f6aaf87016::governance::x_oracle_package_upgrade_cap(arg0), v2, v3)
    }

    public fun commit_xoracle_upgrade(arg0: &mut 0xbe5c9b1447e9b45ce67dbdc3450c2374606a0f01e410416f76c774f6aaf87016::governance::DragonBallCollector, arg1: 0x2::package::UpgradeReceipt, arg2: &0x2::tx_context::TxContext) {
        0xbe5c9b1447e9b45ce67dbdc3450c2374606a0f01e410416f76c774f6aaf87016::governance::ensure_functional(arg0);
        0xbe5c9b1447e9b45ce67dbdc3450c2374606a0f01e410416f76c774f6aaf87016::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg2));
        0x2::package::commit_upgrade(0xbe5c9b1447e9b45ce67dbdc3450c2374606a0f01e410416f76c774f6aaf87016::governance::x_oracle_package_upgrade_cap(arg0), arg1);
    }

    public fun wish_authorize_xoracle_upgrade(arg0: &mut 0xbe5c9b1447e9b45ce67dbdc3450c2374606a0f01e410416f76c774f6aaf87016::governance::DragonBallCollector, arg1: u8, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        0xbe5c9b1447e9b45ce67dbdc3450c2374606a0f01e410416f76c774f6aaf87016::governance::ensure_functional(arg0);
        0xbe5c9b1447e9b45ce67dbdc3450c2374606a0f01e410416f76c774f6aaf87016::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg4));
        let v0 = XOracleUpgradeWish{
            policy : arg1,
            digest : arg2,
        };
        0xbe5c9b1447e9b45ce67dbdc3450c2374606a0f01e410416f76c774f6aaf87016::wish_event::emit_new_wish_event<XOracleUpgradeWish>(v0);
        0xbe5c9b1447e9b45ce67dbdc3450c2374606a0f01e410416f76c774f6aaf87016::governance::store_locked_update<0xbe5c9b1447e9b45ce67dbdc3450c2374606a0f01e410416f76c774f6aaf87016::time_lock::TimeLock<XOracleUpgradeWish>>(arg0, 0x1::type_name::with_defining_ids<XOracleUpgradeWish>(), 0xbe5c9b1447e9b45ce67dbdc3450c2374606a0f01e410416f76c774f6aaf87016::time_lock::new_time_locked<XOracleUpgradeWish>(v0, arg3, 0xbe5c9b1447e9b45ce67dbdc3450c2374606a0f01e410416f76c774f6aaf87016::governance::time_lock_duration_seconds(arg0), 0xbe5c9b1447e9b45ce67dbdc3450c2374606a0f01e410416f76c774f6aaf87016::governance::time_lock_expriration_seconds(arg0)));
    }

    // decompiled from Move bytecode v6
}

