module 0xdee35215f1c300952008b9188b2e1c5ac5e579bac8e6f678a72bc19d679d882e::liquidate {
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

    public fun liquidate<T0>(arg0: &0xdee35215f1c300952008b9188b2e1c5ac5e579bac8e6f678a72bc19d679d882e::version::Version, arg1: &mut 0xdee35215f1c300952008b9188b2e1c5ac5e579bac8e6f678a72bc19d679d882e::obligation::Obligation, arg2: &mut 0xdee35215f1c300952008b9188b2e1c5ac5e579bac8e6f678a72bc19d679d882e::market::Market, arg3: 0x2::coin::Coin<0xf63455ff6a0e224f8797c015317a14bb84a3c0334541fa88a494d36864947c0::coin_gusd::COIN_GUSD>, arg4: &0xed4cd0afbc14d8961499a2523961e371d72b6a12abdd4a0da2d39cd1ca441472::coin_decimals_registry::CoinDecimalsRegistry, arg5: &0x58908fcf6fe6711a482ab9dc4000d5c9f2ab753c34298843c2a96a534f7fae1d::x_oracle::XOracle, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0xf63455ff6a0e224f8797c015317a14bb84a3c0334541fa88a494d36864947c0::coin_gusd::COIN_GUSD>, 0x2::coin::Coin<T0>) {
        0xdee35215f1c300952008b9188b2e1c5ac5e579bac8e6f678a72bc19d679d882e::version::assert_current_version(arg0);
        assert!(0xdee35215f1c300952008b9188b2e1c5ac5e579bac8e6f678a72bc19d679d882e::obligation::liquidate_locked(arg1) == false, 0xdee35215f1c300952008b9188b2e1c5ac5e579bac8e6f678a72bc19d679d882e::error::obligation_locked());
        assert!(0x2::coin::value<0xf63455ff6a0e224f8797c015317a14bb84a3c0334541fa88a494d36864947c0::coin_gusd::COIN_GUSD>(&arg3) > 0, 0xdee35215f1c300952008b9188b2e1c5ac5e579bac8e6f678a72bc19d679d882e::error::zero_amount_error());
        let v0 = 0x2::coin::into_balance<0xf63455ff6a0e224f8797c015317a14bb84a3c0334541fa88a494d36864947c0::coin_gusd::COIN_GUSD>(arg3);
        let v1 = 0x2::clock::timestamp_ms(arg6) / 1000;
        0xdee35215f1c300952008b9188b2e1c5ac5e579bac8e6f678a72bc19d679d882e::market::accrue_all_interests(arg2, v1);
        0xdee35215f1c300952008b9188b2e1c5ac5e579bac8e6f678a72bc19d679d882e::obligation::accrue_interests_and_rewards(arg1, arg2);
        let (v2, v3, v4) = 0xdee35215f1c300952008b9188b2e1c5ac5e579bac8e6f678a72bc19d679d882e::liquidation_evaluator::liquidation_amounts<0xf63455ff6a0e224f8797c015317a14bb84a3c0334541fa88a494d36864947c0::coin_gusd::COIN_GUSD, T0>(arg1, arg2, arg4, 0x2::balance::value<0xf63455ff6a0e224f8797c015317a14bb84a3c0334541fa88a494d36864947c0::coin_gusd::COIN_GUSD>(&v0), arg5, arg6);
        assert!(v4 > 0, 0xdee35215f1c300952008b9188b2e1c5ac5e579bac8e6f678a72bc19d679d882e::error::unable_to_liquidate_error());
        let (_, _, v7) = 0xdee35215f1c300952008b9188b2e1c5ac5e579bac8e6f678a72bc19d679d882e::obligation::debt(arg1, 0x1::type_name::get<0xf63455ff6a0e224f8797c015317a14bb84a3c0334541fa88a494d36864947c0::coin_gusd::COIN_GUSD>());
        0xdee35215f1c300952008b9188b2e1c5ac5e579bac8e6f678a72bc19d679d882e::obligation::decrease_debt(arg1, 0x1::type_name::get<0xf63455ff6a0e224f8797c015317a14bb84a3c0334541fa88a494d36864947c0::coin_gusd::COIN_GUSD>(), v2);
        0xdee35215f1c300952008b9188b2e1c5ac5e579bac8e6f678a72bc19d679d882e::obligation::decrease_debt_interest(arg1, 0x1::type_name::get<0xf63455ff6a0e224f8797c015317a14bb84a3c0334541fa88a494d36864947c0::coin_gusd::COIN_GUSD>(), 0x2::math::min(v7, v2));
        0xdee35215f1c300952008b9188b2e1c5ac5e579bac8e6f678a72bc19d679d882e::market::handle_liquidation<T0>(arg2, 0x2::balance::split<0xf63455ff6a0e224f8797c015317a14bb84a3c0334541fa88a494d36864947c0::coin_gusd::COIN_GUSD>(&mut v0, v2), 0x2::balance::split<0xf63455ff6a0e224f8797c015317a14bb84a3c0334541fa88a494d36864947c0::coin_gusd::COIN_GUSD>(&mut v0, v3), v4, v7, arg7);
        let v8 = LiquidateEvent{
            liquidator       : 0x2::tx_context::sender(arg7),
            obligation       : 0x2::object::id<0xdee35215f1c300952008b9188b2e1c5ac5e579bac8e6f678a72bc19d679d882e::obligation::Obligation>(arg1),
            debt_type        : 0x1::type_name::get<0xf63455ff6a0e224f8797c015317a14bb84a3c0334541fa88a494d36864947c0::coin_gusd::COIN_GUSD>(),
            collateral_type  : 0x1::type_name::get<T0>(),
            repay_on_behalf  : v2,
            repay_revenue    : v3,
            liq_amount       : v4,
            collateral_price : 0xdee35215f1c300952008b9188b2e1c5ac5e579bac8e6f678a72bc19d679d882e::price::get_price(arg5, 0x1::type_name::get<T0>(), arg6),
            debt_price       : 0xdee35215f1c300952008b9188b2e1c5ac5e579bac8e6f678a72bc19d679d882e::price::get_price(arg5, 0x1::type_name::get<0xf63455ff6a0e224f8797c015317a14bb84a3c0334541fa88a494d36864947c0::coin_gusd::COIN_GUSD>(), arg6),
            timestamp        : v1,
        };
        0x2::event::emit<LiquidateEvent>(v8);
        (0x2::coin::from_balance<0xf63455ff6a0e224f8797c015317a14bb84a3c0334541fa88a494d36864947c0::coin_gusd::COIN_GUSD>(v0, arg7), 0x2::coin::from_balance<T0>(0xdee35215f1c300952008b9188b2e1c5ac5e579bac8e6f678a72bc19d679d882e::obligation::withdraw_collateral<T0>(arg1, v4), arg7))
    }

    public fun liquidate_entry<T0>(arg0: &0xdee35215f1c300952008b9188b2e1c5ac5e579bac8e6f678a72bc19d679d882e::version::Version, arg1: &mut 0xdee35215f1c300952008b9188b2e1c5ac5e579bac8e6f678a72bc19d679d882e::obligation::Obligation, arg2: &mut 0xdee35215f1c300952008b9188b2e1c5ac5e579bac8e6f678a72bc19d679d882e::market::Market, arg3: 0x2::coin::Coin<0xf63455ff6a0e224f8797c015317a14bb84a3c0334541fa88a494d36864947c0::coin_gusd::COIN_GUSD>, arg4: &0xed4cd0afbc14d8961499a2523961e371d72b6a12abdd4a0da2d39cd1ca441472::coin_decimals_registry::CoinDecimalsRegistry, arg5: &0x58908fcf6fe6711a482ab9dc4000d5c9f2ab753c34298843c2a96a534f7fae1d::x_oracle::XOracle, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = liquidate<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xf63455ff6a0e224f8797c015317a14bb84a3c0334541fa88a494d36864947c0::coin_gusd::COIN_GUSD>>(v0, 0x2::tx_context::sender(arg7));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, 0x2::tx_context::sender(arg7));
    }

    // decompiled from Move bytecode v6
}

