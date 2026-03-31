module 0xb8adce96346c5c9c7c3a3ac02ca35712d36a58952d4a727a225c6ef5cc159f2::borrow {
    struct BorrowEvent has copy, drop {
        borrower: address,
        obligation: 0x2::object::ID,
        amount: u64,
        borrow_fee: u64,
        time: u64,
    }

    public fun borrow(arg0: &0xb8adce96346c5c9c7c3a3ac02ca35712d36a58952d4a727a225c6ef5cc159f2::version::Version, arg1: &mut 0xb8adce96346c5c9c7c3a3ac02ca35712d36a58952d4a727a225c6ef5cc159f2::obligation::Obligation, arg2: &0xb8adce96346c5c9c7c3a3ac02ca35712d36a58952d4a727a225c6ef5cc159f2::obligation::ObligationKey, arg3: &mut 0xb8adce96346c5c9c7c3a3ac02ca35712d36a58952d4a727a225c6ef5cc159f2::market::Market, arg4: &0x61f02204c9c3f56662b27ce7a29e935c2bce1917f51188f2a8aed5552505647b::coin_decimals_registry::CoinDecimalsRegistry, arg5: u64, arg6: &0x39a8c5852036a052d196973795d48537f71bbb280616c878d7953cc1f98a79f2::x_oracle::XOracle, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xfed4826846f281385e9b6eac8c116b6302105dbd30eebc5509b634e64b1bb818::coin_gusd::COIN_GUSD> {
        0xb8adce96346c5c9c7c3a3ac02ca35712d36a58952d4a727a225c6ef5cc159f2::version::assert_current_version(arg0);
        assert!(!0xb8adce96346c5c9c7c3a3ac02ca35712d36a58952d4a727a225c6ef5cc159f2::market::is_paused(arg3), 0xb8adce96346c5c9c7c3a3ac02ca35712d36a58952d4a727a225c6ef5cc159f2::error::market_paused_error());
        borrow_internal(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
    }

    public entry fun borrow_entry(arg0: &0xb8adce96346c5c9c7c3a3ac02ca35712d36a58952d4a727a225c6ef5cc159f2::version::Version, arg1: &mut 0xb8adce96346c5c9c7c3a3ac02ca35712d36a58952d4a727a225c6ef5cc159f2::obligation::Obligation, arg2: &0xb8adce96346c5c9c7c3a3ac02ca35712d36a58952d4a727a225c6ef5cc159f2::obligation::ObligationKey, arg3: &mut 0xb8adce96346c5c9c7c3a3ac02ca35712d36a58952d4a727a225c6ef5cc159f2::market::Market, arg4: &0x61f02204c9c3f56662b27ce7a29e935c2bce1917f51188f2a8aed5552505647b::coin_decimals_registry::CoinDecimalsRegistry, arg5: u64, arg6: &0x39a8c5852036a052d196973795d48537f71bbb280616c878d7953cc1f98a79f2::x_oracle::XOracle, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(!0xb8adce96346c5c9c7c3a3ac02ca35712d36a58952d4a727a225c6ef5cc159f2::market::is_paused(arg3), 0xb8adce96346c5c9c7c3a3ac02ca35712d36a58952d4a727a225c6ef5cc159f2::error::market_paused_error());
        let v0 = borrow(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xfed4826846f281385e9b6eac8c116b6302105dbd30eebc5509b634e64b1bb818::coin_gusd::COIN_GUSD>>(v0, 0x2::tx_context::sender(arg8));
    }

    fun borrow_internal(arg0: &mut 0xb8adce96346c5c9c7c3a3ac02ca35712d36a58952d4a727a225c6ef5cc159f2::obligation::Obligation, arg1: &0xb8adce96346c5c9c7c3a3ac02ca35712d36a58952d4a727a225c6ef5cc159f2::obligation::ObligationKey, arg2: &mut 0xb8adce96346c5c9c7c3a3ac02ca35712d36a58952d4a727a225c6ef5cc159f2::market::Market, arg3: &0x61f02204c9c3f56662b27ce7a29e935c2bce1917f51188f2a8aed5552505647b::coin_decimals_registry::CoinDecimalsRegistry, arg4: u64, arg5: &0x39a8c5852036a052d196973795d48537f71bbb280616c878d7953cc1f98a79f2::x_oracle::XOracle, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xfed4826846f281385e9b6eac8c116b6302105dbd30eebc5509b634e64b1bb818::coin_gusd::COIN_GUSD> {
        assert!(0xb8adce96346c5c9c7c3a3ac02ca35712d36a58952d4a727a225c6ef5cc159f2::obligation::borrow_locked(arg0) == false, 0xb8adce96346c5c9c7c3a3ac02ca35712d36a58952d4a727a225c6ef5cc159f2::error::obligation_locked());
        let v0 = 0x1::type_name::get<0xfed4826846f281385e9b6eac8c116b6302105dbd30eebc5509b634e64b1bb818::coin_gusd::COIN_GUSD>();
        let v1 = 0x2::clock::timestamp_ms(arg6) / 1000;
        0xb8adce96346c5c9c7c3a3ac02ca35712d36a58952d4a727a225c6ef5cc159f2::obligation::assert_key_match(arg0, arg1);
        let v2 = 0x1::fixed_point32::multiply_u64(arg4, *0x2::dynamic_field::borrow<0xb8adce96346c5c9c7c3a3ac02ca35712d36a58952d4a727a225c6ef5cc159f2::market_dynamic_keys::BorrowFeeKey, 0x1::fixed_point32::FixedPoint32>(0xb8adce96346c5c9c7c3a3ac02ca35712d36a58952d4a727a225c6ef5cc159f2::market::uid(arg2), 0xb8adce96346c5c9c7c3a3ac02ca35712d36a58952d4a727a225c6ef5cc159f2::market_dynamic_keys::borrow_fee_key(v0)));
        assert!(arg4 >= 0xb8adce96346c5c9c7c3a3ac02ca35712d36a58952d4a727a225c6ef5cc159f2::interest_model::min_borrow_amount(0xb8adce96346c5c9c7c3a3ac02ca35712d36a58952d4a727a225c6ef5cc159f2::market::interest_model(arg2, v0)) + v2, 0xb8adce96346c5c9c7c3a3ac02ca35712d36a58952d4a727a225c6ef5cc159f2::error::borrow_too_small_error());
        assert!((0xb8adce96346c5c9c7c3a3ac02ca35712d36a58952d4a727a225c6ef5cc159f2::market::total_global_debt(arg2, v0) as u128) + (arg4 as u128) <= *0x2::dynamic_field::borrow<0xb8adce96346c5c9c7c3a3ac02ca35712d36a58952d4a727a225c6ef5cc159f2::market_dynamic_keys::BorrowLimitKey, u128>(0xb8adce96346c5c9c7c3a3ac02ca35712d36a58952d4a727a225c6ef5cc159f2::market::uid(arg2), 0xb8adce96346c5c9c7c3a3ac02ca35712d36a58952d4a727a225c6ef5cc159f2::market_dynamic_keys::borrow_limit_key(v0)), 0xb8adce96346c5c9c7c3a3ac02ca35712d36a58952d4a727a225c6ef5cc159f2::error::borrow_limit_reached_error());
        0xb8adce96346c5c9c7c3a3ac02ca35712d36a58952d4a727a225c6ef5cc159f2::market::handle_outflow<0xfed4826846f281385e9b6eac8c116b6302105dbd30eebc5509b634e64b1bb818::coin_gusd::COIN_GUSD>(arg2, arg4, v1);
        0xb8adce96346c5c9c7c3a3ac02ca35712d36a58952d4a727a225c6ef5cc159f2::obligation::init_debt(arg0, arg2, v0);
        0xb8adce96346c5c9c7c3a3ac02ca35712d36a58952d4a727a225c6ef5cc159f2::obligation::accrue_interests_and_rewards(arg0, arg2);
        assert!(arg4 <= 0xb8adce96346c5c9c7c3a3ac02ca35712d36a58952d4a727a225c6ef5cc159f2::borrow_withdraw_evaluator::max_borrow_amount<0xfed4826846f281385e9b6eac8c116b6302105dbd30eebc5509b634e64b1bb818::coin_gusd::COIN_GUSD>(arg0, arg2, arg3, arg5, arg6), 0xb8adce96346c5c9c7c3a3ac02ca35712d36a58952d4a727a225c6ef5cc159f2::error::borrow_too_much_error());
        0xb8adce96346c5c9c7c3a3ac02ca35712d36a58952d4a727a225c6ef5cc159f2::obligation::increase_debt(arg0, v0, arg4);
        assert!(0x826f5bc822e65e0cd12528ea725e16c9752b5fa94c66e20c6732d7a866c1781a::fixed_point32_empower::gt(0xb8adce96346c5c9c7c3a3ac02ca35712d36a58952d4a727a225c6ef5cc159f2::collateral_value::collaterals_value_usd_for_borrow(arg0, arg2, arg3, arg5, arg6), 0xb8adce96346c5c9c7c3a3ac02ca35712d36a58952d4a727a225c6ef5cc159f2::debt_value::debts_value_usd(arg0, arg3, arg5, arg6)), 0xb8adce96346c5c9c7c3a3ac02ca35712d36a58952d4a727a225c6ef5cc159f2::error::borrow_too_much_error());
        let v3 = 0xb8adce96346c5c9c7c3a3ac02ca35712d36a58952d4a727a225c6ef5cc159f2::market::handle_borrow(arg2, arg4, v1, arg7);
        0xb8adce96346c5c9c7c3a3ac02ca35712d36a58952d4a727a225c6ef5cc159f2::market::add_borrow_fee<0xfed4826846f281385e9b6eac8c116b6302105dbd30eebc5509b634e64b1bb818::coin_gusd::COIN_GUSD>(arg2, 0x2::coin::into_balance<0xfed4826846f281385e9b6eac8c116b6302105dbd30eebc5509b634e64b1bb818::coin_gusd::COIN_GUSD>(0x2::coin::split<0xfed4826846f281385e9b6eac8c116b6302105dbd30eebc5509b634e64b1bb818::coin_gusd::COIN_GUSD>(&mut v3, v2, arg7)), arg7);
        let v4 = BorrowEvent{
            borrower   : 0x2::tx_context::sender(arg7),
            obligation : 0x2::object::id<0xb8adce96346c5c9c7c3a3ac02ca35712d36a58952d4a727a225c6ef5cc159f2::obligation::Obligation>(arg0),
            amount     : arg4,
            borrow_fee : v2,
            time       : v1,
        };
        0x2::event::emit<BorrowEvent>(v4);
        v3
    }

    // decompiled from Move bytecode v6
}

