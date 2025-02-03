module 0x4cb6a6f8c9d61f3a849f7033a78086076296842fd0ca3c0dce10f6d39172dc00::liquidate {
    struct LiquidateEvent has copy, drop {
        liquidator: address,
        obligation: 0x2::object::ID,
        debt_type: 0x1::type_name::TypeName,
        collateral_type: 0x1::type_name::TypeName,
        repay_on_behalf: u64,
        repay_revenue: u64,
        liq_amount: u64,
    }

    public fun liquidate<T0, T1>(arg0: &0x4cb6a6f8c9d61f3a849f7033a78086076296842fd0ca3c0dce10f6d39172dc00::version::Version, arg1: &mut 0x4cb6a6f8c9d61f3a849f7033a78086076296842fd0ca3c0dce10f6d39172dc00::obligation::Obligation, arg2: &mut 0x4cb6a6f8c9d61f3a849f7033a78086076296842fd0ca3c0dce10f6d39172dc00::market::Market, arg3: 0x2::coin::Coin<T0>, arg4: &0xd68eb3aafa85228a532500ca1ca45af097cb3b941dbdf297e68b1f01e0cdd95e::coin_decimals_registry::CoinDecimalsRegistry, arg5: &0x50be75ec6be925b2422c57182e6ef40eadec69eb9b55130b9c4af7fbb039f460::x_oracle::XOracle, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        0x4cb6a6f8c9d61f3a849f7033a78086076296842fd0ca3c0dce10f6d39172dc00::version::assert_current_version(arg0);
        assert!(0x59baf2f4eab98d6f8b9c5982aab0b6ac7213c96a8e7b08118b6c931b862adef9::whitelist::is_address_allowed(0x4cb6a6f8c9d61f3a849f7033a78086076296842fd0ca3c0dce10f6d39172dc00::market::uid(arg2), 0x2::tx_context::sender(arg7)), 0x4cb6a6f8c9d61f3a849f7033a78086076296842fd0ca3c0dce10f6d39172dc00::error::whitelist_error());
        assert!(0x4cb6a6f8c9d61f3a849f7033a78086076296842fd0ca3c0dce10f6d39172dc00::obligation::liquidate_locked(arg1) == false, 0x4cb6a6f8c9d61f3a849f7033a78086076296842fd0ca3c0dce10f6d39172dc00::error::obligation_locked());
        let v0 = 0x2::coin::into_balance<T0>(arg3);
        0x4cb6a6f8c9d61f3a849f7033a78086076296842fd0ca3c0dce10f6d39172dc00::market::accrue_all_interests(arg2, 0x2::clock::timestamp_ms(arg6) / 1000);
        0x4cb6a6f8c9d61f3a849f7033a78086076296842fd0ca3c0dce10f6d39172dc00::obligation::accrue_interests_and_rewards(arg1, arg2);
        let (v1, v2, v3) = 0x4cb6a6f8c9d61f3a849f7033a78086076296842fd0ca3c0dce10f6d39172dc00::liquidation_evaluator::liquidation_amounts<T0, T1>(arg1, arg2, arg4, 0x2::balance::value<T0>(&v0), arg5, arg6);
        assert!(v3 > 0, 0x4cb6a6f8c9d61f3a849f7033a78086076296842fd0ca3c0dce10f6d39172dc00::error::unable_to_liquidate_error());
        0x4cb6a6f8c9d61f3a849f7033a78086076296842fd0ca3c0dce10f6d39172dc00::obligation::decrease_debt(arg1, 0x1::type_name::get<T0>(), v1);
        0x4cb6a6f8c9d61f3a849f7033a78086076296842fd0ca3c0dce10f6d39172dc00::market::handle_liquidation<T0>(arg2, 0x2::balance::split<T0>(&mut v0, v1), 0x2::balance::split<T0>(&mut v0, v2));
        let v4 = LiquidateEvent{
            liquidator      : 0x2::tx_context::sender(arg7),
            obligation      : 0x2::object::id<0x4cb6a6f8c9d61f3a849f7033a78086076296842fd0ca3c0dce10f6d39172dc00::obligation::Obligation>(arg1),
            debt_type       : 0x1::type_name::get<T0>(),
            collateral_type : 0x1::type_name::get<T1>(),
            repay_on_behalf : v1,
            repay_revenue   : v2,
            liq_amount      : v3,
        };
        0x2::event::emit<LiquidateEvent>(v4);
        (0x2::coin::from_balance<T0>(v0, arg7), 0x2::coin::from_balance<T1>(0x4cb6a6f8c9d61f3a849f7033a78086076296842fd0ca3c0dce10f6d39172dc00::obligation::withdraw_collateral<T1>(arg1, v3), arg7))
    }

    public entry fun liquidate_entry<T0, T1>(arg0: &0x4cb6a6f8c9d61f3a849f7033a78086076296842fd0ca3c0dce10f6d39172dc00::version::Version, arg1: &mut 0x4cb6a6f8c9d61f3a849f7033a78086076296842fd0ca3c0dce10f6d39172dc00::obligation::Obligation, arg2: &mut 0x4cb6a6f8c9d61f3a849f7033a78086076296842fd0ca3c0dce10f6d39172dc00::market::Market, arg3: 0x2::coin::Coin<T0>, arg4: &0xd68eb3aafa85228a532500ca1ca45af097cb3b941dbdf297e68b1f01e0cdd95e::coin_decimals_registry::CoinDecimalsRegistry, arg5: &0x50be75ec6be925b2422c57182e6ef40eadec69eb9b55130b9c4af7fbb039f460::x_oracle::XOracle, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = liquidate<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg7));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v1, 0x2::tx_context::sender(arg7));
    }

    // decompiled from Move bytecode v6
}

