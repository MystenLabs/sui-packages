module 0xc8c50afd079e0e000be2a84ef5079fb01ab9e84da27b2c259badcf846d75465c::whitelist {
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

    public fun fulfill_burn_whitelist_wish(arg0: &mut 0xc8c50afd079e0e000be2a84ef5079fb01ab9e84da27b2c259badcf846d75465c::governance::DragonBallCollector, arg1: &mut 0xb0cb7d234cca8c3554767ce007d7e1e54424db6db8fb24e992da7336a830904::app::ProtocolApp, arg2: &mut 0xb24d2c9ae39a07cabfeaa8afa89fc99b87486ee329ae3d99816bcdd2c5c6351d::leverage_app::LeverageApp, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xc8c50afd079e0e000be2a84ef5079fb01ab9e84da27b2c259badcf846d75465c::governance::ensure_can_summon_shenron(arg0);
        0xc8c50afd079e0e000be2a84ef5079fb01ab9e84da27b2c259badcf846d75465c::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg4));
        let v0 = 0xc8c50afd079e0e000be2a84ef5079fb01ab9e84da27b2c259badcf846d75465c::governance::take_locked_update<0xc8c50afd079e0e000be2a84ef5079fb01ab9e84da27b2c259badcf846d75465c::time_lock::TimeLock<BurnWhitelistWish>>(arg0, 0x1::type_name::with_defining_ids<BurnWhitelistWish>());
        assert!(0xc8c50afd079e0e000be2a84ef5079fb01ab9e84da27b2c259badcf846d75465c::time_lock::is_active<BurnWhitelistWish>(&v0, arg3), 0xc8c50afd079e0e000be2a84ef5079fb01ab9e84da27b2c259badcf846d75465c::errors::time_locked_not_active());
        0xc8c50afd079e0e000be2a84ef5079fb01ab9e84da27b2c259badcf846d75465c::wish_event::emit_fulfill_wish_event<BurnWhitelistWish>(0xc8c50afd079e0e000be2a84ef5079fb01ab9e84da27b2c259badcf846d75465c::time_lock::into_inner<BurnWhitelistWish>(v0));
        0xb24d2c9ae39a07cabfeaa8afa89fc99b87486ee329ae3d99816bcdd2c5c6351d::leverage_admin::remove_protocol_caller_cap(0xc8c50afd079e0e000be2a84ef5079fb01ab9e84da27b2c259badcf846d75465c::governance::lending_admin_cap(arg0), arg1, arg2);
    }

    public fun fulfill_mint_whitelist_wish(arg0: &mut 0xc8c50afd079e0e000be2a84ef5079fb01ab9e84da27b2c259badcf846d75465c::governance::DragonBallCollector, arg1: &mut 0xb0cb7d234cca8c3554767ce007d7e1e54424db6db8fb24e992da7336a830904::app::ProtocolApp, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0xb0cb7d234cca8c3554767ce007d7e1e54424db6db8fb24e992da7336a830904::app::PackageCallerCap {
        0xc8c50afd079e0e000be2a84ef5079fb01ab9e84da27b2c259badcf846d75465c::governance::ensure_can_summon_shenron(arg0);
        0xc8c50afd079e0e000be2a84ef5079fb01ab9e84da27b2c259badcf846d75465c::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg3));
        let v0 = 0xc8c50afd079e0e000be2a84ef5079fb01ab9e84da27b2c259badcf846d75465c::governance::take_locked_update<0xc8c50afd079e0e000be2a84ef5079fb01ab9e84da27b2c259badcf846d75465c::time_lock::TimeLock<MintWhitelistWish>>(arg0, 0x1::type_name::with_defining_ids<MintWhitelistWish>());
        assert!(0xc8c50afd079e0e000be2a84ef5079fb01ab9e84da27b2c259badcf846d75465c::time_lock::is_active<MintWhitelistWish>(&v0, arg2), 0xc8c50afd079e0e000be2a84ef5079fb01ab9e84da27b2c259badcf846d75465c::errors::time_locked_not_active());
        0xc8c50afd079e0e000be2a84ef5079fb01ab9e84da27b2c259badcf846d75465c::wish_event::emit_fulfill_wish_event<MintWhitelistWish>(0xc8c50afd079e0e000be2a84ef5079fb01ab9e84da27b2c259badcf846d75465c::time_lock::into_inner<MintWhitelistWish>(v0));
        0xb0cb7d234cca8c3554767ce007d7e1e54424db6db8fb24e992da7336a830904::whitelist_admin::mint_new_whitelist(0xc8c50afd079e0e000be2a84ef5079fb01ab9e84da27b2c259badcf846d75465c::governance::lending_admin_cap(arg0), arg1, arg3)
    }

    public fun fulfill_remove_whitelist_wish(arg0: &mut 0xc8c50afd079e0e000be2a84ef5079fb01ab9e84da27b2c259badcf846d75465c::governance::DragonBallCollector, arg1: &mut 0xb0cb7d234cca8c3554767ce007d7e1e54424db6db8fb24e992da7336a830904::app::ProtocolApp, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0xc8c50afd079e0e000be2a84ef5079fb01ab9e84da27b2c259badcf846d75465c::governance::ensure_can_summon_shenron(arg0);
        0xc8c50afd079e0e000be2a84ef5079fb01ab9e84da27b2c259badcf846d75465c::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg3));
        let v0 = 0xc8c50afd079e0e000be2a84ef5079fb01ab9e84da27b2c259badcf846d75465c::governance::take_locked_update<0xc8c50afd079e0e000be2a84ef5079fb01ab9e84da27b2c259badcf846d75465c::time_lock::TimeLock<RemoveWhitelistWish>>(arg0, 0x1::type_name::with_defining_ids<RemoveWhitelistWish>());
        assert!(0xc8c50afd079e0e000be2a84ef5079fb01ab9e84da27b2c259badcf846d75465c::time_lock::is_active<RemoveWhitelistWish>(&v0, arg2), 0xc8c50afd079e0e000be2a84ef5079fb01ab9e84da27b2c259badcf846d75465c::errors::time_locked_not_active());
        let v1 = 0xc8c50afd079e0e000be2a84ef5079fb01ab9e84da27b2c259badcf846d75465c::time_lock::into_inner<RemoveWhitelistWish>(v0);
        0xc8c50afd079e0e000be2a84ef5079fb01ab9e84da27b2c259badcf846d75465c::wish_event::emit_fulfill_wish_event<RemoveWhitelistWish>(v1);
        let RemoveWhitelistWish { id: v2 } = v1;
        0xb0cb7d234cca8c3554767ce007d7e1e54424db6db8fb24e992da7336a830904::whitelist_admin::remove_whitelist(0xc8c50afd079e0e000be2a84ef5079fb01ab9e84da27b2c259badcf846d75465c::governance::lending_admin_cap(arg0), arg1, v2);
    }

    public fun fulfill_update_whitelist_what_wish(arg0: &mut 0xc8c50afd079e0e000be2a84ef5079fb01ab9e84da27b2c259badcf846d75465c::governance::DragonBallCollector, arg1: &mut 0xb0cb7d234cca8c3554767ce007d7e1e54424db6db8fb24e992da7336a830904::app::ProtocolApp, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0xc8c50afd079e0e000be2a84ef5079fb01ab9e84da27b2c259badcf846d75465c::governance::ensure_can_summon_shenron(arg0);
        0xc8c50afd079e0e000be2a84ef5079fb01ab9e84da27b2c259badcf846d75465c::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg3));
        let v0 = 0xc8c50afd079e0e000be2a84ef5079fb01ab9e84da27b2c259badcf846d75465c::governance::take_locked_update<0xc8c50afd079e0e000be2a84ef5079fb01ab9e84da27b2c259badcf846d75465c::time_lock::TimeLock<UpdateWhitelistPermissionWish>>(arg0, 0x1::type_name::with_defining_ids<UpdateWhitelistPermissionWish>());
        assert!(0xc8c50afd079e0e000be2a84ef5079fb01ab9e84da27b2c259badcf846d75465c::time_lock::is_active<UpdateWhitelistPermissionWish>(&v0, arg2), 0xc8c50afd079e0e000be2a84ef5079fb01ab9e84da27b2c259badcf846d75465c::errors::time_locked_not_active());
        let v1 = 0xc8c50afd079e0e000be2a84ef5079fb01ab9e84da27b2c259badcf846d75465c::time_lock::into_inner<UpdateWhitelistPermissionWish>(v0);
        0xc8c50afd079e0e000be2a84ef5079fb01ab9e84da27b2c259badcf846d75465c::wish_event::emit_fulfill_wish_event<UpdateWhitelistPermissionWish>(v1);
        let UpdateWhitelistPermissionWish {
            id       : v2,
            what     : v3,
            is_grant : v4,
        } = v1;
        0xb0cb7d234cca8c3554767ce007d7e1e54424db6db8fb24e992da7336a830904::whitelist_admin::update_permission(0xc8c50afd079e0e000be2a84ef5079fb01ab9e84da27b2c259badcf846d75465c::governance::lending_admin_cap(arg0), arg1, v2, v3, v4);
    }

    public fun inject_to_leverage_app(arg0: &mut 0xc8c50afd079e0e000be2a84ef5079fb01ab9e84da27b2c259badcf846d75465c::governance::DragonBallCollector, arg1: 0xb0cb7d234cca8c3554767ce007d7e1e54424db6db8fb24e992da7336a830904::app::PackageCallerCap, arg2: &mut 0xb24d2c9ae39a07cabfeaa8afa89fc99b87486ee329ae3d99816bcdd2c5c6351d::leverage_app::LeverageApp, arg3: &mut 0x2::tx_context::TxContext) {
        0xc8c50afd079e0e000be2a84ef5079fb01ab9e84da27b2c259badcf846d75465c::governance::ensure_can_summon_shenron(arg0);
        0xc8c50afd079e0e000be2a84ef5079fb01ab9e84da27b2c259badcf846d75465c::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg3));
        0xb24d2c9ae39a07cabfeaa8afa89fc99b87486ee329ae3d99816bcdd2c5c6351d::leverage_admin::inject_protocol_caller_cap(0xc8c50afd079e0e000be2a84ef5079fb01ab9e84da27b2c259badcf846d75465c::governance::lending_admin_cap(arg0), arg2, arg1);
    }

    public fun wish_burn_whitelist(arg0: &mut 0xc8c50afd079e0e000be2a84ef5079fb01ab9e84da27b2c259badcf846d75465c::governance::DragonBallCollector, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        0xc8c50afd079e0e000be2a84ef5079fb01ab9e84da27b2c259badcf846d75465c::governance::ensure_can_summon_shenron(arg0);
        0xc8c50afd079e0e000be2a84ef5079fb01ab9e84da27b2c259badcf846d75465c::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg2));
        let v0 = BurnWhitelistWish{dummy_field: false};
        0xc8c50afd079e0e000be2a84ef5079fb01ab9e84da27b2c259badcf846d75465c::wish_event::emit_new_wish_event<BurnWhitelistWish>(v0);
        0xc8c50afd079e0e000be2a84ef5079fb01ab9e84da27b2c259badcf846d75465c::governance::store_locked_update<0xc8c50afd079e0e000be2a84ef5079fb01ab9e84da27b2c259badcf846d75465c::time_lock::TimeLock<BurnWhitelistWish>>(arg0, 0x1::type_name::with_defining_ids<BurnWhitelistWish>(), 0xc8c50afd079e0e000be2a84ef5079fb01ab9e84da27b2c259badcf846d75465c::time_lock::new_time_locked<BurnWhitelistWish>(v0, arg1, 0xc8c50afd079e0e000be2a84ef5079fb01ab9e84da27b2c259badcf846d75465c::governance::time_lock_duration_seconds(arg0), 0xc8c50afd079e0e000be2a84ef5079fb01ab9e84da27b2c259badcf846d75465c::governance::time_lock_expriration_seconds(arg0)));
    }

    public fun wish_mint_whitelist(arg0: &mut 0xc8c50afd079e0e000be2a84ef5079fb01ab9e84da27b2c259badcf846d75465c::governance::DragonBallCollector, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        0xc8c50afd079e0e000be2a84ef5079fb01ab9e84da27b2c259badcf846d75465c::governance::ensure_can_summon_shenron(arg0);
        0xc8c50afd079e0e000be2a84ef5079fb01ab9e84da27b2c259badcf846d75465c::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg2));
        let v0 = MintWhitelistWish{dummy_field: false};
        0xc8c50afd079e0e000be2a84ef5079fb01ab9e84da27b2c259badcf846d75465c::wish_event::emit_new_wish_event<MintWhitelistWish>(v0);
        0xc8c50afd079e0e000be2a84ef5079fb01ab9e84da27b2c259badcf846d75465c::governance::store_locked_update<0xc8c50afd079e0e000be2a84ef5079fb01ab9e84da27b2c259badcf846d75465c::time_lock::TimeLock<MintWhitelistWish>>(arg0, 0x1::type_name::with_defining_ids<MintWhitelistWish>(), 0xc8c50afd079e0e000be2a84ef5079fb01ab9e84da27b2c259badcf846d75465c::time_lock::new_time_locked<MintWhitelistWish>(v0, arg1, 0xc8c50afd079e0e000be2a84ef5079fb01ab9e84da27b2c259badcf846d75465c::governance::time_lock_duration_seconds(arg0), 0xc8c50afd079e0e000be2a84ef5079fb01ab9e84da27b2c259badcf846d75465c::governance::time_lock_expriration_seconds(arg0)));
    }

    public fun wish_remove_whitelist(arg0: &mut 0xc8c50afd079e0e000be2a84ef5079fb01ab9e84da27b2c259badcf846d75465c::governance::DragonBallCollector, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0xc8c50afd079e0e000be2a84ef5079fb01ab9e84da27b2c259badcf846d75465c::governance::ensure_can_summon_shenron(arg0);
        0xc8c50afd079e0e000be2a84ef5079fb01ab9e84da27b2c259badcf846d75465c::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg3));
        let v0 = RemoveWhitelistWish{id: arg1};
        0xc8c50afd079e0e000be2a84ef5079fb01ab9e84da27b2c259badcf846d75465c::wish_event::emit_new_wish_event<RemoveWhitelistWish>(v0);
        0xc8c50afd079e0e000be2a84ef5079fb01ab9e84da27b2c259badcf846d75465c::governance::store_locked_update<0xc8c50afd079e0e000be2a84ef5079fb01ab9e84da27b2c259badcf846d75465c::time_lock::TimeLock<RemoveWhitelistWish>>(arg0, 0x1::type_name::with_defining_ids<RemoveWhitelistWish>(), 0xc8c50afd079e0e000be2a84ef5079fb01ab9e84da27b2c259badcf846d75465c::time_lock::new_time_locked<RemoveWhitelistWish>(v0, arg2, 0xc8c50afd079e0e000be2a84ef5079fb01ab9e84da27b2c259badcf846d75465c::governance::time_lock_duration_seconds(arg0), 0xc8c50afd079e0e000be2a84ef5079fb01ab9e84da27b2c259badcf846d75465c::governance::time_lock_expriration_seconds(arg0)));
    }

    public fun wish_update_whitelist_what(arg0: &mut 0xc8c50afd079e0e000be2a84ef5079fb01ab9e84da27b2c259badcf846d75465c::governance::DragonBallCollector, arg1: 0x2::object::ID, arg2: u8, arg3: bool, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xc8c50afd079e0e000be2a84ef5079fb01ab9e84da27b2c259badcf846d75465c::governance::ensure_can_summon_shenron(arg0);
        0xc8c50afd079e0e000be2a84ef5079fb01ab9e84da27b2c259badcf846d75465c::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg5));
        let v0 = UpdateWhitelistPermissionWish{
            id       : arg1,
            what     : arg2,
            is_grant : arg3,
        };
        0xc8c50afd079e0e000be2a84ef5079fb01ab9e84da27b2c259badcf846d75465c::wish_event::emit_new_wish_event<UpdateWhitelistPermissionWish>(v0);
        0xc8c50afd079e0e000be2a84ef5079fb01ab9e84da27b2c259badcf846d75465c::governance::store_locked_update<0xc8c50afd079e0e000be2a84ef5079fb01ab9e84da27b2c259badcf846d75465c::time_lock::TimeLock<UpdateWhitelistPermissionWish>>(arg0, 0x1::type_name::with_defining_ids<UpdateWhitelistPermissionWish>(), 0xc8c50afd079e0e000be2a84ef5079fb01ab9e84da27b2c259badcf846d75465c::time_lock::new_time_locked<UpdateWhitelistPermissionWish>(v0, arg4, 0xc8c50afd079e0e000be2a84ef5079fb01ab9e84da27b2c259badcf846d75465c::governance::time_lock_duration_seconds(arg0), 0xc8c50afd079e0e000be2a84ef5079fb01ab9e84da27b2c259badcf846d75465c::governance::time_lock_expriration_seconds(arg0)));
    }

    // decompiled from Move bytecode v6
}

