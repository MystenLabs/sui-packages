module 0xa2a32ced2fad3a86200a6f36c879ac77922763a69b9e52e31b0ea38b859a5713::upgrade_protocol {
    struct ProtocolUpgradeWish has copy, drop, store {
        policy: u8,
        digest: vector<u8>,
        super_admin_approved: bool,
    }

    public(friend) fun migrate_inner(arg0: &0xa2a32ced2fad3a86200a6f36c879ac77922763a69b9e52e31b0ea38b859a5713::governance::DragonBallCollector, arg1: &mut 0xf619885d1fcaee3a6581881ab740e93ba919078e7cdc8247796b6934a8aeaa74::app::ProtocolApp, arg2: &0x2::tx_context::TxContext) {
        0xa2a32ced2fad3a86200a6f36c879ac77922763a69b9e52e31b0ea38b859a5713::wish_event::emit_object_migrated(1, 0xf619885d1fcaee3a6581881ab740e93ba919078e7cdc8247796b6934a8aeaa74::version_admin::migrate(0xa2a32ced2fad3a86200a6f36c879ac77922763a69b9e52e31b0ea38b859a5713::governance::lending_admin_cap(arg0), arg1), 0x2::tx_context::sender(arg2));
    }

    public fun authorize_protocol_upgrade(arg0: &mut 0xa2a32ced2fad3a86200a6f36c879ac77922763a69b9e52e31b0ea38b859a5713::governance::DragonBallCollector, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : 0x2::package::UpgradeTicket {
        0xa2a32ced2fad3a86200a6f36c879ac77922763a69b9e52e31b0ea38b859a5713::governance::ensure_functional(arg0);
        0xa2a32ced2fad3a86200a6f36c879ac77922763a69b9e52e31b0ea38b859a5713::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg2));
        let v0 = 0xa2a32ced2fad3a86200a6f36c879ac77922763a69b9e52e31b0ea38b859a5713::governance::take_locked_update<0xa2a32ced2fad3a86200a6f36c879ac77922763a69b9e52e31b0ea38b859a5713::time_lock::TimeLock<ProtocolUpgradeWish>>(arg0, 0x1::type_name::with_defining_ids<ProtocolUpgradeWish>());
        assert!(0xa2a32ced2fad3a86200a6f36c879ac77922763a69b9e52e31b0ea38b859a5713::time_lock::is_active<ProtocolUpgradeWish>(&v0, arg1), 0xa2a32ced2fad3a86200a6f36c879ac77922763a69b9e52e31b0ea38b859a5713::errors::time_locked_not_active());
        let v1 = 0xa2a32ced2fad3a86200a6f36c879ac77922763a69b9e52e31b0ea38b859a5713::time_lock::into_inner<ProtocolUpgradeWish>(v0);
        0xa2a32ced2fad3a86200a6f36c879ac77922763a69b9e52e31b0ea38b859a5713::wish_event::emit_fulfill_wish_event<ProtocolUpgradeWish>(v1);
        let ProtocolUpgradeWish {
            policy               : v2,
            digest               : v3,
            super_admin_approved : v4,
        } = v1;
        assert!(v4, 0xa2a32ced2fad3a86200a6f36c879ac77922763a69b9e52e31b0ea38b859a5713::errors::super_admin_not_approved());
        0x2::package::authorize_upgrade(0xa2a32ced2fad3a86200a6f36c879ac77922763a69b9e52e31b0ea38b859a5713::governance::lending_package_upgrade_cap(arg0), v2, v3)
    }

    public fun commit_protocol_upgrade(arg0: &mut 0xa2a32ced2fad3a86200a6f36c879ac77922763a69b9e52e31b0ea38b859a5713::governance::DragonBallCollector, arg1: 0x2::package::UpgradeReceipt, arg2: &0x2::tx_context::TxContext) {
        0xa2a32ced2fad3a86200a6f36c879ac77922763a69b9e52e31b0ea38b859a5713::governance::ensure_functional(arg0);
        0xa2a32ced2fad3a86200a6f36c879ac77922763a69b9e52e31b0ea38b859a5713::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg2));
        0x2::package::commit_upgrade(0xa2a32ced2fad3a86200a6f36c879ac77922763a69b9e52e31b0ea38b859a5713::governance::lending_package_upgrade_cap(arg0), arg1);
    }

    public fun migrate(arg0: &mut 0xa2a32ced2fad3a86200a6f36c879ac77922763a69b9e52e31b0ea38b859a5713::governance::DragonBallCollector, arg1: &mut 0xf619885d1fcaee3a6581881ab740e93ba919078e7cdc8247796b6934a8aeaa74::app::ProtocolApp, arg2: &mut 0x27ef7aa84771904162eb86126b3ead179003f6f26bef7c751c36caae1589a993::leverage_app::LeverageApp, arg3: &0x2::tx_context::TxContext) {
        0xa2a32ced2fad3a86200a6f36c879ac77922763a69b9e52e31b0ea38b859a5713::governance::ensure_can_summon_shenron(arg0);
        0xa2a32ced2fad3a86200a6f36c879ac77922763a69b9e52e31b0ea38b859a5713::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg3));
        migrate_inner(arg0, arg1, arg3);
        0xa2a32ced2fad3a86200a6f36c879ac77922763a69b9e52e31b0ea38b859a5713::upgrade_leverage::migrate_inner(arg0, arg2, arg3);
        0xa2a32ced2fad3a86200a6f36c879ac77922763a69b9e52e31b0ea38b859a5713::upgrade_self::migrate_inner(arg0, arg3);
    }

    public fun update_upgrade_approval(arg0: &0xa2a32ced2fad3a86200a6f36c879ac77922763a69b9e52e31b0ea38b859a5713::roles::SuperAdminRole, arg1: &mut 0xa2a32ced2fad3a86200a6f36c879ac77922763a69b9e52e31b0ea38b859a5713::governance::DragonBallCollector, arg2: bool, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        0xa2a32ced2fad3a86200a6f36c879ac77922763a69b9e52e31b0ea38b859a5713::governance::ensure_functional(arg1);
        let v0 = 0xa2a32ced2fad3a86200a6f36c879ac77922763a69b9e52e31b0ea38b859a5713::governance::brrow_mut_wish<0xa2a32ced2fad3a86200a6f36c879ac77922763a69b9e52e31b0ea38b859a5713::time_lock::TimeLock<ProtocolUpgradeWish>>(arg1, 0x1::type_name::with_defining_ids<ProtocolUpgradeWish>());
        assert!(!0xa2a32ced2fad3a86200a6f36c879ac77922763a69b9e52e31b0ea38b859a5713::time_lock::is_expired<ProtocolUpgradeWish>(v0, arg3), 0xa2a32ced2fad3a86200a6f36c879ac77922763a69b9e52e31b0ea38b859a5713::errors::time_locked_expired());
        0xa2a32ced2fad3a86200a6f36c879ac77922763a69b9e52e31b0ea38b859a5713::time_lock::inner_mut<ProtocolUpgradeWish>(v0).super_admin_approved = arg2;
        0xa2a32ced2fad3a86200a6f36c879ac77922763a69b9e52e31b0ea38b859a5713::wish_event::emit_upgrade_approval_changed(1, arg2, 0x2::tx_context::sender(arg4));
    }

    public fun wish_authorize_protocol_upgrade(arg0: &mut 0xa2a32ced2fad3a86200a6f36c879ac77922763a69b9e52e31b0ea38b859a5713::governance::DragonBallCollector, arg1: u8, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        0xa2a32ced2fad3a86200a6f36c879ac77922763a69b9e52e31b0ea38b859a5713::governance::ensure_can_summon_shenron(arg0);
        0xa2a32ced2fad3a86200a6f36c879ac77922763a69b9e52e31b0ea38b859a5713::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg4));
        let v0 = ProtocolUpgradeWish{
            policy               : arg1,
            digest               : arg2,
            super_admin_approved : false,
        };
        0xa2a32ced2fad3a86200a6f36c879ac77922763a69b9e52e31b0ea38b859a5713::wish_event::emit_new_wish_event<ProtocolUpgradeWish>(v0);
        0xa2a32ced2fad3a86200a6f36c879ac77922763a69b9e52e31b0ea38b859a5713::governance::store_locked_update<0xa2a32ced2fad3a86200a6f36c879ac77922763a69b9e52e31b0ea38b859a5713::time_lock::TimeLock<ProtocolUpgradeWish>>(arg0, 0x1::type_name::with_defining_ids<ProtocolUpgradeWish>(), 0xa2a32ced2fad3a86200a6f36c879ac77922763a69b9e52e31b0ea38b859a5713::time_lock::new_time_locked<ProtocolUpgradeWish>(v0, arg3, 0xa2a32ced2fad3a86200a6f36c879ac77922763a69b9e52e31b0ea38b859a5713::governance::time_lock_duration_seconds(arg0), 0xa2a32ced2fad3a86200a6f36c879ac77922763a69b9e52e31b0ea38b859a5713::governance::time_lock_expriration_seconds(arg0)));
    }

    // decompiled from Move bytecode v6
}

