module 0x643057d4e32bdd8035a7c681d04293f2bde919de59b80b63f192daeafec31629::upgrade_xoracle {
    struct XOracleUpgradeWish has copy, drop, store {
        policy: u8,
        digest: vector<u8>,
        super_admin_approved: bool,
    }

    public fun migrate(arg0: &mut 0x643057d4e32bdd8035a7c681d04293f2bde919de59b80b63f192daeafec31629::governance::DragonBallCollector, arg1: &mut 0xcb8499accc8d72fc498287808427fb1bc76b509b3127df63b5859919427dbc::x_oracle::XOracle, arg2: &mut 0x4ad0cdb92efdaf00ba808d097af9746923150d1769046d4f8aeac9a466d8c1db::app::ProtocolApp, arg3: &mut 0xc640c0be4e6e502ebf7e37456c8501ec2e102d5cfe4fac827c1b3ebcef544f94::leverage_app::LeverageApp, arg4: &0x2::tx_context::TxContext) {
        0x643057d4e32bdd8035a7c681d04293f2bde919de59b80b63f192daeafec31629::governance::ensure_can_summon_shenron(arg0);
        0x643057d4e32bdd8035a7c681d04293f2bde919de59b80b63f192daeafec31629::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg4));
        migrate_inner(arg0, arg1, arg4);
        0x643057d4e32bdd8035a7c681d04293f2bde919de59b80b63f192daeafec31629::upgrade_protocol::migrate_inner(arg0, arg2, arg4);
        0x643057d4e32bdd8035a7c681d04293f2bde919de59b80b63f192daeafec31629::upgrade_leverage::migrate_inner(arg0, arg3, arg4);
        0x643057d4e32bdd8035a7c681d04293f2bde919de59b80b63f192daeafec31629::upgrade_self::migrate_inner(arg0, arg4);
    }

    fun migrate_inner(arg0: &0x643057d4e32bdd8035a7c681d04293f2bde919de59b80b63f192daeafec31629::governance::DragonBallCollector, arg1: &mut 0xcb8499accc8d72fc498287808427fb1bc76b509b3127df63b5859919427dbc::x_oracle::XOracle, arg2: &0x2::tx_context::TxContext) {
        0x643057d4e32bdd8035a7c681d04293f2bde919de59b80b63f192daeafec31629::wish_event::emit_object_migrated(0, 0xcb8499accc8d72fc498287808427fb1bc76b509b3127df63b5859919427dbc::oracle_admin::migrate(0x643057d4e32bdd8035a7c681d04293f2bde919de59b80b63f192daeafec31629::governance::x_oracle_admin_cap(arg0), arg1), 0x2::tx_context::sender(arg2));
    }

    public fun authorize_xoracle_upgrade(arg0: &mut 0x643057d4e32bdd8035a7c681d04293f2bde919de59b80b63f192daeafec31629::governance::DragonBallCollector, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) : 0x2::package::UpgradeTicket {
        0x643057d4e32bdd8035a7c681d04293f2bde919de59b80b63f192daeafec31629::governance::ensure_functional(arg0);
        0x643057d4e32bdd8035a7c681d04293f2bde919de59b80b63f192daeafec31629::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg2));
        let v0 = 0x643057d4e32bdd8035a7c681d04293f2bde919de59b80b63f192daeafec31629::governance::take_locked_update<0x643057d4e32bdd8035a7c681d04293f2bde919de59b80b63f192daeafec31629::time_lock::TimeLock<XOracleUpgradeWish>>(arg0, 0x1::type_name::with_defining_ids<XOracleUpgradeWish>());
        assert!(0x643057d4e32bdd8035a7c681d04293f2bde919de59b80b63f192daeafec31629::time_lock::is_active<XOracleUpgradeWish>(&v0, arg1), 0x643057d4e32bdd8035a7c681d04293f2bde919de59b80b63f192daeafec31629::errors::time_locked_not_active());
        let v1 = 0x643057d4e32bdd8035a7c681d04293f2bde919de59b80b63f192daeafec31629::time_lock::into_inner<XOracleUpgradeWish>(v0);
        0x643057d4e32bdd8035a7c681d04293f2bde919de59b80b63f192daeafec31629::wish_event::emit_fulfill_wish_event<XOracleUpgradeWish>(v1);
        let XOracleUpgradeWish {
            policy               : v2,
            digest               : v3,
            super_admin_approved : v4,
        } = v1;
        assert!(v4, 0x643057d4e32bdd8035a7c681d04293f2bde919de59b80b63f192daeafec31629::errors::super_admin_not_approved());
        0x2::package::authorize_upgrade(0x643057d4e32bdd8035a7c681d04293f2bde919de59b80b63f192daeafec31629::governance::x_oracle_package_upgrade_cap(arg0), v2, v3)
    }

    public fun commit_xoracle_upgrade(arg0: &mut 0x643057d4e32bdd8035a7c681d04293f2bde919de59b80b63f192daeafec31629::governance::DragonBallCollector, arg1: 0x2::package::UpgradeReceipt, arg2: &0x2::tx_context::TxContext) {
        0x643057d4e32bdd8035a7c681d04293f2bde919de59b80b63f192daeafec31629::governance::ensure_functional(arg0);
        0x643057d4e32bdd8035a7c681d04293f2bde919de59b80b63f192daeafec31629::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg2));
        0x2::package::commit_upgrade(0x643057d4e32bdd8035a7c681d04293f2bde919de59b80b63f192daeafec31629::governance::x_oracle_package_upgrade_cap(arg0), arg1);
    }

    public fun update_upgrade_approval(arg0: &0x643057d4e32bdd8035a7c681d04293f2bde919de59b80b63f192daeafec31629::roles::SuperAdminRole, arg1: &mut 0x643057d4e32bdd8035a7c681d04293f2bde919de59b80b63f192daeafec31629::governance::DragonBallCollector, arg2: bool, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        0x643057d4e32bdd8035a7c681d04293f2bde919de59b80b63f192daeafec31629::governance::ensure_functional(arg1);
        let v0 = 0x643057d4e32bdd8035a7c681d04293f2bde919de59b80b63f192daeafec31629::governance::borrow_mut_wish<0x643057d4e32bdd8035a7c681d04293f2bde919de59b80b63f192daeafec31629::time_lock::TimeLock<XOracleUpgradeWish>>(arg1, 0x1::type_name::with_defining_ids<XOracleUpgradeWish>());
        assert!(!0x643057d4e32bdd8035a7c681d04293f2bde919de59b80b63f192daeafec31629::time_lock::is_expired<XOracleUpgradeWish>(v0, arg3), 0x643057d4e32bdd8035a7c681d04293f2bde919de59b80b63f192daeafec31629::errors::time_locked_expired());
        0x643057d4e32bdd8035a7c681d04293f2bde919de59b80b63f192daeafec31629::time_lock::inner_mut<XOracleUpgradeWish>(v0).super_admin_approved = arg2;
        0x643057d4e32bdd8035a7c681d04293f2bde919de59b80b63f192daeafec31629::wish_event::emit_upgrade_approval_changed(0, arg2, 0x2::tx_context::sender(arg4));
    }

    public fun wish_authorize_xoracle_upgrade(arg0: &mut 0x643057d4e32bdd8035a7c681d04293f2bde919de59b80b63f192daeafec31629::governance::DragonBallCollector, arg1: u8, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        0x643057d4e32bdd8035a7c681d04293f2bde919de59b80b63f192daeafec31629::governance::ensure_functional(arg0);
        0x643057d4e32bdd8035a7c681d04293f2bde919de59b80b63f192daeafec31629::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg4));
        let v0 = XOracleUpgradeWish{
            policy               : arg1,
            digest               : arg2,
            super_admin_approved : false,
        };
        0x643057d4e32bdd8035a7c681d04293f2bde919de59b80b63f192daeafec31629::wish_event::emit_new_wish_event<XOracleUpgradeWish>(v0);
        0x643057d4e32bdd8035a7c681d04293f2bde919de59b80b63f192daeafec31629::governance::store_locked_update<0x643057d4e32bdd8035a7c681d04293f2bde919de59b80b63f192daeafec31629::time_lock::TimeLock<XOracleUpgradeWish>>(arg0, 0x1::type_name::with_defining_ids<XOracleUpgradeWish>(), 0x643057d4e32bdd8035a7c681d04293f2bde919de59b80b63f192daeafec31629::time_lock::new_time_locked<XOracleUpgradeWish>(v0, arg3, 0x643057d4e32bdd8035a7c681d04293f2bde919de59b80b63f192daeafec31629::governance::time_lock_duration_seconds(arg0), 0x643057d4e32bdd8035a7c681d04293f2bde919de59b80b63f192daeafec31629::governance::time_lock_expriration_seconds(arg0)));
    }

    // decompiled from Move bytecode v6
}

