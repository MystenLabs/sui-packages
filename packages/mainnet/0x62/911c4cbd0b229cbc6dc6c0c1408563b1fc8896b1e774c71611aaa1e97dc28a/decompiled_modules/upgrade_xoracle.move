module 0x62911c4cbd0b229cbc6dc6c0c1408563b1fc8896b1e774c71611aaa1e97dc28a::upgrade_xoracle {
    struct XOracleUpgradeWish has copy, drop, store {
        policy: u8,
        digest: vector<u8>,
    }

    fun migrate_inner(arg0: &0x62911c4cbd0b229cbc6dc6c0c1408563b1fc8896b1e774c71611aaa1e97dc28a::governance::DragonBallCollector, arg1: &mut 0xf4b6a35a90a54d9758c06cf304ef93534fc37746ab0eff62bcae6bf272e50e83::x_oracle::XOracle, arg2: &0x2::tx_context::TxContext) {
        0x62911c4cbd0b229cbc6dc6c0c1408563b1fc8896b1e774c71611aaa1e97dc28a::wish_event::emit_object_migrated(0, 0xf4b6a35a90a54d9758c06cf304ef93534fc37746ab0eff62bcae6bf272e50e83::oracle_admin::migrate(0x62911c4cbd0b229cbc6dc6c0c1408563b1fc8896b1e774c71611aaa1e97dc28a::governance::x_oracle_admin_cap(arg0), arg1), 0x2::tx_context::sender(arg2));
    }

    public fun authorize_xoracle_upgrade(arg0: &mut 0x62911c4cbd0b229cbc6dc6c0c1408563b1fc8896b1e774c71611aaa1e97dc28a::governance::DragonBallCollector, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) : 0x2::package::UpgradeTicket {
        0x62911c4cbd0b229cbc6dc6c0c1408563b1fc8896b1e774c71611aaa1e97dc28a::governance::ensure_functional(arg0);
        0x62911c4cbd0b229cbc6dc6c0c1408563b1fc8896b1e774c71611aaa1e97dc28a::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg2));
        let v0 = 0x62911c4cbd0b229cbc6dc6c0c1408563b1fc8896b1e774c71611aaa1e97dc28a::governance::take_locked_update<0x62911c4cbd0b229cbc6dc6c0c1408563b1fc8896b1e774c71611aaa1e97dc28a::time_lock::TimeLock<XOracleUpgradeWish>>(arg0, 0x1::type_name::with_defining_ids<XOracleUpgradeWish>());
        assert!(0x62911c4cbd0b229cbc6dc6c0c1408563b1fc8896b1e774c71611aaa1e97dc28a::time_lock::is_active<XOracleUpgradeWish>(&v0, arg1), 0x62911c4cbd0b229cbc6dc6c0c1408563b1fc8896b1e774c71611aaa1e97dc28a::errors::time_locked_not_active());
        let v1 = 0x62911c4cbd0b229cbc6dc6c0c1408563b1fc8896b1e774c71611aaa1e97dc28a::time_lock::into_inner<XOracleUpgradeWish>(v0);
        0x62911c4cbd0b229cbc6dc6c0c1408563b1fc8896b1e774c71611aaa1e97dc28a::wish_event::emit_fulfill_wish_event<XOracleUpgradeWish>(v1);
        let XOracleUpgradeWish {
            policy : v2,
            digest : v3,
        } = v1;
        0x2::package::authorize_upgrade(0x62911c4cbd0b229cbc6dc6c0c1408563b1fc8896b1e774c71611aaa1e97dc28a::governance::x_oracle_package_upgrade_cap(arg0), v2, v3)
    }

    public fun commit_xoracle_upgrade(arg0: &mut 0x62911c4cbd0b229cbc6dc6c0c1408563b1fc8896b1e774c71611aaa1e97dc28a::governance::DragonBallCollector, arg1: 0x2::package::UpgradeReceipt, arg2: &0x2::tx_context::TxContext) {
        0x62911c4cbd0b229cbc6dc6c0c1408563b1fc8896b1e774c71611aaa1e97dc28a::governance::ensure_functional(arg0);
        0x62911c4cbd0b229cbc6dc6c0c1408563b1fc8896b1e774c71611aaa1e97dc28a::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg2));
        0x2::package::commit_upgrade(0x62911c4cbd0b229cbc6dc6c0c1408563b1fc8896b1e774c71611aaa1e97dc28a::governance::x_oracle_package_upgrade_cap(arg0), arg1);
    }

    public fun migrate(arg0: &mut 0x62911c4cbd0b229cbc6dc6c0c1408563b1fc8896b1e774c71611aaa1e97dc28a::governance::DragonBallCollector, arg1: &mut 0xf4b6a35a90a54d9758c06cf304ef93534fc37746ab0eff62bcae6bf272e50e83::x_oracle::XOracle, arg2: &mut 0xa377cac91d12de361e03940bad7f17ceaaa9dc095ae2c30b284110ef099cb8b6::app::ProtocolApp, arg3: &mut 0x355a656d163883e472da3ed6c4137ddf043c8e5f11ab49a5d7e9ca0cf1023d9e::leverage_app::LeverageApp, arg4: &0x2::tx_context::TxContext) {
        0x62911c4cbd0b229cbc6dc6c0c1408563b1fc8896b1e774c71611aaa1e97dc28a::governance::ensure_can_summon_shenron(arg0);
        0x62911c4cbd0b229cbc6dc6c0c1408563b1fc8896b1e774c71611aaa1e97dc28a::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg4));
        migrate_inner(arg0, arg1, arg4);
        0x62911c4cbd0b229cbc6dc6c0c1408563b1fc8896b1e774c71611aaa1e97dc28a::upgrade_protocol::migrate_inner(arg0, arg2, arg4);
        0x62911c4cbd0b229cbc6dc6c0c1408563b1fc8896b1e774c71611aaa1e97dc28a::upgrade_leverage::migrate_inner(arg0, arg3, arg4);
        0x62911c4cbd0b229cbc6dc6c0c1408563b1fc8896b1e774c71611aaa1e97dc28a::upgrade_self::migrate_inner(arg0, arg4);
    }

    public fun wish_authorize_xoracle_upgrade(arg0: &mut 0x62911c4cbd0b229cbc6dc6c0c1408563b1fc8896b1e774c71611aaa1e97dc28a::governance::DragonBallCollector, arg1: u8, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        0x62911c4cbd0b229cbc6dc6c0c1408563b1fc8896b1e774c71611aaa1e97dc28a::governance::ensure_functional(arg0);
        0x62911c4cbd0b229cbc6dc6c0c1408563b1fc8896b1e774c71611aaa1e97dc28a::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg4));
        let v0 = XOracleUpgradeWish{
            policy : arg1,
            digest : arg2,
        };
        0x62911c4cbd0b229cbc6dc6c0c1408563b1fc8896b1e774c71611aaa1e97dc28a::wish_event::emit_new_wish_event<XOracleUpgradeWish>(v0);
        0x62911c4cbd0b229cbc6dc6c0c1408563b1fc8896b1e774c71611aaa1e97dc28a::governance::store_locked_update<0x62911c4cbd0b229cbc6dc6c0c1408563b1fc8896b1e774c71611aaa1e97dc28a::time_lock::TimeLock<XOracleUpgradeWish>>(arg0, 0x1::type_name::with_defining_ids<XOracleUpgradeWish>(), 0x62911c4cbd0b229cbc6dc6c0c1408563b1fc8896b1e774c71611aaa1e97dc28a::time_lock::new_time_locked<XOracleUpgradeWish>(v0, arg3, 0x62911c4cbd0b229cbc6dc6c0c1408563b1fc8896b1e774c71611aaa1e97dc28a::governance::time_lock_duration_seconds(arg0), 0x62911c4cbd0b229cbc6dc6c0c1408563b1fc8896b1e774c71611aaa1e97dc28a::governance::time_lock_expriration_seconds(arg0)));
    }

    // decompiled from Move bytecode v6
}

