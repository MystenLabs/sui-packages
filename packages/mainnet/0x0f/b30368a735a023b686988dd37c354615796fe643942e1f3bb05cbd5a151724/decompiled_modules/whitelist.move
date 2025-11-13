module 0xfb30368a735a023b686988dd37c354615796fe643942e1f3bb05cbd5a151724::whitelist {
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

    public fun fulfill_burn_whitelist_wish(arg0: &mut 0xfb30368a735a023b686988dd37c354615796fe643942e1f3bb05cbd5a151724::governance::DragonBallCollector, arg1: &mut 0x5ba8b0d04af44f1270412cac98ab288e60fcfc449f3bfefbf4db953d32908866::app::ProtocolApp, arg2: &mut 0x2c11c14fe07381e97c5b4033b7c85c21cb7ae30a4c35a91a64685a4728d85f90::leverage_app::LeverageApp, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xfb30368a735a023b686988dd37c354615796fe643942e1f3bb05cbd5a151724::governance::ensure_can_summon_shenron(arg0);
        0xfb30368a735a023b686988dd37c354615796fe643942e1f3bb05cbd5a151724::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg4));
        let v0 = 0xfb30368a735a023b686988dd37c354615796fe643942e1f3bb05cbd5a151724::governance::take_locked_update<0xfb30368a735a023b686988dd37c354615796fe643942e1f3bb05cbd5a151724::time_lock::TimeLock<BurnWhitelistWish>>(arg0, 0x1::type_name::with_defining_ids<BurnWhitelistWish>());
        assert!(0xfb30368a735a023b686988dd37c354615796fe643942e1f3bb05cbd5a151724::time_lock::is_active<BurnWhitelistWish>(&v0, arg3), 0xfb30368a735a023b686988dd37c354615796fe643942e1f3bb05cbd5a151724::errors::time_locked_not_active());
        0xfb30368a735a023b686988dd37c354615796fe643942e1f3bb05cbd5a151724::time_lock::into_inner<BurnWhitelistWish>(v0);
        0x2c11c14fe07381e97c5b4033b7c85c21cb7ae30a4c35a91a64685a4728d85f90::leverage_admin::remove_protocol_caller_cap(0xfb30368a735a023b686988dd37c354615796fe643942e1f3bb05cbd5a151724::governance::lending_admin_cap(arg0), arg1, arg2);
    }

    public fun fulfill_mint_whitelist_wish(arg0: &mut 0xfb30368a735a023b686988dd37c354615796fe643942e1f3bb05cbd5a151724::governance::DragonBallCollector, arg1: &mut 0x5ba8b0d04af44f1270412cac98ab288e60fcfc449f3bfefbf4db953d32908866::app::ProtocolApp, arg2: &mut 0x2c11c14fe07381e97c5b4033b7c85c21cb7ae30a4c35a91a64685a4728d85f90::leverage_app::LeverageApp, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xfb30368a735a023b686988dd37c354615796fe643942e1f3bb05cbd5a151724::governance::ensure_can_summon_shenron(arg0);
        0xfb30368a735a023b686988dd37c354615796fe643942e1f3bb05cbd5a151724::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg4));
        let v0 = 0xfb30368a735a023b686988dd37c354615796fe643942e1f3bb05cbd5a151724::governance::take_locked_update<0xfb30368a735a023b686988dd37c354615796fe643942e1f3bb05cbd5a151724::time_lock::TimeLock<MintWhitelistWish>>(arg0, 0x1::type_name::with_defining_ids<MintWhitelistWish>());
        assert!(0xfb30368a735a023b686988dd37c354615796fe643942e1f3bb05cbd5a151724::time_lock::is_active<MintWhitelistWish>(&v0, arg3), 0xfb30368a735a023b686988dd37c354615796fe643942e1f3bb05cbd5a151724::errors::time_locked_not_active());
        0xfb30368a735a023b686988dd37c354615796fe643942e1f3bb05cbd5a151724::time_lock::into_inner<MintWhitelistWish>(v0);
        0x2c11c14fe07381e97c5b4033b7c85c21cb7ae30a4c35a91a64685a4728d85f90::leverage_admin::inject_protocol_caller_cap(0xfb30368a735a023b686988dd37c354615796fe643942e1f3bb05cbd5a151724::governance::lending_admin_cap(arg0), arg2, 0x5ba8b0d04af44f1270412cac98ab288e60fcfc449f3bfefbf4db953d32908866::whitelist_admin::mint_new_whitelist(0xfb30368a735a023b686988dd37c354615796fe643942e1f3bb05cbd5a151724::governance::lending_admin_cap(arg0), arg1, arg4));
    }

    public fun fulfill_remove_whitelist_wish(arg0: &mut 0xfb30368a735a023b686988dd37c354615796fe643942e1f3bb05cbd5a151724::governance::DragonBallCollector, arg1: &mut 0x5ba8b0d04af44f1270412cac98ab288e60fcfc449f3bfefbf4db953d32908866::app::ProtocolApp, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0xfb30368a735a023b686988dd37c354615796fe643942e1f3bb05cbd5a151724::governance::ensure_can_summon_shenron(arg0);
        0xfb30368a735a023b686988dd37c354615796fe643942e1f3bb05cbd5a151724::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg3));
        let v0 = 0xfb30368a735a023b686988dd37c354615796fe643942e1f3bb05cbd5a151724::governance::take_locked_update<0xfb30368a735a023b686988dd37c354615796fe643942e1f3bb05cbd5a151724::time_lock::TimeLock<RemoveWhitelistWish>>(arg0, 0x1::type_name::with_defining_ids<RemoveWhitelistWish>());
        assert!(0xfb30368a735a023b686988dd37c354615796fe643942e1f3bb05cbd5a151724::time_lock::is_active<RemoveWhitelistWish>(&v0, arg2), 0xfb30368a735a023b686988dd37c354615796fe643942e1f3bb05cbd5a151724::errors::time_locked_not_active());
        let RemoveWhitelistWish { id: v1 } = 0xfb30368a735a023b686988dd37c354615796fe643942e1f3bb05cbd5a151724::time_lock::into_inner<RemoveWhitelistWish>(v0);
        0x5ba8b0d04af44f1270412cac98ab288e60fcfc449f3bfefbf4db953d32908866::whitelist_admin::remove_whitelist(0xfb30368a735a023b686988dd37c354615796fe643942e1f3bb05cbd5a151724::governance::lending_admin_cap(arg0), arg1, v1);
    }

    public fun fulfill_update_whitelist_what_wish(arg0: &mut 0xfb30368a735a023b686988dd37c354615796fe643942e1f3bb05cbd5a151724::governance::DragonBallCollector, arg1: &mut 0x5ba8b0d04af44f1270412cac98ab288e60fcfc449f3bfefbf4db953d32908866::app::ProtocolApp, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0xfb30368a735a023b686988dd37c354615796fe643942e1f3bb05cbd5a151724::governance::ensure_can_summon_shenron(arg0);
        0xfb30368a735a023b686988dd37c354615796fe643942e1f3bb05cbd5a151724::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg3));
        let v0 = 0xfb30368a735a023b686988dd37c354615796fe643942e1f3bb05cbd5a151724::governance::take_locked_update<0xfb30368a735a023b686988dd37c354615796fe643942e1f3bb05cbd5a151724::time_lock::TimeLock<UpdateWhitelistPermissionWish>>(arg0, 0x1::type_name::with_defining_ids<UpdateWhitelistPermissionWish>());
        assert!(0xfb30368a735a023b686988dd37c354615796fe643942e1f3bb05cbd5a151724::time_lock::is_active<UpdateWhitelistPermissionWish>(&v0, arg2), 0xfb30368a735a023b686988dd37c354615796fe643942e1f3bb05cbd5a151724::errors::time_locked_not_active());
        let UpdateWhitelistPermissionWish {
            id       : v1,
            what     : v2,
            is_grant : v3,
        } = 0xfb30368a735a023b686988dd37c354615796fe643942e1f3bb05cbd5a151724::time_lock::into_inner<UpdateWhitelistPermissionWish>(v0);
        0x5ba8b0d04af44f1270412cac98ab288e60fcfc449f3bfefbf4db953d32908866::whitelist_admin::update_permission(0xfb30368a735a023b686988dd37c354615796fe643942e1f3bb05cbd5a151724::governance::lending_admin_cap(arg0), arg1, v1, v2, v3);
    }

    public fun wish_burn_whitelist(arg0: &mut 0xfb30368a735a023b686988dd37c354615796fe643942e1f3bb05cbd5a151724::governance::DragonBallCollector, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        0xfb30368a735a023b686988dd37c354615796fe643942e1f3bb05cbd5a151724::governance::ensure_can_summon_shenron(arg0);
        0xfb30368a735a023b686988dd37c354615796fe643942e1f3bb05cbd5a151724::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg2));
        let v0 = BurnWhitelistWish{dummy_field: false};
        0xfb30368a735a023b686988dd37c354615796fe643942e1f3bb05cbd5a151724::governance::store_locked_update<0xfb30368a735a023b686988dd37c354615796fe643942e1f3bb05cbd5a151724::time_lock::TimeLock<BurnWhitelistWish>>(arg0, 0x1::type_name::with_defining_ids<BurnWhitelistWish>(), 0xfb30368a735a023b686988dd37c354615796fe643942e1f3bb05cbd5a151724::time_lock::new_time_locked<BurnWhitelistWish>(v0, arg1, 0xfb30368a735a023b686988dd37c354615796fe643942e1f3bb05cbd5a151724::governance::time_lock_duration_seconds(arg0), 0xfb30368a735a023b686988dd37c354615796fe643942e1f3bb05cbd5a151724::governance::time_lock_expriration_seconds(arg0)));
    }

    public fun wish_mint_whitelist(arg0: &mut 0xfb30368a735a023b686988dd37c354615796fe643942e1f3bb05cbd5a151724::governance::DragonBallCollector, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        0xfb30368a735a023b686988dd37c354615796fe643942e1f3bb05cbd5a151724::governance::ensure_can_summon_shenron(arg0);
        0xfb30368a735a023b686988dd37c354615796fe643942e1f3bb05cbd5a151724::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg2));
        let v0 = MintWhitelistWish{dummy_field: false};
        0xfb30368a735a023b686988dd37c354615796fe643942e1f3bb05cbd5a151724::governance::store_locked_update<0xfb30368a735a023b686988dd37c354615796fe643942e1f3bb05cbd5a151724::time_lock::TimeLock<MintWhitelistWish>>(arg0, 0x1::type_name::with_defining_ids<MintWhitelistWish>(), 0xfb30368a735a023b686988dd37c354615796fe643942e1f3bb05cbd5a151724::time_lock::new_time_locked<MintWhitelistWish>(v0, arg1, 0xfb30368a735a023b686988dd37c354615796fe643942e1f3bb05cbd5a151724::governance::time_lock_duration_seconds(arg0), 0xfb30368a735a023b686988dd37c354615796fe643942e1f3bb05cbd5a151724::governance::time_lock_expriration_seconds(arg0)));
    }

    public fun wish_remove_whitelist(arg0: &mut 0xfb30368a735a023b686988dd37c354615796fe643942e1f3bb05cbd5a151724::governance::DragonBallCollector, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0xfb30368a735a023b686988dd37c354615796fe643942e1f3bb05cbd5a151724::governance::ensure_can_summon_shenron(arg0);
        0xfb30368a735a023b686988dd37c354615796fe643942e1f3bb05cbd5a151724::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg3));
        let v0 = RemoveWhitelistWish{id: arg1};
        0xfb30368a735a023b686988dd37c354615796fe643942e1f3bb05cbd5a151724::governance::store_locked_update<0xfb30368a735a023b686988dd37c354615796fe643942e1f3bb05cbd5a151724::time_lock::TimeLock<RemoveWhitelistWish>>(arg0, 0x1::type_name::with_defining_ids<RemoveWhitelistWish>(), 0xfb30368a735a023b686988dd37c354615796fe643942e1f3bb05cbd5a151724::time_lock::new_time_locked<RemoveWhitelistWish>(v0, arg2, 0xfb30368a735a023b686988dd37c354615796fe643942e1f3bb05cbd5a151724::governance::time_lock_duration_seconds(arg0), 0xfb30368a735a023b686988dd37c354615796fe643942e1f3bb05cbd5a151724::governance::time_lock_expriration_seconds(arg0)));
    }

    public fun wish_update_whitelist_what(arg0: &mut 0xfb30368a735a023b686988dd37c354615796fe643942e1f3bb05cbd5a151724::governance::DragonBallCollector, arg1: 0x2::object::ID, arg2: u8, arg3: bool, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xfb30368a735a023b686988dd37c354615796fe643942e1f3bb05cbd5a151724::governance::ensure_can_summon_shenron(arg0);
        0xfb30368a735a023b686988dd37c354615796fe643942e1f3bb05cbd5a151724::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg5));
        let v0 = UpdateWhitelistPermissionWish{
            id       : arg1,
            what     : arg2,
            is_grant : arg3,
        };
        0xfb30368a735a023b686988dd37c354615796fe643942e1f3bb05cbd5a151724::governance::store_locked_update<0xfb30368a735a023b686988dd37c354615796fe643942e1f3bb05cbd5a151724::time_lock::TimeLock<UpdateWhitelistPermissionWish>>(arg0, 0x1::type_name::with_defining_ids<UpdateWhitelistPermissionWish>(), 0xfb30368a735a023b686988dd37c354615796fe643942e1f3bb05cbd5a151724::time_lock::new_time_locked<UpdateWhitelistPermissionWish>(v0, arg4, 0xfb30368a735a023b686988dd37c354615796fe643942e1f3bb05cbd5a151724::governance::time_lock_duration_seconds(arg0), 0xfb30368a735a023b686988dd37c354615796fe643942e1f3bb05cbd5a151724::governance::time_lock_expriration_seconds(arg0)));
    }

    // decompiled from Move bytecode v6
}

