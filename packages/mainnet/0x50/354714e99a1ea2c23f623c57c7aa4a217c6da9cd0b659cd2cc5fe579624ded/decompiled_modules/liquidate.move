module 0x50354714e99a1ea2c23f623c57c7aa4a217c6da9cd0b659cd2cc5fe579624ded::liquidate {
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

    public fun liquidate<T0>(arg0: &0x50354714e99a1ea2c23f623c57c7aa4a217c6da9cd0b659cd2cc5fe579624ded::version::Version, arg1: &mut 0x50354714e99a1ea2c23f623c57c7aa4a217c6da9cd0b659cd2cc5fe579624ded::obligation::Obligation, arg2: &mut 0x50354714e99a1ea2c23f623c57c7aa4a217c6da9cd0b659cd2cc5fe579624ded::market::Market, arg3: 0x2::coin::Coin<0xc13fb492d0fd3bc1da07d90a5e3807288919884ab1ecc53894295be3c169b459::coin_gusd::COIN_GUSD>, arg4: &0xb5f004a43af64a6a75c07eab517f3b27567d58e2172c237c90e9b76db1328359::coin_decimals_registry::CoinDecimalsRegistry, arg5: &0x152f1e2b109013b019e15b5e31298cea5a104212c6e8019c682ee57cfe629e31::x_oracle::XOracle, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0xc13fb492d0fd3bc1da07d90a5e3807288919884ab1ecc53894295be3c169b459::coin_gusd::COIN_GUSD>, 0x2::coin::Coin<T0>) {
        0x50354714e99a1ea2c23f623c57c7aa4a217c6da9cd0b659cd2cc5fe579624ded::version::assert_current_version(arg0);
        assert!(0x50354714e99a1ea2c23f623c57c7aa4a217c6da9cd0b659cd2cc5fe579624ded::obligation::liquidate_locked(arg1) == false, 0x50354714e99a1ea2c23f623c57c7aa4a217c6da9cd0b659cd2cc5fe579624ded::error::obligation_locked());
        assert!(0x2::coin::value<0xc13fb492d0fd3bc1da07d90a5e3807288919884ab1ecc53894295be3c169b459::coin_gusd::COIN_GUSD>(&arg3) > 0, 0x50354714e99a1ea2c23f623c57c7aa4a217c6da9cd0b659cd2cc5fe579624ded::error::zero_amount_error());
        let v0 = 0x2::coin::into_balance<0xc13fb492d0fd3bc1da07d90a5e3807288919884ab1ecc53894295be3c169b459::coin_gusd::COIN_GUSD>(arg3);
        let v1 = 0x2::clock::timestamp_ms(arg6) / 1000;
        0x50354714e99a1ea2c23f623c57c7aa4a217c6da9cd0b659cd2cc5fe579624ded::market::accrue_all_interests(arg2, v1);
        0x50354714e99a1ea2c23f623c57c7aa4a217c6da9cd0b659cd2cc5fe579624ded::obligation::accrue_interests_and_rewards(arg1, arg2);
        let (v2, v3, v4) = 0x50354714e99a1ea2c23f623c57c7aa4a217c6da9cd0b659cd2cc5fe579624ded::liquidation_evaluator::liquidation_amounts<0xc13fb492d0fd3bc1da07d90a5e3807288919884ab1ecc53894295be3c169b459::coin_gusd::COIN_GUSD, T0>(arg1, arg2, arg4, 0x2::balance::value<0xc13fb492d0fd3bc1da07d90a5e3807288919884ab1ecc53894295be3c169b459::coin_gusd::COIN_GUSD>(&v0), arg5, arg6);
        assert!(v4 > 0, 0x50354714e99a1ea2c23f623c57c7aa4a217c6da9cd0b659cd2cc5fe579624ded::error::unable_to_liquidate_error());
        let (_, _, v7) = 0x50354714e99a1ea2c23f623c57c7aa4a217c6da9cd0b659cd2cc5fe579624ded::obligation::debt(arg1, 0x1::type_name::get<0xc13fb492d0fd3bc1da07d90a5e3807288919884ab1ecc53894295be3c169b459::coin_gusd::COIN_GUSD>());
        if (v7 > 0) {
            0x50354714e99a1ea2c23f623c57c7aa4a217c6da9cd0b659cd2cc5fe579624ded::obligation::decrease_debt_interest(arg1, 0x1::type_name::get<0xc13fb492d0fd3bc1da07d90a5e3807288919884ab1ecc53894295be3c169b459::coin_gusd::COIN_GUSD>(), 0x2::math::min(v7, v2));
        };
        0x50354714e99a1ea2c23f623c57c7aa4a217c6da9cd0b659cd2cc5fe579624ded::obligation::decrease_debt(arg1, 0x1::type_name::get<0xc13fb492d0fd3bc1da07d90a5e3807288919884ab1ecc53894295be3c169b459::coin_gusd::COIN_GUSD>(), v2);
        0x50354714e99a1ea2c23f623c57c7aa4a217c6da9cd0b659cd2cc5fe579624ded::market::handle_liquidation<T0>(arg2, 0x2::balance::split<0xc13fb492d0fd3bc1da07d90a5e3807288919884ab1ecc53894295be3c169b459::coin_gusd::COIN_GUSD>(&mut v0, v2), 0x2::balance::split<0xc13fb492d0fd3bc1da07d90a5e3807288919884ab1ecc53894295be3c169b459::coin_gusd::COIN_GUSD>(&mut v0, v3), v4, v7, arg7);
        let v8 = LiquidateEvent{
            liquidator       : 0x2::tx_context::sender(arg7),
            obligation       : 0x2::object::id<0x50354714e99a1ea2c23f623c57c7aa4a217c6da9cd0b659cd2cc5fe579624ded::obligation::Obligation>(arg1),
            debt_type        : 0x1::type_name::get<0xc13fb492d0fd3bc1da07d90a5e3807288919884ab1ecc53894295be3c169b459::coin_gusd::COIN_GUSD>(),
            collateral_type  : 0x1::type_name::get<T0>(),
            repay_on_behalf  : v2,
            repay_revenue    : v3,
            liq_amount       : v4,
            collateral_price : 0x50354714e99a1ea2c23f623c57c7aa4a217c6da9cd0b659cd2cc5fe579624ded::price::get_price(arg5, 0x1::type_name::get<T0>(), arg6),
            debt_price       : 0x50354714e99a1ea2c23f623c57c7aa4a217c6da9cd0b659cd2cc5fe579624ded::price::get_price(arg5, 0x1::type_name::get<0xc13fb492d0fd3bc1da07d90a5e3807288919884ab1ecc53894295be3c169b459::coin_gusd::COIN_GUSD>(), arg6),
            timestamp        : v1,
        };
        0x2::event::emit<LiquidateEvent>(v8);
        (0x2::coin::from_balance<0xc13fb492d0fd3bc1da07d90a5e3807288919884ab1ecc53894295be3c169b459::coin_gusd::COIN_GUSD>(v0, arg7), 0x2::coin::from_balance<T0>(0x50354714e99a1ea2c23f623c57c7aa4a217c6da9cd0b659cd2cc5fe579624ded::obligation::withdraw_collateral<T0>(arg1, v4), arg7))
    }

    public fun liquidate_entry<T0>(arg0: &0x50354714e99a1ea2c23f623c57c7aa4a217c6da9cd0b659cd2cc5fe579624ded::version::Version, arg1: &mut 0x50354714e99a1ea2c23f623c57c7aa4a217c6da9cd0b659cd2cc5fe579624ded::obligation::Obligation, arg2: &mut 0x50354714e99a1ea2c23f623c57c7aa4a217c6da9cd0b659cd2cc5fe579624ded::market::Market, arg3: 0x2::coin::Coin<0xc13fb492d0fd3bc1da07d90a5e3807288919884ab1ecc53894295be3c169b459::coin_gusd::COIN_GUSD>, arg4: &0xb5f004a43af64a6a75c07eab517f3b27567d58e2172c237c90e9b76db1328359::coin_decimals_registry::CoinDecimalsRegistry, arg5: &0x152f1e2b109013b019e15b5e31298cea5a104212c6e8019c682ee57cfe629e31::x_oracle::XOracle, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = liquidate<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xc13fb492d0fd3bc1da07d90a5e3807288919884ab1ecc53894295be3c169b459::coin_gusd::COIN_GUSD>>(v0, 0x2::tx_context::sender(arg7));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, 0x2::tx_context::sender(arg7));
    }

    // decompiled from Move bytecode v6
}

