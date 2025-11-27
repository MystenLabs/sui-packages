module 0xaeae1f6d55b5c254c5e7f4cdc6fb86a9df1651af5905ab3ba289f10bed6ee1b2::liquidate {
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

    public fun liquidate<T0>(arg0: &0xaeae1f6d55b5c254c5e7f4cdc6fb86a9df1651af5905ab3ba289f10bed6ee1b2::version::Version, arg1: &mut 0xaeae1f6d55b5c254c5e7f4cdc6fb86a9df1651af5905ab3ba289f10bed6ee1b2::obligation::Obligation, arg2: &mut 0xaeae1f6d55b5c254c5e7f4cdc6fb86a9df1651af5905ab3ba289f10bed6ee1b2::market::Market, arg3: 0x2::coin::Coin<0x293cb7d3d070d4609d0654ee262b17f86d7c4f758e86707ec5f8602c0b9ca2a7::coin_gusd::COIN_GUSD>, arg4: &0x8ceeeb2bca5b5eb310b9436b0d7ce7d81b27ce0fb58370cbc200e2f9365730d1::coin_decimals_registry::CoinDecimalsRegistry, arg5: &0xba8ce54a8b72c404990eafcee688689fe90a76657a14d1b7b528f419808833c8::x_oracle::XOracle, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x293cb7d3d070d4609d0654ee262b17f86d7c4f758e86707ec5f8602c0b9ca2a7::coin_gusd::COIN_GUSD>, 0x2::coin::Coin<T0>) {
        0xaeae1f6d55b5c254c5e7f4cdc6fb86a9df1651af5905ab3ba289f10bed6ee1b2::version::assert_current_version(arg0);
        assert!(0xaeae1f6d55b5c254c5e7f4cdc6fb86a9df1651af5905ab3ba289f10bed6ee1b2::obligation::liquidate_locked(arg1) == false, 0xaeae1f6d55b5c254c5e7f4cdc6fb86a9df1651af5905ab3ba289f10bed6ee1b2::error::obligation_locked());
        assert!(0x2::coin::value<0x293cb7d3d070d4609d0654ee262b17f86d7c4f758e86707ec5f8602c0b9ca2a7::coin_gusd::COIN_GUSD>(&arg3) > 0, 0xaeae1f6d55b5c254c5e7f4cdc6fb86a9df1651af5905ab3ba289f10bed6ee1b2::error::zero_amount_error());
        let v0 = 0x2::coin::into_balance<0x293cb7d3d070d4609d0654ee262b17f86d7c4f758e86707ec5f8602c0b9ca2a7::coin_gusd::COIN_GUSD>(arg3);
        let v1 = 0x2::clock::timestamp_ms(arg6) / 1000;
        0xaeae1f6d55b5c254c5e7f4cdc6fb86a9df1651af5905ab3ba289f10bed6ee1b2::market::accrue_all_interests(arg2, v1);
        0xaeae1f6d55b5c254c5e7f4cdc6fb86a9df1651af5905ab3ba289f10bed6ee1b2::obligation::accrue_interests_and_rewards(arg1, arg2);
        let (v2, v3, v4) = 0xaeae1f6d55b5c254c5e7f4cdc6fb86a9df1651af5905ab3ba289f10bed6ee1b2::liquidation_evaluator::liquidation_amounts<0x293cb7d3d070d4609d0654ee262b17f86d7c4f758e86707ec5f8602c0b9ca2a7::coin_gusd::COIN_GUSD, T0>(arg1, arg2, arg4, 0x2::balance::value<0x293cb7d3d070d4609d0654ee262b17f86d7c4f758e86707ec5f8602c0b9ca2a7::coin_gusd::COIN_GUSD>(&v0), arg5, arg6);
        assert!(v4 > 0, 0xaeae1f6d55b5c254c5e7f4cdc6fb86a9df1651af5905ab3ba289f10bed6ee1b2::error::unable_to_liquidate_error());
        let (_, _, v7) = 0xaeae1f6d55b5c254c5e7f4cdc6fb86a9df1651af5905ab3ba289f10bed6ee1b2::obligation::debt(arg1, 0x1::type_name::get<0x293cb7d3d070d4609d0654ee262b17f86d7c4f758e86707ec5f8602c0b9ca2a7::coin_gusd::COIN_GUSD>());
        0xaeae1f6d55b5c254c5e7f4cdc6fb86a9df1651af5905ab3ba289f10bed6ee1b2::obligation::decrease_debt(arg1, 0x1::type_name::get<0x293cb7d3d070d4609d0654ee262b17f86d7c4f758e86707ec5f8602c0b9ca2a7::coin_gusd::COIN_GUSD>(), v2);
        0xaeae1f6d55b5c254c5e7f4cdc6fb86a9df1651af5905ab3ba289f10bed6ee1b2::obligation::decrease_debt_interest(arg1, 0x1::type_name::get<0x293cb7d3d070d4609d0654ee262b17f86d7c4f758e86707ec5f8602c0b9ca2a7::coin_gusd::COIN_GUSD>(), 0x2::math::min(v7, v2));
        0xaeae1f6d55b5c254c5e7f4cdc6fb86a9df1651af5905ab3ba289f10bed6ee1b2::market::handle_liquidation<T0>(arg2, 0x2::balance::split<0x293cb7d3d070d4609d0654ee262b17f86d7c4f758e86707ec5f8602c0b9ca2a7::coin_gusd::COIN_GUSD>(&mut v0, v2), 0x2::balance::split<0x293cb7d3d070d4609d0654ee262b17f86d7c4f758e86707ec5f8602c0b9ca2a7::coin_gusd::COIN_GUSD>(&mut v0, v3), v4, v7, arg7);
        let v8 = LiquidateEvent{
            liquidator       : 0x2::tx_context::sender(arg7),
            obligation       : 0x2::object::id<0xaeae1f6d55b5c254c5e7f4cdc6fb86a9df1651af5905ab3ba289f10bed6ee1b2::obligation::Obligation>(arg1),
            debt_type        : 0x1::type_name::get<0x293cb7d3d070d4609d0654ee262b17f86d7c4f758e86707ec5f8602c0b9ca2a7::coin_gusd::COIN_GUSD>(),
            collateral_type  : 0x1::type_name::get<T0>(),
            repay_on_behalf  : v2,
            repay_revenue    : v3,
            liq_amount       : v4,
            collateral_price : 0xaeae1f6d55b5c254c5e7f4cdc6fb86a9df1651af5905ab3ba289f10bed6ee1b2::price::get_price(arg5, 0x1::type_name::get<T0>(), arg6),
            debt_price       : 0xaeae1f6d55b5c254c5e7f4cdc6fb86a9df1651af5905ab3ba289f10bed6ee1b2::price::get_price(arg5, 0x1::type_name::get<0x293cb7d3d070d4609d0654ee262b17f86d7c4f758e86707ec5f8602c0b9ca2a7::coin_gusd::COIN_GUSD>(), arg6),
            timestamp        : v1,
        };
        0x2::event::emit<LiquidateEvent>(v8);
        (0x2::coin::from_balance<0x293cb7d3d070d4609d0654ee262b17f86d7c4f758e86707ec5f8602c0b9ca2a7::coin_gusd::COIN_GUSD>(v0, arg7), 0x2::coin::from_balance<T0>(0xaeae1f6d55b5c254c5e7f4cdc6fb86a9df1651af5905ab3ba289f10bed6ee1b2::obligation::withdraw_collateral<T0>(arg1, v4), arg7))
    }

    public fun liquidate_entry<T0>(arg0: &0xaeae1f6d55b5c254c5e7f4cdc6fb86a9df1651af5905ab3ba289f10bed6ee1b2::version::Version, arg1: &mut 0xaeae1f6d55b5c254c5e7f4cdc6fb86a9df1651af5905ab3ba289f10bed6ee1b2::obligation::Obligation, arg2: &mut 0xaeae1f6d55b5c254c5e7f4cdc6fb86a9df1651af5905ab3ba289f10bed6ee1b2::market::Market, arg3: 0x2::coin::Coin<0x293cb7d3d070d4609d0654ee262b17f86d7c4f758e86707ec5f8602c0b9ca2a7::coin_gusd::COIN_GUSD>, arg4: &0x8ceeeb2bca5b5eb310b9436b0d7ce7d81b27ce0fb58370cbc200e2f9365730d1::coin_decimals_registry::CoinDecimalsRegistry, arg5: &0xba8ce54a8b72c404990eafcee688689fe90a76657a14d1b7b528f419808833c8::x_oracle::XOracle, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = liquidate<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x293cb7d3d070d4609d0654ee262b17f86d7c4f758e86707ec5f8602c0b9ca2a7::coin_gusd::COIN_GUSD>>(v0, 0x2::tx_context::sender(arg7));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, 0x2::tx_context::sender(arg7));
    }

    // decompiled from Move bytecode v6
}

