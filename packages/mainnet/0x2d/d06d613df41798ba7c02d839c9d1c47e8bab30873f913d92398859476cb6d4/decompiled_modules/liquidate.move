module 0x2dd06d613df41798ba7c02d839c9d1c47e8bab30873f913d92398859476cb6d4::liquidate {
    struct LiquidateEvent has copy, drop {
        liquidator: address,
        obligation: 0x2::object::ID,
        debt_type: 0x1::type_name::TypeName,
        collateral_type: 0x1::type_name::TypeName,
        repay_on_behalf: u64,
        repay_revenue: u64,
        liq_amount: u64,
    }

    public fun liquidate<T0, T1>(arg0: &mut 0x2dd06d613df41798ba7c02d839c9d1c47e8bab30873f913d92398859476cb6d4::obligation::Obligation, arg1: &mut 0x2dd06d613df41798ba7c02d839c9d1c47e8bab30873f913d92398859476cb6d4::market::Market, arg2: 0x2::coin::Coin<T0>, arg3: &0xd68eb3aafa85228a532500ca1ca45af097cb3b941dbdf297e68b1f01e0cdd95e::coin_decimals_registry::CoinDecimalsRegistry, arg4: &0xcd9bf99ee89711edd5084fbd67aee0865b866f0bb3262701ec487cd45b0d3041::x_oracle::XOracle, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        assert!(0x4168e1c807a2d1f4cf301e9ce5fbd6e58f54a86751b02df176d89672489ceea8::whitelist::is_address_allowed(0x2dd06d613df41798ba7c02d839c9d1c47e8bab30873f913d92398859476cb6d4::market::uid(arg1), 0x2::tx_context::sender(arg6)), 0x2dd06d613df41798ba7c02d839c9d1c47e8bab30873f913d92398859476cb6d4::error::whitelist_error());
        let v0 = 0x2::coin::into_balance<T0>(arg2);
        0x2dd06d613df41798ba7c02d839c9d1c47e8bab30873f913d92398859476cb6d4::market::accrue_all_interests(arg1, 0x2::clock::timestamp_ms(arg5) / 1000);
        0x2dd06d613df41798ba7c02d839c9d1c47e8bab30873f913d92398859476cb6d4::obligation::accrue_interests(arg0, arg1);
        let (v1, v2, v3) = 0x2dd06d613df41798ba7c02d839c9d1c47e8bab30873f913d92398859476cb6d4::liquidation_evaluator::liquidation_amounts<T0, T1>(arg0, arg1, arg3, 0x2::balance::value<T0>(&v0), arg4, arg5);
        assert!(v3 > 0, 196609);
        0x2dd06d613df41798ba7c02d839c9d1c47e8bab30873f913d92398859476cb6d4::obligation::decrease_debt(arg0, 0x1::type_name::get<T0>(), v1);
        0x2dd06d613df41798ba7c02d839c9d1c47e8bab30873f913d92398859476cb6d4::market::handle_liquidation<T0>(arg1, 0x2::balance::split<T0>(&mut v0, v1), 0x2::balance::split<T0>(&mut v0, v2));
        let v4 = LiquidateEvent{
            liquidator      : 0x2::tx_context::sender(arg6),
            obligation      : 0x2::object::id<0x2dd06d613df41798ba7c02d839c9d1c47e8bab30873f913d92398859476cb6d4::obligation::Obligation>(arg0),
            debt_type       : 0x1::type_name::get<T0>(),
            collateral_type : 0x1::type_name::get<T1>(),
            repay_on_behalf : v1,
            repay_revenue   : v2,
            liq_amount      : v3,
        };
        0x2::event::emit<LiquidateEvent>(v4);
        (0x2::coin::from_balance<T0>(v0, arg6), 0x2::coin::from_balance<T1>(0x2dd06d613df41798ba7c02d839c9d1c47e8bab30873f913d92398859476cb6d4::obligation::withdraw_collateral<T1>(arg0, v3), arg6))
    }

    public entry fun liquidate_entry<T0, T1>(arg0: &mut 0x2dd06d613df41798ba7c02d839c9d1c47e8bab30873f913d92398859476cb6d4::obligation::Obligation, arg1: &mut 0x2dd06d613df41798ba7c02d839c9d1c47e8bab30873f913d92398859476cb6d4::market::Market, arg2: 0x2::coin::Coin<T0>, arg3: &0xd68eb3aafa85228a532500ca1ca45af097cb3b941dbdf297e68b1f01e0cdd95e::coin_decimals_registry::CoinDecimalsRegistry, arg4: &0xcd9bf99ee89711edd5084fbd67aee0865b866f0bb3262701ec487cd45b0d3041::x_oracle::XOracle, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = liquidate<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg6));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v1, 0x2::tx_context::sender(arg6));
    }

    // decompiled from Move bytecode v6
}

