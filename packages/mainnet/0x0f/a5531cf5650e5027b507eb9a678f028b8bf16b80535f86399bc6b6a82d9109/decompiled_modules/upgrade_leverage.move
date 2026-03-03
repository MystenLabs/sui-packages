module 0xfa5531cf5650e5027b507eb9a678f028b8bf16b80535f86399bc6b6a82d9109::upgrade_leverage {
    struct LeverageUpgradeWish has copy, drop, store {
        policy: u8,
        digest: vector<u8>,
    }

    public fun authorize_leverage_upgrade(arg0: &mut 0xfa5531cf5650e5027b507eb9a678f028b8bf16b80535f86399bc6b6a82d9109::governance::DragonBallCollector, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) : 0x2::package::UpgradeTicket {
        0xfa5531cf5650e5027b507eb9a678f028b8bf16b80535f86399bc6b6a82d9109::governance::ensure_can_summon_shenron(arg0);
        0xfa5531cf5650e5027b507eb9a678f028b8bf16b80535f86399bc6b6a82d9109::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg2));
        let v0 = 0xfa5531cf5650e5027b507eb9a678f028b8bf16b80535f86399bc6b6a82d9109::governance::take_locked_update<0xfa5531cf5650e5027b507eb9a678f028b8bf16b80535f86399bc6b6a82d9109::time_lock::TimeLock<LeverageUpgradeWish>>(arg0, 0x1::type_name::with_defining_ids<LeverageUpgradeWish>());
        assert!(0xfa5531cf5650e5027b507eb9a678f028b8bf16b80535f86399bc6b6a82d9109::time_lock::is_active<LeverageUpgradeWish>(&v0, arg1), 0xfa5531cf5650e5027b507eb9a678f028b8bf16b80535f86399bc6b6a82d9109::errors::time_locked_not_active());
        let v1 = 0xfa5531cf5650e5027b507eb9a678f028b8bf16b80535f86399bc6b6a82d9109::time_lock::into_inner<LeverageUpgradeWish>(v0);
        0xfa5531cf5650e5027b507eb9a678f028b8bf16b80535f86399bc6b6a82d9109::wish_event::emit_fulfill_wish_event<LeverageUpgradeWish>(v1);
        let LeverageUpgradeWish {
            policy : v2,
            digest : v3,
        } = v1;
        0x2::package::authorize_upgrade(0xfa5531cf5650e5027b507eb9a678f028b8bf16b80535f86399bc6b6a82d9109::governance::leverage_package_upgrade_cap(arg0), v2, v3)
    }

    public fun commit_leverage_upgrade(arg0: &mut 0xfa5531cf5650e5027b507eb9a678f028b8bf16b80535f86399bc6b6a82d9109::governance::DragonBallCollector, arg1: 0x2::package::UpgradeReceipt, arg2: &0x2::tx_context::TxContext) {
        0xfa5531cf5650e5027b507eb9a678f028b8bf16b80535f86399bc6b6a82d9109::governance::ensure_functional(arg0);
        0xfa5531cf5650e5027b507eb9a678f028b8bf16b80535f86399bc6b6a82d9109::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg2));
        0x2::package::commit_upgrade(0xfa5531cf5650e5027b507eb9a678f028b8bf16b80535f86399bc6b6a82d9109::governance::leverage_package_upgrade_cap(arg0), arg1);
    }

    public fun migrate(arg0: &mut 0xfa5531cf5650e5027b507eb9a678f028b8bf16b80535f86399bc6b6a82d9109::governance::DragonBallCollector, arg1: &mut 0xae62107ac6d3865863a5b6949dcf1c52ba12ba99e7086a16dcf1ab659144bc69::leverage_app::LeverageApp, arg2: &0x2::tx_context::TxContext) {
        0xfa5531cf5650e5027b507eb9a678f028b8bf16b80535f86399bc6b6a82d9109::governance::ensure_can_summon_shenron(arg0);
        0xfa5531cf5650e5027b507eb9a678f028b8bf16b80535f86399bc6b6a82d9109::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg2));
        migrate_inner(arg0, arg1, arg2);
        0xfa5531cf5650e5027b507eb9a678f028b8bf16b80535f86399bc6b6a82d9109::upgrade_self::migrate_inner(arg0, arg2);
    }

    public(friend) fun migrate_inner(arg0: &0xfa5531cf5650e5027b507eb9a678f028b8bf16b80535f86399bc6b6a82d9109::governance::DragonBallCollector, arg1: &mut 0xae62107ac6d3865863a5b6949dcf1c52ba12ba99e7086a16dcf1ab659144bc69::leverage_app::LeverageApp, arg2: &0x2::tx_context::TxContext) {
        0xfa5531cf5650e5027b507eb9a678f028b8bf16b80535f86399bc6b6a82d9109::wish_event::emit_object_migrated(2, 0xae62107ac6d3865863a5b6949dcf1c52ba12ba99e7086a16dcf1ab659144bc69::leverage_admin::migrate(0xfa5531cf5650e5027b507eb9a678f028b8bf16b80535f86399bc6b6a82d9109::governance::lending_admin_cap(arg0), arg1), 0x2::tx_context::sender(arg2));
    }

    public fun wish_authorize_leverage_upgrade(arg0: &mut 0xfa5531cf5650e5027b507eb9a678f028b8bf16b80535f86399bc6b6a82d9109::governance::DragonBallCollector, arg1: u8, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        0xfa5531cf5650e5027b507eb9a678f028b8bf16b80535f86399bc6b6a82d9109::governance::ensure_can_summon_shenron(arg0);
        0xfa5531cf5650e5027b507eb9a678f028b8bf16b80535f86399bc6b6a82d9109::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg4));
        let v0 = LeverageUpgradeWish{
            policy : arg1,
            digest : arg2,
        };
        0xfa5531cf5650e5027b507eb9a678f028b8bf16b80535f86399bc6b6a82d9109::wish_event::emit_new_wish_event<LeverageUpgradeWish>(v0);
        0xfa5531cf5650e5027b507eb9a678f028b8bf16b80535f86399bc6b6a82d9109::governance::store_locked_update<0xfa5531cf5650e5027b507eb9a678f028b8bf16b80535f86399bc6b6a82d9109::time_lock::TimeLock<LeverageUpgradeWish>>(arg0, 0x1::type_name::with_defining_ids<LeverageUpgradeWish>(), 0xfa5531cf5650e5027b507eb9a678f028b8bf16b80535f86399bc6b6a82d9109::time_lock::new_time_locked<LeverageUpgradeWish>(v0, arg3, 0xfa5531cf5650e5027b507eb9a678f028b8bf16b80535f86399bc6b6a82d9109::governance::time_lock_duration_seconds(arg0), 0xfa5531cf5650e5027b507eb9a678f028b8bf16b80535f86399bc6b6a82d9109::governance::time_lock_expriration_seconds(arg0)));
    }

    // decompiled from Move bytecode v6
}

