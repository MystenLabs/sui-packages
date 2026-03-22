module 0xf2cdbcebdeb82cb7d213114e0278b5951491f1f20faf54531a9574f0e05a1481::upgrade_xoracle {
    struct XOracleUpgradeWish has copy, drop, store {
        policy: u8,
        digest: vector<u8>,
        super_admin_approved: bool,
    }

    public fun migrate(arg0: &mut 0xf2cdbcebdeb82cb7d213114e0278b5951491f1f20faf54531a9574f0e05a1481::governance::DragonBallCollector, arg1: &mut 0xb2122b399c78f3f0f9874bdd34fbdda90d3867ebf8972bda97f85218bf0de67::x_oracle::XOracle, arg2: &mut 0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::app::ProtocolApp, arg3: &mut 0xc7c4314eb7c803d6a885c978cfc45dca5a7183499d31db646146025488aa5db6::leverage_app::LeverageApp, arg4: &0x2::tx_context::TxContext) {
        0xf2cdbcebdeb82cb7d213114e0278b5951491f1f20faf54531a9574f0e05a1481::governance::ensure_can_summon_shenron(arg0);
        0xf2cdbcebdeb82cb7d213114e0278b5951491f1f20faf54531a9574f0e05a1481::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg4));
        migrate_inner(arg0, arg1, arg4);
        0xf2cdbcebdeb82cb7d213114e0278b5951491f1f20faf54531a9574f0e05a1481::upgrade_protocol::migrate_inner(arg0, arg2, arg4);
        0xf2cdbcebdeb82cb7d213114e0278b5951491f1f20faf54531a9574f0e05a1481::upgrade_leverage::migrate_inner(arg0, arg3, arg4);
        0xf2cdbcebdeb82cb7d213114e0278b5951491f1f20faf54531a9574f0e05a1481::upgrade_self::migrate_inner(arg0, arg4);
    }

    fun migrate_inner(arg0: &0xf2cdbcebdeb82cb7d213114e0278b5951491f1f20faf54531a9574f0e05a1481::governance::DragonBallCollector, arg1: &mut 0xb2122b399c78f3f0f9874bdd34fbdda90d3867ebf8972bda97f85218bf0de67::x_oracle::XOracle, arg2: &0x2::tx_context::TxContext) {
        0xf2cdbcebdeb82cb7d213114e0278b5951491f1f20faf54531a9574f0e05a1481::wish_event::emit_object_migrated(0, 0xb2122b399c78f3f0f9874bdd34fbdda90d3867ebf8972bda97f85218bf0de67::oracle_admin::migrate(0xf2cdbcebdeb82cb7d213114e0278b5951491f1f20faf54531a9574f0e05a1481::governance::x_oracle_admin_cap(arg0), arg1), 0x2::tx_context::sender(arg2));
    }

    public fun authorize_xoracle_upgrade(arg0: &mut 0xf2cdbcebdeb82cb7d213114e0278b5951491f1f20faf54531a9574f0e05a1481::governance::DragonBallCollector, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) : 0x2::package::UpgradeTicket {
        0xf2cdbcebdeb82cb7d213114e0278b5951491f1f20faf54531a9574f0e05a1481::governance::ensure_functional(arg0);
        0xf2cdbcebdeb82cb7d213114e0278b5951491f1f20faf54531a9574f0e05a1481::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg2));
        let v0 = 0xf2cdbcebdeb82cb7d213114e0278b5951491f1f20faf54531a9574f0e05a1481::governance::take_locked_update<0xf2cdbcebdeb82cb7d213114e0278b5951491f1f20faf54531a9574f0e05a1481::time_lock::TimeLock<XOracleUpgradeWish>>(arg0, 0x1::type_name::with_defining_ids<XOracleUpgradeWish>());
        assert!(0xf2cdbcebdeb82cb7d213114e0278b5951491f1f20faf54531a9574f0e05a1481::time_lock::is_active<XOracleUpgradeWish>(&v0, arg1), 0xf2cdbcebdeb82cb7d213114e0278b5951491f1f20faf54531a9574f0e05a1481::errors::time_locked_not_active());
        let v1 = 0xf2cdbcebdeb82cb7d213114e0278b5951491f1f20faf54531a9574f0e05a1481::time_lock::into_inner<XOracleUpgradeWish>(v0);
        0xf2cdbcebdeb82cb7d213114e0278b5951491f1f20faf54531a9574f0e05a1481::wish_event::emit_fulfill_wish_event<XOracleUpgradeWish>(v1);
        let XOracleUpgradeWish {
            policy               : v2,
            digest               : v3,
            super_admin_approved : v4,
        } = v1;
        assert!(v4, 0xf2cdbcebdeb82cb7d213114e0278b5951491f1f20faf54531a9574f0e05a1481::errors::super_admin_not_approved());
        0x2::package::authorize_upgrade(0xf2cdbcebdeb82cb7d213114e0278b5951491f1f20faf54531a9574f0e05a1481::governance::x_oracle_package_upgrade_cap(arg0), v2, v3)
    }

    public fun commit_xoracle_upgrade(arg0: &mut 0xf2cdbcebdeb82cb7d213114e0278b5951491f1f20faf54531a9574f0e05a1481::governance::DragonBallCollector, arg1: 0x2::package::UpgradeReceipt, arg2: &0x2::tx_context::TxContext) {
        0xf2cdbcebdeb82cb7d213114e0278b5951491f1f20faf54531a9574f0e05a1481::governance::ensure_functional(arg0);
        0xf2cdbcebdeb82cb7d213114e0278b5951491f1f20faf54531a9574f0e05a1481::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg2));
        0x2::package::commit_upgrade(0xf2cdbcebdeb82cb7d213114e0278b5951491f1f20faf54531a9574f0e05a1481::governance::x_oracle_package_upgrade_cap(arg0), arg1);
    }

    public fun update_upgrade_approval(arg0: &0xf2cdbcebdeb82cb7d213114e0278b5951491f1f20faf54531a9574f0e05a1481::roles::SuperAdminRole, arg1: &mut 0xf2cdbcebdeb82cb7d213114e0278b5951491f1f20faf54531a9574f0e05a1481::governance::DragonBallCollector, arg2: bool, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        0xf2cdbcebdeb82cb7d213114e0278b5951491f1f20faf54531a9574f0e05a1481::governance::ensure_functional(arg1);
        let v0 = 0xf2cdbcebdeb82cb7d213114e0278b5951491f1f20faf54531a9574f0e05a1481::governance::borrow_mut_wish<0xf2cdbcebdeb82cb7d213114e0278b5951491f1f20faf54531a9574f0e05a1481::time_lock::TimeLock<XOracleUpgradeWish>>(arg1, 0x1::type_name::with_defining_ids<XOracleUpgradeWish>());
        assert!(!0xf2cdbcebdeb82cb7d213114e0278b5951491f1f20faf54531a9574f0e05a1481::time_lock::is_expired<XOracleUpgradeWish>(v0, arg3), 0xf2cdbcebdeb82cb7d213114e0278b5951491f1f20faf54531a9574f0e05a1481::errors::time_locked_expired());
        0xf2cdbcebdeb82cb7d213114e0278b5951491f1f20faf54531a9574f0e05a1481::time_lock::inner_mut<XOracleUpgradeWish>(v0).super_admin_approved = arg2;
        0xf2cdbcebdeb82cb7d213114e0278b5951491f1f20faf54531a9574f0e05a1481::wish_event::emit_upgrade_approval_changed(0, arg2, 0x2::tx_context::sender(arg4));
    }

    public fun wish_authorize_xoracle_upgrade(arg0: &mut 0xf2cdbcebdeb82cb7d213114e0278b5951491f1f20faf54531a9574f0e05a1481::governance::DragonBallCollector, arg1: u8, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        0xf2cdbcebdeb82cb7d213114e0278b5951491f1f20faf54531a9574f0e05a1481::governance::ensure_functional(arg0);
        0xf2cdbcebdeb82cb7d213114e0278b5951491f1f20faf54531a9574f0e05a1481::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg4));
        let v0 = XOracleUpgradeWish{
            policy               : arg1,
            digest               : arg2,
            super_admin_approved : false,
        };
        0xf2cdbcebdeb82cb7d213114e0278b5951491f1f20faf54531a9574f0e05a1481::wish_event::emit_new_wish_event<XOracleUpgradeWish>(v0);
        0xf2cdbcebdeb82cb7d213114e0278b5951491f1f20faf54531a9574f0e05a1481::governance::store_locked_update<0xf2cdbcebdeb82cb7d213114e0278b5951491f1f20faf54531a9574f0e05a1481::time_lock::TimeLock<XOracleUpgradeWish>>(arg0, 0x1::type_name::with_defining_ids<XOracleUpgradeWish>(), 0xf2cdbcebdeb82cb7d213114e0278b5951491f1f20faf54531a9574f0e05a1481::time_lock::new_time_locked<XOracleUpgradeWish>(v0, arg3, 0xf2cdbcebdeb82cb7d213114e0278b5951491f1f20faf54531a9574f0e05a1481::governance::time_lock_duration_seconds(arg0), 0xf2cdbcebdeb82cb7d213114e0278b5951491f1f20faf54531a9574f0e05a1481::governance::time_lock_expriration_seconds(arg0)));
    }

    // decompiled from Move bytecode v6
}

