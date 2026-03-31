module 0xb8adce96346c5c9c7c3a3ac02ca35712d36a58952d4a727a225c6ef5cc159f2::liquidate {
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

    public fun liquidate<T0>(arg0: &0xb8adce96346c5c9c7c3a3ac02ca35712d36a58952d4a727a225c6ef5cc159f2::version::Version, arg1: &mut 0xb8adce96346c5c9c7c3a3ac02ca35712d36a58952d4a727a225c6ef5cc159f2::obligation::Obligation, arg2: &mut 0xb8adce96346c5c9c7c3a3ac02ca35712d36a58952d4a727a225c6ef5cc159f2::market::Market, arg3: 0x2::coin::Coin<0xfed4826846f281385e9b6eac8c116b6302105dbd30eebc5509b634e64b1bb818::coin_gusd::COIN_GUSD>, arg4: &0x61f02204c9c3f56662b27ce7a29e935c2bce1917f51188f2a8aed5552505647b::coin_decimals_registry::CoinDecimalsRegistry, arg5: &0x39a8c5852036a052d196973795d48537f71bbb280616c878d7953cc1f98a79f2::x_oracle::XOracle, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0xfed4826846f281385e9b6eac8c116b6302105dbd30eebc5509b634e64b1bb818::coin_gusd::COIN_GUSD>, 0x2::coin::Coin<T0>) {
        0xb8adce96346c5c9c7c3a3ac02ca35712d36a58952d4a727a225c6ef5cc159f2::version::assert_current_version(arg0);
        assert!(0xb8adce96346c5c9c7c3a3ac02ca35712d36a58952d4a727a225c6ef5cc159f2::obligation::liquidate_locked(arg1) == false, 0xb8adce96346c5c9c7c3a3ac02ca35712d36a58952d4a727a225c6ef5cc159f2::error::obligation_locked());
        assert!(0x2::coin::value<0xfed4826846f281385e9b6eac8c116b6302105dbd30eebc5509b634e64b1bb818::coin_gusd::COIN_GUSD>(&arg3) > 0, 0xb8adce96346c5c9c7c3a3ac02ca35712d36a58952d4a727a225c6ef5cc159f2::error::zero_amount_error());
        let v0 = 0x2::coin::into_balance<0xfed4826846f281385e9b6eac8c116b6302105dbd30eebc5509b634e64b1bb818::coin_gusd::COIN_GUSD>(arg3);
        let v1 = 0x2::clock::timestamp_ms(arg6) / 1000;
        0xb8adce96346c5c9c7c3a3ac02ca35712d36a58952d4a727a225c6ef5cc159f2::market::accrue_all_interests(arg2, v1);
        0xb8adce96346c5c9c7c3a3ac02ca35712d36a58952d4a727a225c6ef5cc159f2::obligation::accrue_interests_and_rewards(arg1, arg2);
        let (v2, v3, v4) = 0xb8adce96346c5c9c7c3a3ac02ca35712d36a58952d4a727a225c6ef5cc159f2::liquidation_evaluator::liquidation_amounts<0xfed4826846f281385e9b6eac8c116b6302105dbd30eebc5509b634e64b1bb818::coin_gusd::COIN_GUSD, T0>(arg1, arg2, arg4, 0x2::balance::value<0xfed4826846f281385e9b6eac8c116b6302105dbd30eebc5509b634e64b1bb818::coin_gusd::COIN_GUSD>(&v0), arg5, arg6);
        assert!(v4 > 0, 0xb8adce96346c5c9c7c3a3ac02ca35712d36a58952d4a727a225c6ef5cc159f2::error::unable_to_liquidate_error());
        let (_, _, v7) = 0xb8adce96346c5c9c7c3a3ac02ca35712d36a58952d4a727a225c6ef5cc159f2::obligation::debt(arg1, 0x1::type_name::get<0xfed4826846f281385e9b6eac8c116b6302105dbd30eebc5509b634e64b1bb818::coin_gusd::COIN_GUSD>());
        if (v7 > 0) {
            0xb8adce96346c5c9c7c3a3ac02ca35712d36a58952d4a727a225c6ef5cc159f2::obligation::decrease_debt_interest(arg1, 0x1::type_name::get<0xfed4826846f281385e9b6eac8c116b6302105dbd30eebc5509b634e64b1bb818::coin_gusd::COIN_GUSD>(), 0x2::math::min(v7, v2));
        };
        0xb8adce96346c5c9c7c3a3ac02ca35712d36a58952d4a727a225c6ef5cc159f2::obligation::decrease_debt(arg1, 0x1::type_name::get<0xfed4826846f281385e9b6eac8c116b6302105dbd30eebc5509b634e64b1bb818::coin_gusd::COIN_GUSD>(), v2);
        0xb8adce96346c5c9c7c3a3ac02ca35712d36a58952d4a727a225c6ef5cc159f2::market::handle_liquidation<T0>(arg2, 0x2::balance::split<0xfed4826846f281385e9b6eac8c116b6302105dbd30eebc5509b634e64b1bb818::coin_gusd::COIN_GUSD>(&mut v0, v2), 0x2::balance::split<0xfed4826846f281385e9b6eac8c116b6302105dbd30eebc5509b634e64b1bb818::coin_gusd::COIN_GUSD>(&mut v0, v3), v4, v7, arg7);
        let v8 = LiquidateEvent{
            liquidator       : 0x2::tx_context::sender(arg7),
            obligation       : 0x2::object::id<0xb8adce96346c5c9c7c3a3ac02ca35712d36a58952d4a727a225c6ef5cc159f2::obligation::Obligation>(arg1),
            debt_type        : 0x1::type_name::get<0xfed4826846f281385e9b6eac8c116b6302105dbd30eebc5509b634e64b1bb818::coin_gusd::COIN_GUSD>(),
            collateral_type  : 0x1::type_name::get<T0>(),
            repay_on_behalf  : v2,
            repay_revenue    : v3,
            liq_amount       : v4,
            collateral_price : 0xb8adce96346c5c9c7c3a3ac02ca35712d36a58952d4a727a225c6ef5cc159f2::price::get_price(arg5, 0x1::type_name::get<T0>(), arg6),
            debt_price       : 0xb8adce96346c5c9c7c3a3ac02ca35712d36a58952d4a727a225c6ef5cc159f2::price::get_price(arg5, 0x1::type_name::get<0xfed4826846f281385e9b6eac8c116b6302105dbd30eebc5509b634e64b1bb818::coin_gusd::COIN_GUSD>(), arg6),
            timestamp        : v1,
        };
        0x2::event::emit<LiquidateEvent>(v8);
        (0x2::coin::from_balance<0xfed4826846f281385e9b6eac8c116b6302105dbd30eebc5509b634e64b1bb818::coin_gusd::COIN_GUSD>(v0, arg7), 0x2::coin::from_balance<T0>(0xb8adce96346c5c9c7c3a3ac02ca35712d36a58952d4a727a225c6ef5cc159f2::obligation::withdraw_collateral<T0>(arg1, v4), arg7))
    }

    public fun liquidate_entry<T0>(arg0: &0xb8adce96346c5c9c7c3a3ac02ca35712d36a58952d4a727a225c6ef5cc159f2::version::Version, arg1: &mut 0xb8adce96346c5c9c7c3a3ac02ca35712d36a58952d4a727a225c6ef5cc159f2::obligation::Obligation, arg2: &mut 0xb8adce96346c5c9c7c3a3ac02ca35712d36a58952d4a727a225c6ef5cc159f2::market::Market, arg3: 0x2::coin::Coin<0xfed4826846f281385e9b6eac8c116b6302105dbd30eebc5509b634e64b1bb818::coin_gusd::COIN_GUSD>, arg4: &0x61f02204c9c3f56662b27ce7a29e935c2bce1917f51188f2a8aed5552505647b::coin_decimals_registry::CoinDecimalsRegistry, arg5: &0x39a8c5852036a052d196973795d48537f71bbb280616c878d7953cc1f98a79f2::x_oracle::XOracle, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = liquidate<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xfed4826846f281385e9b6eac8c116b6302105dbd30eebc5509b634e64b1bb818::coin_gusd::COIN_GUSD>>(v0, 0x2::tx_context::sender(arg7));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, 0x2::tx_context::sender(arg7));
    }

    // decompiled from Move bytecode v6
}

