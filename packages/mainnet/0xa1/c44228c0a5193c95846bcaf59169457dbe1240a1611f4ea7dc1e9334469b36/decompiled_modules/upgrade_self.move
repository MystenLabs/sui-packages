module 0xa1c44228c0a5193c95846bcaf59169457dbe1240a1611f4ea7dc1e9334469b36::upgrade_self {
    struct GovernanceUpgradeWish has copy, drop, store {
        policy: u8,
        digest: vector<u8>,
    }

    public fun authorize_governance_upgrade(arg0: &mut 0xa1c44228c0a5193c95846bcaf59169457dbe1240a1611f4ea7dc1e9334469b36::governance::DragonBallCollector, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : 0x2::package::UpgradeTicket {
        0xa1c44228c0a5193c95846bcaf59169457dbe1240a1611f4ea7dc1e9334469b36::governance::ensure_can_summon_shenron(arg0);
        0xa1c44228c0a5193c95846bcaf59169457dbe1240a1611f4ea7dc1e9334469b36::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg2));
        let v0 = 0xa1c44228c0a5193c95846bcaf59169457dbe1240a1611f4ea7dc1e9334469b36::governance::take_locked_update<0xa1c44228c0a5193c95846bcaf59169457dbe1240a1611f4ea7dc1e9334469b36::time_lock::TimeLock<GovernanceUpgradeWish>>(arg0, 0x1::type_name::with_defining_ids<GovernanceUpgradeWish>());
        assert!(0xa1c44228c0a5193c95846bcaf59169457dbe1240a1611f4ea7dc1e9334469b36::time_lock::is_active<GovernanceUpgradeWish>(&v0, arg1), 0xa1c44228c0a5193c95846bcaf59169457dbe1240a1611f4ea7dc1e9334469b36::errors::time_locked_not_active());
        let v1 = 0xa1c44228c0a5193c95846bcaf59169457dbe1240a1611f4ea7dc1e9334469b36::time_lock::into_inner<GovernanceUpgradeWish>(v0);
        0xa1c44228c0a5193c95846bcaf59169457dbe1240a1611f4ea7dc1e9334469b36::wish_event::emit_fulfill_wish_event<GovernanceUpgradeWish>(v1);
        let GovernanceUpgradeWish {
            policy : v2,
            digest : v3,
        } = v1;
        0x2::package::authorize_upgrade(0xa1c44228c0a5193c95846bcaf59169457dbe1240a1611f4ea7dc1e9334469b36::governance::governance_package_upgrade_cap(arg0), v2, v3)
    }

    public fun commit_governance_upgrade(arg0: &mut 0xa1c44228c0a5193c95846bcaf59169457dbe1240a1611f4ea7dc1e9334469b36::governance::DragonBallCollector, arg1: 0x2::package::UpgradeReceipt, arg2: &mut 0x2::tx_context::TxContext) {
        0xa1c44228c0a5193c95846bcaf59169457dbe1240a1611f4ea7dc1e9334469b36::governance::ensure_can_summon_shenron(arg0);
        0xa1c44228c0a5193c95846bcaf59169457dbe1240a1611f4ea7dc1e9334469b36::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg2));
        0x2::package::commit_upgrade(0xa1c44228c0a5193c95846bcaf59169457dbe1240a1611f4ea7dc1e9334469b36::governance::governance_package_upgrade_cap(arg0), arg1);
    }

    public fun wish_authorize_governance_upgrade(arg0: &mut 0xa1c44228c0a5193c95846bcaf59169457dbe1240a1611f4ea7dc1e9334469b36::governance::DragonBallCollector, arg1: u8, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xa1c44228c0a5193c95846bcaf59169457dbe1240a1611f4ea7dc1e9334469b36::governance::ensure_can_summon_shenron(arg0);
        0xa1c44228c0a5193c95846bcaf59169457dbe1240a1611f4ea7dc1e9334469b36::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg4));
        let v0 = GovernanceUpgradeWish{
            policy : arg1,
            digest : arg2,
        };
        0xa1c44228c0a5193c95846bcaf59169457dbe1240a1611f4ea7dc1e9334469b36::wish_event::emit_new_wish_event<GovernanceUpgradeWish>(v0);
        0xa1c44228c0a5193c95846bcaf59169457dbe1240a1611f4ea7dc1e9334469b36::governance::store_locked_update<0xa1c44228c0a5193c95846bcaf59169457dbe1240a1611f4ea7dc1e9334469b36::time_lock::TimeLock<GovernanceUpgradeWish>>(arg0, 0x1::type_name::with_defining_ids<GovernanceUpgradeWish>(), 0xa1c44228c0a5193c95846bcaf59169457dbe1240a1611f4ea7dc1e9334469b36::time_lock::new_time_locked<GovernanceUpgradeWish>(v0, arg3, 0xa1c44228c0a5193c95846bcaf59169457dbe1240a1611f4ea7dc1e9334469b36::governance::time_lock_duration_seconds(arg0), 0xa1c44228c0a5193c95846bcaf59169457dbe1240a1611f4ea7dc1e9334469b36::governance::time_lock_expriration_seconds(arg0)));
    }

    // decompiled from Move bytecode v6
}

