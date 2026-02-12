module 0x8a3cfc58ffd8d2db62c986fa2fd89303293ffc463a70923fa3a70df16ea59803::upgrade_xoracle {
    struct XOracleUpgradeWish has copy, drop, store {
        policy: u8,
        digest: vector<u8>,
    }

    public fun authorize_xoracle_upgrade(arg0: &mut 0x8a3cfc58ffd8d2db62c986fa2fd89303293ffc463a70923fa3a70df16ea59803::governance::DragonBallCollector, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : 0x2::package::UpgradeTicket {
        0x8a3cfc58ffd8d2db62c986fa2fd89303293ffc463a70923fa3a70df16ea59803::governance::ensure_can_summon_shenron(arg0);
        0x8a3cfc58ffd8d2db62c986fa2fd89303293ffc463a70923fa3a70df16ea59803::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg2));
        let v0 = 0x8a3cfc58ffd8d2db62c986fa2fd89303293ffc463a70923fa3a70df16ea59803::governance::take_locked_update<0x8a3cfc58ffd8d2db62c986fa2fd89303293ffc463a70923fa3a70df16ea59803::time_lock::TimeLock<XOracleUpgradeWish>>(arg0, 0x1::type_name::with_defining_ids<XOracleUpgradeWish>());
        assert!(0x8a3cfc58ffd8d2db62c986fa2fd89303293ffc463a70923fa3a70df16ea59803::time_lock::is_active<XOracleUpgradeWish>(&v0, arg1), 0x8a3cfc58ffd8d2db62c986fa2fd89303293ffc463a70923fa3a70df16ea59803::errors::time_locked_not_active());
        let v1 = 0x8a3cfc58ffd8d2db62c986fa2fd89303293ffc463a70923fa3a70df16ea59803::time_lock::into_inner<XOracleUpgradeWish>(v0);
        0x8a3cfc58ffd8d2db62c986fa2fd89303293ffc463a70923fa3a70df16ea59803::wish_event::emit_fulfill_wish_event<XOracleUpgradeWish>(v1);
        let XOracleUpgradeWish {
            policy : v2,
            digest : v3,
        } = v1;
        0x2::package::authorize_upgrade(0x8a3cfc58ffd8d2db62c986fa2fd89303293ffc463a70923fa3a70df16ea59803::governance::x_oracle_package_upgrade_cap(arg0), v2, v3)
    }

    public fun commit_xoracle_upgrade(arg0: &mut 0x8a3cfc58ffd8d2db62c986fa2fd89303293ffc463a70923fa3a70df16ea59803::governance::DragonBallCollector, arg1: 0x2::package::UpgradeReceipt, arg2: &mut 0x2::tx_context::TxContext) {
        0x8a3cfc58ffd8d2db62c986fa2fd89303293ffc463a70923fa3a70df16ea59803::governance::ensure_can_summon_shenron(arg0);
        0x8a3cfc58ffd8d2db62c986fa2fd89303293ffc463a70923fa3a70df16ea59803::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg2));
        0x2::package::commit_upgrade(0x8a3cfc58ffd8d2db62c986fa2fd89303293ffc463a70923fa3a70df16ea59803::governance::x_oracle_package_upgrade_cap(arg0), arg1);
    }

    public fun wish_authorize_xoracle_upgrade(arg0: &mut 0x8a3cfc58ffd8d2db62c986fa2fd89303293ffc463a70923fa3a70df16ea59803::governance::DragonBallCollector, arg1: u8, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x8a3cfc58ffd8d2db62c986fa2fd89303293ffc463a70923fa3a70df16ea59803::governance::ensure_can_summon_shenron(arg0);
        0x8a3cfc58ffd8d2db62c986fa2fd89303293ffc463a70923fa3a70df16ea59803::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg4));
        let v0 = XOracleUpgradeWish{
            policy : arg1,
            digest : arg2,
        };
        0x8a3cfc58ffd8d2db62c986fa2fd89303293ffc463a70923fa3a70df16ea59803::wish_event::emit_new_wish_event<XOracleUpgradeWish>(v0);
        0x8a3cfc58ffd8d2db62c986fa2fd89303293ffc463a70923fa3a70df16ea59803::governance::store_locked_update<0x8a3cfc58ffd8d2db62c986fa2fd89303293ffc463a70923fa3a70df16ea59803::time_lock::TimeLock<XOracleUpgradeWish>>(arg0, 0x1::type_name::with_defining_ids<XOracleUpgradeWish>(), 0x8a3cfc58ffd8d2db62c986fa2fd89303293ffc463a70923fa3a70df16ea59803::time_lock::new_time_locked<XOracleUpgradeWish>(v0, arg3, 0x8a3cfc58ffd8d2db62c986fa2fd89303293ffc463a70923fa3a70df16ea59803::governance::time_lock_duration_seconds(arg0), 0x8a3cfc58ffd8d2db62c986fa2fd89303293ffc463a70923fa3a70df16ea59803::governance::time_lock_expriration_seconds(arg0)));
    }

    // decompiled from Move bytecode v6
}

