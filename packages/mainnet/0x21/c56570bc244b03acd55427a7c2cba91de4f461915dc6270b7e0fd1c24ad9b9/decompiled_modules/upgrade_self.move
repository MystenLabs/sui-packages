module 0x21c56570bc244b03acd55427a7c2cba91de4f461915dc6270b7e0fd1c24ad9b9::upgrade_self {
    struct GovernanceUpgradeWish has copy, drop, store {
        policy: u8,
        digest: vector<u8>,
    }

    public fun authorize_governance_upgrade(arg0: &mut 0x21c56570bc244b03acd55427a7c2cba91de4f461915dc6270b7e0fd1c24ad9b9::governance::DragonBallCollector, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : 0x2::package::UpgradeTicket {
        0x21c56570bc244b03acd55427a7c2cba91de4f461915dc6270b7e0fd1c24ad9b9::governance::ensure_can_summon_shenron(arg0);
        0x21c56570bc244b03acd55427a7c2cba91de4f461915dc6270b7e0fd1c24ad9b9::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg2));
        let v0 = 0x21c56570bc244b03acd55427a7c2cba91de4f461915dc6270b7e0fd1c24ad9b9::governance::take_locked_update<0x21c56570bc244b03acd55427a7c2cba91de4f461915dc6270b7e0fd1c24ad9b9::time_lock::TimeLock<GovernanceUpgradeWish>>(arg0, 0x1::type_name::with_defining_ids<GovernanceUpgradeWish>());
        assert!(0x21c56570bc244b03acd55427a7c2cba91de4f461915dc6270b7e0fd1c24ad9b9::time_lock::is_active<GovernanceUpgradeWish>(&v0, arg1), 0x21c56570bc244b03acd55427a7c2cba91de4f461915dc6270b7e0fd1c24ad9b9::errors::time_locked_not_active());
        let GovernanceUpgradeWish {
            policy : v1,
            digest : v2,
        } = 0x21c56570bc244b03acd55427a7c2cba91de4f461915dc6270b7e0fd1c24ad9b9::time_lock::into_inner<GovernanceUpgradeWish>(v0);
        0x2::package::authorize_upgrade(0x21c56570bc244b03acd55427a7c2cba91de4f461915dc6270b7e0fd1c24ad9b9::governance::governance_package_upgrade_cap(arg0), v1, v2)
    }

    public fun commit_governance_upgrade(arg0: &mut 0x21c56570bc244b03acd55427a7c2cba91de4f461915dc6270b7e0fd1c24ad9b9::governance::DragonBallCollector, arg1: 0x2::package::UpgradeReceipt, arg2: &mut 0x2::tx_context::TxContext) {
        0x21c56570bc244b03acd55427a7c2cba91de4f461915dc6270b7e0fd1c24ad9b9::governance::ensure_can_summon_shenron(arg0);
        0x21c56570bc244b03acd55427a7c2cba91de4f461915dc6270b7e0fd1c24ad9b9::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg2));
        0x2::package::commit_upgrade(0x21c56570bc244b03acd55427a7c2cba91de4f461915dc6270b7e0fd1c24ad9b9::governance::governance_package_upgrade_cap(arg0), arg1);
    }

    public fun wish_authorize_governance_upgrade(arg0: &mut 0x21c56570bc244b03acd55427a7c2cba91de4f461915dc6270b7e0fd1c24ad9b9::governance::DragonBallCollector, arg1: u8, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x21c56570bc244b03acd55427a7c2cba91de4f461915dc6270b7e0fd1c24ad9b9::governance::ensure_can_summon_shenron(arg0);
        0x21c56570bc244b03acd55427a7c2cba91de4f461915dc6270b7e0fd1c24ad9b9::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg4));
        let v0 = GovernanceUpgradeWish{
            policy : arg1,
            digest : arg2,
        };
        0x21c56570bc244b03acd55427a7c2cba91de4f461915dc6270b7e0fd1c24ad9b9::governance::store_locked_update<0x21c56570bc244b03acd55427a7c2cba91de4f461915dc6270b7e0fd1c24ad9b9::time_lock::TimeLock<GovernanceUpgradeWish>>(arg0, 0x1::type_name::with_defining_ids<GovernanceUpgradeWish>(), 0x21c56570bc244b03acd55427a7c2cba91de4f461915dc6270b7e0fd1c24ad9b9::time_lock::new_time_locked<GovernanceUpgradeWish>(v0, arg3, 0x21c56570bc244b03acd55427a7c2cba91de4f461915dc6270b7e0fd1c24ad9b9::governance::time_lock_duration_seconds(arg0), 0x21c56570bc244b03acd55427a7c2cba91de4f461915dc6270b7e0fd1c24ad9b9::governance::time_lock_expriration_seconds(arg0)));
    }

    // decompiled from Move bytecode v6
}

