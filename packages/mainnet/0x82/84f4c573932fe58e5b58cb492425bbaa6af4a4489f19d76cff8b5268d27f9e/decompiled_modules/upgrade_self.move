module 0x8284f4c573932fe58e5b58cb492425bbaa6af4a4489f19d76cff8b5268d27f9e::upgrade_self {
    struct GovernanceUpgradeWish has copy, drop, store {
        policy: u8,
        digest: vector<u8>,
    }

    public fun migrate(arg0: &mut 0x8284f4c573932fe58e5b58cb492425bbaa6af4a4489f19d76cff8b5268d27f9e::governance::DragonBallCollector, arg1: &0x2::tx_context::TxContext) {
        0x8284f4c573932fe58e5b58cb492425bbaa6af4a4489f19d76cff8b5268d27f9e::governance::ensure_can_summon_shenron(arg0);
        0x8284f4c573932fe58e5b58cb492425bbaa6af4a4489f19d76cff8b5268d27f9e::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg1));
        migrate_inner(arg0, arg1);
    }

    public fun authorize_governance_upgrade(arg0: &mut 0x8284f4c573932fe58e5b58cb492425bbaa6af4a4489f19d76cff8b5268d27f9e::governance::DragonBallCollector, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) : 0x2::package::UpgradeTicket {
        0x8284f4c573932fe58e5b58cb492425bbaa6af4a4489f19d76cff8b5268d27f9e::governance::ensure_can_summon_shenron(arg0);
        0x8284f4c573932fe58e5b58cb492425bbaa6af4a4489f19d76cff8b5268d27f9e::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg2));
        let v0 = 0x8284f4c573932fe58e5b58cb492425bbaa6af4a4489f19d76cff8b5268d27f9e::governance::take_locked_update<0x8284f4c573932fe58e5b58cb492425bbaa6af4a4489f19d76cff8b5268d27f9e::time_lock::TimeLock<GovernanceUpgradeWish>>(arg0, 0x1::type_name::with_defining_ids<GovernanceUpgradeWish>());
        assert!(0x8284f4c573932fe58e5b58cb492425bbaa6af4a4489f19d76cff8b5268d27f9e::time_lock::is_active<GovernanceUpgradeWish>(&v0, arg1), 0x8284f4c573932fe58e5b58cb492425bbaa6af4a4489f19d76cff8b5268d27f9e::errors::time_locked_not_active());
        let v1 = 0x8284f4c573932fe58e5b58cb492425bbaa6af4a4489f19d76cff8b5268d27f9e::time_lock::into_inner<GovernanceUpgradeWish>(v0);
        0x8284f4c573932fe58e5b58cb492425bbaa6af4a4489f19d76cff8b5268d27f9e::wish_event::emit_fulfill_wish_event<GovernanceUpgradeWish>(v1);
        let GovernanceUpgradeWish {
            policy : v2,
            digest : v3,
        } = v1;
        0x2::package::authorize_upgrade(0x8284f4c573932fe58e5b58cb492425bbaa6af4a4489f19d76cff8b5268d27f9e::governance::governance_package_upgrade_cap(arg0), v2, v3)
    }

    public fun commit_governance_upgrade(arg0: &mut 0x8284f4c573932fe58e5b58cb492425bbaa6af4a4489f19d76cff8b5268d27f9e::governance::DragonBallCollector, arg1: 0x2::package::UpgradeReceipt, arg2: &0x2::tx_context::TxContext) {
        0x8284f4c573932fe58e5b58cb492425bbaa6af4a4489f19d76cff8b5268d27f9e::governance::ensure_can_summon_shenron(arg0);
        0x8284f4c573932fe58e5b58cb492425bbaa6af4a4489f19d76cff8b5268d27f9e::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg2));
        0x2::package::commit_upgrade(0x8284f4c573932fe58e5b58cb492425bbaa6af4a4489f19d76cff8b5268d27f9e::governance::governance_package_upgrade_cap(arg0), arg1);
    }

    public(friend) fun migrate_inner(arg0: &mut 0x8284f4c573932fe58e5b58cb492425bbaa6af4a4489f19d76cff8b5268d27f9e::governance::DragonBallCollector, arg1: &0x2::tx_context::TxContext) {
        0x8284f4c573932fe58e5b58cb492425bbaa6af4a4489f19d76cff8b5268d27f9e::wish_event::emit_object_migrated(3, 0x8284f4c573932fe58e5b58cb492425bbaa6af4a4489f19d76cff8b5268d27f9e::governance::migrate(arg0), 0x2::tx_context::sender(arg1));
    }

    public fun wish_authorize_governance_upgrade(arg0: &mut 0x8284f4c573932fe58e5b58cb492425bbaa6af4a4489f19d76cff8b5268d27f9e::governance::DragonBallCollector, arg1: u8, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        0x8284f4c573932fe58e5b58cb492425bbaa6af4a4489f19d76cff8b5268d27f9e::governance::ensure_can_summon_shenron(arg0);
        0x8284f4c573932fe58e5b58cb492425bbaa6af4a4489f19d76cff8b5268d27f9e::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg4));
        let v0 = GovernanceUpgradeWish{
            policy : arg1,
            digest : arg2,
        };
        0x8284f4c573932fe58e5b58cb492425bbaa6af4a4489f19d76cff8b5268d27f9e::wish_event::emit_new_wish_event<GovernanceUpgradeWish>(v0);
        0x8284f4c573932fe58e5b58cb492425bbaa6af4a4489f19d76cff8b5268d27f9e::governance::store_locked_update<0x8284f4c573932fe58e5b58cb492425bbaa6af4a4489f19d76cff8b5268d27f9e::time_lock::TimeLock<GovernanceUpgradeWish>>(arg0, 0x1::type_name::with_defining_ids<GovernanceUpgradeWish>(), 0x8284f4c573932fe58e5b58cb492425bbaa6af4a4489f19d76cff8b5268d27f9e::time_lock::new_time_locked<GovernanceUpgradeWish>(v0, arg3, 0x8284f4c573932fe58e5b58cb492425bbaa6af4a4489f19d76cff8b5268d27f9e::governance::time_lock_duration_seconds(arg0), 0x8284f4c573932fe58e5b58cb492425bbaa6af4a4489f19d76cff8b5268d27f9e::governance::time_lock_expriration_seconds(arg0)));
    }

    // decompiled from Move bytecode v6
}

