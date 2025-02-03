module 0xe43c9165051f207c76d4607a86394cc952d55099c91d4d818052c8f5c52070f3::liquidate {
    struct LiquidateEvent has copy, drop {
        liquidator: address,
        obligation: 0x2::object::ID,
        debt_type: 0x1::type_name::TypeName,
        collateral_type: 0x1::type_name::TypeName,
        repay_on_behalf: u64,
        repay_revenue: u64,
        liq_amount: u64,
    }

    public fun liquidate<T0, T1>(arg0: &0xe43c9165051f207c76d4607a86394cc952d55099c91d4d818052c8f5c52070f3::version::Version, arg1: &mut 0xe43c9165051f207c76d4607a86394cc952d55099c91d4d818052c8f5c52070f3::obligation::Obligation, arg2: &mut 0xe43c9165051f207c76d4607a86394cc952d55099c91d4d818052c8f5c52070f3::market::Market, arg3: 0x2::coin::Coin<T0>, arg4: &0x169b9acc361b079b9f58d87ea3c51546a1564ed374d1f4d25dba4e3684481695::coin_decimals_registry::CoinDecimalsRegistry, arg5: &0x66f4d8dce7fe98d445fd832e864756fc7666d540f1558176eb1434ecd0c52a11::x_oracle::XOracle, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        0xe43c9165051f207c76d4607a86394cc952d55099c91d4d818052c8f5c52070f3::version::assert_current_version(arg0);
        assert!(0x2da61c07dec5b60272c576ecd96a8f95e067b5e4387dc31b41ab6a12a49086db::whitelist::is_address_allowed(0xe43c9165051f207c76d4607a86394cc952d55099c91d4d818052c8f5c52070f3::market::uid(arg2), 0x2::tx_context::sender(arg7)), 0xe43c9165051f207c76d4607a86394cc952d55099c91d4d818052c8f5c52070f3::error::whitelist_error());
        assert!(0xe43c9165051f207c76d4607a86394cc952d55099c91d4d818052c8f5c52070f3::obligation::liquidate_locked(arg1) == false, 0xe43c9165051f207c76d4607a86394cc952d55099c91d4d818052c8f5c52070f3::error::obligation_locked());
        let v0 = 0x2::coin::into_balance<T0>(arg3);
        0xe43c9165051f207c76d4607a86394cc952d55099c91d4d818052c8f5c52070f3::market::accrue_all_interests(arg2, 0x2::clock::timestamp_ms(arg6) / 1000);
        0xe43c9165051f207c76d4607a86394cc952d55099c91d4d818052c8f5c52070f3::obligation::accrue_interests_and_rewards(arg1, arg2);
        let (v1, v2, v3) = 0xe43c9165051f207c76d4607a86394cc952d55099c91d4d818052c8f5c52070f3::liquidation_evaluator::liquidation_amounts<T0, T1>(arg1, arg2, arg4, 0x2::balance::value<T0>(&v0), arg5, arg6);
        assert!(v3 > 0, 0xe43c9165051f207c76d4607a86394cc952d55099c91d4d818052c8f5c52070f3::error::unable_to_liquidate_error());
        0xe43c9165051f207c76d4607a86394cc952d55099c91d4d818052c8f5c52070f3::obligation::decrease_debt(arg1, 0x1::type_name::get<T0>(), v1);
        0xe43c9165051f207c76d4607a86394cc952d55099c91d4d818052c8f5c52070f3::market::handle_liquidation<T0>(arg2, 0x2::balance::split<T0>(&mut v0, v1), 0x2::balance::split<T0>(&mut v0, v2));
        let v4 = LiquidateEvent{
            liquidator      : 0x2::tx_context::sender(arg7),
            obligation      : 0x2::object::id<0xe43c9165051f207c76d4607a86394cc952d55099c91d4d818052c8f5c52070f3::obligation::Obligation>(arg1),
            debt_type       : 0x1::type_name::get<T0>(),
            collateral_type : 0x1::type_name::get<T1>(),
            repay_on_behalf : v1,
            repay_revenue   : v2,
            liq_amount      : v3,
        };
        0x2::event::emit<LiquidateEvent>(v4);
        (0x2::coin::from_balance<T0>(v0, arg7), 0x2::coin::from_balance<T1>(0xe43c9165051f207c76d4607a86394cc952d55099c91d4d818052c8f5c52070f3::obligation::withdraw_collateral<T1>(arg1, v3), arg7))
    }

    public entry fun liquidate_entry<T0, T1>(arg0: &0xe43c9165051f207c76d4607a86394cc952d55099c91d4d818052c8f5c52070f3::version::Version, arg1: &mut 0xe43c9165051f207c76d4607a86394cc952d55099c91d4d818052c8f5c52070f3::obligation::Obligation, arg2: &mut 0xe43c9165051f207c76d4607a86394cc952d55099c91d4d818052c8f5c52070f3::market::Market, arg3: 0x2::coin::Coin<T0>, arg4: &0x169b9acc361b079b9f58d87ea3c51546a1564ed374d1f4d25dba4e3684481695::coin_decimals_registry::CoinDecimalsRegistry, arg5: &0x66f4d8dce7fe98d445fd832e864756fc7666d540f1558176eb1434ecd0c52a11::x_oracle::XOracle, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = liquidate<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg7));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v1, 0x2::tx_context::sender(arg7));
    }

    // decompiled from Move bytecode v6
}

