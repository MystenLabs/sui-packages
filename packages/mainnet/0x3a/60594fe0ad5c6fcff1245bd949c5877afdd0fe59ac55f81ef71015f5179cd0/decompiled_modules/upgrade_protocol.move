module 0x3a60594fe0ad5c6fcff1245bd949c5877afdd0fe59ac55f81ef71015f5179cd0::upgrade_protocol {
    struct ProtocolUpgradeWish has copy, drop, store {
        policy: u8,
        digest: vector<u8>,
        super_admin_approved: bool,
    }

    public(friend) fun migrate_inner(arg0: &0x3a60594fe0ad5c6fcff1245bd949c5877afdd0fe59ac55f81ef71015f5179cd0::governance::DragonBallCollector, arg1: &mut 0x9a1a0e74290b944c71a13a09b4587c6ef43067f7539a43c1a6b1a14e6923609b::app::ProtocolApp, arg2: &0x2::tx_context::TxContext) {
        0x3a60594fe0ad5c6fcff1245bd949c5877afdd0fe59ac55f81ef71015f5179cd0::wish_event::emit_object_migrated(1, 0x9a1a0e74290b944c71a13a09b4587c6ef43067f7539a43c1a6b1a14e6923609b::version_admin::migrate(0x3a60594fe0ad5c6fcff1245bd949c5877afdd0fe59ac55f81ef71015f5179cd0::governance::lending_admin_cap(arg0), arg1), 0x2::tx_context::sender(arg2));
    }

    public fun authorize_protocol_upgrade(arg0: &mut 0x3a60594fe0ad5c6fcff1245bd949c5877afdd0fe59ac55f81ef71015f5179cd0::governance::DragonBallCollector, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : 0x2::package::UpgradeTicket {
        0x3a60594fe0ad5c6fcff1245bd949c5877afdd0fe59ac55f81ef71015f5179cd0::governance::ensure_functional(arg0);
        0x3a60594fe0ad5c6fcff1245bd949c5877afdd0fe59ac55f81ef71015f5179cd0::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg2));
        let v0 = 0x3a60594fe0ad5c6fcff1245bd949c5877afdd0fe59ac55f81ef71015f5179cd0::governance::take_locked_update<0x3a60594fe0ad5c6fcff1245bd949c5877afdd0fe59ac55f81ef71015f5179cd0::time_lock::TimeLock<ProtocolUpgradeWish>>(arg0, 0x1::type_name::with_defining_ids<ProtocolUpgradeWish>());
        assert!(0x3a60594fe0ad5c6fcff1245bd949c5877afdd0fe59ac55f81ef71015f5179cd0::time_lock::is_active<ProtocolUpgradeWish>(&v0, arg1), 0x3a60594fe0ad5c6fcff1245bd949c5877afdd0fe59ac55f81ef71015f5179cd0::errors::time_locked_not_active());
        let v1 = 0x3a60594fe0ad5c6fcff1245bd949c5877afdd0fe59ac55f81ef71015f5179cd0::time_lock::into_inner<ProtocolUpgradeWish>(v0);
        0x3a60594fe0ad5c6fcff1245bd949c5877afdd0fe59ac55f81ef71015f5179cd0::wish_event::emit_fulfill_wish_event<ProtocolUpgradeWish>(v1);
        let ProtocolUpgradeWish {
            policy               : v2,
            digest               : v3,
            super_admin_approved : v4,
        } = v1;
        assert!(v4, 0x3a60594fe0ad5c6fcff1245bd949c5877afdd0fe59ac55f81ef71015f5179cd0::errors::super_admin_not_approved());
        0x2::package::authorize_upgrade(0x3a60594fe0ad5c6fcff1245bd949c5877afdd0fe59ac55f81ef71015f5179cd0::governance::lending_package_upgrade_cap(arg0), v2, v3)
    }

    public fun commit_protocol_upgrade(arg0: &mut 0x3a60594fe0ad5c6fcff1245bd949c5877afdd0fe59ac55f81ef71015f5179cd0::governance::DragonBallCollector, arg1: 0x2::package::UpgradeReceipt, arg2: &0x2::tx_context::TxContext) {
        0x3a60594fe0ad5c6fcff1245bd949c5877afdd0fe59ac55f81ef71015f5179cd0::governance::ensure_functional(arg0);
        0x3a60594fe0ad5c6fcff1245bd949c5877afdd0fe59ac55f81ef71015f5179cd0::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg2));
        0x2::package::commit_upgrade(0x3a60594fe0ad5c6fcff1245bd949c5877afdd0fe59ac55f81ef71015f5179cd0::governance::lending_package_upgrade_cap(arg0), arg1);
    }

    public fun migrate(arg0: &mut 0x3a60594fe0ad5c6fcff1245bd949c5877afdd0fe59ac55f81ef71015f5179cd0::governance::DragonBallCollector, arg1: &mut 0x9a1a0e74290b944c71a13a09b4587c6ef43067f7539a43c1a6b1a14e6923609b::app::ProtocolApp, arg2: &mut 0x54f922df2da95336443a9d2763833160050e846c6a9bc12d0ab0eccb5a321984::leverage_app::LeverageApp, arg3: &0x2::tx_context::TxContext) {
        0x3a60594fe0ad5c6fcff1245bd949c5877afdd0fe59ac55f81ef71015f5179cd0::governance::ensure_can_summon_shenron(arg0);
        0x3a60594fe0ad5c6fcff1245bd949c5877afdd0fe59ac55f81ef71015f5179cd0::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg3));
        migrate_inner(arg0, arg1, arg3);
        0x3a60594fe0ad5c6fcff1245bd949c5877afdd0fe59ac55f81ef71015f5179cd0::upgrade_leverage::migrate_inner(arg0, arg2, arg3);
        0x3a60594fe0ad5c6fcff1245bd949c5877afdd0fe59ac55f81ef71015f5179cd0::upgrade_self::migrate_inner(arg0, arg3);
    }

    public fun update_upgrade_approval(arg0: &0x3a60594fe0ad5c6fcff1245bd949c5877afdd0fe59ac55f81ef71015f5179cd0::roles::SuperAdminRole, arg1: &mut 0x3a60594fe0ad5c6fcff1245bd949c5877afdd0fe59ac55f81ef71015f5179cd0::governance::DragonBallCollector, arg2: bool, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        0x3a60594fe0ad5c6fcff1245bd949c5877afdd0fe59ac55f81ef71015f5179cd0::governance::ensure_functional(arg1);
        let v0 = 0x3a60594fe0ad5c6fcff1245bd949c5877afdd0fe59ac55f81ef71015f5179cd0::governance::brrow_mut_wish<0x3a60594fe0ad5c6fcff1245bd949c5877afdd0fe59ac55f81ef71015f5179cd0::time_lock::TimeLock<ProtocolUpgradeWish>>(arg1, 0x1::type_name::with_defining_ids<ProtocolUpgradeWish>());
        assert!(!0x3a60594fe0ad5c6fcff1245bd949c5877afdd0fe59ac55f81ef71015f5179cd0::time_lock::is_expired<ProtocolUpgradeWish>(v0, arg3), 0x3a60594fe0ad5c6fcff1245bd949c5877afdd0fe59ac55f81ef71015f5179cd0::errors::time_locked_expired());
        0x3a60594fe0ad5c6fcff1245bd949c5877afdd0fe59ac55f81ef71015f5179cd0::time_lock::inner_mut<ProtocolUpgradeWish>(v0).super_admin_approved = arg2;
        0x3a60594fe0ad5c6fcff1245bd949c5877afdd0fe59ac55f81ef71015f5179cd0::wish_event::emit_upgrade_approval_changed(1, arg2, 0x2::tx_context::sender(arg4));
    }

    public fun wish_authorize_protocol_upgrade(arg0: &mut 0x3a60594fe0ad5c6fcff1245bd949c5877afdd0fe59ac55f81ef71015f5179cd0::governance::DragonBallCollector, arg1: u8, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        0x3a60594fe0ad5c6fcff1245bd949c5877afdd0fe59ac55f81ef71015f5179cd0::governance::ensure_can_summon_shenron(arg0);
        0x3a60594fe0ad5c6fcff1245bd949c5877afdd0fe59ac55f81ef71015f5179cd0::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg4));
        let v0 = ProtocolUpgradeWish{
            policy               : arg1,
            digest               : arg2,
            super_admin_approved : false,
        };
        0x3a60594fe0ad5c6fcff1245bd949c5877afdd0fe59ac55f81ef71015f5179cd0::wish_event::emit_new_wish_event<ProtocolUpgradeWish>(v0);
        0x3a60594fe0ad5c6fcff1245bd949c5877afdd0fe59ac55f81ef71015f5179cd0::governance::store_locked_update<0x3a60594fe0ad5c6fcff1245bd949c5877afdd0fe59ac55f81ef71015f5179cd0::time_lock::TimeLock<ProtocolUpgradeWish>>(arg0, 0x1::type_name::with_defining_ids<ProtocolUpgradeWish>(), 0x3a60594fe0ad5c6fcff1245bd949c5877afdd0fe59ac55f81ef71015f5179cd0::time_lock::new_time_locked<ProtocolUpgradeWish>(v0, arg3, 0x3a60594fe0ad5c6fcff1245bd949c5877afdd0fe59ac55f81ef71015f5179cd0::governance::time_lock_duration_seconds(arg0), 0x3a60594fe0ad5c6fcff1245bd949c5877afdd0fe59ac55f81ef71015f5179cd0::governance::time_lock_expriration_seconds(arg0)));
    }

    // decompiled from Move bytecode v6
}

