module 0xba1289f1d8476106664b93f5ec4d4b62d3e277f7372cd0ba740f3963c18f01b1::liquidate {
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

    public fun liquidate<T0>(arg0: &0xba1289f1d8476106664b93f5ec4d4b62d3e277f7372cd0ba740f3963c18f01b1::version::Version, arg1: &mut 0xba1289f1d8476106664b93f5ec4d4b62d3e277f7372cd0ba740f3963c18f01b1::obligation::Obligation, arg2: &mut 0xba1289f1d8476106664b93f5ec4d4b62d3e277f7372cd0ba740f3963c18f01b1::market::Market, arg3: 0x2::coin::Coin<0xf028af390aef73ad70f8bbbeb380321933a0c8a4fc8b405706d669862a762d88::coin_gusd::COIN_GUSD>, arg4: &0xd2340f9ef1088b9fdc4d02d2628fcca4b4552f71ffdb03049425fc0a3b19ce41::coin_decimals_registry::CoinDecimalsRegistry, arg5: &0x95fd973aea15879e75407f4e4c66a8d1026ad10a25360275a73b0ce44c7b09e8::x_oracle::XOracle, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0xf028af390aef73ad70f8bbbeb380321933a0c8a4fc8b405706d669862a762d88::coin_gusd::COIN_GUSD>, 0x2::coin::Coin<T0>) {
        0xba1289f1d8476106664b93f5ec4d4b62d3e277f7372cd0ba740f3963c18f01b1::version::assert_current_version(arg0);
        assert!(0xba1289f1d8476106664b93f5ec4d4b62d3e277f7372cd0ba740f3963c18f01b1::obligation::liquidate_locked(arg1) == false, 0xba1289f1d8476106664b93f5ec4d4b62d3e277f7372cd0ba740f3963c18f01b1::error::obligation_locked());
        assert!(0x2::coin::value<0xf028af390aef73ad70f8bbbeb380321933a0c8a4fc8b405706d669862a762d88::coin_gusd::COIN_GUSD>(&arg3) > 0, 0xba1289f1d8476106664b93f5ec4d4b62d3e277f7372cd0ba740f3963c18f01b1::error::zero_amount_error());
        let v0 = 0x2::coin::into_balance<0xf028af390aef73ad70f8bbbeb380321933a0c8a4fc8b405706d669862a762d88::coin_gusd::COIN_GUSD>(arg3);
        let v1 = 0x2::clock::timestamp_ms(arg6) / 1000;
        0xba1289f1d8476106664b93f5ec4d4b62d3e277f7372cd0ba740f3963c18f01b1::market::accrue_all_interests(arg2, v1);
        0xba1289f1d8476106664b93f5ec4d4b62d3e277f7372cd0ba740f3963c18f01b1::obligation::accrue_interests_and_rewards(arg1, arg2);
        let (v2, v3, v4) = 0xba1289f1d8476106664b93f5ec4d4b62d3e277f7372cd0ba740f3963c18f01b1::liquidation_evaluator::liquidation_amounts<0xf028af390aef73ad70f8bbbeb380321933a0c8a4fc8b405706d669862a762d88::coin_gusd::COIN_GUSD, T0>(arg1, arg2, arg4, 0x2::balance::value<0xf028af390aef73ad70f8bbbeb380321933a0c8a4fc8b405706d669862a762d88::coin_gusd::COIN_GUSD>(&v0), arg5, arg6);
        assert!(v4 > 0, 0xba1289f1d8476106664b93f5ec4d4b62d3e277f7372cd0ba740f3963c18f01b1::error::unable_to_liquidate_error());
        0xba1289f1d8476106664b93f5ec4d4b62d3e277f7372cd0ba740f3963c18f01b1::obligation::decrease_debt(arg1, 0x1::type_name::get<0xf028af390aef73ad70f8bbbeb380321933a0c8a4fc8b405706d669862a762d88::coin_gusd::COIN_GUSD>(), v2);
        0xba1289f1d8476106664b93f5ec4d4b62d3e277f7372cd0ba740f3963c18f01b1::market::handle_liquidation<T0>(arg2, 0x2::balance::split<0xf028af390aef73ad70f8bbbeb380321933a0c8a4fc8b405706d669862a762d88::coin_gusd::COIN_GUSD>(&mut v0, v2), 0x2::balance::split<0xf028af390aef73ad70f8bbbeb380321933a0c8a4fc8b405706d669862a762d88::coin_gusd::COIN_GUSD>(&mut v0, v3), v4, arg7);
        let v5 = LiquidateEvent{
            liquidator       : 0x2::tx_context::sender(arg7),
            obligation       : 0x2::object::id<0xba1289f1d8476106664b93f5ec4d4b62d3e277f7372cd0ba740f3963c18f01b1::obligation::Obligation>(arg1),
            debt_type        : 0x1::type_name::get<0xf028af390aef73ad70f8bbbeb380321933a0c8a4fc8b405706d669862a762d88::coin_gusd::COIN_GUSD>(),
            collateral_type  : 0x1::type_name::get<T0>(),
            repay_on_behalf  : v2,
            repay_revenue    : v3,
            liq_amount       : v4,
            collateral_price : 0xba1289f1d8476106664b93f5ec4d4b62d3e277f7372cd0ba740f3963c18f01b1::price::get_price(arg5, 0x1::type_name::get<T0>(), arg6),
            debt_price       : 0xba1289f1d8476106664b93f5ec4d4b62d3e277f7372cd0ba740f3963c18f01b1::price::get_price(arg5, 0x1::type_name::get<0xf028af390aef73ad70f8bbbeb380321933a0c8a4fc8b405706d669862a762d88::coin_gusd::COIN_GUSD>(), arg6),
            timestamp        : v1,
        };
        0x2::event::emit<LiquidateEvent>(v5);
        (0x2::coin::from_balance<0xf028af390aef73ad70f8bbbeb380321933a0c8a4fc8b405706d669862a762d88::coin_gusd::COIN_GUSD>(v0, arg7), 0x2::coin::from_balance<T0>(0xba1289f1d8476106664b93f5ec4d4b62d3e277f7372cd0ba740f3963c18f01b1::obligation::withdraw_collateral<T0>(arg1, v4), arg7))
    }

    public fun liquidate_entry<T0>(arg0: &0xba1289f1d8476106664b93f5ec4d4b62d3e277f7372cd0ba740f3963c18f01b1::version::Version, arg1: &mut 0xba1289f1d8476106664b93f5ec4d4b62d3e277f7372cd0ba740f3963c18f01b1::obligation::Obligation, arg2: &mut 0xba1289f1d8476106664b93f5ec4d4b62d3e277f7372cd0ba740f3963c18f01b1::market::Market, arg3: 0x2::coin::Coin<0xf028af390aef73ad70f8bbbeb380321933a0c8a4fc8b405706d669862a762d88::coin_gusd::COIN_GUSD>, arg4: &0xd2340f9ef1088b9fdc4d02d2628fcca4b4552f71ffdb03049425fc0a3b19ce41::coin_decimals_registry::CoinDecimalsRegistry, arg5: &0x95fd973aea15879e75407f4e4c66a8d1026ad10a25360275a73b0ce44c7b09e8::x_oracle::XOracle, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = liquidate<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xf028af390aef73ad70f8bbbeb380321933a0c8a4fc8b405706d669862a762d88::coin_gusd::COIN_GUSD>>(v0, 0x2::tx_context::sender(arg7));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, 0x2::tx_context::sender(arg7));
    }

    // decompiled from Move bytecode v6
}

