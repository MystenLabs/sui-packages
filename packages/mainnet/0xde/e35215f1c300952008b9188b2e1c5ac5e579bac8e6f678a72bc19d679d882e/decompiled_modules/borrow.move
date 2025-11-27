module 0xdee35215f1c300952008b9188b2e1c5ac5e579bac8e6f678a72bc19d679d882e::borrow {
    struct BorrowEvent has copy, drop {
        borrower: address,
        obligation: 0x2::object::ID,
        amount: u64,
        borrow_fee: u64,
        time: u64,
    }

    public fun borrow(arg0: &0xdee35215f1c300952008b9188b2e1c5ac5e579bac8e6f678a72bc19d679d882e::version::Version, arg1: &mut 0xdee35215f1c300952008b9188b2e1c5ac5e579bac8e6f678a72bc19d679d882e::obligation::Obligation, arg2: &0xdee35215f1c300952008b9188b2e1c5ac5e579bac8e6f678a72bc19d679d882e::obligation::ObligationKey, arg3: &mut 0xdee35215f1c300952008b9188b2e1c5ac5e579bac8e6f678a72bc19d679d882e::market::Market, arg4: &0xed4cd0afbc14d8961499a2523961e371d72b6a12abdd4a0da2d39cd1ca441472::coin_decimals_registry::CoinDecimalsRegistry, arg5: u64, arg6: &0x58908fcf6fe6711a482ab9dc4000d5c9f2ab753c34298843c2a96a534f7fae1d::x_oracle::XOracle, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xf63455ff6a0e224f8797c015317a14bb84a3c0334541fa88a494d36864947c0::coin_gusd::COIN_GUSD> {
        0xdee35215f1c300952008b9188b2e1c5ac5e579bac8e6f678a72bc19d679d882e::version::assert_current_version(arg0);
        assert!(!0xdee35215f1c300952008b9188b2e1c5ac5e579bac8e6f678a72bc19d679d882e::market::is_paused(arg3), 0xdee35215f1c300952008b9188b2e1c5ac5e579bac8e6f678a72bc19d679d882e::error::market_paused_error());
        borrow_internal(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
    }

    public entry fun borrow_entry(arg0: &0xdee35215f1c300952008b9188b2e1c5ac5e579bac8e6f678a72bc19d679d882e::version::Version, arg1: &mut 0xdee35215f1c300952008b9188b2e1c5ac5e579bac8e6f678a72bc19d679d882e::obligation::Obligation, arg2: &0xdee35215f1c300952008b9188b2e1c5ac5e579bac8e6f678a72bc19d679d882e::obligation::ObligationKey, arg3: &mut 0xdee35215f1c300952008b9188b2e1c5ac5e579bac8e6f678a72bc19d679d882e::market::Market, arg4: &0xed4cd0afbc14d8961499a2523961e371d72b6a12abdd4a0da2d39cd1ca441472::coin_decimals_registry::CoinDecimalsRegistry, arg5: u64, arg6: &0x58908fcf6fe6711a482ab9dc4000d5c9f2ab753c34298843c2a96a534f7fae1d::x_oracle::XOracle, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(!0xdee35215f1c300952008b9188b2e1c5ac5e579bac8e6f678a72bc19d679d882e::market::is_paused(arg3), 0xdee35215f1c300952008b9188b2e1c5ac5e579bac8e6f678a72bc19d679d882e::error::market_paused_error());
        let v0 = borrow(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xf63455ff6a0e224f8797c015317a14bb84a3c0334541fa88a494d36864947c0::coin_gusd::COIN_GUSD>>(v0, 0x2::tx_context::sender(arg8));
    }

    fun borrow_internal(arg0: &mut 0xdee35215f1c300952008b9188b2e1c5ac5e579bac8e6f678a72bc19d679d882e::obligation::Obligation, arg1: &0xdee35215f1c300952008b9188b2e1c5ac5e579bac8e6f678a72bc19d679d882e::obligation::ObligationKey, arg2: &mut 0xdee35215f1c300952008b9188b2e1c5ac5e579bac8e6f678a72bc19d679d882e::market::Market, arg3: &0xed4cd0afbc14d8961499a2523961e371d72b6a12abdd4a0da2d39cd1ca441472::coin_decimals_registry::CoinDecimalsRegistry, arg4: u64, arg5: &0x58908fcf6fe6711a482ab9dc4000d5c9f2ab753c34298843c2a96a534f7fae1d::x_oracle::XOracle, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xf63455ff6a0e224f8797c015317a14bb84a3c0334541fa88a494d36864947c0::coin_gusd::COIN_GUSD> {
        assert!(0xdee35215f1c300952008b9188b2e1c5ac5e579bac8e6f678a72bc19d679d882e::obligation::borrow_locked(arg0) == false, 0xdee35215f1c300952008b9188b2e1c5ac5e579bac8e6f678a72bc19d679d882e::error::obligation_locked());
        let v0 = 0x1::type_name::get<0xf63455ff6a0e224f8797c015317a14bb84a3c0334541fa88a494d36864947c0::coin_gusd::COIN_GUSD>();
        let v1 = 0x2::clock::timestamp_ms(arg6) / 1000;
        0xdee35215f1c300952008b9188b2e1c5ac5e579bac8e6f678a72bc19d679d882e::obligation::assert_key_match(arg0, arg1);
        let v2 = 0x1::fixed_point32::multiply_u64(arg4, *0x2::dynamic_field::borrow<0xdee35215f1c300952008b9188b2e1c5ac5e579bac8e6f678a72bc19d679d882e::market_dynamic_keys::BorrowFeeKey, 0x1::fixed_point32::FixedPoint32>(0xdee35215f1c300952008b9188b2e1c5ac5e579bac8e6f678a72bc19d679d882e::market::uid(arg2), 0xdee35215f1c300952008b9188b2e1c5ac5e579bac8e6f678a72bc19d679d882e::market_dynamic_keys::borrow_fee_key(v0)));
        assert!(arg4 >= 0xdee35215f1c300952008b9188b2e1c5ac5e579bac8e6f678a72bc19d679d882e::interest_model::min_borrow_amount(0xdee35215f1c300952008b9188b2e1c5ac5e579bac8e6f678a72bc19d679d882e::market::interest_model(arg2, v0)) + v2, 0xdee35215f1c300952008b9188b2e1c5ac5e579bac8e6f678a72bc19d679d882e::error::borrow_too_small_error());
        assert!((0xdee35215f1c300952008b9188b2e1c5ac5e579bac8e6f678a72bc19d679d882e::market::total_global_debt(arg2, v0) as u128) + (arg4 as u128) <= *0x2::dynamic_field::borrow<0xdee35215f1c300952008b9188b2e1c5ac5e579bac8e6f678a72bc19d679d882e::market_dynamic_keys::BorrowLimitKey, u128>(0xdee35215f1c300952008b9188b2e1c5ac5e579bac8e6f678a72bc19d679d882e::market::uid(arg2), 0xdee35215f1c300952008b9188b2e1c5ac5e579bac8e6f678a72bc19d679d882e::market_dynamic_keys::borrow_limit_key(v0)), 0xdee35215f1c300952008b9188b2e1c5ac5e579bac8e6f678a72bc19d679d882e::error::borrow_limit_reached_error());
        0xdee35215f1c300952008b9188b2e1c5ac5e579bac8e6f678a72bc19d679d882e::market::handle_outflow<0xf63455ff6a0e224f8797c015317a14bb84a3c0334541fa88a494d36864947c0::coin_gusd::COIN_GUSD>(arg2, arg4, v1);
        let v3 = 0xdee35215f1c300952008b9188b2e1c5ac5e579bac8e6f678a72bc19d679d882e::market::handle_borrow(arg2, arg4, v1, arg7);
        0xdee35215f1c300952008b9188b2e1c5ac5e579bac8e6f678a72bc19d679d882e::obligation::init_debt(arg0, arg2, v0);
        0xdee35215f1c300952008b9188b2e1c5ac5e579bac8e6f678a72bc19d679d882e::obligation::accrue_interests_and_rewards(arg0, arg2);
        assert!(arg4 <= 0xdee35215f1c300952008b9188b2e1c5ac5e579bac8e6f678a72bc19d679d882e::borrow_withdraw_evaluator::max_borrow_amount<0xf63455ff6a0e224f8797c015317a14bb84a3c0334541fa88a494d36864947c0::coin_gusd::COIN_GUSD>(arg0, arg2, arg3, arg5, arg6), 0xdee35215f1c300952008b9188b2e1c5ac5e579bac8e6f678a72bc19d679d882e::error::borrow_too_much_error());
        0xdee35215f1c300952008b9188b2e1c5ac5e579bac8e6f678a72bc19d679d882e::obligation::increase_debt(arg0, v0, arg4);
        assert!(0x8a0d9d6a55c999c37f153a7e282ca4438d00e411bd5b92ef0fad87391c78c08d::fixed_point32_empower::gt(0xdee35215f1c300952008b9188b2e1c5ac5e579bac8e6f678a72bc19d679d882e::collateral_value::collaterals_value_usd_for_borrow(arg0, arg2, arg3, arg5, arg6), 0xdee35215f1c300952008b9188b2e1c5ac5e579bac8e6f678a72bc19d679d882e::debt_value::debts_value_usd(arg0, arg3, arg5, arg6)), 0xdee35215f1c300952008b9188b2e1c5ac5e579bac8e6f678a72bc19d679d882e::error::borrow_too_much_error());
        0xdee35215f1c300952008b9188b2e1c5ac5e579bac8e6f678a72bc19d679d882e::market::add_borrow_fee<0xf63455ff6a0e224f8797c015317a14bb84a3c0334541fa88a494d36864947c0::coin_gusd::COIN_GUSD>(arg2, 0x2::coin::into_balance<0xf63455ff6a0e224f8797c015317a14bb84a3c0334541fa88a494d36864947c0::coin_gusd::COIN_GUSD>(0x2::coin::split<0xf63455ff6a0e224f8797c015317a14bb84a3c0334541fa88a494d36864947c0::coin_gusd::COIN_GUSD>(&mut v3, v2, arg7)), arg7);
        let v4 = BorrowEvent{
            borrower   : 0x2::tx_context::sender(arg7),
            obligation : 0x2::object::id<0xdee35215f1c300952008b9188b2e1c5ac5e579bac8e6f678a72bc19d679d882e::obligation::Obligation>(arg0),
            amount     : arg4,
            borrow_fee : v2,
            time       : v1,
        };
        0x2::event::emit<BorrowEvent>(v4);
        v3
    }

    // decompiled from Move bytecode v6
}

