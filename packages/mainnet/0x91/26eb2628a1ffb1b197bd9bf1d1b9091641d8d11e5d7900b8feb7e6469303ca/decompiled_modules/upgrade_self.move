module 0x9126eb2628a1ffb1b197bd9bf1d1b9091641d8d11e5d7900b8feb7e6469303ca::upgrade_self {
    struct GovernanceUpgradeWish has copy, drop, store {
        policy: u8,
        digest: vector<u8>,
        super_admin_approved: bool,
    }

    public fun migrate(arg0: &mut 0x9126eb2628a1ffb1b197bd9bf1d1b9091641d8d11e5d7900b8feb7e6469303ca::governance::DragonBallCollector, arg1: &0x2::tx_context::TxContext) {
        0x9126eb2628a1ffb1b197bd9bf1d1b9091641d8d11e5d7900b8feb7e6469303ca::governance::ensure_can_summon_shenron(arg0);
        0x9126eb2628a1ffb1b197bd9bf1d1b9091641d8d11e5d7900b8feb7e6469303ca::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg1));
        migrate_inner(arg0, arg1);
    }

    public fun authorize_governance_upgrade(arg0: &mut 0x9126eb2628a1ffb1b197bd9bf1d1b9091641d8d11e5d7900b8feb7e6469303ca::governance::DragonBallCollector, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) : 0x2::package::UpgradeTicket {
        0x9126eb2628a1ffb1b197bd9bf1d1b9091641d8d11e5d7900b8feb7e6469303ca::governance::ensure_functional(arg0);
        0x9126eb2628a1ffb1b197bd9bf1d1b9091641d8d11e5d7900b8feb7e6469303ca::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg2));
        let v0 = 0x9126eb2628a1ffb1b197bd9bf1d1b9091641d8d11e5d7900b8feb7e6469303ca::governance::take_locked_update<0x9126eb2628a1ffb1b197bd9bf1d1b9091641d8d11e5d7900b8feb7e6469303ca::time_lock::TimeLock<GovernanceUpgradeWish>>(arg0, 0x1::type_name::with_defining_ids<GovernanceUpgradeWish>());
        assert!(0x9126eb2628a1ffb1b197bd9bf1d1b9091641d8d11e5d7900b8feb7e6469303ca::time_lock::is_active<GovernanceUpgradeWish>(&v0, arg1), 0x9126eb2628a1ffb1b197bd9bf1d1b9091641d8d11e5d7900b8feb7e6469303ca::errors::time_locked_not_active());
        let v1 = 0x9126eb2628a1ffb1b197bd9bf1d1b9091641d8d11e5d7900b8feb7e6469303ca::time_lock::into_inner<GovernanceUpgradeWish>(v0);
        0x9126eb2628a1ffb1b197bd9bf1d1b9091641d8d11e5d7900b8feb7e6469303ca::wish_event::emit_fulfill_wish_event<GovernanceUpgradeWish>(v1);
        let GovernanceUpgradeWish {
            policy               : v2,
            digest               : v3,
            super_admin_approved : v4,
        } = v1;
        assert!(v4, 0x9126eb2628a1ffb1b197bd9bf1d1b9091641d8d11e5d7900b8feb7e6469303ca::errors::super_admin_not_approved());
        0x2::package::authorize_upgrade(0x9126eb2628a1ffb1b197bd9bf1d1b9091641d8d11e5d7900b8feb7e6469303ca::governance::governance_package_upgrade_cap(arg0), v2, v3)
    }

    public fun commit_governance_upgrade(arg0: &mut 0x9126eb2628a1ffb1b197bd9bf1d1b9091641d8d11e5d7900b8feb7e6469303ca::governance::DragonBallCollector, arg1: 0x2::package::UpgradeReceipt, arg2: &0x2::tx_context::TxContext) {
        0x9126eb2628a1ffb1b197bd9bf1d1b9091641d8d11e5d7900b8feb7e6469303ca::governance::ensure_functional(arg0);
        0x9126eb2628a1ffb1b197bd9bf1d1b9091641d8d11e5d7900b8feb7e6469303ca::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg2));
        0x2::package::commit_upgrade(0x9126eb2628a1ffb1b197bd9bf1d1b9091641d8d11e5d7900b8feb7e6469303ca::governance::governance_package_upgrade_cap(arg0), arg1);
    }

    public(friend) fun migrate_inner(arg0: &mut 0x9126eb2628a1ffb1b197bd9bf1d1b9091641d8d11e5d7900b8feb7e6469303ca::governance::DragonBallCollector, arg1: &0x2::tx_context::TxContext) {
        0x9126eb2628a1ffb1b197bd9bf1d1b9091641d8d11e5d7900b8feb7e6469303ca::wish_event::emit_object_migrated(3, 0x9126eb2628a1ffb1b197bd9bf1d1b9091641d8d11e5d7900b8feb7e6469303ca::governance::migrate(arg0), 0x2::tx_context::sender(arg1));
    }

    public fun update_upgrade_approval(arg0: &0x9126eb2628a1ffb1b197bd9bf1d1b9091641d8d11e5d7900b8feb7e6469303ca::roles::SuperAdminRole, arg1: &mut 0x9126eb2628a1ffb1b197bd9bf1d1b9091641d8d11e5d7900b8feb7e6469303ca::governance::DragonBallCollector, arg2: bool, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        0x9126eb2628a1ffb1b197bd9bf1d1b9091641d8d11e5d7900b8feb7e6469303ca::governance::ensure_functional(arg1);
        let v0 = 0x9126eb2628a1ffb1b197bd9bf1d1b9091641d8d11e5d7900b8feb7e6469303ca::governance::brrow_mut_wish<0x9126eb2628a1ffb1b197bd9bf1d1b9091641d8d11e5d7900b8feb7e6469303ca::time_lock::TimeLock<GovernanceUpgradeWish>>(arg1, 0x1::type_name::with_defining_ids<GovernanceUpgradeWish>());
        assert!(!0x9126eb2628a1ffb1b197bd9bf1d1b9091641d8d11e5d7900b8feb7e6469303ca::time_lock::is_expired<GovernanceUpgradeWish>(v0, arg3), 0x9126eb2628a1ffb1b197bd9bf1d1b9091641d8d11e5d7900b8feb7e6469303ca::errors::time_locked_expired());
        0x9126eb2628a1ffb1b197bd9bf1d1b9091641d8d11e5d7900b8feb7e6469303ca::time_lock::inner_mut<GovernanceUpgradeWish>(v0).super_admin_approved = arg2;
        0x9126eb2628a1ffb1b197bd9bf1d1b9091641d8d11e5d7900b8feb7e6469303ca::wish_event::emit_upgrade_approval_changed(3, arg2, 0x2::tx_context::sender(arg4));
    }

    public fun wish_authorize_governance_upgrade(arg0: &mut 0x9126eb2628a1ffb1b197bd9bf1d1b9091641d8d11e5d7900b8feb7e6469303ca::governance::DragonBallCollector, arg1: u8, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        0x9126eb2628a1ffb1b197bd9bf1d1b9091641d8d11e5d7900b8feb7e6469303ca::governance::ensure_functional(arg0);
        0x9126eb2628a1ffb1b197bd9bf1d1b9091641d8d11e5d7900b8feb7e6469303ca::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg4));
        let v0 = GovernanceUpgradeWish{
            policy               : arg1,
            digest               : arg2,
            super_admin_approved : false,
        };
        0x9126eb2628a1ffb1b197bd9bf1d1b9091641d8d11e5d7900b8feb7e6469303ca::wish_event::emit_new_wish_event<GovernanceUpgradeWish>(v0);
        0x9126eb2628a1ffb1b197bd9bf1d1b9091641d8d11e5d7900b8feb7e6469303ca::governance::store_locked_update<0x9126eb2628a1ffb1b197bd9bf1d1b9091641d8d11e5d7900b8feb7e6469303ca::time_lock::TimeLock<GovernanceUpgradeWish>>(arg0, 0x1::type_name::with_defining_ids<GovernanceUpgradeWish>(), 0x9126eb2628a1ffb1b197bd9bf1d1b9091641d8d11e5d7900b8feb7e6469303ca::time_lock::new_time_locked<GovernanceUpgradeWish>(v0, arg3, 0x9126eb2628a1ffb1b197bd9bf1d1b9091641d8d11e5d7900b8feb7e6469303ca::governance::time_lock_duration_seconds(arg0), 0x9126eb2628a1ffb1b197bd9bf1d1b9091641d8d11e5d7900b8feb7e6469303ca::governance::time_lock_expriration_seconds(arg0)));
    }

    // decompiled from Move bytecode v6
}

