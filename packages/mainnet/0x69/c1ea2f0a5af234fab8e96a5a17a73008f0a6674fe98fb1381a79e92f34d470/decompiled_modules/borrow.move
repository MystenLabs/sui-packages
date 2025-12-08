module 0x69c1ea2f0a5af234fab8e96a5a17a73008f0a6674fe98fb1381a79e92f34d470::borrow {
    struct BorrowEvent has copy, drop {
        borrower: address,
        obligation: 0x2::object::ID,
        amount: u64,
        borrow_fee: u64,
        time: u64,
    }

    public fun borrow(arg0: &0x69c1ea2f0a5af234fab8e96a5a17a73008f0a6674fe98fb1381a79e92f34d470::version::Version, arg1: &mut 0x69c1ea2f0a5af234fab8e96a5a17a73008f0a6674fe98fb1381a79e92f34d470::obligation::Obligation, arg2: &0x69c1ea2f0a5af234fab8e96a5a17a73008f0a6674fe98fb1381a79e92f34d470::obligation::ObligationKey, arg3: &mut 0x69c1ea2f0a5af234fab8e96a5a17a73008f0a6674fe98fb1381a79e92f34d470::market::Market, arg4: &0xca1af76adf00b3fd346ac132e219342e535ef7fdce5a4df8793b51f03e93cd9d::coin_decimals_registry::CoinDecimalsRegistry, arg5: u64, arg6: &0xce91f0478d12ae82a78c09db1bcffb873242d242976d9f721a76a1a40e2d8bc4::x_oracle::XOracle, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x6634b0ffe24d3764c6863c80385a6ab436411431938d056636377e33ad11eb06::coin_gusd::COIN_GUSD> {
        0x69c1ea2f0a5af234fab8e96a5a17a73008f0a6674fe98fb1381a79e92f34d470::version::assert_current_version(arg0);
        assert!(!0x69c1ea2f0a5af234fab8e96a5a17a73008f0a6674fe98fb1381a79e92f34d470::market::is_paused(arg3), 0x69c1ea2f0a5af234fab8e96a5a17a73008f0a6674fe98fb1381a79e92f34d470::error::market_paused_error());
        borrow_internal(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
    }

    public entry fun borrow_entry(arg0: &0x69c1ea2f0a5af234fab8e96a5a17a73008f0a6674fe98fb1381a79e92f34d470::version::Version, arg1: &mut 0x69c1ea2f0a5af234fab8e96a5a17a73008f0a6674fe98fb1381a79e92f34d470::obligation::Obligation, arg2: &0x69c1ea2f0a5af234fab8e96a5a17a73008f0a6674fe98fb1381a79e92f34d470::obligation::ObligationKey, arg3: &mut 0x69c1ea2f0a5af234fab8e96a5a17a73008f0a6674fe98fb1381a79e92f34d470::market::Market, arg4: &0xca1af76adf00b3fd346ac132e219342e535ef7fdce5a4df8793b51f03e93cd9d::coin_decimals_registry::CoinDecimalsRegistry, arg5: u64, arg6: &0xce91f0478d12ae82a78c09db1bcffb873242d242976d9f721a76a1a40e2d8bc4::x_oracle::XOracle, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(!0x69c1ea2f0a5af234fab8e96a5a17a73008f0a6674fe98fb1381a79e92f34d470::market::is_paused(arg3), 0x69c1ea2f0a5af234fab8e96a5a17a73008f0a6674fe98fb1381a79e92f34d470::error::market_paused_error());
        let v0 = borrow(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x6634b0ffe24d3764c6863c80385a6ab436411431938d056636377e33ad11eb06::coin_gusd::COIN_GUSD>>(v0, 0x2::tx_context::sender(arg8));
    }

    fun borrow_internal(arg0: &mut 0x69c1ea2f0a5af234fab8e96a5a17a73008f0a6674fe98fb1381a79e92f34d470::obligation::Obligation, arg1: &0x69c1ea2f0a5af234fab8e96a5a17a73008f0a6674fe98fb1381a79e92f34d470::obligation::ObligationKey, arg2: &mut 0x69c1ea2f0a5af234fab8e96a5a17a73008f0a6674fe98fb1381a79e92f34d470::market::Market, arg3: &0xca1af76adf00b3fd346ac132e219342e535ef7fdce5a4df8793b51f03e93cd9d::coin_decimals_registry::CoinDecimalsRegistry, arg4: u64, arg5: &0xce91f0478d12ae82a78c09db1bcffb873242d242976d9f721a76a1a40e2d8bc4::x_oracle::XOracle, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x6634b0ffe24d3764c6863c80385a6ab436411431938d056636377e33ad11eb06::coin_gusd::COIN_GUSD> {
        assert!(0x69c1ea2f0a5af234fab8e96a5a17a73008f0a6674fe98fb1381a79e92f34d470::obligation::borrow_locked(arg0) == false, 0x69c1ea2f0a5af234fab8e96a5a17a73008f0a6674fe98fb1381a79e92f34d470::error::obligation_locked());
        let v0 = 0x1::type_name::get<0x6634b0ffe24d3764c6863c80385a6ab436411431938d056636377e33ad11eb06::coin_gusd::COIN_GUSD>();
        let v1 = 0x2::clock::timestamp_ms(arg6) / 1000;
        0x69c1ea2f0a5af234fab8e96a5a17a73008f0a6674fe98fb1381a79e92f34d470::obligation::assert_key_match(arg0, arg1);
        let v2 = 0x1::fixed_point32::multiply_u64(arg4, *0x2::dynamic_field::borrow<0x69c1ea2f0a5af234fab8e96a5a17a73008f0a6674fe98fb1381a79e92f34d470::market_dynamic_keys::BorrowFeeKey, 0x1::fixed_point32::FixedPoint32>(0x69c1ea2f0a5af234fab8e96a5a17a73008f0a6674fe98fb1381a79e92f34d470::market::uid(arg2), 0x69c1ea2f0a5af234fab8e96a5a17a73008f0a6674fe98fb1381a79e92f34d470::market_dynamic_keys::borrow_fee_key(v0)));
        assert!(arg4 >= 0x69c1ea2f0a5af234fab8e96a5a17a73008f0a6674fe98fb1381a79e92f34d470::interest_model::min_borrow_amount(0x69c1ea2f0a5af234fab8e96a5a17a73008f0a6674fe98fb1381a79e92f34d470::market::interest_model(arg2, v0)) + v2, 0x69c1ea2f0a5af234fab8e96a5a17a73008f0a6674fe98fb1381a79e92f34d470::error::borrow_too_small_error());
        assert!((0x69c1ea2f0a5af234fab8e96a5a17a73008f0a6674fe98fb1381a79e92f34d470::market::total_global_debt(arg2, v0) as u128) + (arg4 as u128) <= *0x2::dynamic_field::borrow<0x69c1ea2f0a5af234fab8e96a5a17a73008f0a6674fe98fb1381a79e92f34d470::market_dynamic_keys::BorrowLimitKey, u128>(0x69c1ea2f0a5af234fab8e96a5a17a73008f0a6674fe98fb1381a79e92f34d470::market::uid(arg2), 0x69c1ea2f0a5af234fab8e96a5a17a73008f0a6674fe98fb1381a79e92f34d470::market_dynamic_keys::borrow_limit_key(v0)), 0x69c1ea2f0a5af234fab8e96a5a17a73008f0a6674fe98fb1381a79e92f34d470::error::borrow_limit_reached_error());
        0x69c1ea2f0a5af234fab8e96a5a17a73008f0a6674fe98fb1381a79e92f34d470::market::handle_outflow<0x6634b0ffe24d3764c6863c80385a6ab436411431938d056636377e33ad11eb06::coin_gusd::COIN_GUSD>(arg2, arg4, v1);
        let v3 = 0x69c1ea2f0a5af234fab8e96a5a17a73008f0a6674fe98fb1381a79e92f34d470::market::handle_borrow(arg2, arg4, v1, arg7);
        0x69c1ea2f0a5af234fab8e96a5a17a73008f0a6674fe98fb1381a79e92f34d470::obligation::init_debt(arg0, arg2, v0);
        0x69c1ea2f0a5af234fab8e96a5a17a73008f0a6674fe98fb1381a79e92f34d470::obligation::accrue_interests_and_rewards(arg0, arg2);
        assert!(arg4 <= 0x69c1ea2f0a5af234fab8e96a5a17a73008f0a6674fe98fb1381a79e92f34d470::borrow_withdraw_evaluator::max_borrow_amount<0x6634b0ffe24d3764c6863c80385a6ab436411431938d056636377e33ad11eb06::coin_gusd::COIN_GUSD>(arg0, arg2, arg3, arg5, arg6), 0x69c1ea2f0a5af234fab8e96a5a17a73008f0a6674fe98fb1381a79e92f34d470::error::borrow_too_much_error());
        0x69c1ea2f0a5af234fab8e96a5a17a73008f0a6674fe98fb1381a79e92f34d470::obligation::increase_debt(arg0, v0, arg4);
        assert!(0x16e04cbe605ede8d3821e07f4ab7b95a61a81e15b5334dcb11bad25ac9822041::fixed_point32_empower::gt(0x69c1ea2f0a5af234fab8e96a5a17a73008f0a6674fe98fb1381a79e92f34d470::collateral_value::collaterals_value_usd_for_borrow(arg0, arg2, arg3, arg5, arg6), 0x69c1ea2f0a5af234fab8e96a5a17a73008f0a6674fe98fb1381a79e92f34d470::debt_value::debts_value_usd(arg0, arg3, arg5, arg6)), 0x69c1ea2f0a5af234fab8e96a5a17a73008f0a6674fe98fb1381a79e92f34d470::error::borrow_too_much_error());
        0x69c1ea2f0a5af234fab8e96a5a17a73008f0a6674fe98fb1381a79e92f34d470::market::add_borrow_fee<0x6634b0ffe24d3764c6863c80385a6ab436411431938d056636377e33ad11eb06::coin_gusd::COIN_GUSD>(arg2, 0x2::coin::into_balance<0x6634b0ffe24d3764c6863c80385a6ab436411431938d056636377e33ad11eb06::coin_gusd::COIN_GUSD>(0x2::coin::split<0x6634b0ffe24d3764c6863c80385a6ab436411431938d056636377e33ad11eb06::coin_gusd::COIN_GUSD>(&mut v3, v2, arg7)), arg7);
        let v4 = BorrowEvent{
            borrower   : 0x2::tx_context::sender(arg7),
            obligation : 0x2::object::id<0x69c1ea2f0a5af234fab8e96a5a17a73008f0a6674fe98fb1381a79e92f34d470::obligation::Obligation>(arg0),
            amount     : arg4,
            borrow_fee : v2,
            time       : v1,
        };
        0x2::event::emit<BorrowEvent>(v4);
        v3
    }

    // decompiled from Move bytecode v6
}

