module 0xa2a32ced2fad3a86200a6f36c879ac77922763a69b9e52e31b0ea38b859a5713::whitelist {
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

    public fun fulfill_burn_whitelist_wish(arg0: &mut 0xa2a32ced2fad3a86200a6f36c879ac77922763a69b9e52e31b0ea38b859a5713::governance::DragonBallCollector, arg1: &mut 0xf619885d1fcaee3a6581881ab740e93ba919078e7cdc8247796b6934a8aeaa74::app::ProtocolApp, arg2: &mut 0x27ef7aa84771904162eb86126b3ead179003f6f26bef7c751c36caae1589a993::leverage_app::LeverageApp, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        0xa2a32ced2fad3a86200a6f36c879ac77922763a69b9e52e31b0ea38b859a5713::governance::ensure_functional(arg0);
        0xa2a32ced2fad3a86200a6f36c879ac77922763a69b9e52e31b0ea38b859a5713::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg4));
        let v0 = 0xa2a32ced2fad3a86200a6f36c879ac77922763a69b9e52e31b0ea38b859a5713::governance::take_locked_update<0xa2a32ced2fad3a86200a6f36c879ac77922763a69b9e52e31b0ea38b859a5713::time_lock::TimeLock<BurnWhitelistWish>>(arg0, 0x1::type_name::with_defining_ids<BurnWhitelistWish>());
        assert!(0xa2a32ced2fad3a86200a6f36c879ac77922763a69b9e52e31b0ea38b859a5713::time_lock::is_active<BurnWhitelistWish>(&v0, arg3), 0xa2a32ced2fad3a86200a6f36c879ac77922763a69b9e52e31b0ea38b859a5713::errors::time_locked_not_active());
        let v1 = 0xa2a32ced2fad3a86200a6f36c879ac77922763a69b9e52e31b0ea38b859a5713::time_lock::into_inner<BurnWhitelistWish>(v0);
        0xa2a32ced2fad3a86200a6f36c879ac77922763a69b9e52e31b0ea38b859a5713::governance::ensure_protocol_app_match(arg1, &v1.protocol_app_id);
        0xa2a32ced2fad3a86200a6f36c879ac77922763a69b9e52e31b0ea38b859a5713::wish_event::emit_fulfill_wish_event<BurnWhitelistWish>(v1);
        0x27ef7aa84771904162eb86126b3ead179003f6f26bef7c751c36caae1589a993::leverage_admin::remove_protocol_caller_cap(0xa2a32ced2fad3a86200a6f36c879ac77922763a69b9e52e31b0ea38b859a5713::governance::lending_admin_cap(arg0), arg1, arg2);
    }

    public fun fulfill_mint_whitelist_wish(arg0: &mut 0xa2a32ced2fad3a86200a6f36c879ac77922763a69b9e52e31b0ea38b859a5713::governance::DragonBallCollector, arg1: &mut 0xf619885d1fcaee3a6581881ab740e93ba919078e7cdc8247796b6934a8aeaa74::app::ProtocolApp, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0xf619885d1fcaee3a6581881ab740e93ba919078e7cdc8247796b6934a8aeaa74::app::PackageCallerCap {
        0xa2a32ced2fad3a86200a6f36c879ac77922763a69b9e52e31b0ea38b859a5713::governance::ensure_functional(arg0);
        0xa2a32ced2fad3a86200a6f36c879ac77922763a69b9e52e31b0ea38b859a5713::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg3));
        let v0 = 0xa2a32ced2fad3a86200a6f36c879ac77922763a69b9e52e31b0ea38b859a5713::governance::take_locked_update<0xa2a32ced2fad3a86200a6f36c879ac77922763a69b9e52e31b0ea38b859a5713::time_lock::TimeLock<MintWhitelistWish>>(arg0, 0x1::type_name::with_defining_ids<MintWhitelistWish>());
        assert!(0xa2a32ced2fad3a86200a6f36c879ac77922763a69b9e52e31b0ea38b859a5713::time_lock::is_active<MintWhitelistWish>(&v0, arg2), 0xa2a32ced2fad3a86200a6f36c879ac77922763a69b9e52e31b0ea38b859a5713::errors::time_locked_not_active());
        let v1 = 0xa2a32ced2fad3a86200a6f36c879ac77922763a69b9e52e31b0ea38b859a5713::time_lock::into_inner<MintWhitelistWish>(v0);
        0xa2a32ced2fad3a86200a6f36c879ac77922763a69b9e52e31b0ea38b859a5713::governance::ensure_protocol_app_match(arg1, &v1.protocol_app_id);
        0xa2a32ced2fad3a86200a6f36c879ac77922763a69b9e52e31b0ea38b859a5713::wish_event::emit_fulfill_wish_event<MintWhitelistWish>(v1);
        0xf619885d1fcaee3a6581881ab740e93ba919078e7cdc8247796b6934a8aeaa74::whitelist_admin::mint_new_whitelist(0xa2a32ced2fad3a86200a6f36c879ac77922763a69b9e52e31b0ea38b859a5713::governance::lending_admin_cap(arg0), arg1, arg3)
    }

    public fun fulfill_remove_whitelist_wish(arg0: &mut 0xa2a32ced2fad3a86200a6f36c879ac77922763a69b9e52e31b0ea38b859a5713::governance::DragonBallCollector, arg1: &mut 0xf619885d1fcaee3a6581881ab740e93ba919078e7cdc8247796b6934a8aeaa74::app::ProtocolApp, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        0xa2a32ced2fad3a86200a6f36c879ac77922763a69b9e52e31b0ea38b859a5713::governance::ensure_functional(arg0);
        0xa2a32ced2fad3a86200a6f36c879ac77922763a69b9e52e31b0ea38b859a5713::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg3));
        let v0 = 0xa2a32ced2fad3a86200a6f36c879ac77922763a69b9e52e31b0ea38b859a5713::governance::take_locked_update<0xa2a32ced2fad3a86200a6f36c879ac77922763a69b9e52e31b0ea38b859a5713::time_lock::TimeLock<RemoveWhitelistWish>>(arg0, 0x1::type_name::with_defining_ids<RemoveWhitelistWish>());
        assert!(0xa2a32ced2fad3a86200a6f36c879ac77922763a69b9e52e31b0ea38b859a5713::time_lock::is_active<RemoveWhitelistWish>(&v0, arg2), 0xa2a32ced2fad3a86200a6f36c879ac77922763a69b9e52e31b0ea38b859a5713::errors::time_locked_not_active());
        let v1 = 0xa2a32ced2fad3a86200a6f36c879ac77922763a69b9e52e31b0ea38b859a5713::time_lock::into_inner<RemoveWhitelistWish>(v0);
        0xa2a32ced2fad3a86200a6f36c879ac77922763a69b9e52e31b0ea38b859a5713::governance::ensure_protocol_app_match(arg1, &v1.protocol_app_id);
        0xa2a32ced2fad3a86200a6f36c879ac77922763a69b9e52e31b0ea38b859a5713::wish_event::emit_fulfill_wish_event<RemoveWhitelistWish>(v1);
        let RemoveWhitelistWish {
            protocol_app_id : _,
            id              : v3,
        } = v1;
        0xf619885d1fcaee3a6581881ab740e93ba919078e7cdc8247796b6934a8aeaa74::whitelist_admin::remove_whitelist(0xa2a32ced2fad3a86200a6f36c879ac77922763a69b9e52e31b0ea38b859a5713::governance::lending_admin_cap(arg0), arg1, v3);
    }

    public fun fulfill_update_whitelist_what_wish(arg0: &mut 0xa2a32ced2fad3a86200a6f36c879ac77922763a69b9e52e31b0ea38b859a5713::governance::DragonBallCollector, arg1: &mut 0xf619885d1fcaee3a6581881ab740e93ba919078e7cdc8247796b6934a8aeaa74::app::ProtocolApp, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        0xa2a32ced2fad3a86200a6f36c879ac77922763a69b9e52e31b0ea38b859a5713::governance::ensure_functional(arg0);
        0xa2a32ced2fad3a86200a6f36c879ac77922763a69b9e52e31b0ea38b859a5713::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg3));
        let v0 = 0xa2a32ced2fad3a86200a6f36c879ac77922763a69b9e52e31b0ea38b859a5713::governance::take_locked_update<0xa2a32ced2fad3a86200a6f36c879ac77922763a69b9e52e31b0ea38b859a5713::time_lock::TimeLock<UpdateWhitelistPermissionWish>>(arg0, 0x1::type_name::with_defining_ids<UpdateWhitelistPermissionWish>());
        assert!(0xa2a32ced2fad3a86200a6f36c879ac77922763a69b9e52e31b0ea38b859a5713::time_lock::is_active<UpdateWhitelistPermissionWish>(&v0, arg2), 0xa2a32ced2fad3a86200a6f36c879ac77922763a69b9e52e31b0ea38b859a5713::errors::time_locked_not_active());
        let v1 = 0xa2a32ced2fad3a86200a6f36c879ac77922763a69b9e52e31b0ea38b859a5713::time_lock::into_inner<UpdateWhitelistPermissionWish>(v0);
        0xa2a32ced2fad3a86200a6f36c879ac77922763a69b9e52e31b0ea38b859a5713::governance::ensure_protocol_app_match(arg1, &v1.protocol_app_id);
        0xa2a32ced2fad3a86200a6f36c879ac77922763a69b9e52e31b0ea38b859a5713::wish_event::emit_fulfill_wish_event<UpdateWhitelistPermissionWish>(v1);
        let UpdateWhitelistPermissionWish {
            protocol_app_id : _,
            id              : v3,
            what            : v4,
            is_grant        : v5,
        } = v1;
        0xf619885d1fcaee3a6581881ab740e93ba919078e7cdc8247796b6934a8aeaa74::whitelist_admin::update_permission(0xa2a32ced2fad3a86200a6f36c879ac77922763a69b9e52e31b0ea38b859a5713::governance::lending_admin_cap(arg0), arg1, v3, v4, v5);
    }

    public fun wish_burn_whitelist(arg0: &mut 0xa2a32ced2fad3a86200a6f36c879ac77922763a69b9e52e31b0ea38b859a5713::governance::DragonBallCollector, arg1: &0xf619885d1fcaee3a6581881ab740e93ba919078e7cdc8247796b6934a8aeaa74::app::ProtocolApp, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        0xa2a32ced2fad3a86200a6f36c879ac77922763a69b9e52e31b0ea38b859a5713::governance::ensure_functional(arg0);
        0xa2a32ced2fad3a86200a6f36c879ac77922763a69b9e52e31b0ea38b859a5713::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg3));
        let v0 = BurnWhitelistWish{protocol_app_id: 0x2::object::id<0xf619885d1fcaee3a6581881ab740e93ba919078e7cdc8247796b6934a8aeaa74::app::ProtocolApp>(arg1)};
        0xa2a32ced2fad3a86200a6f36c879ac77922763a69b9e52e31b0ea38b859a5713::wish_event::emit_new_wish_event<BurnWhitelistWish>(v0);
        0xa2a32ced2fad3a86200a6f36c879ac77922763a69b9e52e31b0ea38b859a5713::governance::store_locked_update<0xa2a32ced2fad3a86200a6f36c879ac77922763a69b9e52e31b0ea38b859a5713::time_lock::TimeLock<BurnWhitelistWish>>(arg0, 0x1::type_name::with_defining_ids<BurnWhitelistWish>(), 0xa2a32ced2fad3a86200a6f36c879ac77922763a69b9e52e31b0ea38b859a5713::time_lock::new_time_locked<BurnWhitelistWish>(v0, arg2, 0xa2a32ced2fad3a86200a6f36c879ac77922763a69b9e52e31b0ea38b859a5713::governance::time_lock_duration_seconds(arg0), 0xa2a32ced2fad3a86200a6f36c879ac77922763a69b9e52e31b0ea38b859a5713::governance::time_lock_expriration_seconds(arg0)));
    }

    public fun wish_mint_whitelist(arg0: &mut 0xa2a32ced2fad3a86200a6f36c879ac77922763a69b9e52e31b0ea38b859a5713::governance::DragonBallCollector, arg1: &0xf619885d1fcaee3a6581881ab740e93ba919078e7cdc8247796b6934a8aeaa74::app::ProtocolApp, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        0xa2a32ced2fad3a86200a6f36c879ac77922763a69b9e52e31b0ea38b859a5713::governance::ensure_functional(arg0);
        0xa2a32ced2fad3a86200a6f36c879ac77922763a69b9e52e31b0ea38b859a5713::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg3));
        let v0 = MintWhitelistWish{protocol_app_id: 0x2::object::id<0xf619885d1fcaee3a6581881ab740e93ba919078e7cdc8247796b6934a8aeaa74::app::ProtocolApp>(arg1)};
        0xa2a32ced2fad3a86200a6f36c879ac77922763a69b9e52e31b0ea38b859a5713::wish_event::emit_new_wish_event<MintWhitelistWish>(v0);
        0xa2a32ced2fad3a86200a6f36c879ac77922763a69b9e52e31b0ea38b859a5713::governance::store_locked_update<0xa2a32ced2fad3a86200a6f36c879ac77922763a69b9e52e31b0ea38b859a5713::time_lock::TimeLock<MintWhitelistWish>>(arg0, 0x1::type_name::with_defining_ids<MintWhitelistWish>(), 0xa2a32ced2fad3a86200a6f36c879ac77922763a69b9e52e31b0ea38b859a5713::time_lock::new_time_locked<MintWhitelistWish>(v0, arg2, 0xa2a32ced2fad3a86200a6f36c879ac77922763a69b9e52e31b0ea38b859a5713::governance::time_lock_duration_seconds(arg0), 0xa2a32ced2fad3a86200a6f36c879ac77922763a69b9e52e31b0ea38b859a5713::governance::time_lock_expriration_seconds(arg0)));
    }

    public fun wish_remove_whitelist(arg0: &mut 0xa2a32ced2fad3a86200a6f36c879ac77922763a69b9e52e31b0ea38b859a5713::governance::DragonBallCollector, arg1: &0xf619885d1fcaee3a6581881ab740e93ba919078e7cdc8247796b6934a8aeaa74::app::ProtocolApp, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        0xa2a32ced2fad3a86200a6f36c879ac77922763a69b9e52e31b0ea38b859a5713::governance::ensure_functional(arg0);
        0xa2a32ced2fad3a86200a6f36c879ac77922763a69b9e52e31b0ea38b859a5713::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg4));
        let v0 = RemoveWhitelistWish{
            protocol_app_id : 0x2::object::id<0xf619885d1fcaee3a6581881ab740e93ba919078e7cdc8247796b6934a8aeaa74::app::ProtocolApp>(arg1),
            id              : arg2,
        };
        0xa2a32ced2fad3a86200a6f36c879ac77922763a69b9e52e31b0ea38b859a5713::wish_event::emit_new_wish_event<RemoveWhitelistWish>(v0);
        0xa2a32ced2fad3a86200a6f36c879ac77922763a69b9e52e31b0ea38b859a5713::governance::store_locked_update<0xa2a32ced2fad3a86200a6f36c879ac77922763a69b9e52e31b0ea38b859a5713::time_lock::TimeLock<RemoveWhitelistWish>>(arg0, 0x1::type_name::with_defining_ids<RemoveWhitelistWish>(), 0xa2a32ced2fad3a86200a6f36c879ac77922763a69b9e52e31b0ea38b859a5713::time_lock::new_time_locked<RemoveWhitelistWish>(v0, arg3, 0xa2a32ced2fad3a86200a6f36c879ac77922763a69b9e52e31b0ea38b859a5713::governance::time_lock_duration_seconds(arg0), 0xa2a32ced2fad3a86200a6f36c879ac77922763a69b9e52e31b0ea38b859a5713::governance::time_lock_expriration_seconds(arg0)));
    }

    public fun wish_update_whitelist_what(arg0: &mut 0xa2a32ced2fad3a86200a6f36c879ac77922763a69b9e52e31b0ea38b859a5713::governance::DragonBallCollector, arg1: &0xf619885d1fcaee3a6581881ab740e93ba919078e7cdc8247796b6934a8aeaa74::app::ProtocolApp, arg2: 0x2::object::ID, arg3: u8, arg4: bool, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        0xa2a32ced2fad3a86200a6f36c879ac77922763a69b9e52e31b0ea38b859a5713::governance::ensure_functional(arg0);
        0xa2a32ced2fad3a86200a6f36c879ac77922763a69b9e52e31b0ea38b859a5713::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg6));
        let v0 = UpdateWhitelistPermissionWish{
            protocol_app_id : 0x2::object::id<0xf619885d1fcaee3a6581881ab740e93ba919078e7cdc8247796b6934a8aeaa74::app::ProtocolApp>(arg1),
            id              : arg2,
            what            : arg3,
            is_grant        : arg4,
        };
        0xa2a32ced2fad3a86200a6f36c879ac77922763a69b9e52e31b0ea38b859a5713::wish_event::emit_new_wish_event<UpdateWhitelistPermissionWish>(v0);
        0xa2a32ced2fad3a86200a6f36c879ac77922763a69b9e52e31b0ea38b859a5713::governance::store_locked_update<0xa2a32ced2fad3a86200a6f36c879ac77922763a69b9e52e31b0ea38b859a5713::time_lock::TimeLock<UpdateWhitelistPermissionWish>>(arg0, 0x1::type_name::with_defining_ids<UpdateWhitelistPermissionWish>(), 0xa2a32ced2fad3a86200a6f36c879ac77922763a69b9e52e31b0ea38b859a5713::time_lock::new_time_locked<UpdateWhitelistPermissionWish>(v0, arg5, 0xa2a32ced2fad3a86200a6f36c879ac77922763a69b9e52e31b0ea38b859a5713::governance::time_lock_duration_seconds(arg0), 0xa2a32ced2fad3a86200a6f36c879ac77922763a69b9e52e31b0ea38b859a5713::governance::time_lock_expriration_seconds(arg0)));
    }

    // decompiled from Move bytecode v6
}

