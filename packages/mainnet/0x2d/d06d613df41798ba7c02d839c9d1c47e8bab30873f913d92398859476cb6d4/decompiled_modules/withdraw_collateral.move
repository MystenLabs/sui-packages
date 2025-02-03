module 0x2dd06d613df41798ba7c02d839c9d1c47e8bab30873f913d92398859476cb6d4::withdraw_collateral {
    struct CollateralWithdrawEvent has copy, drop {
        taker: address,
        obligation: 0x2::object::ID,
        withdraw_asset: 0x1::type_name::TypeName,
        withdraw_amount: u64,
    }

    public fun withdraw_collateral<T0>(arg0: &mut 0x2dd06d613df41798ba7c02d839c9d1c47e8bab30873f913d92398859476cb6d4::obligation::Obligation, arg1: &0x2dd06d613df41798ba7c02d839c9d1c47e8bab30873f913d92398859476cb6d4::obligation::ObligationKey, arg2: &mut 0x2dd06d613df41798ba7c02d839c9d1c47e8bab30873f913d92398859476cb6d4::market::Market, arg3: &0xd68eb3aafa85228a532500ca1ca45af097cb3b941dbdf297e68b1f01e0cdd95e::coin_decimals_registry::CoinDecimalsRegistry, arg4: u64, arg5: &0xcd9bf99ee89711edd5084fbd67aee0865b866f0bb3262701ec487cd45b0d3041::x_oracle::XOracle, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x4168e1c807a2d1f4cf301e9ce5fbd6e58f54a86751b02df176d89672489ceea8::whitelist::is_address_allowed(0x2dd06d613df41798ba7c02d839c9d1c47e8bab30873f913d92398859476cb6d4::market::uid(arg2), 0x2::tx_context::sender(arg7)), 0x2dd06d613df41798ba7c02d839c9d1c47e8bab30873f913d92398859476cb6d4::error::whitelist_error());
        0x2dd06d613df41798ba7c02d839c9d1c47e8bab30873f913d92398859476cb6d4::obligation::assert_key_match(arg0, arg1);
        0x2dd06d613df41798ba7c02d839c9d1c47e8bab30873f913d92398859476cb6d4::market::handle_withdraw_collateral<T0>(arg2, arg4, 0x2::clock::timestamp_ms(arg6) / 1000);
        0x2dd06d613df41798ba7c02d839c9d1c47e8bab30873f913d92398859476cb6d4::obligation::accrue_interests(arg0, arg2);
        assert!(arg4 <= 0x2dd06d613df41798ba7c02d839c9d1c47e8bab30873f913d92398859476cb6d4::borrow_withdraw_evaluator::max_withdraw_amount<T0>(arg0, arg2, arg3, arg5, arg6), 524289);
        let v0 = 0x2dd06d613df41798ba7c02d839c9d1c47e8bab30873f913d92398859476cb6d4::obligation::withdraw_collateral<T0>(arg0, arg4);
        let v1 = CollateralWithdrawEvent{
            taker           : 0x2::tx_context::sender(arg7),
            obligation      : 0x2::object::id<0x2dd06d613df41798ba7c02d839c9d1c47e8bab30873f913d92398859476cb6d4::obligation::Obligation>(arg0),
            withdraw_asset  : 0x1::type_name::get<T0>(),
            withdraw_amount : 0x2::balance::value<T0>(&v0),
        };
        0x2::event::emit<CollateralWithdrawEvent>(v1);
        0x2::coin::from_balance<T0>(v0, arg7)
    }

    public entry fun withdraw_collateral_entry<T0>(arg0: &mut 0x2dd06d613df41798ba7c02d839c9d1c47e8bab30873f913d92398859476cb6d4::obligation::Obligation, arg1: &0x2dd06d613df41798ba7c02d839c9d1c47e8bab30873f913d92398859476cb6d4::obligation::ObligationKey, arg2: &mut 0x2dd06d613df41798ba7c02d839c9d1c47e8bab30873f913d92398859476cb6d4::market::Market, arg3: &0xd68eb3aafa85228a532500ca1ca45af097cb3b941dbdf297e68b1f01e0cdd95e::coin_decimals_registry::CoinDecimalsRegistry, arg4: u64, arg5: &0xcd9bf99ee89711edd5084fbd67aee0865b866f0bb3262701ec487cd45b0d3041::x_oracle::XOracle, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = withdraw_collateral<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg7));
    }

    // decompiled from Move bytecode v6
}

