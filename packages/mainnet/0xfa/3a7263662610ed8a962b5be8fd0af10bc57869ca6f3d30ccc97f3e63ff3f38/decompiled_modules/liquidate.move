module 0xfa3a7263662610ed8a962b5be8fd0af10bc57869ca6f3d30ccc97f3e63ff3f38::liquidate {
    struct LiquidateEvent has copy, drop {
        liquidator: address,
        obligation: 0x2::object::ID,
        debt_type: 0x1::type_name::TypeName,
        collateral_type: 0x1::type_name::TypeName,
        repay_on_behalf: u64,
        repay_revenue: u64,
        liq_amount: u64,
    }

    public fun liquidate<T0, T1>(arg0: &0xfa3a7263662610ed8a962b5be8fd0af10bc57869ca6f3d30ccc97f3e63ff3f38::version::Version, arg1: &mut 0xfa3a7263662610ed8a962b5be8fd0af10bc57869ca6f3d30ccc97f3e63ff3f38::obligation::Obligation, arg2: &mut 0xfa3a7263662610ed8a962b5be8fd0af10bc57869ca6f3d30ccc97f3e63ff3f38::market::Market, arg3: 0x2::coin::Coin<T0>, arg4: &0xfa3a7263662610ed8a962b5be8fd0af10bc57869ca6f3d30ccc97f3e63ff3f38::coin_decimals_registry::CoinDecimalsRegistry, arg5: &0xfa3a7263662610ed8a962b5be8fd0af10bc57869ca6f3d30ccc97f3e63ff3f38::x_oracle::XOracle, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        0xfa3a7263662610ed8a962b5be8fd0af10bc57869ca6f3d30ccc97f3e63ff3f38::version::assert_current_version(arg0);
        assert!(0xfa3a7263662610ed8a962b5be8fd0af10bc57869ca6f3d30ccc97f3e63ff3f38::whitelist::is_address_allowed(0xfa3a7263662610ed8a962b5be8fd0af10bc57869ca6f3d30ccc97f3e63ff3f38::market::uid(arg2), 0x2::tx_context::sender(arg7)), 0xfa3a7263662610ed8a962b5be8fd0af10bc57869ca6f3d30ccc97f3e63ff3f38::error::whitelist_error());
        assert!(0xfa3a7263662610ed8a962b5be8fd0af10bc57869ca6f3d30ccc97f3e63ff3f38::obligation::liquidate_locked(arg1) == false, 0xfa3a7263662610ed8a962b5be8fd0af10bc57869ca6f3d30ccc97f3e63ff3f38::error::obligation_locked());
        let v0 = 0x2::coin::into_balance<T0>(arg3);
        let v1 = 0x2::clock::timestamp_ms(arg6) / 1000;
        0xfa3a7263662610ed8a962b5be8fd0af10bc57869ca6f3d30ccc97f3e63ff3f38::market::accrue_all_interests(arg2, v1);
        0xfa3a7263662610ed8a962b5be8fd0af10bc57869ca6f3d30ccc97f3e63ff3f38::obligation::accrue_interests_and_rewards(arg1, arg2);
        let (v2, v3, v4) = 0xfa3a7263662610ed8a962b5be8fd0af10bc57869ca6f3d30ccc97f3e63ff3f38::liquidation_evaluator::liquidation_amounts<T0, T1>(arg1, arg2, arg4, 0x2::balance::value<T0>(&v0), arg5, arg6);
        assert!(v4 > 0, 0xfa3a7263662610ed8a962b5be8fd0af10bc57869ca6f3d30ccc97f3e63ff3f38::error::unable_to_liquidate_error());
        0xfa3a7263662610ed8a962b5be8fd0af10bc57869ca6f3d30ccc97f3e63ff3f38::obligation::decrease_debt(arg1, 0x1::type_name::get<T0>(), v2);
        0xfa3a7263662610ed8a962b5be8fd0af10bc57869ca6f3d30ccc97f3e63ff3f38::market::handle_inflow<T0>(arg2, v2, v1);
        0xfa3a7263662610ed8a962b5be8fd0af10bc57869ca6f3d30ccc97f3e63ff3f38::market::handle_liquidation<T0, T1>(arg2, 0x2::balance::split<T0>(&mut v0, v2), 0x2::balance::split<T0>(&mut v0, v3), v4);
        let v5 = LiquidateEvent{
            liquidator      : 0x2::tx_context::sender(arg7),
            obligation      : 0x2::object::id<0xfa3a7263662610ed8a962b5be8fd0af10bc57869ca6f3d30ccc97f3e63ff3f38::obligation::Obligation>(arg1),
            debt_type       : 0x1::type_name::get<T0>(),
            collateral_type : 0x1::type_name::get<T1>(),
            repay_on_behalf : v2,
            repay_revenue   : v3,
            liq_amount      : v4,
        };
        0x2::event::emit<LiquidateEvent>(v5);
        (0x2::coin::from_balance<T0>(v0, arg7), 0x2::coin::from_balance<T1>(0xfa3a7263662610ed8a962b5be8fd0af10bc57869ca6f3d30ccc97f3e63ff3f38::obligation::withdraw_collateral<T1>(arg1, v4), arg7))
    }

    public entry fun liquidate_entry<T0, T1>(arg0: &0xfa3a7263662610ed8a962b5be8fd0af10bc57869ca6f3d30ccc97f3e63ff3f38::version::Version, arg1: &mut 0xfa3a7263662610ed8a962b5be8fd0af10bc57869ca6f3d30ccc97f3e63ff3f38::obligation::Obligation, arg2: &mut 0xfa3a7263662610ed8a962b5be8fd0af10bc57869ca6f3d30ccc97f3e63ff3f38::market::Market, arg3: 0x2::coin::Coin<T0>, arg4: &0xfa3a7263662610ed8a962b5be8fd0af10bc57869ca6f3d30ccc97f3e63ff3f38::coin_decimals_registry::CoinDecimalsRegistry, arg5: &0xfa3a7263662610ed8a962b5be8fd0af10bc57869ca6f3d30ccc97f3e63ff3f38::x_oracle::XOracle, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = liquidate<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg7));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v1, 0x2::tx_context::sender(arg7));
    }

    // decompiled from Move bytecode v6
}

