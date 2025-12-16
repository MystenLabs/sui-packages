module 0xd8c7ad9b5ff01e83ba14d9087f67d3a03f49d815844777fbf51ac1e004d1458d::borrow {
    struct BorrowEvent has copy, drop {
        borrower: address,
        obligation: 0x2::object::ID,
        amount: u64,
        borrow_fee: u64,
        time: u64,
    }

    public fun borrow(arg0: &0xd8c7ad9b5ff01e83ba14d9087f67d3a03f49d815844777fbf51ac1e004d1458d::version::Version, arg1: &mut 0xd8c7ad9b5ff01e83ba14d9087f67d3a03f49d815844777fbf51ac1e004d1458d::obligation::Obligation, arg2: &0xd8c7ad9b5ff01e83ba14d9087f67d3a03f49d815844777fbf51ac1e004d1458d::obligation::ObligationKey, arg3: &mut 0xd8c7ad9b5ff01e83ba14d9087f67d3a03f49d815844777fbf51ac1e004d1458d::market::Market, arg4: &0xe418d2f1bf2bfae8a624e642a56e84d396fe58684be2a84b721fc157ccad6020::coin_decimals_registry::CoinDecimalsRegistry, arg5: u64, arg6: &0xa672673d45ce659ff4e5fbca19d2e757a4822d95bbb064e5c98c05e04880b70f::x_oracle::XOracle, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x1e1f71a94e5207c310a3b13edc038e0aa3104cf8f9c9918548b233133987cd6a::coin_gusd::COIN_GUSD> {
        0xd8c7ad9b5ff01e83ba14d9087f67d3a03f49d815844777fbf51ac1e004d1458d::version::assert_current_version(arg0);
        assert!(!0xd8c7ad9b5ff01e83ba14d9087f67d3a03f49d815844777fbf51ac1e004d1458d::market::is_paused(arg3), 0xd8c7ad9b5ff01e83ba14d9087f67d3a03f49d815844777fbf51ac1e004d1458d::error::market_paused_error());
        borrow_internal(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
    }

    public entry fun borrow_entry(arg0: &0xd8c7ad9b5ff01e83ba14d9087f67d3a03f49d815844777fbf51ac1e004d1458d::version::Version, arg1: &mut 0xd8c7ad9b5ff01e83ba14d9087f67d3a03f49d815844777fbf51ac1e004d1458d::obligation::Obligation, arg2: &0xd8c7ad9b5ff01e83ba14d9087f67d3a03f49d815844777fbf51ac1e004d1458d::obligation::ObligationKey, arg3: &mut 0xd8c7ad9b5ff01e83ba14d9087f67d3a03f49d815844777fbf51ac1e004d1458d::market::Market, arg4: &0xe418d2f1bf2bfae8a624e642a56e84d396fe58684be2a84b721fc157ccad6020::coin_decimals_registry::CoinDecimalsRegistry, arg5: u64, arg6: &0xa672673d45ce659ff4e5fbca19d2e757a4822d95bbb064e5c98c05e04880b70f::x_oracle::XOracle, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(!0xd8c7ad9b5ff01e83ba14d9087f67d3a03f49d815844777fbf51ac1e004d1458d::market::is_paused(arg3), 0xd8c7ad9b5ff01e83ba14d9087f67d3a03f49d815844777fbf51ac1e004d1458d::error::market_paused_error());
        let v0 = borrow(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x1e1f71a94e5207c310a3b13edc038e0aa3104cf8f9c9918548b233133987cd6a::coin_gusd::COIN_GUSD>>(v0, 0x2::tx_context::sender(arg8));
    }

    fun borrow_internal(arg0: &mut 0xd8c7ad9b5ff01e83ba14d9087f67d3a03f49d815844777fbf51ac1e004d1458d::obligation::Obligation, arg1: &0xd8c7ad9b5ff01e83ba14d9087f67d3a03f49d815844777fbf51ac1e004d1458d::obligation::ObligationKey, arg2: &mut 0xd8c7ad9b5ff01e83ba14d9087f67d3a03f49d815844777fbf51ac1e004d1458d::market::Market, arg3: &0xe418d2f1bf2bfae8a624e642a56e84d396fe58684be2a84b721fc157ccad6020::coin_decimals_registry::CoinDecimalsRegistry, arg4: u64, arg5: &0xa672673d45ce659ff4e5fbca19d2e757a4822d95bbb064e5c98c05e04880b70f::x_oracle::XOracle, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x1e1f71a94e5207c310a3b13edc038e0aa3104cf8f9c9918548b233133987cd6a::coin_gusd::COIN_GUSD> {
        assert!(0xd8c7ad9b5ff01e83ba14d9087f67d3a03f49d815844777fbf51ac1e004d1458d::obligation::borrow_locked(arg0) == false, 0xd8c7ad9b5ff01e83ba14d9087f67d3a03f49d815844777fbf51ac1e004d1458d::error::obligation_locked());
        let v0 = 0x1::type_name::get<0x1e1f71a94e5207c310a3b13edc038e0aa3104cf8f9c9918548b233133987cd6a::coin_gusd::COIN_GUSD>();
        let v1 = 0x2::clock::timestamp_ms(arg6) / 1000;
        0xd8c7ad9b5ff01e83ba14d9087f67d3a03f49d815844777fbf51ac1e004d1458d::obligation::assert_key_match(arg0, arg1);
        let v2 = 0x1::fixed_point32::multiply_u64(arg4, *0x2::dynamic_field::borrow<0xd8c7ad9b5ff01e83ba14d9087f67d3a03f49d815844777fbf51ac1e004d1458d::market_dynamic_keys::BorrowFeeKey, 0x1::fixed_point32::FixedPoint32>(0xd8c7ad9b5ff01e83ba14d9087f67d3a03f49d815844777fbf51ac1e004d1458d::market::uid(arg2), 0xd8c7ad9b5ff01e83ba14d9087f67d3a03f49d815844777fbf51ac1e004d1458d::market_dynamic_keys::borrow_fee_key(v0)));
        assert!(arg4 >= 0xd8c7ad9b5ff01e83ba14d9087f67d3a03f49d815844777fbf51ac1e004d1458d::interest_model::min_borrow_amount(0xd8c7ad9b5ff01e83ba14d9087f67d3a03f49d815844777fbf51ac1e004d1458d::market::interest_model(arg2, v0)) + v2, 0xd8c7ad9b5ff01e83ba14d9087f67d3a03f49d815844777fbf51ac1e004d1458d::error::borrow_too_small_error());
        assert!((0xd8c7ad9b5ff01e83ba14d9087f67d3a03f49d815844777fbf51ac1e004d1458d::market::total_global_debt(arg2, v0) as u128) + (arg4 as u128) <= *0x2::dynamic_field::borrow<0xd8c7ad9b5ff01e83ba14d9087f67d3a03f49d815844777fbf51ac1e004d1458d::market_dynamic_keys::BorrowLimitKey, u128>(0xd8c7ad9b5ff01e83ba14d9087f67d3a03f49d815844777fbf51ac1e004d1458d::market::uid(arg2), 0xd8c7ad9b5ff01e83ba14d9087f67d3a03f49d815844777fbf51ac1e004d1458d::market_dynamic_keys::borrow_limit_key(v0)), 0xd8c7ad9b5ff01e83ba14d9087f67d3a03f49d815844777fbf51ac1e004d1458d::error::borrow_limit_reached_error());
        0xd8c7ad9b5ff01e83ba14d9087f67d3a03f49d815844777fbf51ac1e004d1458d::market::handle_outflow<0x1e1f71a94e5207c310a3b13edc038e0aa3104cf8f9c9918548b233133987cd6a::coin_gusd::COIN_GUSD>(arg2, arg4, v1);
        let v3 = 0xd8c7ad9b5ff01e83ba14d9087f67d3a03f49d815844777fbf51ac1e004d1458d::market::handle_borrow(arg2, arg4, v1, arg7);
        0xd8c7ad9b5ff01e83ba14d9087f67d3a03f49d815844777fbf51ac1e004d1458d::obligation::init_debt(arg0, arg2, v0);
        0xd8c7ad9b5ff01e83ba14d9087f67d3a03f49d815844777fbf51ac1e004d1458d::obligation::accrue_interests_and_rewards(arg0, arg2);
        assert!(arg4 <= 0xd8c7ad9b5ff01e83ba14d9087f67d3a03f49d815844777fbf51ac1e004d1458d::borrow_withdraw_evaluator::max_borrow_amount<0x1e1f71a94e5207c310a3b13edc038e0aa3104cf8f9c9918548b233133987cd6a::coin_gusd::COIN_GUSD>(arg0, arg2, arg3, arg5, arg6), 0xd8c7ad9b5ff01e83ba14d9087f67d3a03f49d815844777fbf51ac1e004d1458d::error::borrow_too_much_error());
        0xd8c7ad9b5ff01e83ba14d9087f67d3a03f49d815844777fbf51ac1e004d1458d::obligation::increase_debt(arg0, v0, arg4);
        assert!(0xfdf81885becfaa2f617bb179da217a833dae1be112733c36d17e7213668478ba::fixed_point32_empower::gt(0xd8c7ad9b5ff01e83ba14d9087f67d3a03f49d815844777fbf51ac1e004d1458d::collateral_value::collaterals_value_usd_for_borrow(arg0, arg2, arg3, arg5, arg6), 0xd8c7ad9b5ff01e83ba14d9087f67d3a03f49d815844777fbf51ac1e004d1458d::debt_value::debts_value_usd(arg0, arg3, arg5, arg6)), 0xd8c7ad9b5ff01e83ba14d9087f67d3a03f49d815844777fbf51ac1e004d1458d::error::borrow_too_much_error());
        0xd8c7ad9b5ff01e83ba14d9087f67d3a03f49d815844777fbf51ac1e004d1458d::market::add_borrow_fee<0x1e1f71a94e5207c310a3b13edc038e0aa3104cf8f9c9918548b233133987cd6a::coin_gusd::COIN_GUSD>(arg2, 0x2::coin::into_balance<0x1e1f71a94e5207c310a3b13edc038e0aa3104cf8f9c9918548b233133987cd6a::coin_gusd::COIN_GUSD>(0x2::coin::split<0x1e1f71a94e5207c310a3b13edc038e0aa3104cf8f9c9918548b233133987cd6a::coin_gusd::COIN_GUSD>(&mut v3, v2, arg7)), arg7);
        let v4 = BorrowEvent{
            borrower   : 0x2::tx_context::sender(arg7),
            obligation : 0x2::object::id<0xd8c7ad9b5ff01e83ba14d9087f67d3a03f49d815844777fbf51ac1e004d1458d::obligation::Obligation>(arg0),
            amount     : arg4,
            borrow_fee : v2,
            time       : v1,
        };
        0x2::event::emit<BorrowEvent>(v4);
        v3
    }

    // decompiled from Move bytecode v6
}

