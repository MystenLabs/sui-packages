module 0x9126eb2628a1ffb1b197bd9bf1d1b9091641d8d11e5d7900b8feb7e6469303ca::whitelist {
    struct MintWhitelistWish has copy, drop, store {
        protocol_app_id: 0x2::object::ID,
    }

    struct BurnWhitelistWish has copy, drop, store {
        protocol_app_id: 0x2::object::ID,
    }

    struct UpdateWhitelistPermissionWish has copy, drop, store {
        protocol_app_id: 0x2::object::ID,
        id: 0x2::object::ID,
        what: u8,
        is_grant: bool,
    }

    struct RemoveWhitelistWish has copy, drop, store {
        protocol_app_id: 0x2::object::ID,
        id: 0x2::object::ID,
    }

    public fun fulfill_burn_whitelist_wish(arg0: &mut 0x9126eb2628a1ffb1b197bd9bf1d1b9091641d8d11e5d7900b8feb7e6469303ca::governance::DragonBallCollector, arg1: &mut 0x4956d9b3e4d709a682bf9b937b660de620e960de6d4d1ea05fff9f644158e041::app::ProtocolApp, arg2: &mut 0x61f31fed814ce72818897dc0d488e16b1065d3dd3c7e36ab63572d7c1a678606::leverage_app::LeverageApp, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        0x9126eb2628a1ffb1b197bd9bf1d1b9091641d8d11e5d7900b8feb7e6469303ca::governance::ensure_functional(arg0);
        0x9126eb2628a1ffb1b197bd9bf1d1b9091641d8d11e5d7900b8feb7e6469303ca::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg4));
        let v0 = 0x9126eb2628a1ffb1b197bd9bf1d1b9091641d8d11e5d7900b8feb7e6469303ca::governance::take_locked_update<0x9126eb2628a1ffb1b197bd9bf1d1b9091641d8d11e5d7900b8feb7e6469303ca::time_lock::TimeLock<BurnWhitelistWish>>(arg0, 0x1::type_name::with_defining_ids<BurnWhitelistWish>());
        assert!(0x9126eb2628a1ffb1b197bd9bf1d1b9091641d8d11e5d7900b8feb7e6469303ca::time_lock::is_active<BurnWhitelistWish>(&v0, arg3), 0x9126eb2628a1ffb1b197bd9bf1d1b9091641d8d11e5d7900b8feb7e6469303ca::errors::time_locked_not_active());
        let v1 = 0x9126eb2628a1ffb1b197bd9bf1d1b9091641d8d11e5d7900b8feb7e6469303ca::time_lock::into_inner<BurnWhitelistWish>(v0);
        0x9126eb2628a1ffb1b197bd9bf1d1b9091641d8d11e5d7900b8feb7e6469303ca::governance::ensure_protocol_app_match(arg1, &v1.protocol_app_id);
        0x9126eb2628a1ffb1b197bd9bf1d1b9091641d8d11e5d7900b8feb7e6469303ca::wish_event::emit_fulfill_wish_event<BurnWhitelistWish>(v1);
        0x61f31fed814ce72818897dc0d488e16b1065d3dd3c7e36ab63572d7c1a678606::leverage_admin::remove_protocol_caller_cap(0x9126eb2628a1ffb1b197bd9bf1d1b9091641d8d11e5d7900b8feb7e6469303ca::governance::lending_admin_cap(arg0), arg1, arg2);
    }

    public fun fulfill_mint_whitelist_wish(arg0: &mut 0x9126eb2628a1ffb1b197bd9bf1d1b9091641d8d11e5d7900b8feb7e6469303ca::governance::DragonBallCollector, arg1: &mut 0x4956d9b3e4d709a682bf9b937b660de620e960de6d4d1ea05fff9f644158e041::app::ProtocolApp, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x4956d9b3e4d709a682bf9b937b660de620e960de6d4d1ea05fff9f644158e041::app::PackageCallerCap {
        0x9126eb2628a1ffb1b197bd9bf1d1b9091641d8d11e5d7900b8feb7e6469303ca::governance::ensure_functional(arg0);
        0x9126eb2628a1ffb1b197bd9bf1d1b9091641d8d11e5d7900b8feb7e6469303ca::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg3));
        let v0 = 0x9126eb2628a1ffb1b197bd9bf1d1b9091641d8d11e5d7900b8feb7e6469303ca::governance::take_locked_update<0x9126eb2628a1ffb1b197bd9bf1d1b9091641d8d11e5d7900b8feb7e6469303ca::time_lock::TimeLock<MintWhitelistWish>>(arg0, 0x1::type_name::with_defining_ids<MintWhitelistWish>());
        assert!(0x9126eb2628a1ffb1b197bd9bf1d1b9091641d8d11e5d7900b8feb7e6469303ca::time_lock::is_active<MintWhitelistWish>(&v0, arg2), 0x9126eb2628a1ffb1b197bd9bf1d1b9091641d8d11e5d7900b8feb7e6469303ca::errors::time_locked_not_active());
        let v1 = 0x9126eb2628a1ffb1b197bd9bf1d1b9091641d8d11e5d7900b8feb7e6469303ca::time_lock::into_inner<MintWhitelistWish>(v0);
        0x9126eb2628a1ffb1b197bd9bf1d1b9091641d8d11e5d7900b8feb7e6469303ca::governance::ensure_protocol_app_match(arg1, &v1.protocol_app_id);
        0x9126eb2628a1ffb1b197bd9bf1d1b9091641d8d11e5d7900b8feb7e6469303ca::wish_event::emit_fulfill_wish_event<MintWhitelistWish>(v1);
        0x4956d9b3e4d709a682bf9b937b660de620e960de6d4d1ea05fff9f644158e041::whitelist_admin::mint_new_whitelist(0x9126eb2628a1ffb1b197bd9bf1d1b9091641d8d11e5d7900b8feb7e6469303ca::governance::lending_admin_cap(arg0), arg1, arg3)
    }

    public fun fulfill_remove_whitelist_wish(arg0: &mut 0x9126eb2628a1ffb1b197bd9bf1d1b9091641d8d11e5d7900b8feb7e6469303ca::governance::DragonBallCollector, arg1: &mut 0x4956d9b3e4d709a682bf9b937b660de620e960de6d4d1ea05fff9f644158e041::app::ProtocolApp, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        0x9126eb2628a1ffb1b197bd9bf1d1b9091641d8d11e5d7900b8feb7e6469303ca::governance::ensure_functional(arg0);
        0x9126eb2628a1ffb1b197bd9bf1d1b9091641d8d11e5d7900b8feb7e6469303ca::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg3));
        let v0 = 0x9126eb2628a1ffb1b197bd9bf1d1b9091641d8d11e5d7900b8feb7e6469303ca::governance::take_locked_update<0x9126eb2628a1ffb1b197bd9bf1d1b9091641d8d11e5d7900b8feb7e6469303ca::time_lock::TimeLock<RemoveWhitelistWish>>(arg0, 0x1::type_name::with_defining_ids<RemoveWhitelistWish>());
        assert!(0x9126eb2628a1ffb1b197bd9bf1d1b9091641d8d11e5d7900b8feb7e6469303ca::time_lock::is_active<RemoveWhitelistWish>(&v0, arg2), 0x9126eb2628a1ffb1b197bd9bf1d1b9091641d8d11e5d7900b8feb7e6469303ca::errors::time_locked_not_active());
        let v1 = 0x9126eb2628a1ffb1b197bd9bf1d1b9091641d8d11e5d7900b8feb7e6469303ca::time_lock::into_inner<RemoveWhitelistWish>(v0);
        0x9126eb2628a1ffb1b197bd9bf1d1b9091641d8d11e5d7900b8feb7e6469303ca::governance::ensure_protocol_app_match(arg1, &v1.protocol_app_id);
        0x9126eb2628a1ffb1b197bd9bf1d1b9091641d8d11e5d7900b8feb7e6469303ca::wish_event::emit_fulfill_wish_event<RemoveWhitelistWish>(v1);
        let RemoveWhitelistWish {
            protocol_app_id : _,
            id              : v3,
        } = v1;
        0x4956d9b3e4d709a682bf9b937b660de620e960de6d4d1ea05fff9f644158e041::whitelist_admin::remove_whitelist(0x9126eb2628a1ffb1b197bd9bf1d1b9091641d8d11e5d7900b8feb7e6469303ca::governance::lending_admin_cap(arg0), arg1, v3);
    }

    public fun fulfill_update_whitelist_what_wish(arg0: &mut 0x9126eb2628a1ffb1b197bd9bf1d1b9091641d8d11e5d7900b8feb7e6469303ca::governance::DragonBallCollector, arg1: &mut 0x4956d9b3e4d709a682bf9b937b660de620e960de6d4d1ea05fff9f644158e041::app::ProtocolApp, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        0x9126eb2628a1ffb1b197bd9bf1d1b9091641d8d11e5d7900b8feb7e6469303ca::governance::ensure_functional(arg0);
        0x9126eb2628a1ffb1b197bd9bf1d1b9091641d8d11e5d7900b8feb7e6469303ca::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg3));
        let v0 = 0x9126eb2628a1ffb1b197bd9bf1d1b9091641d8d11e5d7900b8feb7e6469303ca::governance::take_locked_update<0x9126eb2628a1ffb1b197bd9bf1d1b9091641d8d11e5d7900b8feb7e6469303ca::time_lock::TimeLock<UpdateWhitelistPermissionWish>>(arg0, 0x1::type_name::with_defining_ids<UpdateWhitelistPermissionWish>());
        assert!(0x9126eb2628a1ffb1b197bd9bf1d1b9091641d8d11e5d7900b8feb7e6469303ca::time_lock::is_active<UpdateWhitelistPermissionWish>(&v0, arg2), 0x9126eb2628a1ffb1b197bd9bf1d1b9091641d8d11e5d7900b8feb7e6469303ca::errors::time_locked_not_active());
        let v1 = 0x9126eb2628a1ffb1b197bd9bf1d1b9091641d8d11e5d7900b8feb7e6469303ca::time_lock::into_inner<UpdateWhitelistPermissionWish>(v0);
        0x9126eb2628a1ffb1b197bd9bf1d1b9091641d8d11e5d7900b8feb7e6469303ca::governance::ensure_protocol_app_match(arg1, &v1.protocol_app_id);
        0x9126eb2628a1ffb1b197bd9bf1d1b9091641d8d11e5d7900b8feb7e6469303ca::wish_event::emit_fulfill_wish_event<UpdateWhitelistPermissionWish>(v1);
        let UpdateWhitelistPermissionWish {
            protocol_app_id : _,
            id              : v3,
            what            : v4,
            is_grant        : v5,
        } = v1;
        0x4956d9b3e4d709a682bf9b937b660de620e960de6d4d1ea05fff9f644158e041::whitelist_admin::update_permission(0x9126eb2628a1ffb1b197bd9bf1d1b9091641d8d11e5d7900b8feb7e6469303ca::governance::lending_admin_cap(arg0), arg1, v3, v4, v5);
    }

    public fun wish_burn_whitelist(arg0: &mut 0x9126eb2628a1ffb1b197bd9bf1d1b9091641d8d11e5d7900b8feb7e6469303ca::governance::DragonBallCollector, arg1: &0x4956d9b3e4d709a682bf9b937b660de620e960de6d4d1ea05fff9f644158e041::app::ProtocolApp, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        0x9126eb2628a1ffb1b197bd9bf1d1b9091641d8d11e5d7900b8feb7e6469303ca::governance::ensure_functional(arg0);
        0x9126eb2628a1ffb1b197bd9bf1d1b9091641d8d11e5d7900b8feb7e6469303ca::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg3));
        let v0 = BurnWhitelistWish{protocol_app_id: 0x2::object::id<0x4956d9b3e4d709a682bf9b937b660de620e960de6d4d1ea05fff9f644158e041::app::ProtocolApp>(arg1)};
        0x9126eb2628a1ffb1b197bd9bf1d1b9091641d8d11e5d7900b8feb7e6469303ca::wish_event::emit_new_wish_event<BurnWhitelistWish>(v0);
        0x9126eb2628a1ffb1b197bd9bf1d1b9091641d8d11e5d7900b8feb7e6469303ca::governance::store_locked_update<0x9126eb2628a1ffb1b197bd9bf1d1b9091641d8d11e5d7900b8feb7e6469303ca::time_lock::TimeLock<BurnWhitelistWish>>(arg0, 0x1::type_name::with_defining_ids<BurnWhitelistWish>(), 0x9126eb2628a1ffb1b197bd9bf1d1b9091641d8d11e5d7900b8feb7e6469303ca::time_lock::new_time_locked<BurnWhitelistWish>(v0, arg2, 0x9126eb2628a1ffb1b197bd9bf1d1b9091641d8d11e5d7900b8feb7e6469303ca::governance::time_lock_duration_seconds(arg0), 0x9126eb2628a1ffb1b197bd9bf1d1b9091641d8d11e5d7900b8feb7e6469303ca::governance::time_lock_expriration_seconds(arg0)));
    }

    public fun wish_mint_whitelist(arg0: &mut 0x9126eb2628a1ffb1b197bd9bf1d1b9091641d8d11e5d7900b8feb7e6469303ca::governance::DragonBallCollector, arg1: &0x4956d9b3e4d709a682bf9b937b660de620e960de6d4d1ea05fff9f644158e041::app::ProtocolApp, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        0x9126eb2628a1ffb1b197bd9bf1d1b9091641d8d11e5d7900b8feb7e6469303ca::governance::ensure_functional(arg0);
        0x9126eb2628a1ffb1b197bd9bf1d1b9091641d8d11e5d7900b8feb7e6469303ca::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg3));
        let v0 = MintWhitelistWish{protocol_app_id: 0x2::object::id<0x4956d9b3e4d709a682bf9b937b660de620e960de6d4d1ea05fff9f644158e041::app::ProtocolApp>(arg1)};
        0x9126eb2628a1ffb1b197bd9bf1d1b9091641d8d11e5d7900b8feb7e6469303ca::wish_event::emit_new_wish_event<MintWhitelistWish>(v0);
        0x9126eb2628a1ffb1b197bd9bf1d1b9091641d8d11e5d7900b8feb7e6469303ca::governance::store_locked_update<0x9126eb2628a1ffb1b197bd9bf1d1b9091641d8d11e5d7900b8feb7e6469303ca::time_lock::TimeLock<MintWhitelistWish>>(arg0, 0x1::type_name::with_defining_ids<MintWhitelistWish>(), 0x9126eb2628a1ffb1b197bd9bf1d1b9091641d8d11e5d7900b8feb7e6469303ca::time_lock::new_time_locked<MintWhitelistWish>(v0, arg2, 0x9126eb2628a1ffb1b197bd9bf1d1b9091641d8d11e5d7900b8feb7e6469303ca::governance::time_lock_duration_seconds(arg0), 0x9126eb2628a1ffb1b197bd9bf1d1b9091641d8d11e5d7900b8feb7e6469303ca::governance::time_lock_expriration_seconds(arg0)));
    }

    public fun wish_remove_whitelist(arg0: &mut 0x9126eb2628a1ffb1b197bd9bf1d1b9091641d8d11e5d7900b8feb7e6469303ca::governance::DragonBallCollector, arg1: &0x4956d9b3e4d709a682bf9b937b660de620e960de6d4d1ea05fff9f644158e041::app::ProtocolApp, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        0x9126eb2628a1ffb1b197bd9bf1d1b9091641d8d11e5d7900b8feb7e6469303ca::governance::ensure_functional(arg0);
        0x9126eb2628a1ffb1b197bd9bf1d1b9091641d8d11e5d7900b8feb7e6469303ca::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg4));
        let v0 = RemoveWhitelistWish{
            protocol_app_id : 0x2::object::id<0x4956d9b3e4d709a682bf9b937b660de620e960de6d4d1ea05fff9f644158e041::app::ProtocolApp>(arg1),
            id              : arg2,
        };
        0x9126eb2628a1ffb1b197bd9bf1d1b9091641d8d11e5d7900b8feb7e6469303ca::wish_event::emit_new_wish_event<RemoveWhitelistWish>(v0);
        0x9126eb2628a1ffb1b197bd9bf1d1b9091641d8d11e5d7900b8feb7e6469303ca::governance::store_locked_update<0x9126eb2628a1ffb1b197bd9bf1d1b9091641d8d11e5d7900b8feb7e6469303ca::time_lock::TimeLock<RemoveWhitelistWish>>(arg0, 0x1::type_name::with_defining_ids<RemoveWhitelistWish>(), 0x9126eb2628a1ffb1b197bd9bf1d1b9091641d8d11e5d7900b8feb7e6469303ca::time_lock::new_time_locked<RemoveWhitelistWish>(v0, arg3, 0x9126eb2628a1ffb1b197bd9bf1d1b9091641d8d11e5d7900b8feb7e6469303ca::governance::time_lock_duration_seconds(arg0), 0x9126eb2628a1ffb1b197bd9bf1d1b9091641d8d11e5d7900b8feb7e6469303ca::governance::time_lock_expriration_seconds(arg0)));
    }

    public fun wish_update_whitelist_what(arg0: &mut 0x9126eb2628a1ffb1b197bd9bf1d1b9091641d8d11e5d7900b8feb7e6469303ca::governance::DragonBallCollector, arg1: &0x4956d9b3e4d709a682bf9b937b660de620e960de6d4d1ea05fff9f644158e041::app::ProtocolApp, arg2: 0x2::object::ID, arg3: u8, arg4: bool, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        0x9126eb2628a1ffb1b197bd9bf1d1b9091641d8d11e5d7900b8feb7e6469303ca::governance::ensure_functional(arg0);
        0x9126eb2628a1ffb1b197bd9bf1d1b9091641d8d11e5d7900b8feb7e6469303ca::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg6));
        let v0 = UpdateWhitelistPermissionWish{
            protocol_app_id : 0x2::object::id<0x4956d9b3e4d709a682bf9b937b660de620e960de6d4d1ea05fff9f644158e041::app::ProtocolApp>(arg1),
            id              : arg2,
            what            : arg3,
            is_grant        : arg4,
        };
        0x9126eb2628a1ffb1b197bd9bf1d1b9091641d8d11e5d7900b8feb7e6469303ca::wish_event::emit_new_wish_event<UpdateWhitelistPermissionWish>(v0);
        0x9126eb2628a1ffb1b197bd9bf1d1b9091641d8d11e5d7900b8feb7e6469303ca::governance::store_locked_update<0x9126eb2628a1ffb1b197bd9bf1d1b9091641d8d11e5d7900b8feb7e6469303ca::time_lock::TimeLock<UpdateWhitelistPermissionWish>>(arg0, 0x1::type_name::with_defining_ids<UpdateWhitelistPermissionWish>(), 0x9126eb2628a1ffb1b197bd9bf1d1b9091641d8d11e5d7900b8feb7e6469303ca::time_lock::new_time_locked<UpdateWhitelistPermissionWish>(v0, arg5, 0x9126eb2628a1ffb1b197bd9bf1d1b9091641d8d11e5d7900b8feb7e6469303ca::governance::time_lock_duration_seconds(arg0), 0x9126eb2628a1ffb1b197bd9bf1d1b9091641d8d11e5d7900b8feb7e6469303ca::governance::time_lock_expriration_seconds(arg0)));
    }

    // decompiled from Move bytecode v6
}

