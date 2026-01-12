module 0x7ac3d8f55df5472a7f5e57da7e84f61a3f091fc1a912e140d347c0d7bf954d1d::liquidate {
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

    public fun liquidate<T0>(arg0: &0x7ac3d8f55df5472a7f5e57da7e84f61a3f091fc1a912e140d347c0d7bf954d1d::version::Version, arg1: &mut 0x7ac3d8f55df5472a7f5e57da7e84f61a3f091fc1a912e140d347c0d7bf954d1d::obligation::Obligation, arg2: &mut 0x7ac3d8f55df5472a7f5e57da7e84f61a3f091fc1a912e140d347c0d7bf954d1d::market::Market, arg3: 0x2::coin::Coin<0x46fe03da9891419ee9a20c2fa445a14aef81446a76f70324cd91abac543ec96a::coin_gusd::COIN_GUSD>, arg4: &0x413d4cf3221e98f4096aabcab4edc84b9e66f60f2239e5cdbf6e49ee2916c7e0::coin_decimals_registry::CoinDecimalsRegistry, arg5: &0x4f0be0e70afb81670fd135b4201270997f9a32a2dccddaa3925825fe5a8b4c2a::x_oracle::XOracle, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x46fe03da9891419ee9a20c2fa445a14aef81446a76f70324cd91abac543ec96a::coin_gusd::COIN_GUSD>, 0x2::coin::Coin<T0>) {
        0x7ac3d8f55df5472a7f5e57da7e84f61a3f091fc1a912e140d347c0d7bf954d1d::version::assert_current_version(arg0);
        assert!(0x7ac3d8f55df5472a7f5e57da7e84f61a3f091fc1a912e140d347c0d7bf954d1d::obligation::liquidate_locked(arg1) == false, 0x7ac3d8f55df5472a7f5e57da7e84f61a3f091fc1a912e140d347c0d7bf954d1d::error::obligation_locked());
        assert!(0x2::coin::value<0x46fe03da9891419ee9a20c2fa445a14aef81446a76f70324cd91abac543ec96a::coin_gusd::COIN_GUSD>(&arg3) > 0, 0x7ac3d8f55df5472a7f5e57da7e84f61a3f091fc1a912e140d347c0d7bf954d1d::error::zero_amount_error());
        let v0 = 0x2::coin::into_balance<0x46fe03da9891419ee9a20c2fa445a14aef81446a76f70324cd91abac543ec96a::coin_gusd::COIN_GUSD>(arg3);
        let v1 = 0x2::clock::timestamp_ms(arg6) / 1000;
        0x7ac3d8f55df5472a7f5e57da7e84f61a3f091fc1a912e140d347c0d7bf954d1d::market::accrue_all_interests(arg2, v1);
        0x7ac3d8f55df5472a7f5e57da7e84f61a3f091fc1a912e140d347c0d7bf954d1d::obligation::accrue_interests_and_rewards(arg1, arg2);
        let (v2, v3, v4) = 0x7ac3d8f55df5472a7f5e57da7e84f61a3f091fc1a912e140d347c0d7bf954d1d::liquidation_evaluator::liquidation_amounts<0x46fe03da9891419ee9a20c2fa445a14aef81446a76f70324cd91abac543ec96a::coin_gusd::COIN_GUSD, T0>(arg1, arg2, arg4, 0x2::balance::value<0x46fe03da9891419ee9a20c2fa445a14aef81446a76f70324cd91abac543ec96a::coin_gusd::COIN_GUSD>(&v0), arg5, arg6);
        assert!(v4 > 0, 0x7ac3d8f55df5472a7f5e57da7e84f61a3f091fc1a912e140d347c0d7bf954d1d::error::unable_to_liquidate_error());
        let (_, _, v7) = 0x7ac3d8f55df5472a7f5e57da7e84f61a3f091fc1a912e140d347c0d7bf954d1d::obligation::debt(arg1, 0x1::type_name::get<0x46fe03da9891419ee9a20c2fa445a14aef81446a76f70324cd91abac543ec96a::coin_gusd::COIN_GUSD>());
        if (v7 > 0) {
            0x7ac3d8f55df5472a7f5e57da7e84f61a3f091fc1a912e140d347c0d7bf954d1d::obligation::decrease_debt_interest(arg1, 0x1::type_name::get<0x46fe03da9891419ee9a20c2fa445a14aef81446a76f70324cd91abac543ec96a::coin_gusd::COIN_GUSD>(), 0x2::math::min(v7, v2));
        };
        0x7ac3d8f55df5472a7f5e57da7e84f61a3f091fc1a912e140d347c0d7bf954d1d::obligation::decrease_debt(arg1, 0x1::type_name::get<0x46fe03da9891419ee9a20c2fa445a14aef81446a76f70324cd91abac543ec96a::coin_gusd::COIN_GUSD>(), v2);
        0x7ac3d8f55df5472a7f5e57da7e84f61a3f091fc1a912e140d347c0d7bf954d1d::market::handle_liquidation<T0>(arg2, 0x2::balance::split<0x46fe03da9891419ee9a20c2fa445a14aef81446a76f70324cd91abac543ec96a::coin_gusd::COIN_GUSD>(&mut v0, v2), 0x2::balance::split<0x46fe03da9891419ee9a20c2fa445a14aef81446a76f70324cd91abac543ec96a::coin_gusd::COIN_GUSD>(&mut v0, v3), v4, v7, arg7);
        let v8 = LiquidateEvent{
            liquidator       : 0x2::tx_context::sender(arg7),
            obligation       : 0x2::object::id<0x7ac3d8f55df5472a7f5e57da7e84f61a3f091fc1a912e140d347c0d7bf954d1d::obligation::Obligation>(arg1),
            debt_type        : 0x1::type_name::get<0x46fe03da9891419ee9a20c2fa445a14aef81446a76f70324cd91abac543ec96a::coin_gusd::COIN_GUSD>(),
            collateral_type  : 0x1::type_name::get<T0>(),
            repay_on_behalf  : v2,
            repay_revenue    : v3,
            liq_amount       : v4,
            collateral_price : 0x7ac3d8f55df5472a7f5e57da7e84f61a3f091fc1a912e140d347c0d7bf954d1d::price::get_price(arg5, 0x1::type_name::get<T0>(), arg6),
            debt_price       : 0x7ac3d8f55df5472a7f5e57da7e84f61a3f091fc1a912e140d347c0d7bf954d1d::price::get_price(arg5, 0x1::type_name::get<0x46fe03da9891419ee9a20c2fa445a14aef81446a76f70324cd91abac543ec96a::coin_gusd::COIN_GUSD>(), arg6),
            timestamp        : v1,
        };
        0x2::event::emit<LiquidateEvent>(v8);
        (0x2::coin::from_balance<0x46fe03da9891419ee9a20c2fa445a14aef81446a76f70324cd91abac543ec96a::coin_gusd::COIN_GUSD>(v0, arg7), 0x2::coin::from_balance<T0>(0x7ac3d8f55df5472a7f5e57da7e84f61a3f091fc1a912e140d347c0d7bf954d1d::obligation::withdraw_collateral<T0>(arg1, v4), arg7))
    }

    public fun liquidate_entry<T0>(arg0: &0x7ac3d8f55df5472a7f5e57da7e84f61a3f091fc1a912e140d347c0d7bf954d1d::version::Version, arg1: &mut 0x7ac3d8f55df5472a7f5e57da7e84f61a3f091fc1a912e140d347c0d7bf954d1d::obligation::Obligation, arg2: &mut 0x7ac3d8f55df5472a7f5e57da7e84f61a3f091fc1a912e140d347c0d7bf954d1d::market::Market, arg3: 0x2::coin::Coin<0x46fe03da9891419ee9a20c2fa445a14aef81446a76f70324cd91abac543ec96a::coin_gusd::COIN_GUSD>, arg4: &0x413d4cf3221e98f4096aabcab4edc84b9e66f60f2239e5cdbf6e49ee2916c7e0::coin_decimals_registry::CoinDecimalsRegistry, arg5: &0x4f0be0e70afb81670fd135b4201270997f9a32a2dccddaa3925825fe5a8b4c2a::x_oracle::XOracle, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = liquidate<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x46fe03da9891419ee9a20c2fa445a14aef81446a76f70324cd91abac543ec96a::coin_gusd::COIN_GUSD>>(v0, 0x2::tx_context::sender(arg7));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, 0x2::tx_context::sender(arg7));
    }

    // decompiled from Move bytecode v6
}

