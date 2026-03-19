module 0x25848c8912fcc5031b8966c87706e335ea06ff64b3117508b54ed5bde9528a25::upgrade_protocol {
    struct ProtocolUpgradeWish has copy, drop, store {
        policy: u8,
        digest: vector<u8>,
        super_admin_approved: bool,
    }

    public(friend) fun migrate_inner(arg0: &0x25848c8912fcc5031b8966c87706e335ea06ff64b3117508b54ed5bde9528a25::governance::DragonBallCollector, arg1: &mut 0x9c5d5dbf497d8eab6b06bb64445b7c7e3c7f0483ae451c2cf83028c9b382473a::app::ProtocolApp, arg2: &0x2::tx_context::TxContext) {
        0x25848c8912fcc5031b8966c87706e335ea06ff64b3117508b54ed5bde9528a25::wish_event::emit_object_migrated(1, 0x9c5d5dbf497d8eab6b06bb64445b7c7e3c7f0483ae451c2cf83028c9b382473a::version_admin::migrate(0x25848c8912fcc5031b8966c87706e335ea06ff64b3117508b54ed5bde9528a25::governance::lending_admin_cap(arg0), arg1), 0x2::tx_context::sender(arg2));
    }

    public fun authorize_protocol_upgrade(arg0: &mut 0x25848c8912fcc5031b8966c87706e335ea06ff64b3117508b54ed5bde9528a25::governance::DragonBallCollector, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : 0x2::package::UpgradeTicket {
        0x25848c8912fcc5031b8966c87706e335ea06ff64b3117508b54ed5bde9528a25::governance::ensure_functional(arg0);
        0x25848c8912fcc5031b8966c87706e335ea06ff64b3117508b54ed5bde9528a25::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg2));
        let v0 = 0x25848c8912fcc5031b8966c87706e335ea06ff64b3117508b54ed5bde9528a25::governance::take_locked_update<0x25848c8912fcc5031b8966c87706e335ea06ff64b3117508b54ed5bde9528a25::time_lock::TimeLock<ProtocolUpgradeWish>>(arg0, 0x1::type_name::with_defining_ids<ProtocolUpgradeWish>());
        assert!(0x25848c8912fcc5031b8966c87706e335ea06ff64b3117508b54ed5bde9528a25::time_lock::is_active<ProtocolUpgradeWish>(&v0, arg1), 0x25848c8912fcc5031b8966c87706e335ea06ff64b3117508b54ed5bde9528a25::errors::time_locked_not_active());
        let v1 = 0x25848c8912fcc5031b8966c87706e335ea06ff64b3117508b54ed5bde9528a25::time_lock::into_inner<ProtocolUpgradeWish>(v0);
        0x25848c8912fcc5031b8966c87706e335ea06ff64b3117508b54ed5bde9528a25::wish_event::emit_fulfill_wish_event<ProtocolUpgradeWish>(v1);
        let ProtocolUpgradeWish {
            policy               : v2,
            digest               : v3,
            super_admin_approved : v4,
        } = v1;
        assert!(v4, 0x25848c8912fcc5031b8966c87706e335ea06ff64b3117508b54ed5bde9528a25::errors::super_admin_not_approved());
        0x2::package::authorize_upgrade(0x25848c8912fcc5031b8966c87706e335ea06ff64b3117508b54ed5bde9528a25::governance::lending_package_upgrade_cap(arg0), v2, v3)
    }

    public fun commit_protocol_upgrade(arg0: &mut 0x25848c8912fcc5031b8966c87706e335ea06ff64b3117508b54ed5bde9528a25::governance::DragonBallCollector, arg1: 0x2::package::UpgradeReceipt, arg2: &0x2::tx_context::TxContext) {
        0x25848c8912fcc5031b8966c87706e335ea06ff64b3117508b54ed5bde9528a25::governance::ensure_functional(arg0);
        0x25848c8912fcc5031b8966c87706e335ea06ff64b3117508b54ed5bde9528a25::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg2));
        0x2::package::commit_upgrade(0x25848c8912fcc5031b8966c87706e335ea06ff64b3117508b54ed5bde9528a25::governance::lending_package_upgrade_cap(arg0), arg1);
    }

    public fun migrate(arg0: &mut 0x25848c8912fcc5031b8966c87706e335ea06ff64b3117508b54ed5bde9528a25::governance::DragonBallCollector, arg1: &mut 0x9c5d5dbf497d8eab6b06bb64445b7c7e3c7f0483ae451c2cf83028c9b382473a::app::ProtocolApp, arg2: &mut 0x1bf36f9a965d27fab136dea05d43c04d676500238c2789951941b3cc14d95f32::leverage_app::LeverageApp, arg3: &0x2::tx_context::TxContext) {
        0x25848c8912fcc5031b8966c87706e335ea06ff64b3117508b54ed5bde9528a25::governance::ensure_can_summon_shenron(arg0);
        0x25848c8912fcc5031b8966c87706e335ea06ff64b3117508b54ed5bde9528a25::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg3));
        migrate_inner(arg0, arg1, arg3);
        0x25848c8912fcc5031b8966c87706e335ea06ff64b3117508b54ed5bde9528a25::upgrade_leverage::migrate_inner(arg0, arg2, arg3);
        0x25848c8912fcc5031b8966c87706e335ea06ff64b3117508b54ed5bde9528a25::upgrade_self::migrate_inner(arg0, arg3);
    }

    public fun update_upgrade_approval(arg0: &0x25848c8912fcc5031b8966c87706e335ea06ff64b3117508b54ed5bde9528a25::roles::SuperAdminRole, arg1: &mut 0x25848c8912fcc5031b8966c87706e335ea06ff64b3117508b54ed5bde9528a25::governance::DragonBallCollector, arg2: bool, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        0x25848c8912fcc5031b8966c87706e335ea06ff64b3117508b54ed5bde9528a25::governance::ensure_functional(arg1);
        let v0 = 0x25848c8912fcc5031b8966c87706e335ea06ff64b3117508b54ed5bde9528a25::governance::brrow_mut_wish<0x25848c8912fcc5031b8966c87706e335ea06ff64b3117508b54ed5bde9528a25::time_lock::TimeLock<ProtocolUpgradeWish>>(arg1, 0x1::type_name::with_defining_ids<ProtocolUpgradeWish>());
        assert!(!0x25848c8912fcc5031b8966c87706e335ea06ff64b3117508b54ed5bde9528a25::time_lock::is_expired<ProtocolUpgradeWish>(v0, arg3), 0x25848c8912fcc5031b8966c87706e335ea06ff64b3117508b54ed5bde9528a25::errors::time_locked_expired());
        0x25848c8912fcc5031b8966c87706e335ea06ff64b3117508b54ed5bde9528a25::time_lock::inner_mut<ProtocolUpgradeWish>(v0).super_admin_approved = arg2;
        0x25848c8912fcc5031b8966c87706e335ea06ff64b3117508b54ed5bde9528a25::wish_event::emit_upgrade_approval_changed(1, arg2, 0x2::tx_context::sender(arg4));
    }

    public fun wish_authorize_protocol_upgrade(arg0: &mut 0x25848c8912fcc5031b8966c87706e335ea06ff64b3117508b54ed5bde9528a25::governance::DragonBallCollector, arg1: u8, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        0x25848c8912fcc5031b8966c87706e335ea06ff64b3117508b54ed5bde9528a25::governance::ensure_can_summon_shenron(arg0);
        0x25848c8912fcc5031b8966c87706e335ea06ff64b3117508b54ed5bde9528a25::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg4));
        let v0 = ProtocolUpgradeWish{
            policy               : arg1,
            digest               : arg2,
            super_admin_approved : false,
        };
        0x25848c8912fcc5031b8966c87706e335ea06ff64b3117508b54ed5bde9528a25::wish_event::emit_new_wish_event<ProtocolUpgradeWish>(v0);
        0x25848c8912fcc5031b8966c87706e335ea06ff64b3117508b54ed5bde9528a25::governance::store_locked_update<0x25848c8912fcc5031b8966c87706e335ea06ff64b3117508b54ed5bde9528a25::time_lock::TimeLock<ProtocolUpgradeWish>>(arg0, 0x1::type_name::with_defining_ids<ProtocolUpgradeWish>(), 0x25848c8912fcc5031b8966c87706e335ea06ff64b3117508b54ed5bde9528a25::time_lock::new_time_locked<ProtocolUpgradeWish>(v0, arg3, 0x25848c8912fcc5031b8966c87706e335ea06ff64b3117508b54ed5bde9528a25::governance::time_lock_duration_seconds(arg0), 0x25848c8912fcc5031b8966c87706e335ea06ff64b3117508b54ed5bde9528a25::governance::time_lock_expriration_seconds(arg0)));
    }

    // decompiled from Move bytecode v6
}

