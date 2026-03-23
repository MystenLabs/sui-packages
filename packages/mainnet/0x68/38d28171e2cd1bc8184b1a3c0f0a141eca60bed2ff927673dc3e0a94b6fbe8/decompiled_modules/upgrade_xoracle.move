module 0x6838d28171e2cd1bc8184b1a3c0f0a141eca60bed2ff927673dc3e0a94b6fbe8::upgrade_xoracle {
    struct XOracleUpgradeWish has copy, drop, store {
        policy: u8,
        digest: vector<u8>,
        super_admin_approved: bool,
    }

    public fun migrate(arg0: &mut 0x6838d28171e2cd1bc8184b1a3c0f0a141eca60bed2ff927673dc3e0a94b6fbe8::governance::DragonBallCollector, arg1: &mut 0x144c57d6014488bc71c0902bddff482af090d13e2c61333ed903fe088220a92c::x_oracle::XOracle, arg2: &mut 0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::app::ProtocolApp, arg3: &mut 0x42a1a418bf977d5306aa783288eebbc2e3ca9200b533fba7feda521e60d199e::leverage_app::LeverageApp, arg4: &0x2::tx_context::TxContext) {
        0x6838d28171e2cd1bc8184b1a3c0f0a141eca60bed2ff927673dc3e0a94b6fbe8::governance::ensure_can_summon_shenron(arg0);
        0x6838d28171e2cd1bc8184b1a3c0f0a141eca60bed2ff927673dc3e0a94b6fbe8::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg4));
        migrate_inner(arg0, arg1, arg4);
        0x6838d28171e2cd1bc8184b1a3c0f0a141eca60bed2ff927673dc3e0a94b6fbe8::upgrade_protocol::migrate_inner(arg0, arg2, arg4);
        0x6838d28171e2cd1bc8184b1a3c0f0a141eca60bed2ff927673dc3e0a94b6fbe8::upgrade_leverage::migrate_inner(arg0, arg3, arg4);
        0x6838d28171e2cd1bc8184b1a3c0f0a141eca60bed2ff927673dc3e0a94b6fbe8::upgrade_self::migrate_inner(arg0, arg4);
    }

    fun migrate_inner(arg0: &0x6838d28171e2cd1bc8184b1a3c0f0a141eca60bed2ff927673dc3e0a94b6fbe8::governance::DragonBallCollector, arg1: &mut 0x144c57d6014488bc71c0902bddff482af090d13e2c61333ed903fe088220a92c::x_oracle::XOracle, arg2: &0x2::tx_context::TxContext) {
        0x6838d28171e2cd1bc8184b1a3c0f0a141eca60bed2ff927673dc3e0a94b6fbe8::wish_event::emit_object_migrated(0, 0x144c57d6014488bc71c0902bddff482af090d13e2c61333ed903fe088220a92c::oracle_admin::migrate(0x6838d28171e2cd1bc8184b1a3c0f0a141eca60bed2ff927673dc3e0a94b6fbe8::governance::x_oracle_admin_cap(arg0), arg1), 0x2::tx_context::sender(arg2));
    }

    public fun authorize_xoracle_upgrade(arg0: &mut 0x6838d28171e2cd1bc8184b1a3c0f0a141eca60bed2ff927673dc3e0a94b6fbe8::governance::DragonBallCollector, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) : 0x2::package::UpgradeTicket {
        0x6838d28171e2cd1bc8184b1a3c0f0a141eca60bed2ff927673dc3e0a94b6fbe8::governance::ensure_functional(arg0);
        0x6838d28171e2cd1bc8184b1a3c0f0a141eca60bed2ff927673dc3e0a94b6fbe8::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg2));
        let v0 = 0x6838d28171e2cd1bc8184b1a3c0f0a141eca60bed2ff927673dc3e0a94b6fbe8::governance::take_locked_update<0x6838d28171e2cd1bc8184b1a3c0f0a141eca60bed2ff927673dc3e0a94b6fbe8::time_lock::TimeLock<XOracleUpgradeWish>>(arg0, 0x1::type_name::with_defining_ids<XOracleUpgradeWish>());
        assert!(0x6838d28171e2cd1bc8184b1a3c0f0a141eca60bed2ff927673dc3e0a94b6fbe8::time_lock::is_active<XOracleUpgradeWish>(&v0, arg1), 0x6838d28171e2cd1bc8184b1a3c0f0a141eca60bed2ff927673dc3e0a94b6fbe8::errors::time_locked_not_active());
        let v1 = 0x6838d28171e2cd1bc8184b1a3c0f0a141eca60bed2ff927673dc3e0a94b6fbe8::time_lock::into_inner<XOracleUpgradeWish>(v0);
        0x6838d28171e2cd1bc8184b1a3c0f0a141eca60bed2ff927673dc3e0a94b6fbe8::wish_event::emit_fulfill_wish_event<XOracleUpgradeWish>(v1);
        let XOracleUpgradeWish {
            policy               : v2,
            digest               : v3,
            super_admin_approved : v4,
        } = v1;
        assert!(v4, 0x6838d28171e2cd1bc8184b1a3c0f0a141eca60bed2ff927673dc3e0a94b6fbe8::errors::super_admin_not_approved());
        0x2::package::authorize_upgrade(0x6838d28171e2cd1bc8184b1a3c0f0a141eca60bed2ff927673dc3e0a94b6fbe8::governance::x_oracle_package_upgrade_cap(arg0), v2, v3)
    }

    public fun commit_xoracle_upgrade(arg0: &mut 0x6838d28171e2cd1bc8184b1a3c0f0a141eca60bed2ff927673dc3e0a94b6fbe8::governance::DragonBallCollector, arg1: 0x2::package::UpgradeReceipt, arg2: &0x2::tx_context::TxContext) {
        0x6838d28171e2cd1bc8184b1a3c0f0a141eca60bed2ff927673dc3e0a94b6fbe8::governance::ensure_functional(arg0);
        0x6838d28171e2cd1bc8184b1a3c0f0a141eca60bed2ff927673dc3e0a94b6fbe8::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg2));
        0x2::package::commit_upgrade(0x6838d28171e2cd1bc8184b1a3c0f0a141eca60bed2ff927673dc3e0a94b6fbe8::governance::x_oracle_package_upgrade_cap(arg0), arg1);
    }

    public fun update_upgrade_approval(arg0: &0x6838d28171e2cd1bc8184b1a3c0f0a141eca60bed2ff927673dc3e0a94b6fbe8::roles::SuperAdminRole, arg1: &mut 0x6838d28171e2cd1bc8184b1a3c0f0a141eca60bed2ff927673dc3e0a94b6fbe8::governance::DragonBallCollector, arg2: bool, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        0x6838d28171e2cd1bc8184b1a3c0f0a141eca60bed2ff927673dc3e0a94b6fbe8::governance::ensure_functional(arg1);
        let v0 = 0x6838d28171e2cd1bc8184b1a3c0f0a141eca60bed2ff927673dc3e0a94b6fbe8::governance::borrow_mut_wish<0x6838d28171e2cd1bc8184b1a3c0f0a141eca60bed2ff927673dc3e0a94b6fbe8::time_lock::TimeLock<XOracleUpgradeWish>>(arg1, 0x1::type_name::with_defining_ids<XOracleUpgradeWish>());
        assert!(!0x6838d28171e2cd1bc8184b1a3c0f0a141eca60bed2ff927673dc3e0a94b6fbe8::time_lock::is_expired<XOracleUpgradeWish>(v0, arg3), 0x6838d28171e2cd1bc8184b1a3c0f0a141eca60bed2ff927673dc3e0a94b6fbe8::errors::time_locked_expired());
        0x6838d28171e2cd1bc8184b1a3c0f0a141eca60bed2ff927673dc3e0a94b6fbe8::time_lock::inner_mut<XOracleUpgradeWish>(v0).super_admin_approved = arg2;
        0x6838d28171e2cd1bc8184b1a3c0f0a141eca60bed2ff927673dc3e0a94b6fbe8::wish_event::emit_upgrade_approval_changed(0, arg2, 0x2::tx_context::sender(arg4));
    }

    public fun wish_authorize_xoracle_upgrade(arg0: &mut 0x6838d28171e2cd1bc8184b1a3c0f0a141eca60bed2ff927673dc3e0a94b6fbe8::governance::DragonBallCollector, arg1: u8, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        0x6838d28171e2cd1bc8184b1a3c0f0a141eca60bed2ff927673dc3e0a94b6fbe8::governance::ensure_functional(arg0);
        0x6838d28171e2cd1bc8184b1a3c0f0a141eca60bed2ff927673dc3e0a94b6fbe8::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg4));
        let v0 = XOracleUpgradeWish{
            policy               : arg1,
            digest               : arg2,
            super_admin_approved : false,
        };
        0x6838d28171e2cd1bc8184b1a3c0f0a141eca60bed2ff927673dc3e0a94b6fbe8::wish_event::emit_new_wish_event<XOracleUpgradeWish>(v0);
        0x6838d28171e2cd1bc8184b1a3c0f0a141eca60bed2ff927673dc3e0a94b6fbe8::governance::store_locked_update<0x6838d28171e2cd1bc8184b1a3c0f0a141eca60bed2ff927673dc3e0a94b6fbe8::time_lock::TimeLock<XOracleUpgradeWish>>(arg0, 0x1::type_name::with_defining_ids<XOracleUpgradeWish>(), 0x6838d28171e2cd1bc8184b1a3c0f0a141eca60bed2ff927673dc3e0a94b6fbe8::time_lock::new_time_locked<XOracleUpgradeWish>(v0, arg3, 0x6838d28171e2cd1bc8184b1a3c0f0a141eca60bed2ff927673dc3e0a94b6fbe8::governance::time_lock_duration_seconds(arg0), 0x6838d28171e2cd1bc8184b1a3c0f0a141eca60bed2ff927673dc3e0a94b6fbe8::governance::time_lock_expriration_seconds(arg0)));
    }

    // decompiled from Move bytecode v6
}

