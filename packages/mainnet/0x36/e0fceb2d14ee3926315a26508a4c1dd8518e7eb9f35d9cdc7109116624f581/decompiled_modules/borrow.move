module 0x36e0fceb2d14ee3926315a26508a4c1dd8518e7eb9f35d9cdc7109116624f581::borrow {
    struct BorrowEvent has copy, drop {
        borrower: address,
        obligation: 0x2::object::ID,
        amount: u64,
        borrow_fee: u64,
        time: u64,
    }

    public fun borrow(arg0: &0x36e0fceb2d14ee3926315a26508a4c1dd8518e7eb9f35d9cdc7109116624f581::version::Version, arg1: &mut 0x36e0fceb2d14ee3926315a26508a4c1dd8518e7eb9f35d9cdc7109116624f581::obligation::Obligation, arg2: &0x36e0fceb2d14ee3926315a26508a4c1dd8518e7eb9f35d9cdc7109116624f581::obligation::ObligationKey, arg3: &mut 0x36e0fceb2d14ee3926315a26508a4c1dd8518e7eb9f35d9cdc7109116624f581::market::Market, arg4: &0x2eb052455f68f40bef97c5f858769d45cfe664c4cb7c4db58bc9aab1b1e0abf6::coin_decimals_registry::CoinDecimalsRegistry, arg5: u64, arg6: &0x2c9820fb02050a7ce492f9ffb0c2332d91a1a4e12ea229e569c95cceab7f702::x_oracle::XOracle, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x9017953faf6b8ba1889fee20a49837b406d45f664097b0312c688fae536e2719::coin_gusd::COIN_GUSD> {
        0x36e0fceb2d14ee3926315a26508a4c1dd8518e7eb9f35d9cdc7109116624f581::version::assert_current_version(arg0);
        assert!(!0x36e0fceb2d14ee3926315a26508a4c1dd8518e7eb9f35d9cdc7109116624f581::market::is_paused(arg3), 0x36e0fceb2d14ee3926315a26508a4c1dd8518e7eb9f35d9cdc7109116624f581::error::market_paused_error());
        borrow_internal(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
    }

    public entry fun borrow_entry(arg0: &0x36e0fceb2d14ee3926315a26508a4c1dd8518e7eb9f35d9cdc7109116624f581::version::Version, arg1: &mut 0x36e0fceb2d14ee3926315a26508a4c1dd8518e7eb9f35d9cdc7109116624f581::obligation::Obligation, arg2: &0x36e0fceb2d14ee3926315a26508a4c1dd8518e7eb9f35d9cdc7109116624f581::obligation::ObligationKey, arg3: &mut 0x36e0fceb2d14ee3926315a26508a4c1dd8518e7eb9f35d9cdc7109116624f581::market::Market, arg4: &0x2eb052455f68f40bef97c5f858769d45cfe664c4cb7c4db58bc9aab1b1e0abf6::coin_decimals_registry::CoinDecimalsRegistry, arg5: u64, arg6: &0x2c9820fb02050a7ce492f9ffb0c2332d91a1a4e12ea229e569c95cceab7f702::x_oracle::XOracle, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(!0x36e0fceb2d14ee3926315a26508a4c1dd8518e7eb9f35d9cdc7109116624f581::market::is_paused(arg3), 0x36e0fceb2d14ee3926315a26508a4c1dd8518e7eb9f35d9cdc7109116624f581::error::market_paused_error());
        let v0 = borrow(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x9017953faf6b8ba1889fee20a49837b406d45f664097b0312c688fae536e2719::coin_gusd::COIN_GUSD>>(v0, 0x2::tx_context::sender(arg8));
    }

    fun borrow_internal(arg0: &mut 0x36e0fceb2d14ee3926315a26508a4c1dd8518e7eb9f35d9cdc7109116624f581::obligation::Obligation, arg1: &0x36e0fceb2d14ee3926315a26508a4c1dd8518e7eb9f35d9cdc7109116624f581::obligation::ObligationKey, arg2: &mut 0x36e0fceb2d14ee3926315a26508a4c1dd8518e7eb9f35d9cdc7109116624f581::market::Market, arg3: &0x2eb052455f68f40bef97c5f858769d45cfe664c4cb7c4db58bc9aab1b1e0abf6::coin_decimals_registry::CoinDecimalsRegistry, arg4: u64, arg5: &0x2c9820fb02050a7ce492f9ffb0c2332d91a1a4e12ea229e569c95cceab7f702::x_oracle::XOracle, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x9017953faf6b8ba1889fee20a49837b406d45f664097b0312c688fae536e2719::coin_gusd::COIN_GUSD> {
        assert!(0x36e0fceb2d14ee3926315a26508a4c1dd8518e7eb9f35d9cdc7109116624f581::obligation::borrow_locked(arg0) == false, 0x36e0fceb2d14ee3926315a26508a4c1dd8518e7eb9f35d9cdc7109116624f581::error::obligation_locked());
        let v0 = 0x1::type_name::get<0x9017953faf6b8ba1889fee20a49837b406d45f664097b0312c688fae536e2719::coin_gusd::COIN_GUSD>();
        let v1 = 0x2::clock::timestamp_ms(arg6) / 1000;
        0x36e0fceb2d14ee3926315a26508a4c1dd8518e7eb9f35d9cdc7109116624f581::obligation::assert_key_match(arg0, arg1);
        let v2 = 0x1::fixed_point32::multiply_u64(arg4, *0x2::dynamic_field::borrow<0x36e0fceb2d14ee3926315a26508a4c1dd8518e7eb9f35d9cdc7109116624f581::market_dynamic_keys::BorrowFeeKey, 0x1::fixed_point32::FixedPoint32>(0x36e0fceb2d14ee3926315a26508a4c1dd8518e7eb9f35d9cdc7109116624f581::market::uid(arg2), 0x36e0fceb2d14ee3926315a26508a4c1dd8518e7eb9f35d9cdc7109116624f581::market_dynamic_keys::borrow_fee_key(v0)));
        assert!(arg4 >= 0x36e0fceb2d14ee3926315a26508a4c1dd8518e7eb9f35d9cdc7109116624f581::interest_model::min_borrow_amount(0x36e0fceb2d14ee3926315a26508a4c1dd8518e7eb9f35d9cdc7109116624f581::market::interest_model(arg2, v0)) + v2, 0x36e0fceb2d14ee3926315a26508a4c1dd8518e7eb9f35d9cdc7109116624f581::error::borrow_too_small_error());
        assert!((0x36e0fceb2d14ee3926315a26508a4c1dd8518e7eb9f35d9cdc7109116624f581::market::total_global_debt(arg2, v0) as u128) + (arg4 as u128) <= *0x2::dynamic_field::borrow<0x36e0fceb2d14ee3926315a26508a4c1dd8518e7eb9f35d9cdc7109116624f581::market_dynamic_keys::BorrowLimitKey, u128>(0x36e0fceb2d14ee3926315a26508a4c1dd8518e7eb9f35d9cdc7109116624f581::market::uid(arg2), 0x36e0fceb2d14ee3926315a26508a4c1dd8518e7eb9f35d9cdc7109116624f581::market_dynamic_keys::borrow_limit_key(v0)), 0x36e0fceb2d14ee3926315a26508a4c1dd8518e7eb9f35d9cdc7109116624f581::error::borrow_limit_reached_error());
        0x36e0fceb2d14ee3926315a26508a4c1dd8518e7eb9f35d9cdc7109116624f581::market::handle_outflow<0x9017953faf6b8ba1889fee20a49837b406d45f664097b0312c688fae536e2719::coin_gusd::COIN_GUSD>(arg2, arg4, v1);
        let v3 = 0x36e0fceb2d14ee3926315a26508a4c1dd8518e7eb9f35d9cdc7109116624f581::market::handle_borrow(arg2, arg4, v1, arg7);
        0x36e0fceb2d14ee3926315a26508a4c1dd8518e7eb9f35d9cdc7109116624f581::obligation::init_debt(arg0, arg2, v0);
        0x36e0fceb2d14ee3926315a26508a4c1dd8518e7eb9f35d9cdc7109116624f581::obligation::accrue_interests_and_rewards(arg0, arg2);
        assert!(arg4 <= 0x36e0fceb2d14ee3926315a26508a4c1dd8518e7eb9f35d9cdc7109116624f581::borrow_withdraw_evaluator::max_borrow_amount<0x9017953faf6b8ba1889fee20a49837b406d45f664097b0312c688fae536e2719::coin_gusd::COIN_GUSD>(arg0, arg2, arg3, arg5, arg6), 0x36e0fceb2d14ee3926315a26508a4c1dd8518e7eb9f35d9cdc7109116624f581::error::borrow_too_much_error());
        0x36e0fceb2d14ee3926315a26508a4c1dd8518e7eb9f35d9cdc7109116624f581::obligation::increase_debt(arg0, v0, arg4);
        assert!(0xd8fabdb51dd60097fe6c582f62b82404596b1f3a5081a18bbd47118ea1ba863f::fixed_point32_empower::gt(0x36e0fceb2d14ee3926315a26508a4c1dd8518e7eb9f35d9cdc7109116624f581::collateral_value::collaterals_value_usd_for_borrow(arg0, arg2, arg3, arg5, arg6), 0x36e0fceb2d14ee3926315a26508a4c1dd8518e7eb9f35d9cdc7109116624f581::debt_value::debts_value_usd(arg0, arg3, arg5, arg6)), 0x36e0fceb2d14ee3926315a26508a4c1dd8518e7eb9f35d9cdc7109116624f581::error::borrow_too_much_error());
        0x36e0fceb2d14ee3926315a26508a4c1dd8518e7eb9f35d9cdc7109116624f581::market::add_borrow_fee<0x9017953faf6b8ba1889fee20a49837b406d45f664097b0312c688fae536e2719::coin_gusd::COIN_GUSD>(arg2, 0x2::coin::into_balance<0x9017953faf6b8ba1889fee20a49837b406d45f664097b0312c688fae536e2719::coin_gusd::COIN_GUSD>(0x2::coin::split<0x9017953faf6b8ba1889fee20a49837b406d45f664097b0312c688fae536e2719::coin_gusd::COIN_GUSD>(&mut v3, v2, arg7)), arg7);
        let v4 = BorrowEvent{
            borrower   : 0x2::tx_context::sender(arg7),
            obligation : 0x2::object::id<0x36e0fceb2d14ee3926315a26508a4c1dd8518e7eb9f35d9cdc7109116624f581::obligation::Obligation>(arg0),
            amount     : arg4,
            borrow_fee : v2,
            time       : v1,
        };
        0x2::event::emit<BorrowEvent>(v4);
        v3
    }

    // decompiled from Move bytecode v6
}

