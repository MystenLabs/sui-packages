module 0xae8efe2d8da673bc88a429e5c584c4b60114e3a0a3610ad7b789f39aa9051fc4::liquidate {
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

    public fun liquidate<T0>(arg0: &0xae8efe2d8da673bc88a429e5c584c4b60114e3a0a3610ad7b789f39aa9051fc4::version::Version, arg1: &mut 0xae8efe2d8da673bc88a429e5c584c4b60114e3a0a3610ad7b789f39aa9051fc4::obligation::Obligation, arg2: &mut 0xae8efe2d8da673bc88a429e5c584c4b60114e3a0a3610ad7b789f39aa9051fc4::market::Market, arg3: 0x2::coin::Coin<0x1d703f494d69529c135b2f8de14da5638d94cf127b6e8ca2b42d2d5658a0f11::coin_gusd::COIN_GUSD>, arg4: &0x2dc52442a27e2f2b361663c00ab56ce6da272a8f1427a1c15bf77429f8399f0a::coin_decimals_registry::CoinDecimalsRegistry, arg5: &0xa5e8e2f789e62771d342ec92fd6597f8f5b3c68193f1ac46f4c4b12cd8b4a63f::x_oracle::XOracle, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x1d703f494d69529c135b2f8de14da5638d94cf127b6e8ca2b42d2d5658a0f11::coin_gusd::COIN_GUSD>, 0x2::coin::Coin<T0>) {
        0xae8efe2d8da673bc88a429e5c584c4b60114e3a0a3610ad7b789f39aa9051fc4::version::assert_current_version(arg0);
        assert!(0xae8efe2d8da673bc88a429e5c584c4b60114e3a0a3610ad7b789f39aa9051fc4::obligation::liquidate_locked(arg1) == false, 0xae8efe2d8da673bc88a429e5c584c4b60114e3a0a3610ad7b789f39aa9051fc4::error::obligation_locked());
        assert!(0x2::coin::value<0x1d703f494d69529c135b2f8de14da5638d94cf127b6e8ca2b42d2d5658a0f11::coin_gusd::COIN_GUSD>(&arg3) > 0, 0xae8efe2d8da673bc88a429e5c584c4b60114e3a0a3610ad7b789f39aa9051fc4::error::zero_amount_error());
        let v0 = 0x2::coin::into_balance<0x1d703f494d69529c135b2f8de14da5638d94cf127b6e8ca2b42d2d5658a0f11::coin_gusd::COIN_GUSD>(arg3);
        let v1 = 0x2::clock::timestamp_ms(arg6) / 1000;
        0xae8efe2d8da673bc88a429e5c584c4b60114e3a0a3610ad7b789f39aa9051fc4::market::accrue_all_interests(arg2, v1);
        0xae8efe2d8da673bc88a429e5c584c4b60114e3a0a3610ad7b789f39aa9051fc4::obligation::accrue_interests_and_rewards(arg1, arg2);
        let (v2, v3, v4) = 0xae8efe2d8da673bc88a429e5c584c4b60114e3a0a3610ad7b789f39aa9051fc4::liquidation_evaluator::liquidation_amounts<0x1d703f494d69529c135b2f8de14da5638d94cf127b6e8ca2b42d2d5658a0f11::coin_gusd::COIN_GUSD, T0>(arg1, arg2, arg4, 0x2::balance::value<0x1d703f494d69529c135b2f8de14da5638d94cf127b6e8ca2b42d2d5658a0f11::coin_gusd::COIN_GUSD>(&v0), arg5, arg6);
        assert!(v4 > 0, 0xae8efe2d8da673bc88a429e5c584c4b60114e3a0a3610ad7b789f39aa9051fc4::error::unable_to_liquidate_error());
        let (_, _, v7) = 0xae8efe2d8da673bc88a429e5c584c4b60114e3a0a3610ad7b789f39aa9051fc4::obligation::debt(arg1, 0x1::type_name::get<0x1d703f494d69529c135b2f8de14da5638d94cf127b6e8ca2b42d2d5658a0f11::coin_gusd::COIN_GUSD>());
        0xae8efe2d8da673bc88a429e5c584c4b60114e3a0a3610ad7b789f39aa9051fc4::obligation::decrease_debt(arg1, 0x1::type_name::get<0x1d703f494d69529c135b2f8de14da5638d94cf127b6e8ca2b42d2d5658a0f11::coin_gusd::COIN_GUSD>(), v2);
        0xae8efe2d8da673bc88a429e5c584c4b60114e3a0a3610ad7b789f39aa9051fc4::obligation::decrease_debt_interest(arg1, 0x1::type_name::get<0x1d703f494d69529c135b2f8de14da5638d94cf127b6e8ca2b42d2d5658a0f11::coin_gusd::COIN_GUSD>(), 0x2::math::min(v7, v2));
        0xae8efe2d8da673bc88a429e5c584c4b60114e3a0a3610ad7b789f39aa9051fc4::market::handle_liquidation<T0>(arg2, 0x2::balance::split<0x1d703f494d69529c135b2f8de14da5638d94cf127b6e8ca2b42d2d5658a0f11::coin_gusd::COIN_GUSD>(&mut v0, v2), 0x2::balance::split<0x1d703f494d69529c135b2f8de14da5638d94cf127b6e8ca2b42d2d5658a0f11::coin_gusd::COIN_GUSD>(&mut v0, v3), v4, v7, arg7);
        let v8 = LiquidateEvent{
            liquidator       : 0x2::tx_context::sender(arg7),
            obligation       : 0x2::object::id<0xae8efe2d8da673bc88a429e5c584c4b60114e3a0a3610ad7b789f39aa9051fc4::obligation::Obligation>(arg1),
            debt_type        : 0x1::type_name::get<0x1d703f494d69529c135b2f8de14da5638d94cf127b6e8ca2b42d2d5658a0f11::coin_gusd::COIN_GUSD>(),
            collateral_type  : 0x1::type_name::get<T0>(),
            repay_on_behalf  : v2,
            repay_revenue    : v3,
            liq_amount       : v4,
            collateral_price : 0xae8efe2d8da673bc88a429e5c584c4b60114e3a0a3610ad7b789f39aa9051fc4::price::get_price(arg5, 0x1::type_name::get<T0>(), arg6),
            debt_price       : 0xae8efe2d8da673bc88a429e5c584c4b60114e3a0a3610ad7b789f39aa9051fc4::price::get_price(arg5, 0x1::type_name::get<0x1d703f494d69529c135b2f8de14da5638d94cf127b6e8ca2b42d2d5658a0f11::coin_gusd::COIN_GUSD>(), arg6),
            timestamp        : v1,
        };
        0x2::event::emit<LiquidateEvent>(v8);
        (0x2::coin::from_balance<0x1d703f494d69529c135b2f8de14da5638d94cf127b6e8ca2b42d2d5658a0f11::coin_gusd::COIN_GUSD>(v0, arg7), 0x2::coin::from_balance<T0>(0xae8efe2d8da673bc88a429e5c584c4b60114e3a0a3610ad7b789f39aa9051fc4::obligation::withdraw_collateral<T0>(arg1, v4), arg7))
    }

    public fun liquidate_entry<T0>(arg0: &0xae8efe2d8da673bc88a429e5c584c4b60114e3a0a3610ad7b789f39aa9051fc4::version::Version, arg1: &mut 0xae8efe2d8da673bc88a429e5c584c4b60114e3a0a3610ad7b789f39aa9051fc4::obligation::Obligation, arg2: &mut 0xae8efe2d8da673bc88a429e5c584c4b60114e3a0a3610ad7b789f39aa9051fc4::market::Market, arg3: 0x2::coin::Coin<0x1d703f494d69529c135b2f8de14da5638d94cf127b6e8ca2b42d2d5658a0f11::coin_gusd::COIN_GUSD>, arg4: &0x2dc52442a27e2f2b361663c00ab56ce6da272a8f1427a1c15bf77429f8399f0a::coin_decimals_registry::CoinDecimalsRegistry, arg5: &0xa5e8e2f789e62771d342ec92fd6597f8f5b3c68193f1ac46f4c4b12cd8b4a63f::x_oracle::XOracle, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = liquidate<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x1d703f494d69529c135b2f8de14da5638d94cf127b6e8ca2b42d2d5658a0f11::coin_gusd::COIN_GUSD>>(v0, 0x2::tx_context::sender(arg7));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, 0x2::tx_context::sender(arg7));
    }

    // decompiled from Move bytecode v6
}

