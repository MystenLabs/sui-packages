module 0xa1c44228c0a5193c95846bcaf59169457dbe1240a1611f4ea7dc1e9334469b36::whitelist {
    struct MintWhitelistWish has copy, drop, store {
        dummy_field: bool,
    }

    struct BurnWhitelistWish has copy, drop, store {
        dummy_field: bool,
    }

    struct UpdateWhitelistPermissionWish has copy, drop, store {
        id: 0x2::object::ID,
        what: u8,
        is_grant: bool,
    }

    struct RemoveWhitelistWish has copy, drop, store {
        id: 0x2::object::ID,
    }

    public fun fulfill_burn_whitelist_wish(arg0: &mut 0xa1c44228c0a5193c95846bcaf59169457dbe1240a1611f4ea7dc1e9334469b36::governance::DragonBallCollector, arg1: &mut 0xfc0dcc82b17da1d09366263e5ad0c28cdffd2f5cee8b5366e48fabaeba50a146::app::ProtocolApp, arg2: &mut 0xe6be8c2642a55b69322dbc1c23fc83177d96cdc2c97b4af5753a6cdc2f188285::leverage_app::LeverageApp, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xa1c44228c0a5193c95846bcaf59169457dbe1240a1611f4ea7dc1e9334469b36::governance::ensure_can_summon_shenron(arg0);
        0xa1c44228c0a5193c95846bcaf59169457dbe1240a1611f4ea7dc1e9334469b36::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg4));
        let v0 = 0xa1c44228c0a5193c95846bcaf59169457dbe1240a1611f4ea7dc1e9334469b36::governance::take_locked_update<0xa1c44228c0a5193c95846bcaf59169457dbe1240a1611f4ea7dc1e9334469b36::time_lock::TimeLock<BurnWhitelistWish>>(arg0, 0x1::type_name::with_defining_ids<BurnWhitelistWish>());
        assert!(0xa1c44228c0a5193c95846bcaf59169457dbe1240a1611f4ea7dc1e9334469b36::time_lock::is_active<BurnWhitelistWish>(&v0, arg3), 0xa1c44228c0a5193c95846bcaf59169457dbe1240a1611f4ea7dc1e9334469b36::errors::time_locked_not_active());
        0xa1c44228c0a5193c95846bcaf59169457dbe1240a1611f4ea7dc1e9334469b36::wish_event::emit_fulfill_wish_event<BurnWhitelistWish>(0xa1c44228c0a5193c95846bcaf59169457dbe1240a1611f4ea7dc1e9334469b36::time_lock::into_inner<BurnWhitelistWish>(v0));
        0xe6be8c2642a55b69322dbc1c23fc83177d96cdc2c97b4af5753a6cdc2f188285::leverage_admin::remove_protocol_caller_cap(0xa1c44228c0a5193c95846bcaf59169457dbe1240a1611f4ea7dc1e9334469b36::governance::lending_admin_cap(arg0), arg1, arg2);
    }

    public fun fulfill_mint_whitelist_wish(arg0: &mut 0xa1c44228c0a5193c95846bcaf59169457dbe1240a1611f4ea7dc1e9334469b36::governance::DragonBallCollector, arg1: &mut 0xfc0dcc82b17da1d09366263e5ad0c28cdffd2f5cee8b5366e48fabaeba50a146::app::ProtocolApp, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0xfc0dcc82b17da1d09366263e5ad0c28cdffd2f5cee8b5366e48fabaeba50a146::app::PackageCallerCap {
        0xa1c44228c0a5193c95846bcaf59169457dbe1240a1611f4ea7dc1e9334469b36::governance::ensure_can_summon_shenron(arg0);
        0xa1c44228c0a5193c95846bcaf59169457dbe1240a1611f4ea7dc1e9334469b36::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg3));
        let v0 = 0xa1c44228c0a5193c95846bcaf59169457dbe1240a1611f4ea7dc1e9334469b36::governance::take_locked_update<0xa1c44228c0a5193c95846bcaf59169457dbe1240a1611f4ea7dc1e9334469b36::time_lock::TimeLock<MintWhitelistWish>>(arg0, 0x1::type_name::with_defining_ids<MintWhitelistWish>());
        assert!(0xa1c44228c0a5193c95846bcaf59169457dbe1240a1611f4ea7dc1e9334469b36::time_lock::is_active<MintWhitelistWish>(&v0, arg2), 0xa1c44228c0a5193c95846bcaf59169457dbe1240a1611f4ea7dc1e9334469b36::errors::time_locked_not_active());
        0xa1c44228c0a5193c95846bcaf59169457dbe1240a1611f4ea7dc1e9334469b36::wish_event::emit_fulfill_wish_event<MintWhitelistWish>(0xa1c44228c0a5193c95846bcaf59169457dbe1240a1611f4ea7dc1e9334469b36::time_lock::into_inner<MintWhitelistWish>(v0));
        0xfc0dcc82b17da1d09366263e5ad0c28cdffd2f5cee8b5366e48fabaeba50a146::whitelist_admin::mint_new_whitelist(0xa1c44228c0a5193c95846bcaf59169457dbe1240a1611f4ea7dc1e9334469b36::governance::lending_admin_cap(arg0), arg1, arg3)
    }

    public fun fulfill_remove_whitelist_wish(arg0: &mut 0xa1c44228c0a5193c95846bcaf59169457dbe1240a1611f4ea7dc1e9334469b36::governance::DragonBallCollector, arg1: &mut 0xfc0dcc82b17da1d09366263e5ad0c28cdffd2f5cee8b5366e48fabaeba50a146::app::ProtocolApp, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0xa1c44228c0a5193c95846bcaf59169457dbe1240a1611f4ea7dc1e9334469b36::governance::ensure_can_summon_shenron(arg0);
        0xa1c44228c0a5193c95846bcaf59169457dbe1240a1611f4ea7dc1e9334469b36::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg3));
        let v0 = 0xa1c44228c0a5193c95846bcaf59169457dbe1240a1611f4ea7dc1e9334469b36::governance::take_locked_update<0xa1c44228c0a5193c95846bcaf59169457dbe1240a1611f4ea7dc1e9334469b36::time_lock::TimeLock<RemoveWhitelistWish>>(arg0, 0x1::type_name::with_defining_ids<RemoveWhitelistWish>());
        assert!(0xa1c44228c0a5193c95846bcaf59169457dbe1240a1611f4ea7dc1e9334469b36::time_lock::is_active<RemoveWhitelistWish>(&v0, arg2), 0xa1c44228c0a5193c95846bcaf59169457dbe1240a1611f4ea7dc1e9334469b36::errors::time_locked_not_active());
        let v1 = 0xa1c44228c0a5193c95846bcaf59169457dbe1240a1611f4ea7dc1e9334469b36::time_lock::into_inner<RemoveWhitelistWish>(v0);
        0xa1c44228c0a5193c95846bcaf59169457dbe1240a1611f4ea7dc1e9334469b36::wish_event::emit_fulfill_wish_event<RemoveWhitelistWish>(v1);
        let RemoveWhitelistWish { id: v2 } = v1;
        0xfc0dcc82b17da1d09366263e5ad0c28cdffd2f5cee8b5366e48fabaeba50a146::whitelist_admin::remove_whitelist(0xa1c44228c0a5193c95846bcaf59169457dbe1240a1611f4ea7dc1e9334469b36::governance::lending_admin_cap(arg0), arg1, v2);
    }

    public fun fulfill_update_whitelist_what_wish(arg0: &mut 0xa1c44228c0a5193c95846bcaf59169457dbe1240a1611f4ea7dc1e9334469b36::governance::DragonBallCollector, arg1: &mut 0xfc0dcc82b17da1d09366263e5ad0c28cdffd2f5cee8b5366e48fabaeba50a146::app::ProtocolApp, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0xa1c44228c0a5193c95846bcaf59169457dbe1240a1611f4ea7dc1e9334469b36::governance::ensure_can_summon_shenron(arg0);
        0xa1c44228c0a5193c95846bcaf59169457dbe1240a1611f4ea7dc1e9334469b36::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg3));
        let v0 = 0xa1c44228c0a5193c95846bcaf59169457dbe1240a1611f4ea7dc1e9334469b36::governance::take_locked_update<0xa1c44228c0a5193c95846bcaf59169457dbe1240a1611f4ea7dc1e9334469b36::time_lock::TimeLock<UpdateWhitelistPermissionWish>>(arg0, 0x1::type_name::with_defining_ids<UpdateWhitelistPermissionWish>());
        assert!(0xa1c44228c0a5193c95846bcaf59169457dbe1240a1611f4ea7dc1e9334469b36::time_lock::is_active<UpdateWhitelistPermissionWish>(&v0, arg2), 0xa1c44228c0a5193c95846bcaf59169457dbe1240a1611f4ea7dc1e9334469b36::errors::time_locked_not_active());
        let v1 = 0xa1c44228c0a5193c95846bcaf59169457dbe1240a1611f4ea7dc1e9334469b36::time_lock::into_inner<UpdateWhitelistPermissionWish>(v0);
        0xa1c44228c0a5193c95846bcaf59169457dbe1240a1611f4ea7dc1e9334469b36::wish_event::emit_fulfill_wish_event<UpdateWhitelistPermissionWish>(v1);
        let UpdateWhitelistPermissionWish {
            id       : v2,
            what     : v3,
            is_grant : v4,
        } = v1;
        0xfc0dcc82b17da1d09366263e5ad0c28cdffd2f5cee8b5366e48fabaeba50a146::whitelist_admin::update_permission(0xa1c44228c0a5193c95846bcaf59169457dbe1240a1611f4ea7dc1e9334469b36::governance::lending_admin_cap(arg0), arg1, v2, v3, v4);
    }

    public fun inject_to_leverage_app(arg0: &mut 0xa1c44228c0a5193c95846bcaf59169457dbe1240a1611f4ea7dc1e9334469b36::governance::DragonBallCollector, arg1: 0xfc0dcc82b17da1d09366263e5ad0c28cdffd2f5cee8b5366e48fabaeba50a146::app::PackageCallerCap, arg2: &mut 0xe6be8c2642a55b69322dbc1c23fc83177d96cdc2c97b4af5753a6cdc2f188285::leverage_app::LeverageApp, arg3: &mut 0x2::tx_context::TxContext) {
        0xa1c44228c0a5193c95846bcaf59169457dbe1240a1611f4ea7dc1e9334469b36::governance::ensure_can_summon_shenron(arg0);
        0xa1c44228c0a5193c95846bcaf59169457dbe1240a1611f4ea7dc1e9334469b36::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg3));
        0xe6be8c2642a55b69322dbc1c23fc83177d96cdc2c97b4af5753a6cdc2f188285::leverage_admin::inject_protocol_caller_cap(0xa1c44228c0a5193c95846bcaf59169457dbe1240a1611f4ea7dc1e9334469b36::governance::lending_admin_cap(arg0), arg2, arg1);
    }

    public fun wish_burn_whitelist(arg0: &mut 0xa1c44228c0a5193c95846bcaf59169457dbe1240a1611f4ea7dc1e9334469b36::governance::DragonBallCollector, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        0xa1c44228c0a5193c95846bcaf59169457dbe1240a1611f4ea7dc1e9334469b36::governance::ensure_can_summon_shenron(arg0);
        0xa1c44228c0a5193c95846bcaf59169457dbe1240a1611f4ea7dc1e9334469b36::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg2));
        let v0 = BurnWhitelistWish{dummy_field: false};
        0xa1c44228c0a5193c95846bcaf59169457dbe1240a1611f4ea7dc1e9334469b36::wish_event::emit_new_wish_event<BurnWhitelistWish>(v0);
        0xa1c44228c0a5193c95846bcaf59169457dbe1240a1611f4ea7dc1e9334469b36::governance::store_locked_update<0xa1c44228c0a5193c95846bcaf59169457dbe1240a1611f4ea7dc1e9334469b36::time_lock::TimeLock<BurnWhitelistWish>>(arg0, 0x1::type_name::with_defining_ids<BurnWhitelistWish>(), 0xa1c44228c0a5193c95846bcaf59169457dbe1240a1611f4ea7dc1e9334469b36::time_lock::new_time_locked<BurnWhitelistWish>(v0, arg1, 0xa1c44228c0a5193c95846bcaf59169457dbe1240a1611f4ea7dc1e9334469b36::governance::time_lock_duration_seconds(arg0), 0xa1c44228c0a5193c95846bcaf59169457dbe1240a1611f4ea7dc1e9334469b36::governance::time_lock_expriration_seconds(arg0)));
    }

    public fun wish_mint_whitelist(arg0: &mut 0xa1c44228c0a5193c95846bcaf59169457dbe1240a1611f4ea7dc1e9334469b36::governance::DragonBallCollector, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        0xa1c44228c0a5193c95846bcaf59169457dbe1240a1611f4ea7dc1e9334469b36::governance::ensure_can_summon_shenron(arg0);
        0xa1c44228c0a5193c95846bcaf59169457dbe1240a1611f4ea7dc1e9334469b36::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg2));
        let v0 = MintWhitelistWish{dummy_field: false};
        0xa1c44228c0a5193c95846bcaf59169457dbe1240a1611f4ea7dc1e9334469b36::wish_event::emit_new_wish_event<MintWhitelistWish>(v0);
        0xa1c44228c0a5193c95846bcaf59169457dbe1240a1611f4ea7dc1e9334469b36::governance::store_locked_update<0xa1c44228c0a5193c95846bcaf59169457dbe1240a1611f4ea7dc1e9334469b36::time_lock::TimeLock<MintWhitelistWish>>(arg0, 0x1::type_name::with_defining_ids<MintWhitelistWish>(), 0xa1c44228c0a5193c95846bcaf59169457dbe1240a1611f4ea7dc1e9334469b36::time_lock::new_time_locked<MintWhitelistWish>(v0, arg1, 0xa1c44228c0a5193c95846bcaf59169457dbe1240a1611f4ea7dc1e9334469b36::governance::time_lock_duration_seconds(arg0), 0xa1c44228c0a5193c95846bcaf59169457dbe1240a1611f4ea7dc1e9334469b36::governance::time_lock_expriration_seconds(arg0)));
    }

    public fun wish_remove_whitelist(arg0: &mut 0xa1c44228c0a5193c95846bcaf59169457dbe1240a1611f4ea7dc1e9334469b36::governance::DragonBallCollector, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0xa1c44228c0a5193c95846bcaf59169457dbe1240a1611f4ea7dc1e9334469b36::governance::ensure_can_summon_shenron(arg0);
        0xa1c44228c0a5193c95846bcaf59169457dbe1240a1611f4ea7dc1e9334469b36::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg3));
        let v0 = RemoveWhitelistWish{id: arg1};
        0xa1c44228c0a5193c95846bcaf59169457dbe1240a1611f4ea7dc1e9334469b36::wish_event::emit_new_wish_event<RemoveWhitelistWish>(v0);
        0xa1c44228c0a5193c95846bcaf59169457dbe1240a1611f4ea7dc1e9334469b36::governance::store_locked_update<0xa1c44228c0a5193c95846bcaf59169457dbe1240a1611f4ea7dc1e9334469b36::time_lock::TimeLock<RemoveWhitelistWish>>(arg0, 0x1::type_name::with_defining_ids<RemoveWhitelistWish>(), 0xa1c44228c0a5193c95846bcaf59169457dbe1240a1611f4ea7dc1e9334469b36::time_lock::new_time_locked<RemoveWhitelistWish>(v0, arg2, 0xa1c44228c0a5193c95846bcaf59169457dbe1240a1611f4ea7dc1e9334469b36::governance::time_lock_duration_seconds(arg0), 0xa1c44228c0a5193c95846bcaf59169457dbe1240a1611f4ea7dc1e9334469b36::governance::time_lock_expriration_seconds(arg0)));
    }

    public fun wish_update_whitelist_what(arg0: &mut 0xa1c44228c0a5193c95846bcaf59169457dbe1240a1611f4ea7dc1e9334469b36::governance::DragonBallCollector, arg1: 0x2::object::ID, arg2: u8, arg3: bool, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xa1c44228c0a5193c95846bcaf59169457dbe1240a1611f4ea7dc1e9334469b36::governance::ensure_can_summon_shenron(arg0);
        0xa1c44228c0a5193c95846bcaf59169457dbe1240a1611f4ea7dc1e9334469b36::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg5));
        let v0 = UpdateWhitelistPermissionWish{
            id       : arg1,
            what     : arg2,
            is_grant : arg3,
        };
        0xa1c44228c0a5193c95846bcaf59169457dbe1240a1611f4ea7dc1e9334469b36::wish_event::emit_new_wish_event<UpdateWhitelistPermissionWish>(v0);
        0xa1c44228c0a5193c95846bcaf59169457dbe1240a1611f4ea7dc1e9334469b36::governance::store_locked_update<0xa1c44228c0a5193c95846bcaf59169457dbe1240a1611f4ea7dc1e9334469b36::time_lock::TimeLock<UpdateWhitelistPermissionWish>>(arg0, 0x1::type_name::with_defining_ids<UpdateWhitelistPermissionWish>(), 0xa1c44228c0a5193c95846bcaf59169457dbe1240a1611f4ea7dc1e9334469b36::time_lock::new_time_locked<UpdateWhitelistPermissionWish>(v0, arg4, 0xa1c44228c0a5193c95846bcaf59169457dbe1240a1611f4ea7dc1e9334469b36::governance::time_lock_duration_seconds(arg0), 0xa1c44228c0a5193c95846bcaf59169457dbe1240a1611f4ea7dc1e9334469b36::governance::time_lock_expriration_seconds(arg0)));
    }

    // decompiled from Move bytecode v6
}

