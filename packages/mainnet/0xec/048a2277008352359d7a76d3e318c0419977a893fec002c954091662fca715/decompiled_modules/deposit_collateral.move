module 0xec048a2277008352359d7a76d3e318c0419977a893fec002c954091662fca715::deposit_collateral {
    struct CollateralDepositEvent has copy, drop {
        provider: address,
        obligation: 0x2::object::ID,
        deposit_asset: 0x1::type_name::TypeName,
        deposit_amount: u64,
    }

    public entry fun deposit_collateral<T0>(arg0: &0xec048a2277008352359d7a76d3e318c0419977a893fec002c954091662fca715::version::Version, arg1: &mut 0xec048a2277008352359d7a76d3e318c0419977a893fec002c954091662fca715::obligation::Obligation, arg2: &mut 0xec048a2277008352359d7a76d3e318c0419977a893fec002c954091662fca715::market::Market, arg3: 0x2::coin::Coin<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        0xec048a2277008352359d7a76d3e318c0419977a893fec002c954091662fca715::version::assert_current_version(arg0);
        assert!(0x4168e1c807a2d1f4cf301e9ce5fbd6e58f54a86751b02df176d89672489ceea8::whitelist::is_address_allowed(0xec048a2277008352359d7a76d3e318c0419977a893fec002c954091662fca715::market::uid(arg2), 0x2::tx_context::sender(arg4)), 0xec048a2277008352359d7a76d3e318c0419977a893fec002c954091662fca715::error::whitelist_error());
        assert!(0xec048a2277008352359d7a76d3e318c0419977a893fec002c954091662fca715::market::has_risk_model(arg2, 0x1::type_name::get<T0>()) == true, 0xec048a2277008352359d7a76d3e318c0419977a893fec002c954091662fca715::error::invalid_collateral_type_error());
        let v0 = CollateralDepositEvent{
            provider       : 0x2::tx_context::sender(arg4),
            obligation     : 0x2::object::id<0xec048a2277008352359d7a76d3e318c0419977a893fec002c954091662fca715::obligation::Obligation>(arg1),
            deposit_asset  : 0x1::type_name::get<T0>(),
            deposit_amount : 0x2::coin::value<T0>(&arg3),
        };
        0x2::event::emit<CollateralDepositEvent>(v0);
        0xec048a2277008352359d7a76d3e318c0419977a893fec002c954091662fca715::market::handle_add_collateral<T0>(arg2, 0x2::coin::value<T0>(&arg3));
        0xec048a2277008352359d7a76d3e318c0419977a893fec002c954091662fca715::obligation::deposit_collateral<T0>(arg1, 0x2::coin::into_balance<T0>(arg3));
    }

    // decompiled from Move bytecode v6
}

