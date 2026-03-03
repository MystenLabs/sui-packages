module 0xfa5531cf5650e5027b507eb9a678f028b8bf16b80535f86399bc6b6a82d9109::whitelist {
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

    public fun fulfill_burn_whitelist_wish(arg0: &mut 0xfa5531cf5650e5027b507eb9a678f028b8bf16b80535f86399bc6b6a82d9109::governance::DragonBallCollector, arg1: &mut 0x936023cfa3fe5b9ae6dd8b4acead70e3c1e0b9f2693e7b073980f34bdc74644b::app::ProtocolApp, arg2: &mut 0xae62107ac6d3865863a5b6949dcf1c52ba12ba99e7086a16dcf1ab659144bc69::leverage_app::LeverageApp, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        0xfa5531cf5650e5027b507eb9a678f028b8bf16b80535f86399bc6b6a82d9109::governance::ensure_functional(arg0);
        0xfa5531cf5650e5027b507eb9a678f028b8bf16b80535f86399bc6b6a82d9109::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg4));
        let v0 = 0xfa5531cf5650e5027b507eb9a678f028b8bf16b80535f86399bc6b6a82d9109::governance::take_locked_update<0xfa5531cf5650e5027b507eb9a678f028b8bf16b80535f86399bc6b6a82d9109::time_lock::TimeLock<BurnWhitelistWish>>(arg0, 0x1::type_name::with_defining_ids<BurnWhitelistWish>());
        assert!(0xfa5531cf5650e5027b507eb9a678f028b8bf16b80535f86399bc6b6a82d9109::time_lock::is_active<BurnWhitelistWish>(&v0, arg3), 0xfa5531cf5650e5027b507eb9a678f028b8bf16b80535f86399bc6b6a82d9109::errors::time_locked_not_active());
        let v1 = 0xfa5531cf5650e5027b507eb9a678f028b8bf16b80535f86399bc6b6a82d9109::time_lock::into_inner<BurnWhitelistWish>(v0);
        0xfa5531cf5650e5027b507eb9a678f028b8bf16b80535f86399bc6b6a82d9109::governance::ensure_protocol_app_match(arg1, &v1.protocol_app_id);
        0xfa5531cf5650e5027b507eb9a678f028b8bf16b80535f86399bc6b6a82d9109::wish_event::emit_fulfill_wish_event<BurnWhitelistWish>(v1);
        0xae62107ac6d3865863a5b6949dcf1c52ba12ba99e7086a16dcf1ab659144bc69::leverage_admin::remove_protocol_caller_cap(0xfa5531cf5650e5027b507eb9a678f028b8bf16b80535f86399bc6b6a82d9109::governance::lending_admin_cap(arg0), arg1, arg2);
    }

    public fun fulfill_mint_whitelist_wish(arg0: &mut 0xfa5531cf5650e5027b507eb9a678f028b8bf16b80535f86399bc6b6a82d9109::governance::DragonBallCollector, arg1: &mut 0x936023cfa3fe5b9ae6dd8b4acead70e3c1e0b9f2693e7b073980f34bdc74644b::app::ProtocolApp, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x936023cfa3fe5b9ae6dd8b4acead70e3c1e0b9f2693e7b073980f34bdc74644b::app::PackageCallerCap {
        0xfa5531cf5650e5027b507eb9a678f028b8bf16b80535f86399bc6b6a82d9109::governance::ensure_functional(arg0);
        0xfa5531cf5650e5027b507eb9a678f028b8bf16b80535f86399bc6b6a82d9109::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg3));
        let v0 = 0xfa5531cf5650e5027b507eb9a678f028b8bf16b80535f86399bc6b6a82d9109::governance::take_locked_update<0xfa5531cf5650e5027b507eb9a678f028b8bf16b80535f86399bc6b6a82d9109::time_lock::TimeLock<MintWhitelistWish>>(arg0, 0x1::type_name::with_defining_ids<MintWhitelistWish>());
        assert!(0xfa5531cf5650e5027b507eb9a678f028b8bf16b80535f86399bc6b6a82d9109::time_lock::is_active<MintWhitelistWish>(&v0, arg2), 0xfa5531cf5650e5027b507eb9a678f028b8bf16b80535f86399bc6b6a82d9109::errors::time_locked_not_active());
        let v1 = 0xfa5531cf5650e5027b507eb9a678f028b8bf16b80535f86399bc6b6a82d9109::time_lock::into_inner<MintWhitelistWish>(v0);
        0xfa5531cf5650e5027b507eb9a678f028b8bf16b80535f86399bc6b6a82d9109::governance::ensure_protocol_app_match(arg1, &v1.protocol_app_id);
        0xfa5531cf5650e5027b507eb9a678f028b8bf16b80535f86399bc6b6a82d9109::wish_event::emit_fulfill_wish_event<MintWhitelistWish>(v1);
        0x936023cfa3fe5b9ae6dd8b4acead70e3c1e0b9f2693e7b073980f34bdc74644b::whitelist_admin::mint_new_whitelist(0xfa5531cf5650e5027b507eb9a678f028b8bf16b80535f86399bc6b6a82d9109::governance::lending_admin_cap(arg0), arg1, arg3)
    }

    public fun fulfill_remove_whitelist_wish(arg0: &mut 0xfa5531cf5650e5027b507eb9a678f028b8bf16b80535f86399bc6b6a82d9109::governance::DragonBallCollector, arg1: &mut 0x936023cfa3fe5b9ae6dd8b4acead70e3c1e0b9f2693e7b073980f34bdc74644b::app::ProtocolApp, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        0xfa5531cf5650e5027b507eb9a678f028b8bf16b80535f86399bc6b6a82d9109::governance::ensure_functional(arg0);
        0xfa5531cf5650e5027b507eb9a678f028b8bf16b80535f86399bc6b6a82d9109::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg3));
        let v0 = 0xfa5531cf5650e5027b507eb9a678f028b8bf16b80535f86399bc6b6a82d9109::governance::take_locked_update<0xfa5531cf5650e5027b507eb9a678f028b8bf16b80535f86399bc6b6a82d9109::time_lock::TimeLock<RemoveWhitelistWish>>(arg0, 0x1::type_name::with_defining_ids<RemoveWhitelistWish>());
        assert!(0xfa5531cf5650e5027b507eb9a678f028b8bf16b80535f86399bc6b6a82d9109::time_lock::is_active<RemoveWhitelistWish>(&v0, arg2), 0xfa5531cf5650e5027b507eb9a678f028b8bf16b80535f86399bc6b6a82d9109::errors::time_locked_not_active());
        let v1 = 0xfa5531cf5650e5027b507eb9a678f028b8bf16b80535f86399bc6b6a82d9109::time_lock::into_inner<RemoveWhitelistWish>(v0);
        0xfa5531cf5650e5027b507eb9a678f028b8bf16b80535f86399bc6b6a82d9109::wish_event::emit_fulfill_wish_event<RemoveWhitelistWish>(v1);
        let RemoveWhitelistWish {
            protocol_app_id : _,
            id              : v3,
        } = v1;
        0x936023cfa3fe5b9ae6dd8b4acead70e3c1e0b9f2693e7b073980f34bdc74644b::whitelist_admin::remove_whitelist(0xfa5531cf5650e5027b507eb9a678f028b8bf16b80535f86399bc6b6a82d9109::governance::lending_admin_cap(arg0), arg1, v3);
    }

    public fun fulfill_update_whitelist_what_wish(arg0: &mut 0xfa5531cf5650e5027b507eb9a678f028b8bf16b80535f86399bc6b6a82d9109::governance::DragonBallCollector, arg1: &mut 0x936023cfa3fe5b9ae6dd8b4acead70e3c1e0b9f2693e7b073980f34bdc74644b::app::ProtocolApp, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        0xfa5531cf5650e5027b507eb9a678f028b8bf16b80535f86399bc6b6a82d9109::governance::ensure_functional(arg0);
        0xfa5531cf5650e5027b507eb9a678f028b8bf16b80535f86399bc6b6a82d9109::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg3));
        let v0 = 0xfa5531cf5650e5027b507eb9a678f028b8bf16b80535f86399bc6b6a82d9109::governance::take_locked_update<0xfa5531cf5650e5027b507eb9a678f028b8bf16b80535f86399bc6b6a82d9109::time_lock::TimeLock<UpdateWhitelistPermissionWish>>(arg0, 0x1::type_name::with_defining_ids<UpdateWhitelistPermissionWish>());
        assert!(0xfa5531cf5650e5027b507eb9a678f028b8bf16b80535f86399bc6b6a82d9109::time_lock::is_active<UpdateWhitelistPermissionWish>(&v0, arg2), 0xfa5531cf5650e5027b507eb9a678f028b8bf16b80535f86399bc6b6a82d9109::errors::time_locked_not_active());
        let v1 = 0xfa5531cf5650e5027b507eb9a678f028b8bf16b80535f86399bc6b6a82d9109::time_lock::into_inner<UpdateWhitelistPermissionWish>(v0);
        0xfa5531cf5650e5027b507eb9a678f028b8bf16b80535f86399bc6b6a82d9109::governance::ensure_protocol_app_match(arg1, &v1.protocol_app_id);
        0xfa5531cf5650e5027b507eb9a678f028b8bf16b80535f86399bc6b6a82d9109::wish_event::emit_fulfill_wish_event<UpdateWhitelistPermissionWish>(v1);
        let UpdateWhitelistPermissionWish {
            protocol_app_id : _,
            id              : v3,
            what            : v4,
            is_grant        : v5,
        } = v1;
        0x936023cfa3fe5b9ae6dd8b4acead70e3c1e0b9f2693e7b073980f34bdc74644b::whitelist_admin::update_permission(0xfa5531cf5650e5027b507eb9a678f028b8bf16b80535f86399bc6b6a82d9109::governance::lending_admin_cap(arg0), arg1, v3, v4, v5);
    }

    public fun wish_burn_whitelist(arg0: &mut 0xfa5531cf5650e5027b507eb9a678f028b8bf16b80535f86399bc6b6a82d9109::governance::DragonBallCollector, arg1: &0x936023cfa3fe5b9ae6dd8b4acead70e3c1e0b9f2693e7b073980f34bdc74644b::app::ProtocolApp, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        0xfa5531cf5650e5027b507eb9a678f028b8bf16b80535f86399bc6b6a82d9109::governance::ensure_functional(arg0);
        0xfa5531cf5650e5027b507eb9a678f028b8bf16b80535f86399bc6b6a82d9109::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg3));
        let v0 = BurnWhitelistWish{protocol_app_id: 0x2::object::id<0x936023cfa3fe5b9ae6dd8b4acead70e3c1e0b9f2693e7b073980f34bdc74644b::app::ProtocolApp>(arg1)};
        0xfa5531cf5650e5027b507eb9a678f028b8bf16b80535f86399bc6b6a82d9109::wish_event::emit_new_wish_event<BurnWhitelistWish>(v0);
        0xfa5531cf5650e5027b507eb9a678f028b8bf16b80535f86399bc6b6a82d9109::governance::store_locked_update<0xfa5531cf5650e5027b507eb9a678f028b8bf16b80535f86399bc6b6a82d9109::time_lock::TimeLock<BurnWhitelistWish>>(arg0, 0x1::type_name::with_defining_ids<BurnWhitelistWish>(), 0xfa5531cf5650e5027b507eb9a678f028b8bf16b80535f86399bc6b6a82d9109::time_lock::new_time_locked<BurnWhitelistWish>(v0, arg2, 0xfa5531cf5650e5027b507eb9a678f028b8bf16b80535f86399bc6b6a82d9109::governance::time_lock_duration_seconds(arg0), 0xfa5531cf5650e5027b507eb9a678f028b8bf16b80535f86399bc6b6a82d9109::governance::time_lock_expriration_seconds(arg0)));
    }

    public fun wish_mint_whitelist(arg0: &mut 0xfa5531cf5650e5027b507eb9a678f028b8bf16b80535f86399bc6b6a82d9109::governance::DragonBallCollector, arg1: &0x936023cfa3fe5b9ae6dd8b4acead70e3c1e0b9f2693e7b073980f34bdc74644b::app::ProtocolApp, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        0xfa5531cf5650e5027b507eb9a678f028b8bf16b80535f86399bc6b6a82d9109::governance::ensure_functional(arg0);
        0xfa5531cf5650e5027b507eb9a678f028b8bf16b80535f86399bc6b6a82d9109::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg3));
        let v0 = MintWhitelistWish{protocol_app_id: 0x2::object::id<0x936023cfa3fe5b9ae6dd8b4acead70e3c1e0b9f2693e7b073980f34bdc74644b::app::ProtocolApp>(arg1)};
        0xfa5531cf5650e5027b507eb9a678f028b8bf16b80535f86399bc6b6a82d9109::wish_event::emit_new_wish_event<MintWhitelistWish>(v0);
        0xfa5531cf5650e5027b507eb9a678f028b8bf16b80535f86399bc6b6a82d9109::governance::store_locked_update<0xfa5531cf5650e5027b507eb9a678f028b8bf16b80535f86399bc6b6a82d9109::time_lock::TimeLock<MintWhitelistWish>>(arg0, 0x1::type_name::with_defining_ids<MintWhitelistWish>(), 0xfa5531cf5650e5027b507eb9a678f028b8bf16b80535f86399bc6b6a82d9109::time_lock::new_time_locked<MintWhitelistWish>(v0, arg2, 0xfa5531cf5650e5027b507eb9a678f028b8bf16b80535f86399bc6b6a82d9109::governance::time_lock_duration_seconds(arg0), 0xfa5531cf5650e5027b507eb9a678f028b8bf16b80535f86399bc6b6a82d9109::governance::time_lock_expriration_seconds(arg0)));
    }

    public fun wish_remove_whitelist(arg0: &mut 0xfa5531cf5650e5027b507eb9a678f028b8bf16b80535f86399bc6b6a82d9109::governance::DragonBallCollector, arg1: &0x936023cfa3fe5b9ae6dd8b4acead70e3c1e0b9f2693e7b073980f34bdc74644b::app::ProtocolApp, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        0xfa5531cf5650e5027b507eb9a678f028b8bf16b80535f86399bc6b6a82d9109::governance::ensure_functional(arg0);
        0xfa5531cf5650e5027b507eb9a678f028b8bf16b80535f86399bc6b6a82d9109::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg4));
        let v0 = RemoveWhitelistWish{
            protocol_app_id : 0x2::object::id<0x936023cfa3fe5b9ae6dd8b4acead70e3c1e0b9f2693e7b073980f34bdc74644b::app::ProtocolApp>(arg1),
            id              : arg2,
        };
        0xfa5531cf5650e5027b507eb9a678f028b8bf16b80535f86399bc6b6a82d9109::wish_event::emit_new_wish_event<RemoveWhitelistWish>(v0);
        0xfa5531cf5650e5027b507eb9a678f028b8bf16b80535f86399bc6b6a82d9109::governance::store_locked_update<0xfa5531cf5650e5027b507eb9a678f028b8bf16b80535f86399bc6b6a82d9109::time_lock::TimeLock<RemoveWhitelistWish>>(arg0, 0x1::type_name::with_defining_ids<RemoveWhitelistWish>(), 0xfa5531cf5650e5027b507eb9a678f028b8bf16b80535f86399bc6b6a82d9109::time_lock::new_time_locked<RemoveWhitelistWish>(v0, arg3, 0xfa5531cf5650e5027b507eb9a678f028b8bf16b80535f86399bc6b6a82d9109::governance::time_lock_duration_seconds(arg0), 0xfa5531cf5650e5027b507eb9a678f028b8bf16b80535f86399bc6b6a82d9109::governance::time_lock_expriration_seconds(arg0)));
    }

    public fun wish_update_whitelist_what(arg0: &mut 0xfa5531cf5650e5027b507eb9a678f028b8bf16b80535f86399bc6b6a82d9109::governance::DragonBallCollector, arg1: &0x936023cfa3fe5b9ae6dd8b4acead70e3c1e0b9f2693e7b073980f34bdc74644b::app::ProtocolApp, arg2: 0x2::object::ID, arg3: u8, arg4: bool, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        0xfa5531cf5650e5027b507eb9a678f028b8bf16b80535f86399bc6b6a82d9109::governance::ensure_functional(arg0);
        0xfa5531cf5650e5027b507eb9a678f028b8bf16b80535f86399bc6b6a82d9109::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg6));
        let v0 = UpdateWhitelistPermissionWish{
            protocol_app_id : 0x2::object::id<0x936023cfa3fe5b9ae6dd8b4acead70e3c1e0b9f2693e7b073980f34bdc74644b::app::ProtocolApp>(arg1),
            id              : arg2,
            what            : arg3,
            is_grant        : arg4,
        };
        0xfa5531cf5650e5027b507eb9a678f028b8bf16b80535f86399bc6b6a82d9109::wish_event::emit_new_wish_event<UpdateWhitelistPermissionWish>(v0);
        0xfa5531cf5650e5027b507eb9a678f028b8bf16b80535f86399bc6b6a82d9109::governance::store_locked_update<0xfa5531cf5650e5027b507eb9a678f028b8bf16b80535f86399bc6b6a82d9109::time_lock::TimeLock<UpdateWhitelistPermissionWish>>(arg0, 0x1::type_name::with_defining_ids<UpdateWhitelistPermissionWish>(), 0xfa5531cf5650e5027b507eb9a678f028b8bf16b80535f86399bc6b6a82d9109::time_lock::new_time_locked<UpdateWhitelistPermissionWish>(v0, arg5, 0xfa5531cf5650e5027b507eb9a678f028b8bf16b80535f86399bc6b6a82d9109::governance::time_lock_duration_seconds(arg0), 0xfa5531cf5650e5027b507eb9a678f028b8bf16b80535f86399bc6b6a82d9109::governance::time_lock_expriration_seconds(arg0)));
    }

    // decompiled from Move bytecode v6
}

