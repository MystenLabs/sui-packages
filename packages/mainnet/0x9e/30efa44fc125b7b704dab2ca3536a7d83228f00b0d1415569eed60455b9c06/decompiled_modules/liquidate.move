module 0x9e30efa44fc125b7b704dab2ca3536a7d83228f00b0d1415569eed60455b9c06::liquidate {
    struct LiquidateEvent has copy, drop {
        liquidator: address,
        obligation: 0x2::object::ID,
        debt_type: 0x1::type_name::TypeName,
        collateral_type: 0x1::type_name::TypeName,
        repay_on_behalf: u64,
        repay_revenue: u64,
        liq_amount: u64,
    }

    public fun liquidate<T0, T1>(arg0: &0x9e30efa44fc125b7b704dab2ca3536a7d83228f00b0d1415569eed60455b9c06::version::Version, arg1: &mut 0x9e30efa44fc125b7b704dab2ca3536a7d83228f00b0d1415569eed60455b9c06::obligation::Obligation, arg2: &mut 0x9e30efa44fc125b7b704dab2ca3536a7d83228f00b0d1415569eed60455b9c06::market::Market, arg3: 0x2::coin::Coin<T0>, arg4: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg5: &0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        0x9e30efa44fc125b7b704dab2ca3536a7d83228f00b0d1415569eed60455b9c06::version::assert_current_version(arg0);
        assert!(0x1318fdc90319ec9c24df1456d960a447521b0a658316155895014a6e39b5482f::whitelist::is_address_allowed(0x9e30efa44fc125b7b704dab2ca3536a7d83228f00b0d1415569eed60455b9c06::market::uid(arg2), 0x2::tx_context::sender(arg7)), 0x9e30efa44fc125b7b704dab2ca3536a7d83228f00b0d1415569eed60455b9c06::error::whitelist_error());
        assert!(0x9e30efa44fc125b7b704dab2ca3536a7d83228f00b0d1415569eed60455b9c06::obligation::liquidate_locked(arg1) == false, 0x9e30efa44fc125b7b704dab2ca3536a7d83228f00b0d1415569eed60455b9c06::error::obligation_locked());
        let v0 = 0x2::coin::into_balance<T0>(arg3);
        let v1 = 0x2::clock::timestamp_ms(arg6) / 1000;
        0x9e30efa44fc125b7b704dab2ca3536a7d83228f00b0d1415569eed60455b9c06::market::accrue_all_interests(arg2, v1);
        0x9e30efa44fc125b7b704dab2ca3536a7d83228f00b0d1415569eed60455b9c06::obligation::accrue_interests_and_rewards(arg1, arg2);
        let (v2, v3, v4) = 0x9e30efa44fc125b7b704dab2ca3536a7d83228f00b0d1415569eed60455b9c06::liquidation_evaluator::liquidation_amounts<T0, T1>(arg1, arg2, arg4, 0x2::balance::value<T0>(&v0), arg5, arg6);
        assert!(v4 > 0, 0x9e30efa44fc125b7b704dab2ca3536a7d83228f00b0d1415569eed60455b9c06::error::unable_to_liquidate_error());
        0x9e30efa44fc125b7b704dab2ca3536a7d83228f00b0d1415569eed60455b9c06::obligation::decrease_debt(arg1, 0x1::type_name::get<T0>(), v2);
        0x9e30efa44fc125b7b704dab2ca3536a7d83228f00b0d1415569eed60455b9c06::market::handle_inflow<T0>(arg2, v2, v1);
        0x9e30efa44fc125b7b704dab2ca3536a7d83228f00b0d1415569eed60455b9c06::market::handle_liquidation<T0, T1>(arg2, 0x2::balance::split<T0>(&mut v0, v2), 0x2::balance::split<T0>(&mut v0, v3), v4);
        let v5 = LiquidateEvent{
            liquidator      : 0x2::tx_context::sender(arg7),
            obligation      : 0x2::object::id<0x9e30efa44fc125b7b704dab2ca3536a7d83228f00b0d1415569eed60455b9c06::obligation::Obligation>(arg1),
            debt_type       : 0x1::type_name::get<T0>(),
            collateral_type : 0x1::type_name::get<T1>(),
            repay_on_behalf : v2,
            repay_revenue   : v3,
            liq_amount      : v4,
        };
        0x2::event::emit<LiquidateEvent>(v5);
        (0x2::coin::from_balance<T0>(v0, arg7), 0x2::coin::from_balance<T1>(0x9e30efa44fc125b7b704dab2ca3536a7d83228f00b0d1415569eed60455b9c06::obligation::withdraw_collateral<T1>(arg1, v4), arg7))
    }

    public entry fun liquidate_entry<T0, T1>(arg0: &0x9e30efa44fc125b7b704dab2ca3536a7d83228f00b0d1415569eed60455b9c06::version::Version, arg1: &mut 0x9e30efa44fc125b7b704dab2ca3536a7d83228f00b0d1415569eed60455b9c06::obligation::Obligation, arg2: &mut 0x9e30efa44fc125b7b704dab2ca3536a7d83228f00b0d1415569eed60455b9c06::market::Market, arg3: 0x2::coin::Coin<T0>, arg4: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg5: &0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = liquidate<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg7));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v1, 0x2::tx_context::sender(arg7));
    }

    // decompiled from Move bytecode v6
}

