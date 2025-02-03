module 0xec048a2277008352359d7a76d3e318c0419977a893fec002c954091662fca715::withdraw_collateral {
    struct CollateralWithdrawEvent has copy, drop {
        taker: address,
        obligation: 0x2::object::ID,
        withdraw_asset: 0x1::type_name::TypeName,
        withdraw_amount: u64,
    }

    public fun withdraw_collateral<T0>(arg0: &0xec048a2277008352359d7a76d3e318c0419977a893fec002c954091662fca715::version::Version, arg1: &mut 0xec048a2277008352359d7a76d3e318c0419977a893fec002c954091662fca715::obligation::Obligation, arg2: &0xec048a2277008352359d7a76d3e318c0419977a893fec002c954091662fca715::obligation::ObligationKey, arg3: &mut 0xec048a2277008352359d7a76d3e318c0419977a893fec002c954091662fca715::market::Market, arg4: &0xd68eb3aafa85228a532500ca1ca45af097cb3b941dbdf297e68b1f01e0cdd95e::coin_decimals_registry::CoinDecimalsRegistry, arg5: u64, arg6: &0xcd9bf99ee89711edd5084fbd67aee0865b866f0bb3262701ec487cd45b0d3041::x_oracle::XOracle, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xec048a2277008352359d7a76d3e318c0419977a893fec002c954091662fca715::version::assert_current_version(arg0);
        assert!(0x4168e1c807a2d1f4cf301e9ce5fbd6e58f54a86751b02df176d89672489ceea8::whitelist::is_address_allowed(0xec048a2277008352359d7a76d3e318c0419977a893fec002c954091662fca715::market::uid(arg3), 0x2::tx_context::sender(arg8)), 0xec048a2277008352359d7a76d3e318c0419977a893fec002c954091662fca715::error::whitelist_error());
        0xec048a2277008352359d7a76d3e318c0419977a893fec002c954091662fca715::obligation::assert_key_match(arg1, arg2);
        0xec048a2277008352359d7a76d3e318c0419977a893fec002c954091662fca715::market::handle_withdraw_collateral<T0>(arg3, arg5, 0x2::clock::timestamp_ms(arg7) / 1000);
        0xec048a2277008352359d7a76d3e318c0419977a893fec002c954091662fca715::obligation::accrue_interests(arg1, arg3);
        assert!(arg5 <= 0xec048a2277008352359d7a76d3e318c0419977a893fec002c954091662fca715::borrow_withdraw_evaluator::max_withdraw_amount<T0>(arg1, arg3, arg4, arg6, arg7), 0xec048a2277008352359d7a76d3e318c0419977a893fec002c954091662fca715::error::withdraw_collateral_too_much_error());
        let v0 = 0xec048a2277008352359d7a76d3e318c0419977a893fec002c954091662fca715::obligation::withdraw_collateral<T0>(arg1, arg5);
        let v1 = CollateralWithdrawEvent{
            taker           : 0x2::tx_context::sender(arg8),
            obligation      : 0x2::object::id<0xec048a2277008352359d7a76d3e318c0419977a893fec002c954091662fca715::obligation::Obligation>(arg1),
            withdraw_asset  : 0x1::type_name::get<T0>(),
            withdraw_amount : 0x2::balance::value<T0>(&v0),
        };
        0x2::event::emit<CollateralWithdrawEvent>(v1);
        0x2::coin::from_balance<T0>(v0, arg8)
    }

    public entry fun withdraw_collateral_entry<T0>(arg0: &0xec048a2277008352359d7a76d3e318c0419977a893fec002c954091662fca715::version::Version, arg1: &mut 0xec048a2277008352359d7a76d3e318c0419977a893fec002c954091662fca715::obligation::Obligation, arg2: &0xec048a2277008352359d7a76d3e318c0419977a893fec002c954091662fca715::obligation::ObligationKey, arg3: &mut 0xec048a2277008352359d7a76d3e318c0419977a893fec002c954091662fca715::market::Market, arg4: &0xd68eb3aafa85228a532500ca1ca45af097cb3b941dbdf297e68b1f01e0cdd95e::coin_decimals_registry::CoinDecimalsRegistry, arg5: u64, arg6: &0xcd9bf99ee89711edd5084fbd67aee0865b866f0bb3262701ec487cd45b0d3041::x_oracle::XOracle, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = withdraw_collateral<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg8));
    }

    // decompiled from Move bytecode v6
}

