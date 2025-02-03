module 0x3027af7d3bde467b61f5f1141c830fe191b22febc38f32405b601b41b5a8959b::liquidate {
    struct LiquidateEvent has copy, drop {
        liquidator: address,
        obligation: 0x2::object::ID,
        debt_type: 0x1::type_name::TypeName,
        collateral_type: 0x1::type_name::TypeName,
        repay_on_behalf: u64,
        repay_revenue: u64,
        liq_amount: u64,
    }

    public fun liquidate<T0, T1>(arg0: &0x3027af7d3bde467b61f5f1141c830fe191b22febc38f32405b601b41b5a8959b::version::Version, arg1: &mut 0x3027af7d3bde467b61f5f1141c830fe191b22febc38f32405b601b41b5a8959b::obligation::Obligation, arg2: &mut 0x3027af7d3bde467b61f5f1141c830fe191b22febc38f32405b601b41b5a8959b::market::Market, arg3: 0x2::coin::Coin<T0>, arg4: &0xeeb70882d5ff9c5aacf7e162e467d884b308781feb62d4ceff9224695698be23::coin_decimals_registry::CoinDecimalsRegistry, arg5: &0x5426f3642f8bb08fb9fe78d25f543730a30b9a248bcf1bd816c6dd5d650921f2::x_oracle::XOracle, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        0x3027af7d3bde467b61f5f1141c830fe191b22febc38f32405b601b41b5a8959b::version::assert_current_version(arg0);
        assert!(0x12d776b6619ab63ce6923cfab6d5a89d964655642201b48ea83a91e42000bb92::whitelist::is_address_allowed(0x3027af7d3bde467b61f5f1141c830fe191b22febc38f32405b601b41b5a8959b::market::uid(arg2), 0x2::tx_context::sender(arg7)), 0x3027af7d3bde467b61f5f1141c830fe191b22febc38f32405b601b41b5a8959b::error::whitelist_error());
        assert!(0x3027af7d3bde467b61f5f1141c830fe191b22febc38f32405b601b41b5a8959b::obligation::liquidate_locked(arg1) == false, 0x3027af7d3bde467b61f5f1141c830fe191b22febc38f32405b601b41b5a8959b::error::obligation_locked());
        let v0 = 0x2::coin::into_balance<T0>(arg3);
        0x3027af7d3bde467b61f5f1141c830fe191b22febc38f32405b601b41b5a8959b::market::accrue_all_interests(arg2, 0x2::clock::timestamp_ms(arg6) / 1000);
        0x3027af7d3bde467b61f5f1141c830fe191b22febc38f32405b601b41b5a8959b::obligation::accrue_interests_and_rewards(arg1, arg2);
        let (v1, v2, v3) = 0x3027af7d3bde467b61f5f1141c830fe191b22febc38f32405b601b41b5a8959b::liquidation_evaluator::liquidation_amounts<T0, T1>(arg1, arg2, arg4, 0x2::balance::value<T0>(&v0), arg5, arg6);
        assert!(v3 > 0, 0x3027af7d3bde467b61f5f1141c830fe191b22febc38f32405b601b41b5a8959b::error::unable_to_liquidate_error());
        0x3027af7d3bde467b61f5f1141c830fe191b22febc38f32405b601b41b5a8959b::obligation::decrease_debt(arg1, 0x1::type_name::get<T0>(), v1);
        0x3027af7d3bde467b61f5f1141c830fe191b22febc38f32405b601b41b5a8959b::market::handle_liquidation<T0>(arg2, 0x2::balance::split<T0>(&mut v0, v1), 0x2::balance::split<T0>(&mut v0, v2));
        let v4 = LiquidateEvent{
            liquidator      : 0x2::tx_context::sender(arg7),
            obligation      : 0x2::object::id<0x3027af7d3bde467b61f5f1141c830fe191b22febc38f32405b601b41b5a8959b::obligation::Obligation>(arg1),
            debt_type       : 0x1::type_name::get<T0>(),
            collateral_type : 0x1::type_name::get<T1>(),
            repay_on_behalf : v1,
            repay_revenue   : v2,
            liq_amount      : v3,
        };
        0x2::event::emit<LiquidateEvent>(v4);
        (0x2::coin::from_balance<T0>(v0, arg7), 0x2::coin::from_balance<T1>(0x3027af7d3bde467b61f5f1141c830fe191b22febc38f32405b601b41b5a8959b::obligation::withdraw_collateral<T1>(arg1, v3), arg7))
    }

    public entry fun liquidate_entry<T0, T1>(arg0: &0x3027af7d3bde467b61f5f1141c830fe191b22febc38f32405b601b41b5a8959b::version::Version, arg1: &mut 0x3027af7d3bde467b61f5f1141c830fe191b22febc38f32405b601b41b5a8959b::obligation::Obligation, arg2: &mut 0x3027af7d3bde467b61f5f1141c830fe191b22febc38f32405b601b41b5a8959b::market::Market, arg3: 0x2::coin::Coin<T0>, arg4: &0xeeb70882d5ff9c5aacf7e162e467d884b308781feb62d4ceff9224695698be23::coin_decimals_registry::CoinDecimalsRegistry, arg5: &0x5426f3642f8bb08fb9fe78d25f543730a30b9a248bcf1bd816c6dd5d650921f2::x_oracle::XOracle, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = liquidate<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg7));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v1, 0x2::tx_context::sender(arg7));
    }

    // decompiled from Move bytecode v6
}

