module 0xa1bfbe88858dad2d113585ef40e86220fa67086ea7b860a34f46e69c82761549::liquidate {
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

    public fun liquidate<T0>(arg0: &0xa1bfbe88858dad2d113585ef40e86220fa67086ea7b860a34f46e69c82761549::version::Version, arg1: &mut 0xa1bfbe88858dad2d113585ef40e86220fa67086ea7b860a34f46e69c82761549::obligation::Obligation, arg2: &mut 0xa1bfbe88858dad2d113585ef40e86220fa67086ea7b860a34f46e69c82761549::market::Market, arg3: 0x2::coin::Coin<0x5f783fa9d2af7423e98747d0a0b39d0c6e06c6551e712e9c11d86a5721458e4f::coin_gusd::COIN_GUSD>, arg4: &0x85f92dbca022a519c6071cc358948a2e8c398fc9aed167cb1f0b0288bf9a1479::coin_decimals_registry::CoinDecimalsRegistry, arg5: &0x64d704ec79adb95f308732d510907b6673db75fb3edabb3f7dc1e527094d3143::x_oracle::XOracle, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x5f783fa9d2af7423e98747d0a0b39d0c6e06c6551e712e9c11d86a5721458e4f::coin_gusd::COIN_GUSD>, 0x2::coin::Coin<T0>) {
        0xa1bfbe88858dad2d113585ef40e86220fa67086ea7b860a34f46e69c82761549::version::assert_current_version(arg0);
        assert!(0xa1bfbe88858dad2d113585ef40e86220fa67086ea7b860a34f46e69c82761549::obligation::liquidate_locked(arg1) == false, 0xa1bfbe88858dad2d113585ef40e86220fa67086ea7b860a34f46e69c82761549::error::obligation_locked());
        assert!(0x2::coin::value<0x5f783fa9d2af7423e98747d0a0b39d0c6e06c6551e712e9c11d86a5721458e4f::coin_gusd::COIN_GUSD>(&arg3) > 0, 0xa1bfbe88858dad2d113585ef40e86220fa67086ea7b860a34f46e69c82761549::error::zero_amount_error());
        let v0 = 0x2::coin::into_balance<0x5f783fa9d2af7423e98747d0a0b39d0c6e06c6551e712e9c11d86a5721458e4f::coin_gusd::COIN_GUSD>(arg3);
        let v1 = 0x2::clock::timestamp_ms(arg6) / 1000;
        0xa1bfbe88858dad2d113585ef40e86220fa67086ea7b860a34f46e69c82761549::market::accrue_all_interests(arg2, v1);
        0xa1bfbe88858dad2d113585ef40e86220fa67086ea7b860a34f46e69c82761549::obligation::accrue_interests_and_rewards(arg1, arg2);
        let (v2, v3, v4) = 0xa1bfbe88858dad2d113585ef40e86220fa67086ea7b860a34f46e69c82761549::liquidation_evaluator::liquidation_amounts<0x5f783fa9d2af7423e98747d0a0b39d0c6e06c6551e712e9c11d86a5721458e4f::coin_gusd::COIN_GUSD, T0>(arg1, arg2, arg4, 0x2::balance::value<0x5f783fa9d2af7423e98747d0a0b39d0c6e06c6551e712e9c11d86a5721458e4f::coin_gusd::COIN_GUSD>(&v0), arg5, arg6);
        assert!(v4 > 0, 0xa1bfbe88858dad2d113585ef40e86220fa67086ea7b860a34f46e69c82761549::error::unable_to_liquidate_error());
        let (_, _, v7) = 0xa1bfbe88858dad2d113585ef40e86220fa67086ea7b860a34f46e69c82761549::obligation::debt(arg1, 0x1::type_name::get<0x5f783fa9d2af7423e98747d0a0b39d0c6e06c6551e712e9c11d86a5721458e4f::coin_gusd::COIN_GUSD>());
        0xa1bfbe88858dad2d113585ef40e86220fa67086ea7b860a34f46e69c82761549::obligation::decrease_debt(arg1, 0x1::type_name::get<0x5f783fa9d2af7423e98747d0a0b39d0c6e06c6551e712e9c11d86a5721458e4f::coin_gusd::COIN_GUSD>(), v2);
        0xa1bfbe88858dad2d113585ef40e86220fa67086ea7b860a34f46e69c82761549::obligation::decrease_debt_interest(arg1, 0x1::type_name::get<0x5f783fa9d2af7423e98747d0a0b39d0c6e06c6551e712e9c11d86a5721458e4f::coin_gusd::COIN_GUSD>(), 0x2::math::min(v7, v2));
        0xa1bfbe88858dad2d113585ef40e86220fa67086ea7b860a34f46e69c82761549::market::handle_liquidation<T0>(arg2, 0x2::balance::split<0x5f783fa9d2af7423e98747d0a0b39d0c6e06c6551e712e9c11d86a5721458e4f::coin_gusd::COIN_GUSD>(&mut v0, v2), 0x2::balance::split<0x5f783fa9d2af7423e98747d0a0b39d0c6e06c6551e712e9c11d86a5721458e4f::coin_gusd::COIN_GUSD>(&mut v0, v3), v4, v7, arg7);
        let v8 = LiquidateEvent{
            liquidator       : 0x2::tx_context::sender(arg7),
            obligation       : 0x2::object::id<0xa1bfbe88858dad2d113585ef40e86220fa67086ea7b860a34f46e69c82761549::obligation::Obligation>(arg1),
            debt_type        : 0x1::type_name::get<0x5f783fa9d2af7423e98747d0a0b39d0c6e06c6551e712e9c11d86a5721458e4f::coin_gusd::COIN_GUSD>(),
            collateral_type  : 0x1::type_name::get<T0>(),
            repay_on_behalf  : v2,
            repay_revenue    : v3,
            liq_amount       : v4,
            collateral_price : 0xa1bfbe88858dad2d113585ef40e86220fa67086ea7b860a34f46e69c82761549::price::get_price(arg5, 0x1::type_name::get<T0>(), arg6),
            debt_price       : 0xa1bfbe88858dad2d113585ef40e86220fa67086ea7b860a34f46e69c82761549::price::get_price(arg5, 0x1::type_name::get<0x5f783fa9d2af7423e98747d0a0b39d0c6e06c6551e712e9c11d86a5721458e4f::coin_gusd::COIN_GUSD>(), arg6),
            timestamp        : v1,
        };
        0x2::event::emit<LiquidateEvent>(v8);
        (0x2::coin::from_balance<0x5f783fa9d2af7423e98747d0a0b39d0c6e06c6551e712e9c11d86a5721458e4f::coin_gusd::COIN_GUSD>(v0, arg7), 0x2::coin::from_balance<T0>(0xa1bfbe88858dad2d113585ef40e86220fa67086ea7b860a34f46e69c82761549::obligation::withdraw_collateral<T0>(arg1, v4), arg7))
    }

    public fun liquidate_entry<T0>(arg0: &0xa1bfbe88858dad2d113585ef40e86220fa67086ea7b860a34f46e69c82761549::version::Version, arg1: &mut 0xa1bfbe88858dad2d113585ef40e86220fa67086ea7b860a34f46e69c82761549::obligation::Obligation, arg2: &mut 0xa1bfbe88858dad2d113585ef40e86220fa67086ea7b860a34f46e69c82761549::market::Market, arg3: 0x2::coin::Coin<0x5f783fa9d2af7423e98747d0a0b39d0c6e06c6551e712e9c11d86a5721458e4f::coin_gusd::COIN_GUSD>, arg4: &0x85f92dbca022a519c6071cc358948a2e8c398fc9aed167cb1f0b0288bf9a1479::coin_decimals_registry::CoinDecimalsRegistry, arg5: &0x64d704ec79adb95f308732d510907b6673db75fb3edabb3f7dc1e527094d3143::x_oracle::XOracle, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = liquidate<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x5f783fa9d2af7423e98747d0a0b39d0c6e06c6551e712e9c11d86a5721458e4f::coin_gusd::COIN_GUSD>>(v0, 0x2::tx_context::sender(arg7));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, 0x2::tx_context::sender(arg7));
    }

    // decompiled from Move bytecode v6
}

