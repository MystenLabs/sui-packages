module 0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::borrow {
    struct BorrowEvent has copy, drop {
        borrower: address,
        obligation: 0x2::object::ID,
        amount: u64,
        borrow_fee: u64,
        time: u64,
    }

    public fun borrow(arg0: &0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::version::Version, arg1: &mut 0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::obligation::Obligation, arg2: &0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::obligation::ObligationKey, arg3: &mut 0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::market::Market, arg4: &0x7796b84742df90f7f700f10cb0d333aa95572b05c6daa556ee10597333069189::coin_decimals_registry::CoinDecimalsRegistry, arg5: u64, arg6: &0xe46a4a7ba1cdb785de2ebac5fa36a336bb560230fbccc023b26f0469dd4392c::x_oracle::XOracle, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xa1fe266d04a850a7af07e55a432596cfaa3849f43042b5eb6efe31d74118a0cf::coin_gusd::COIN_GUSD> {
        0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::version::assert_current_version(arg0);
        assert!(!0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::market::is_paused(arg3), 0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::error::market_paused_error());
        borrow_internal(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
    }

    public entry fun borrow_entry(arg0: &0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::version::Version, arg1: &mut 0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::obligation::Obligation, arg2: &0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::obligation::ObligationKey, arg3: &mut 0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::market::Market, arg4: &0x7796b84742df90f7f700f10cb0d333aa95572b05c6daa556ee10597333069189::coin_decimals_registry::CoinDecimalsRegistry, arg5: u64, arg6: &0xe46a4a7ba1cdb785de2ebac5fa36a336bb560230fbccc023b26f0469dd4392c::x_oracle::XOracle, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(!0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::market::is_paused(arg3), 0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::error::market_paused_error());
        let v0 = borrow(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xa1fe266d04a850a7af07e55a432596cfaa3849f43042b5eb6efe31d74118a0cf::coin_gusd::COIN_GUSD>>(v0, 0x2::tx_context::sender(arg8));
    }

    fun borrow_internal(arg0: &mut 0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::obligation::Obligation, arg1: &0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::obligation::ObligationKey, arg2: &mut 0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::market::Market, arg3: &0x7796b84742df90f7f700f10cb0d333aa95572b05c6daa556ee10597333069189::coin_decimals_registry::CoinDecimalsRegistry, arg4: u64, arg5: &0xe46a4a7ba1cdb785de2ebac5fa36a336bb560230fbccc023b26f0469dd4392c::x_oracle::XOracle, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xa1fe266d04a850a7af07e55a432596cfaa3849f43042b5eb6efe31d74118a0cf::coin_gusd::COIN_GUSD> {
        assert!(0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::obligation::borrow_locked(arg0) == false, 0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::error::obligation_locked());
        let v0 = 0x1::type_name::get<0xa1fe266d04a850a7af07e55a432596cfaa3849f43042b5eb6efe31d74118a0cf::coin_gusd::COIN_GUSD>();
        let v1 = 0x2::clock::timestamp_ms(arg6) / 1000;
        0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::obligation::assert_key_match(arg0, arg1);
        let v2 = 0x1::fixed_point32::multiply_u64(arg4, *0x2::dynamic_field::borrow<0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::market_dynamic_keys::BorrowFeeKey, 0x1::fixed_point32::FixedPoint32>(0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::market::uid(arg2), 0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::market_dynamic_keys::borrow_fee_key(v0)));
        assert!(arg4 >= 0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::interest_model::min_borrow_amount(0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::market::interest_model(arg2, v0)) + v2, 0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::error::borrow_too_small_error());
        assert!((0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::market::total_global_debt(arg2, v0) as u128) + (arg4 as u128) <= *0x2::dynamic_field::borrow<0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::market_dynamic_keys::BorrowLimitKey, u128>(0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::market::uid(arg2), 0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::market_dynamic_keys::borrow_limit_key(v0)), 0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::error::borrow_limit_reached_error());
        0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::market::handle_outflow<0xa1fe266d04a850a7af07e55a432596cfaa3849f43042b5eb6efe31d74118a0cf::coin_gusd::COIN_GUSD>(arg2, arg4, v1);
        let v3 = 0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::market::handle_borrow(arg2, arg4, v1, arg7);
        0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::obligation::init_debt(arg0, arg2, v0);
        0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::obligation::accrue_interests_and_rewards(arg0, arg2);
        assert!(arg4 <= 0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::borrow_withdraw_evaluator::max_borrow_amount<0xa1fe266d04a850a7af07e55a432596cfaa3849f43042b5eb6efe31d74118a0cf::coin_gusd::COIN_GUSD>(arg0, arg2, arg3, arg5, arg6), 0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::error::borrow_too_much_error());
        0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::obligation::increase_debt(arg0, v0, arg4);
        assert!(0x7a2b7bd2ae94b09560fb22b9ff4137c66ebce098e8c76660c6635027f3c6a34f::fixed_point32_empower::gt(0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::collateral_value::collaterals_value_usd_for_borrow(arg0, arg2, arg3, arg5, arg6), 0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::debt_value::debts_value_usd(arg0, arg3, arg5, arg6)), 0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::error::borrow_too_much_error());
        0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::market::add_borrow_fee<0xa1fe266d04a850a7af07e55a432596cfaa3849f43042b5eb6efe31d74118a0cf::coin_gusd::COIN_GUSD>(arg2, 0x2::coin::into_balance<0xa1fe266d04a850a7af07e55a432596cfaa3849f43042b5eb6efe31d74118a0cf::coin_gusd::COIN_GUSD>(0x2::coin::split<0xa1fe266d04a850a7af07e55a432596cfaa3849f43042b5eb6efe31d74118a0cf::coin_gusd::COIN_GUSD>(&mut v3, v2, arg7)), arg7);
        let v4 = BorrowEvent{
            borrower   : 0x2::tx_context::sender(arg7),
            obligation : 0x2::object::id<0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::obligation::Obligation>(arg0),
            amount     : arg4,
            borrow_fee : v2,
            time       : v1,
        };
        0x2::event::emit<BorrowEvent>(v4);
        v3
    }

    // decompiled from Move bytecode v6
}

