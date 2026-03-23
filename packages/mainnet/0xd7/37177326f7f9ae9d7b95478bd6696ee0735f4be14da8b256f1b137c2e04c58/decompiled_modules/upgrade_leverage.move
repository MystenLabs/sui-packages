module 0xd737177326f7f9ae9d7b95478bd6696ee0735f4be14da8b256f1b137c2e04c58::upgrade_leverage {
    struct LeverageUpgradeWish has copy, drop, store {
        policy: u8,
        digest: vector<u8>,
        super_admin_approved: bool,
    }

    public fun migrate(arg0: &mut 0xd737177326f7f9ae9d7b95478bd6696ee0735f4be14da8b256f1b137c2e04c58::governance::DragonBallCollector, arg1: &mut 0x1cde00fda2b82fabeb4a24e5ef2eb8c557a03481839a6ead2971f9cd857462a3::leverage_app::LeverageApp, arg2: &0x2::tx_context::TxContext) {
        0xd737177326f7f9ae9d7b95478bd6696ee0735f4be14da8b256f1b137c2e04c58::governance::ensure_can_summon_shenron(arg0);
        0xd737177326f7f9ae9d7b95478bd6696ee0735f4be14da8b256f1b137c2e04c58::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg2));
        migrate_inner(arg0, arg1, arg2);
        0xd737177326f7f9ae9d7b95478bd6696ee0735f4be14da8b256f1b137c2e04c58::upgrade_self::migrate_inner(arg0, arg2);
    }

    public fun authorize_leverage_upgrade(arg0: &mut 0xd737177326f7f9ae9d7b95478bd6696ee0735f4be14da8b256f1b137c2e04c58::governance::DragonBallCollector, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) : 0x2::package::UpgradeTicket {
        0xd737177326f7f9ae9d7b95478bd6696ee0735f4be14da8b256f1b137c2e04c58::governance::ensure_functional(arg0);
        0xd737177326f7f9ae9d7b95478bd6696ee0735f4be14da8b256f1b137c2e04c58::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg2));
        let v0 = 0xd737177326f7f9ae9d7b95478bd6696ee0735f4be14da8b256f1b137c2e04c58::governance::take_locked_update<0xd737177326f7f9ae9d7b95478bd6696ee0735f4be14da8b256f1b137c2e04c58::time_lock::TimeLock<LeverageUpgradeWish>>(arg0, 0x1::type_name::with_defining_ids<LeverageUpgradeWish>());
        assert!(0xd737177326f7f9ae9d7b95478bd6696ee0735f4be14da8b256f1b137c2e04c58::time_lock::is_active<LeverageUpgradeWish>(&v0, arg1), 0xd737177326f7f9ae9d7b95478bd6696ee0735f4be14da8b256f1b137c2e04c58::errors::time_locked_not_active());
        let v1 = 0xd737177326f7f9ae9d7b95478bd6696ee0735f4be14da8b256f1b137c2e04c58::time_lock::into_inner<LeverageUpgradeWish>(v0);
        0xd737177326f7f9ae9d7b95478bd6696ee0735f4be14da8b256f1b137c2e04c58::wish_event::emit_fulfill_wish_event<LeverageUpgradeWish>(v1);
        let LeverageUpgradeWish {
            policy               : v2,
            digest               : v3,
            super_admin_approved : v4,
        } = v1;
        assert!(v4, 0xd737177326f7f9ae9d7b95478bd6696ee0735f4be14da8b256f1b137c2e04c58::errors::super_admin_not_approved());
        0x2::package::authorize_upgrade(0xd737177326f7f9ae9d7b95478bd6696ee0735f4be14da8b256f1b137c2e04c58::governance::leverage_package_upgrade_cap(arg0), v2, v3)
    }

    public fun commit_leverage_upgrade(arg0: &mut 0xd737177326f7f9ae9d7b95478bd6696ee0735f4be14da8b256f1b137c2e04c58::governance::DragonBallCollector, arg1: 0x2::package::UpgradeReceipt, arg2: &0x2::tx_context::TxContext) {
        0xd737177326f7f9ae9d7b95478bd6696ee0735f4be14da8b256f1b137c2e04c58::governance::ensure_can_summon_shenron(arg0);
        0xd737177326f7f9ae9d7b95478bd6696ee0735f4be14da8b256f1b137c2e04c58::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg2));
        0x2::package::commit_upgrade(0xd737177326f7f9ae9d7b95478bd6696ee0735f4be14da8b256f1b137c2e04c58::governance::leverage_package_upgrade_cap(arg0), arg1);
    }

    public(friend) fun migrate_inner(arg0: &0xd737177326f7f9ae9d7b95478bd6696ee0735f4be14da8b256f1b137c2e04c58::governance::DragonBallCollector, arg1: &mut 0x1cde00fda2b82fabeb4a24e5ef2eb8c557a03481839a6ead2971f9cd857462a3::leverage_app::LeverageApp, arg2: &0x2::tx_context::TxContext) {
        0xd737177326f7f9ae9d7b95478bd6696ee0735f4be14da8b256f1b137c2e04c58::wish_event::emit_object_migrated(2, 0x1cde00fda2b82fabeb4a24e5ef2eb8c557a03481839a6ead2971f9cd857462a3::leverage_admin::migrate(0xd737177326f7f9ae9d7b95478bd6696ee0735f4be14da8b256f1b137c2e04c58::governance::lending_admin_cap(arg0), arg1), 0x2::tx_context::sender(arg2));
    }

    public fun update_upgrade_approval(arg0: &0xd737177326f7f9ae9d7b95478bd6696ee0735f4be14da8b256f1b137c2e04c58::roles::SuperAdminRole, arg1: &mut 0xd737177326f7f9ae9d7b95478bd6696ee0735f4be14da8b256f1b137c2e04c58::governance::DragonBallCollector, arg2: bool, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        0xd737177326f7f9ae9d7b95478bd6696ee0735f4be14da8b256f1b137c2e04c58::governance::ensure_functional(arg1);
        let v0 = 0xd737177326f7f9ae9d7b95478bd6696ee0735f4be14da8b256f1b137c2e04c58::governance::borrow_mut_wish<0xd737177326f7f9ae9d7b95478bd6696ee0735f4be14da8b256f1b137c2e04c58::time_lock::TimeLock<LeverageUpgradeWish>>(arg1, 0x1::type_name::with_defining_ids<LeverageUpgradeWish>());
        assert!(!0xd737177326f7f9ae9d7b95478bd6696ee0735f4be14da8b256f1b137c2e04c58::time_lock::is_expired<LeverageUpgradeWish>(v0, arg3), 0xd737177326f7f9ae9d7b95478bd6696ee0735f4be14da8b256f1b137c2e04c58::errors::time_locked_expired());
        0xd737177326f7f9ae9d7b95478bd6696ee0735f4be14da8b256f1b137c2e04c58::time_lock::inner_mut<LeverageUpgradeWish>(v0).super_admin_approved = arg2;
        0xd737177326f7f9ae9d7b95478bd6696ee0735f4be14da8b256f1b137c2e04c58::wish_event::emit_upgrade_approval_changed(2, arg2, 0x2::tx_context::sender(arg4));
    }

    public fun wish_authorize_leverage_upgrade(arg0: &mut 0xd737177326f7f9ae9d7b95478bd6696ee0735f4be14da8b256f1b137c2e04c58::governance::DragonBallCollector, arg1: u8, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        0xd737177326f7f9ae9d7b95478bd6696ee0735f4be14da8b256f1b137c2e04c58::governance::ensure_functional(arg0);
        0xd737177326f7f9ae9d7b95478bd6696ee0735f4be14da8b256f1b137c2e04c58::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg4));
        let v0 = LeverageUpgradeWish{
            policy               : arg1,
            digest               : arg2,
            super_admin_approved : false,
        };
        0xd737177326f7f9ae9d7b95478bd6696ee0735f4be14da8b256f1b137c2e04c58::wish_event::emit_new_wish_event<LeverageUpgradeWish>(v0);
        0xd737177326f7f9ae9d7b95478bd6696ee0735f4be14da8b256f1b137c2e04c58::governance::store_locked_update<0xd737177326f7f9ae9d7b95478bd6696ee0735f4be14da8b256f1b137c2e04c58::time_lock::TimeLock<LeverageUpgradeWish>>(arg0, 0x1::type_name::with_defining_ids<LeverageUpgradeWish>(), 0xd737177326f7f9ae9d7b95478bd6696ee0735f4be14da8b256f1b137c2e04c58::time_lock::new_time_locked<LeverageUpgradeWish>(v0, arg3, 0xd737177326f7f9ae9d7b95478bd6696ee0735f4be14da8b256f1b137c2e04c58::governance::time_lock_duration_seconds(arg0), 0xd737177326f7f9ae9d7b95478bd6696ee0735f4be14da8b256f1b137c2e04c58::governance::time_lock_expriration_seconds(arg0)));
    }

    // decompiled from Move bytecode v6
}

