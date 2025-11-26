module 0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::liquidate {
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

    public fun liquidate<T0>(arg0: &0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::version::Version, arg1: &mut 0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::obligation::Obligation, arg2: &mut 0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::market::Market, arg3: 0x2::coin::Coin<0xa4d5fe28cdff0c3427ee0c9a2eba81e6cfef7e45676268729204071896836394::coin_gusd::COIN_GUSD>, arg4: &0x177afe2b7c818730b4980df53cc683be7393d20cada006b02152d92210983a74::coin_decimals_registry::CoinDecimalsRegistry, arg5: &0x7fdc2bc8e78c3e133728c75e54fe5587b868ad59f849d8c7611147cc0394f305::x_oracle::XOracle, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0xa4d5fe28cdff0c3427ee0c9a2eba81e6cfef7e45676268729204071896836394::coin_gusd::COIN_GUSD>, 0x2::coin::Coin<T0>) {
        0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::version::assert_current_version(arg0);
        assert!(0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::obligation::liquidate_locked(arg1) == false, 0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::error::obligation_locked());
        assert!(0x2::coin::value<0xa4d5fe28cdff0c3427ee0c9a2eba81e6cfef7e45676268729204071896836394::coin_gusd::COIN_GUSD>(&arg3) > 0, 0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::error::zero_amount_error());
        let v0 = 0x2::coin::into_balance<0xa4d5fe28cdff0c3427ee0c9a2eba81e6cfef7e45676268729204071896836394::coin_gusd::COIN_GUSD>(arg3);
        let v1 = 0x2::clock::timestamp_ms(arg6) / 1000;
        0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::market::accrue_all_interests(arg2, v1);
        0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::obligation::accrue_interests_and_rewards(arg1, arg2);
        let (v2, v3, v4) = 0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::liquidation_evaluator::liquidation_amounts<0xa4d5fe28cdff0c3427ee0c9a2eba81e6cfef7e45676268729204071896836394::coin_gusd::COIN_GUSD, T0>(arg1, arg2, arg4, 0x2::balance::value<0xa4d5fe28cdff0c3427ee0c9a2eba81e6cfef7e45676268729204071896836394::coin_gusd::COIN_GUSD>(&v0), arg5, arg6);
        assert!(v4 > 0, 0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::error::unable_to_liquidate_error());
        0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::obligation::decrease_debt(arg1, 0x1::type_name::get<0xa4d5fe28cdff0c3427ee0c9a2eba81e6cfef7e45676268729204071896836394::coin_gusd::COIN_GUSD>(), v2);
        0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::market::handle_liquidation<T0>(arg2, 0x2::balance::split<0xa4d5fe28cdff0c3427ee0c9a2eba81e6cfef7e45676268729204071896836394::coin_gusd::COIN_GUSD>(&mut v0, v2), 0x2::balance::split<0xa4d5fe28cdff0c3427ee0c9a2eba81e6cfef7e45676268729204071896836394::coin_gusd::COIN_GUSD>(&mut v0, v3), v4, arg7);
        let v5 = LiquidateEvent{
            liquidator       : 0x2::tx_context::sender(arg7),
            obligation       : 0x2::object::id<0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::obligation::Obligation>(arg1),
            debt_type        : 0x1::type_name::get<0xa4d5fe28cdff0c3427ee0c9a2eba81e6cfef7e45676268729204071896836394::coin_gusd::COIN_GUSD>(),
            collateral_type  : 0x1::type_name::get<T0>(),
            repay_on_behalf  : v2,
            repay_revenue    : v3,
            liq_amount       : v4,
            collateral_price : 0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::price::get_price(arg5, 0x1::type_name::get<T0>(), arg6),
            debt_price       : 0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::price::get_price(arg5, 0x1::type_name::get<0xa4d5fe28cdff0c3427ee0c9a2eba81e6cfef7e45676268729204071896836394::coin_gusd::COIN_GUSD>(), arg6),
            timestamp        : v1,
        };
        0x2::event::emit<LiquidateEvent>(v5);
        (0x2::coin::from_balance<0xa4d5fe28cdff0c3427ee0c9a2eba81e6cfef7e45676268729204071896836394::coin_gusd::COIN_GUSD>(v0, arg7), 0x2::coin::from_balance<T0>(0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::obligation::withdraw_collateral<T0>(arg1, v4), arg7))
    }

    public fun liquidate_entry<T0>(arg0: &0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::version::Version, arg1: &mut 0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::obligation::Obligation, arg2: &mut 0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::market::Market, arg3: 0x2::coin::Coin<0xa4d5fe28cdff0c3427ee0c9a2eba81e6cfef7e45676268729204071896836394::coin_gusd::COIN_GUSD>, arg4: &0x177afe2b7c818730b4980df53cc683be7393d20cada006b02152d92210983a74::coin_decimals_registry::CoinDecimalsRegistry, arg5: &0x7fdc2bc8e78c3e133728c75e54fe5587b868ad59f849d8c7611147cc0394f305::x_oracle::XOracle, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = liquidate<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xa4d5fe28cdff0c3427ee0c9a2eba81e6cfef7e45676268729204071896836394::coin_gusd::COIN_GUSD>>(v0, 0x2::tx_context::sender(arg7));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, 0x2::tx_context::sender(arg7));
    }

    // decompiled from Move bytecode v6
}

