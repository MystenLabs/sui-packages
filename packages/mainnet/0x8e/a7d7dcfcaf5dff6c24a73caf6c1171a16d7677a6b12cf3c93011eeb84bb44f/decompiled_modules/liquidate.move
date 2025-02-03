module 0x8ea7d7dcfcaf5dff6c24a73caf6c1171a16d7677a6b12cf3c93011eeb84bb44f::liquidate {
    struct LiquidateEvent has copy, drop {
        liquidator: address,
        obligation: 0x2::object::ID,
        debt_type: 0x1::type_name::TypeName,
        collateral_type: 0x1::type_name::TypeName,
        repay_on_behalf: u64,
        repay_revenue: u64,
        liq_amount: u64,
    }

    public fun liquidate<T0, T1>(arg0: &0x8ea7d7dcfcaf5dff6c24a73caf6c1171a16d7677a6b12cf3c93011eeb84bb44f::version::Version, arg1: &mut 0x8ea7d7dcfcaf5dff6c24a73caf6c1171a16d7677a6b12cf3c93011eeb84bb44f::obligation::Obligation, arg2: &mut 0x8ea7d7dcfcaf5dff6c24a73caf6c1171a16d7677a6b12cf3c93011eeb84bb44f::market::Market, arg3: 0x2::coin::Coin<T0>, arg4: &0xd68eb3aafa85228a532500ca1ca45af097cb3b941dbdf297e68b1f01e0cdd95e::coin_decimals_registry::CoinDecimalsRegistry, arg5: &0xcd9bf99ee89711edd5084fbd67aee0865b866f0bb3262701ec487cd45b0d3041::x_oracle::XOracle, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        0x8ea7d7dcfcaf5dff6c24a73caf6c1171a16d7677a6b12cf3c93011eeb84bb44f::version::assert_current_version(arg0);
        assert!(0x4168e1c807a2d1f4cf301e9ce5fbd6e58f54a86751b02df176d89672489ceea8::whitelist::is_address_allowed(0x8ea7d7dcfcaf5dff6c24a73caf6c1171a16d7677a6b12cf3c93011eeb84bb44f::market::uid(arg2), 0x2::tx_context::sender(arg7)), 0x8ea7d7dcfcaf5dff6c24a73caf6c1171a16d7677a6b12cf3c93011eeb84bb44f::error::whitelist_error());
        let v0 = 0x2::coin::into_balance<T0>(arg3);
        0x8ea7d7dcfcaf5dff6c24a73caf6c1171a16d7677a6b12cf3c93011eeb84bb44f::market::accrue_all_interests(arg2, 0x2::clock::timestamp_ms(arg6) / 1000);
        0x8ea7d7dcfcaf5dff6c24a73caf6c1171a16d7677a6b12cf3c93011eeb84bb44f::obligation::accrue_interests(arg1, arg2);
        let (v1, v2, v3) = 0x8ea7d7dcfcaf5dff6c24a73caf6c1171a16d7677a6b12cf3c93011eeb84bb44f::liquidation_evaluator::liquidation_amounts<T0, T1>(arg1, arg2, arg4, 0x2::balance::value<T0>(&v0), arg5, arg6);
        assert!(v3 > 0, 0x8ea7d7dcfcaf5dff6c24a73caf6c1171a16d7677a6b12cf3c93011eeb84bb44f::error::unable_to_liquidate_error());
        0x8ea7d7dcfcaf5dff6c24a73caf6c1171a16d7677a6b12cf3c93011eeb84bb44f::obligation::decrease_debt(arg1, 0x1::type_name::get<T0>(), v1);
        0x8ea7d7dcfcaf5dff6c24a73caf6c1171a16d7677a6b12cf3c93011eeb84bb44f::market::handle_liquidation<T0>(arg2, 0x2::balance::split<T0>(&mut v0, v1), 0x2::balance::split<T0>(&mut v0, v2));
        let v4 = LiquidateEvent{
            liquidator      : 0x2::tx_context::sender(arg7),
            obligation      : 0x2::object::id<0x8ea7d7dcfcaf5dff6c24a73caf6c1171a16d7677a6b12cf3c93011eeb84bb44f::obligation::Obligation>(arg1),
            debt_type       : 0x1::type_name::get<T0>(),
            collateral_type : 0x1::type_name::get<T1>(),
            repay_on_behalf : v1,
            repay_revenue   : v2,
            liq_amount      : v3,
        };
        0x2::event::emit<LiquidateEvent>(v4);
        (0x2::coin::from_balance<T0>(v0, arg7), 0x2::coin::from_balance<T1>(0x8ea7d7dcfcaf5dff6c24a73caf6c1171a16d7677a6b12cf3c93011eeb84bb44f::obligation::withdraw_collateral<T1>(arg1, v3), arg7))
    }

    public entry fun liquidate_entry<T0, T1>(arg0: &0x8ea7d7dcfcaf5dff6c24a73caf6c1171a16d7677a6b12cf3c93011eeb84bb44f::version::Version, arg1: &mut 0x8ea7d7dcfcaf5dff6c24a73caf6c1171a16d7677a6b12cf3c93011eeb84bb44f::obligation::Obligation, arg2: &mut 0x8ea7d7dcfcaf5dff6c24a73caf6c1171a16d7677a6b12cf3c93011eeb84bb44f::market::Market, arg3: 0x2::coin::Coin<T0>, arg4: &0xd68eb3aafa85228a532500ca1ca45af097cb3b941dbdf297e68b1f01e0cdd95e::coin_decimals_registry::CoinDecimalsRegistry, arg5: &0xcd9bf99ee89711edd5084fbd67aee0865b866f0bb3262701ec487cd45b0d3041::x_oracle::XOracle, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = liquidate<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg7));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v1, 0x2::tx_context::sender(arg7));
    }

    // decompiled from Move bytecode v6
}

