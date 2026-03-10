module 0x62911c4cbd0b229cbc6dc6c0c1408563b1fc8896b1e774c71611aaa1e97dc28a::upgrade_leverage {
    struct LeverageUpgradeWish has copy, drop, store {
        policy: u8,
        digest: vector<u8>,
    }

    public fun migrate(arg0: &mut 0x62911c4cbd0b229cbc6dc6c0c1408563b1fc8896b1e774c71611aaa1e97dc28a::governance::DragonBallCollector, arg1: &mut 0x355a656d163883e472da3ed6c4137ddf043c8e5f11ab49a5d7e9ca0cf1023d9e::leverage_app::LeverageApp, arg2: &0x2::tx_context::TxContext) {
        0x62911c4cbd0b229cbc6dc6c0c1408563b1fc8896b1e774c71611aaa1e97dc28a::governance::ensure_can_summon_shenron(arg0);
        0x62911c4cbd0b229cbc6dc6c0c1408563b1fc8896b1e774c71611aaa1e97dc28a::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg2));
        migrate_inner(arg0, arg1, arg2);
        0x62911c4cbd0b229cbc6dc6c0c1408563b1fc8896b1e774c71611aaa1e97dc28a::upgrade_self::migrate_inner(arg0, arg2);
    }

    public fun authorize_leverage_upgrade(arg0: &mut 0x62911c4cbd0b229cbc6dc6c0c1408563b1fc8896b1e774c71611aaa1e97dc28a::governance::DragonBallCollector, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) : 0x2::package::UpgradeTicket {
        0x62911c4cbd0b229cbc6dc6c0c1408563b1fc8896b1e774c71611aaa1e97dc28a::governance::ensure_functional(arg0);
        0x62911c4cbd0b229cbc6dc6c0c1408563b1fc8896b1e774c71611aaa1e97dc28a::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg2));
        let v0 = 0x62911c4cbd0b229cbc6dc6c0c1408563b1fc8896b1e774c71611aaa1e97dc28a::governance::take_locked_update<0x62911c4cbd0b229cbc6dc6c0c1408563b1fc8896b1e774c71611aaa1e97dc28a::time_lock::TimeLock<LeverageUpgradeWish>>(arg0, 0x1::type_name::with_defining_ids<LeverageUpgradeWish>());
        assert!(0x62911c4cbd0b229cbc6dc6c0c1408563b1fc8896b1e774c71611aaa1e97dc28a::time_lock::is_active<LeverageUpgradeWish>(&v0, arg1), 0x62911c4cbd0b229cbc6dc6c0c1408563b1fc8896b1e774c71611aaa1e97dc28a::errors::time_locked_not_active());
        let v1 = 0x62911c4cbd0b229cbc6dc6c0c1408563b1fc8896b1e774c71611aaa1e97dc28a::time_lock::into_inner<LeverageUpgradeWish>(v0);
        0x62911c4cbd0b229cbc6dc6c0c1408563b1fc8896b1e774c71611aaa1e97dc28a::wish_event::emit_fulfill_wish_event<LeverageUpgradeWish>(v1);
        let LeverageUpgradeWish {
            policy : v2,
            digest : v3,
        } = v1;
        0x2::package::authorize_upgrade(0x62911c4cbd0b229cbc6dc6c0c1408563b1fc8896b1e774c71611aaa1e97dc28a::governance::leverage_package_upgrade_cap(arg0), v2, v3)
    }

    public fun commit_leverage_upgrade(arg0: &mut 0x62911c4cbd0b229cbc6dc6c0c1408563b1fc8896b1e774c71611aaa1e97dc28a::governance::DragonBallCollector, arg1: 0x2::package::UpgradeReceipt, arg2: &0x2::tx_context::TxContext) {
        0x62911c4cbd0b229cbc6dc6c0c1408563b1fc8896b1e774c71611aaa1e97dc28a::governance::ensure_can_summon_shenron(arg0);
        0x62911c4cbd0b229cbc6dc6c0c1408563b1fc8896b1e774c71611aaa1e97dc28a::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg2));
        0x2::package::commit_upgrade(0x62911c4cbd0b229cbc6dc6c0c1408563b1fc8896b1e774c71611aaa1e97dc28a::governance::leverage_package_upgrade_cap(arg0), arg1);
    }

    public(friend) fun migrate_inner(arg0: &0x62911c4cbd0b229cbc6dc6c0c1408563b1fc8896b1e774c71611aaa1e97dc28a::governance::DragonBallCollector, arg1: &mut 0x355a656d163883e472da3ed6c4137ddf043c8e5f11ab49a5d7e9ca0cf1023d9e::leverage_app::LeverageApp, arg2: &0x2::tx_context::TxContext) {
        0x62911c4cbd0b229cbc6dc6c0c1408563b1fc8896b1e774c71611aaa1e97dc28a::wish_event::emit_object_migrated(2, 0x355a656d163883e472da3ed6c4137ddf043c8e5f11ab49a5d7e9ca0cf1023d9e::leverage_admin::migrate(0x62911c4cbd0b229cbc6dc6c0c1408563b1fc8896b1e774c71611aaa1e97dc28a::governance::lending_admin_cap(arg0), arg1), 0x2::tx_context::sender(arg2));
    }

    public fun wish_authorize_leverage_upgrade(arg0: &mut 0x62911c4cbd0b229cbc6dc6c0c1408563b1fc8896b1e774c71611aaa1e97dc28a::governance::DragonBallCollector, arg1: u8, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        0x62911c4cbd0b229cbc6dc6c0c1408563b1fc8896b1e774c71611aaa1e97dc28a::governance::ensure_functional(arg0);
        0x62911c4cbd0b229cbc6dc6c0c1408563b1fc8896b1e774c71611aaa1e97dc28a::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg4));
        let v0 = LeverageUpgradeWish{
            policy : arg1,
            digest : arg2,
        };
        0x62911c4cbd0b229cbc6dc6c0c1408563b1fc8896b1e774c71611aaa1e97dc28a::wish_event::emit_new_wish_event<LeverageUpgradeWish>(v0);
        0x62911c4cbd0b229cbc6dc6c0c1408563b1fc8896b1e774c71611aaa1e97dc28a::governance::store_locked_update<0x62911c4cbd0b229cbc6dc6c0c1408563b1fc8896b1e774c71611aaa1e97dc28a::time_lock::TimeLock<LeverageUpgradeWish>>(arg0, 0x1::type_name::with_defining_ids<LeverageUpgradeWish>(), 0x62911c4cbd0b229cbc6dc6c0c1408563b1fc8896b1e774c71611aaa1e97dc28a::time_lock::new_time_locked<LeverageUpgradeWish>(v0, arg3, 0x62911c4cbd0b229cbc6dc6c0c1408563b1fc8896b1e774c71611aaa1e97dc28a::governance::time_lock_duration_seconds(arg0), 0x62911c4cbd0b229cbc6dc6c0c1408563b1fc8896b1e774c71611aaa1e97dc28a::governance::time_lock_expriration_seconds(arg0)));
    }

    // decompiled from Move bytecode v6
}

