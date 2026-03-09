module 0x3ae667edc4eb7525acc423b0ad4d09bfb1d54079da2bcbc473e2313cf1a450be::upgrade_protocol {
    struct ProtocolUpgradeWish has copy, drop, store {
        policy: u8,
        digest: vector<u8>,
    }

    public(friend) fun migrate_inner(arg0: &0x3ae667edc4eb7525acc423b0ad4d09bfb1d54079da2bcbc473e2313cf1a450be::governance::DragonBallCollector, arg1: &mut 0xa377cac91d12de361e03940bad7f17ceaaa9dc095ae2c30b284110ef099cb8b6::app::ProtocolApp, arg2: &0x2::tx_context::TxContext) {
        0x3ae667edc4eb7525acc423b0ad4d09bfb1d54079da2bcbc473e2313cf1a450be::wish_event::emit_object_migrated(1, 0xa377cac91d12de361e03940bad7f17ceaaa9dc095ae2c30b284110ef099cb8b6::version_admin::migrate(0x3ae667edc4eb7525acc423b0ad4d09bfb1d54079da2bcbc473e2313cf1a450be::governance::lending_admin_cap(arg0), arg1), 0x2::tx_context::sender(arg2));
    }

    public fun authorize_protocol_upgrade(arg0: &mut 0x3ae667edc4eb7525acc423b0ad4d09bfb1d54079da2bcbc473e2313cf1a450be::governance::DragonBallCollector, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : 0x2::package::UpgradeTicket {
        0x3ae667edc4eb7525acc423b0ad4d09bfb1d54079da2bcbc473e2313cf1a450be::governance::ensure_functional(arg0);
        0x3ae667edc4eb7525acc423b0ad4d09bfb1d54079da2bcbc473e2313cf1a450be::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg2));
        let v0 = 0x3ae667edc4eb7525acc423b0ad4d09bfb1d54079da2bcbc473e2313cf1a450be::governance::take_locked_update<0x3ae667edc4eb7525acc423b0ad4d09bfb1d54079da2bcbc473e2313cf1a450be::time_lock::TimeLock<ProtocolUpgradeWish>>(arg0, 0x1::type_name::with_defining_ids<ProtocolUpgradeWish>());
        assert!(0x3ae667edc4eb7525acc423b0ad4d09bfb1d54079da2bcbc473e2313cf1a450be::time_lock::is_active<ProtocolUpgradeWish>(&v0, arg1), 0x3ae667edc4eb7525acc423b0ad4d09bfb1d54079da2bcbc473e2313cf1a450be::errors::time_locked_not_active());
        let v1 = 0x3ae667edc4eb7525acc423b0ad4d09bfb1d54079da2bcbc473e2313cf1a450be::time_lock::into_inner<ProtocolUpgradeWish>(v0);
        0x3ae667edc4eb7525acc423b0ad4d09bfb1d54079da2bcbc473e2313cf1a450be::wish_event::emit_fulfill_wish_event<ProtocolUpgradeWish>(v1);
        let ProtocolUpgradeWish {
            policy : v2,
            digest : v3,
        } = v1;
        0x2::package::authorize_upgrade(0x3ae667edc4eb7525acc423b0ad4d09bfb1d54079da2bcbc473e2313cf1a450be::governance::lending_package_upgrade_cap(arg0), v2, v3)
    }

    public fun commit_protocol_upgrade(arg0: &mut 0x3ae667edc4eb7525acc423b0ad4d09bfb1d54079da2bcbc473e2313cf1a450be::governance::DragonBallCollector, arg1: 0x2::package::UpgradeReceipt, arg2: &0x2::tx_context::TxContext) {
        0x3ae667edc4eb7525acc423b0ad4d09bfb1d54079da2bcbc473e2313cf1a450be::governance::ensure_functional(arg0);
        0x3ae667edc4eb7525acc423b0ad4d09bfb1d54079da2bcbc473e2313cf1a450be::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg2));
        0x2::package::commit_upgrade(0x3ae667edc4eb7525acc423b0ad4d09bfb1d54079da2bcbc473e2313cf1a450be::governance::lending_package_upgrade_cap(arg0), arg1);
    }

    public fun migrate(arg0: &mut 0x3ae667edc4eb7525acc423b0ad4d09bfb1d54079da2bcbc473e2313cf1a450be::governance::DragonBallCollector, arg1: &mut 0xa377cac91d12de361e03940bad7f17ceaaa9dc095ae2c30b284110ef099cb8b6::app::ProtocolApp, arg2: &mut 0x355a656d163883e472da3ed6c4137ddf043c8e5f11ab49a5d7e9ca0cf1023d9e::leverage_app::LeverageApp, arg3: &0x2::tx_context::TxContext) {
        0x3ae667edc4eb7525acc423b0ad4d09bfb1d54079da2bcbc473e2313cf1a450be::governance::ensure_can_summon_shenron(arg0);
        0x3ae667edc4eb7525acc423b0ad4d09bfb1d54079da2bcbc473e2313cf1a450be::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg3));
        migrate_inner(arg0, arg1, arg3);
        0x3ae667edc4eb7525acc423b0ad4d09bfb1d54079da2bcbc473e2313cf1a450be::upgrade_leverage::migrate_inner(arg0, arg2, arg3);
        0x3ae667edc4eb7525acc423b0ad4d09bfb1d54079da2bcbc473e2313cf1a450be::upgrade_self::migrate_inner(arg0, arg3);
    }

    public fun wish_authorize_protocol_upgrade(arg0: &mut 0x3ae667edc4eb7525acc423b0ad4d09bfb1d54079da2bcbc473e2313cf1a450be::governance::DragonBallCollector, arg1: u8, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        0x3ae667edc4eb7525acc423b0ad4d09bfb1d54079da2bcbc473e2313cf1a450be::governance::ensure_functional(arg0);
        0x3ae667edc4eb7525acc423b0ad4d09bfb1d54079da2bcbc473e2313cf1a450be::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg4));
        let v0 = ProtocolUpgradeWish{
            policy : arg1,
            digest : arg2,
        };
        0x3ae667edc4eb7525acc423b0ad4d09bfb1d54079da2bcbc473e2313cf1a450be::wish_event::emit_new_wish_event<ProtocolUpgradeWish>(v0);
        0x3ae667edc4eb7525acc423b0ad4d09bfb1d54079da2bcbc473e2313cf1a450be::governance::store_locked_update<0x3ae667edc4eb7525acc423b0ad4d09bfb1d54079da2bcbc473e2313cf1a450be::time_lock::TimeLock<ProtocolUpgradeWish>>(arg0, 0x1::type_name::with_defining_ids<ProtocolUpgradeWish>(), 0x3ae667edc4eb7525acc423b0ad4d09bfb1d54079da2bcbc473e2313cf1a450be::time_lock::new_time_locked<ProtocolUpgradeWish>(v0, arg3, 0x3ae667edc4eb7525acc423b0ad4d09bfb1d54079da2bcbc473e2313cf1a450be::governance::time_lock_duration_seconds(arg0), 0x3ae667edc4eb7525acc423b0ad4d09bfb1d54079da2bcbc473e2313cf1a450be::governance::time_lock_expriration_seconds(arg0)));
    }

    // decompiled from Move bytecode v6
}

