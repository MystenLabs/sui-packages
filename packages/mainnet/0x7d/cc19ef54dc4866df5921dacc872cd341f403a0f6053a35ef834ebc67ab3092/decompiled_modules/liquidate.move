module 0x7dcc19ef54dc4866df5921dacc872cd341f403a0f6053a35ef834ebc67ab3092::liquidate {
    struct LiquidateEvent has copy, drop {
        liquidator: address,
        obligation: 0x2::object::ID,
        debt_type: 0x1::type_name::TypeName,
        collateral_type: 0x1::type_name::TypeName,
        repay_on_behalf: u64,
        repay_revenue: u64,
        liq_amount: u64,
        collateral_price: 0x1::fixed_point32::FixedPoint32,
        debt_price: 0x1::fixed_point32::FixedPoint32,
        timestamp: u64,
    }

    public fun liquidate<T0>(arg0: &0x7dcc19ef54dc4866df5921dacc872cd341f403a0f6053a35ef834ebc67ab3092::version::Version, arg1: &mut 0x7dcc19ef54dc4866df5921dacc872cd341f403a0f6053a35ef834ebc67ab3092::obligation::Obligation, arg2: &mut 0x7dcc19ef54dc4866df5921dacc872cd341f403a0f6053a35ef834ebc67ab3092::market::Market, arg3: 0x2::coin::Coin<0x1ad0ff481b24a7d182ba9f6784522bdea412d9d65d07c0d278cfa5f2281c0abd::coin_gusd::COIN_GUSD>, arg4: &0x596e3f4cbfceafa0cca766cad1bd9a42ef720732c3fe786f75cc8c70575e31e::coin_decimals_registry::CoinDecimalsRegistry, arg5: &0x66895f6e3a45637db4bf50868d6b522f18f8ab35687517d3bacea4f1a3bae218::x_oracle::XOracle, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x1ad0ff481b24a7d182ba9f6784522bdea412d9d65d07c0d278cfa5f2281c0abd::coin_gusd::COIN_GUSD>, 0x2::coin::Coin<T0>) {
        0x7dcc19ef54dc4866df5921dacc872cd341f403a0f6053a35ef834ebc67ab3092::version::assert_current_version(arg0);
        assert!(0x7dcc19ef54dc4866df5921dacc872cd341f403a0f6053a35ef834ebc67ab3092::obligation::liquidate_locked(arg1) == false, 0x7dcc19ef54dc4866df5921dacc872cd341f403a0f6053a35ef834ebc67ab3092::error::obligation_locked());
        assert!(0x2::coin::value<0x1ad0ff481b24a7d182ba9f6784522bdea412d9d65d07c0d278cfa5f2281c0abd::coin_gusd::COIN_GUSD>(&arg3) > 0, 0x7dcc19ef54dc4866df5921dacc872cd341f403a0f6053a35ef834ebc67ab3092::error::zero_amount_error());
        let v0 = 0x2::coin::into_balance<0x1ad0ff481b24a7d182ba9f6784522bdea412d9d65d07c0d278cfa5f2281c0abd::coin_gusd::COIN_GUSD>(arg3);
        let v1 = 0x2::clock::timestamp_ms(arg6) / 1000;
        0x7dcc19ef54dc4866df5921dacc872cd341f403a0f6053a35ef834ebc67ab3092::market::accrue_all_interests(arg2, v1);
        0x7dcc19ef54dc4866df5921dacc872cd341f403a0f6053a35ef834ebc67ab3092::obligation::accrue_interests_and_rewards(arg1, arg2);
        let (v2, v3, v4) = 0x7dcc19ef54dc4866df5921dacc872cd341f403a0f6053a35ef834ebc67ab3092::liquidation_evaluator::liquidation_amounts<0x1ad0ff481b24a7d182ba9f6784522bdea412d9d65d07c0d278cfa5f2281c0abd::coin_gusd::COIN_GUSD, T0>(arg1, arg2, arg4, 0x2::balance::value<0x1ad0ff481b24a7d182ba9f6784522bdea412d9d65d07c0d278cfa5f2281c0abd::coin_gusd::COIN_GUSD>(&v0), arg5, arg6);
        assert!(v4 > 0, 0x7dcc19ef54dc4866df5921dacc872cd341f403a0f6053a35ef834ebc67ab3092::error::unable_to_liquidate_error());
        0x7dcc19ef54dc4866df5921dacc872cd341f403a0f6053a35ef834ebc67ab3092::obligation::decrease_debt(arg1, 0x1::type_name::get<0x1ad0ff481b24a7d182ba9f6784522bdea412d9d65d07c0d278cfa5f2281c0abd::coin_gusd::COIN_GUSD>(), v2);
        0x7dcc19ef54dc4866df5921dacc872cd341f403a0f6053a35ef834ebc67ab3092::market::handle_liquidation<T0>(arg2, 0x2::balance::split<0x1ad0ff481b24a7d182ba9f6784522bdea412d9d65d07c0d278cfa5f2281c0abd::coin_gusd::COIN_GUSD>(&mut v0, v2), 0x2::balance::split<0x1ad0ff481b24a7d182ba9f6784522bdea412d9d65d07c0d278cfa5f2281c0abd::coin_gusd::COIN_GUSD>(&mut v0, v3), v4, arg7);
        let v5 = LiquidateEvent{
            liquidator       : 0x2::tx_context::sender(arg7),
            obligation       : 0x2::object::id<0x7dcc19ef54dc4866df5921dacc872cd341f403a0f6053a35ef834ebc67ab3092::obligation::Obligation>(arg1),
            debt_type        : 0x1::type_name::get<0x1ad0ff481b24a7d182ba9f6784522bdea412d9d65d07c0d278cfa5f2281c0abd::coin_gusd::COIN_GUSD>(),
            collateral_type  : 0x1::type_name::get<T0>(),
            repay_on_behalf  : v2,
            repay_revenue    : v3,
            liq_amount       : v4,
            collateral_price : 0x7dcc19ef54dc4866df5921dacc872cd341f403a0f6053a35ef834ebc67ab3092::price::get_price(arg5, 0x1::type_name::get<T0>(), arg6),
            debt_price       : 0x7dcc19ef54dc4866df5921dacc872cd341f403a0f6053a35ef834ebc67ab3092::price::get_price(arg5, 0x1::type_name::get<0x1ad0ff481b24a7d182ba9f6784522bdea412d9d65d07c0d278cfa5f2281c0abd::coin_gusd::COIN_GUSD>(), arg6),
            timestamp        : v1,
        };
        0x2::event::emit<LiquidateEvent>(v5);
        (0x2::coin::from_balance<0x1ad0ff481b24a7d182ba9f6784522bdea412d9d65d07c0d278cfa5f2281c0abd::coin_gusd::COIN_GUSD>(v0, arg7), 0x2::coin::from_balance<T0>(0x7dcc19ef54dc4866df5921dacc872cd341f403a0f6053a35ef834ebc67ab3092::obligation::withdraw_collateral<T0>(arg1, v4), arg7))
    }

    public fun liquidate_entry<T0>(arg0: &0x7dcc19ef54dc4866df5921dacc872cd341f403a0f6053a35ef834ebc67ab3092::version::Version, arg1: &mut 0x7dcc19ef54dc4866df5921dacc872cd341f403a0f6053a35ef834ebc67ab3092::obligation::Obligation, arg2: &mut 0x7dcc19ef54dc4866df5921dacc872cd341f403a0f6053a35ef834ebc67ab3092::market::Market, arg3: 0x2::coin::Coin<0x1ad0ff481b24a7d182ba9f6784522bdea412d9d65d07c0d278cfa5f2281c0abd::coin_gusd::COIN_GUSD>, arg4: &0x596e3f4cbfceafa0cca766cad1bd9a42ef720732c3fe786f75cc8c70575e31e::coin_decimals_registry::CoinDecimalsRegistry, arg5: &0x66895f6e3a45637db4bf50868d6b522f18f8ab35687517d3bacea4f1a3bae218::x_oracle::XOracle, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = liquidate<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x1ad0ff481b24a7d182ba9f6784522bdea412d9d65d07c0d278cfa5f2281c0abd::coin_gusd::COIN_GUSD>>(v0, 0x2::tx_context::sender(arg7));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, 0x2::tx_context::sender(arg7));
    }

    // decompiled from Move bytecode v6
}

