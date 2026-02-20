module 0x6cc212ed4d117713b39d2f235339f042be80579c20147baf25eac7458f3f9ee6::upgrade_xoracle {
    struct XOracleUpgradeWish has copy, drop, store {
        policy: u8,
        digest: vector<u8>,
    }

    fun migrate_inner(arg0: &0x6cc212ed4d117713b39d2f235339f042be80579c20147baf25eac7458f3f9ee6::governance::DragonBallCollector, arg1: &mut 0xb97857eb8c5b0c9aaf4ae617982a9557d5386b093a00adbc35bace8b14a6a7a6::x_oracle::XOracle, arg2: &0x2::tx_context::TxContext) {
        0x6cc212ed4d117713b39d2f235339f042be80579c20147baf25eac7458f3f9ee6::wish_event::emit_object_migrated(0, 0xb97857eb8c5b0c9aaf4ae617982a9557d5386b093a00adbc35bace8b14a6a7a6::oracle_admin::migrate(0x6cc212ed4d117713b39d2f235339f042be80579c20147baf25eac7458f3f9ee6::governance::x_oracle_admin_cap(arg0), arg1), 0x2::tx_context::sender(arg2));
    }

    public fun authorize_xoracle_upgrade(arg0: &mut 0x6cc212ed4d117713b39d2f235339f042be80579c20147baf25eac7458f3f9ee6::governance::DragonBallCollector, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) : 0x2::package::UpgradeTicket {
        0x6cc212ed4d117713b39d2f235339f042be80579c20147baf25eac7458f3f9ee6::governance::ensure_functional(arg0);
        0x6cc212ed4d117713b39d2f235339f042be80579c20147baf25eac7458f3f9ee6::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg2));
        let v0 = 0x6cc212ed4d117713b39d2f235339f042be80579c20147baf25eac7458f3f9ee6::governance::take_locked_update<0x6cc212ed4d117713b39d2f235339f042be80579c20147baf25eac7458f3f9ee6::time_lock::TimeLock<XOracleUpgradeWish>>(arg0, 0x1::type_name::with_defining_ids<XOracleUpgradeWish>());
        assert!(0x6cc212ed4d117713b39d2f235339f042be80579c20147baf25eac7458f3f9ee6::time_lock::is_active<XOracleUpgradeWish>(&v0, arg1), 0x6cc212ed4d117713b39d2f235339f042be80579c20147baf25eac7458f3f9ee6::errors::time_locked_not_active());
        let v1 = 0x6cc212ed4d117713b39d2f235339f042be80579c20147baf25eac7458f3f9ee6::time_lock::into_inner<XOracleUpgradeWish>(v0);
        0x6cc212ed4d117713b39d2f235339f042be80579c20147baf25eac7458f3f9ee6::wish_event::emit_fulfill_wish_event<XOracleUpgradeWish>(v1);
        let XOracleUpgradeWish {
            policy : v2,
            digest : v3,
        } = v1;
        0x2::package::authorize_upgrade(0x6cc212ed4d117713b39d2f235339f042be80579c20147baf25eac7458f3f9ee6::governance::x_oracle_package_upgrade_cap(arg0), v2, v3)
    }

    public fun commit_xoracle_upgrade(arg0: &mut 0x6cc212ed4d117713b39d2f235339f042be80579c20147baf25eac7458f3f9ee6::governance::DragonBallCollector, arg1: 0x2::package::UpgradeReceipt, arg2: &0x2::tx_context::TxContext) {
        0x6cc212ed4d117713b39d2f235339f042be80579c20147baf25eac7458f3f9ee6::governance::ensure_functional(arg0);
        0x6cc212ed4d117713b39d2f235339f042be80579c20147baf25eac7458f3f9ee6::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg2));
        0x2::package::commit_upgrade(0x6cc212ed4d117713b39d2f235339f042be80579c20147baf25eac7458f3f9ee6::governance::x_oracle_package_upgrade_cap(arg0), arg1);
    }

    public fun migrate(arg0: &mut 0x6cc212ed4d117713b39d2f235339f042be80579c20147baf25eac7458f3f9ee6::governance::DragonBallCollector, arg1: &mut 0xb97857eb8c5b0c9aaf4ae617982a9557d5386b093a00adbc35bace8b14a6a7a6::x_oracle::XOracle, arg2: &mut 0x1c866c70d8ab65dd45409d6624f65a6ac0e3d07d634bec793220711ca0394f26::app::ProtocolApp, arg3: &mut 0x3a6dcf831e2a45963f8468f8f8132eeddbea6604526852252ff2e285dcd4d07d::leverage_app::LeverageApp, arg4: &0x2::tx_context::TxContext) {
        0x6cc212ed4d117713b39d2f235339f042be80579c20147baf25eac7458f3f9ee6::governance::ensure_functional(arg0);
        0x6cc212ed4d117713b39d2f235339f042be80579c20147baf25eac7458f3f9ee6::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg4));
        migrate_inner(arg0, arg1, arg4);
        0x6cc212ed4d117713b39d2f235339f042be80579c20147baf25eac7458f3f9ee6::upgrade_protocol::migrate_inner(arg0, arg2, arg4);
        0x6cc212ed4d117713b39d2f235339f042be80579c20147baf25eac7458f3f9ee6::upgrade_leverage::migrate_inner(arg0, arg3, arg4);
        0x6cc212ed4d117713b39d2f235339f042be80579c20147baf25eac7458f3f9ee6::upgrade_self::migrate_inner(arg0, arg4);
    }

    public fun wish_authorize_xoracle_upgrade(arg0: &mut 0x6cc212ed4d117713b39d2f235339f042be80579c20147baf25eac7458f3f9ee6::governance::DragonBallCollector, arg1: u8, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        0x6cc212ed4d117713b39d2f235339f042be80579c20147baf25eac7458f3f9ee6::governance::ensure_functional(arg0);
        0x6cc212ed4d117713b39d2f235339f042be80579c20147baf25eac7458f3f9ee6::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg4));
        let v0 = XOracleUpgradeWish{
            policy : arg1,
            digest : arg2,
        };
        0x6cc212ed4d117713b39d2f235339f042be80579c20147baf25eac7458f3f9ee6::wish_event::emit_new_wish_event<XOracleUpgradeWish>(v0);
        0x6cc212ed4d117713b39d2f235339f042be80579c20147baf25eac7458f3f9ee6::governance::store_locked_update<0x6cc212ed4d117713b39d2f235339f042be80579c20147baf25eac7458f3f9ee6::time_lock::TimeLock<XOracleUpgradeWish>>(arg0, 0x1::type_name::with_defining_ids<XOracleUpgradeWish>(), 0x6cc212ed4d117713b39d2f235339f042be80579c20147baf25eac7458f3f9ee6::time_lock::new_time_locked<XOracleUpgradeWish>(v0, arg3, 0x6cc212ed4d117713b39d2f235339f042be80579c20147baf25eac7458f3f9ee6::governance::time_lock_duration_seconds(arg0), 0x6cc212ed4d117713b39d2f235339f042be80579c20147baf25eac7458f3f9ee6::governance::time_lock_expriration_seconds(arg0)));
    }

    // decompiled from Move bytecode v6
}

