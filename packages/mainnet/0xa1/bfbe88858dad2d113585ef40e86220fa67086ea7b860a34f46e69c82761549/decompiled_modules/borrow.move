module 0xa1bfbe88858dad2d113585ef40e86220fa67086ea7b860a34f46e69c82761549::borrow {
    struct BorrowEvent has copy, drop {
        borrower: address,
        obligation: 0x2::object::ID,
        amount: u64,
        borrow_fee: u64,
        time: u64,
    }

    public fun borrow(arg0: &0xa1bfbe88858dad2d113585ef40e86220fa67086ea7b860a34f46e69c82761549::version::Version, arg1: &mut 0xa1bfbe88858dad2d113585ef40e86220fa67086ea7b860a34f46e69c82761549::obligation::Obligation, arg2: &0xa1bfbe88858dad2d113585ef40e86220fa67086ea7b860a34f46e69c82761549::obligation::ObligationKey, arg3: &mut 0xa1bfbe88858dad2d113585ef40e86220fa67086ea7b860a34f46e69c82761549::market::Market, arg4: &0x85f92dbca022a519c6071cc358948a2e8c398fc9aed167cb1f0b0288bf9a1479::coin_decimals_registry::CoinDecimalsRegistry, arg5: u64, arg6: &0x64d704ec79adb95f308732d510907b6673db75fb3edabb3f7dc1e527094d3143::x_oracle::XOracle, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x5f783fa9d2af7423e98747d0a0b39d0c6e06c6551e712e9c11d86a5721458e4f::coin_gusd::COIN_GUSD> {
        0xa1bfbe88858dad2d113585ef40e86220fa67086ea7b860a34f46e69c82761549::version::assert_current_version(arg0);
        assert!(!0xa1bfbe88858dad2d113585ef40e86220fa67086ea7b860a34f46e69c82761549::market::is_paused(arg3), 0xa1bfbe88858dad2d113585ef40e86220fa67086ea7b860a34f46e69c82761549::error::market_paused_error());
        borrow_internal(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
    }

    public entry fun borrow_entry(arg0: &0xa1bfbe88858dad2d113585ef40e86220fa67086ea7b860a34f46e69c82761549::version::Version, arg1: &mut 0xa1bfbe88858dad2d113585ef40e86220fa67086ea7b860a34f46e69c82761549::obligation::Obligation, arg2: &0xa1bfbe88858dad2d113585ef40e86220fa67086ea7b860a34f46e69c82761549::obligation::ObligationKey, arg3: &mut 0xa1bfbe88858dad2d113585ef40e86220fa67086ea7b860a34f46e69c82761549::market::Market, arg4: &0x85f92dbca022a519c6071cc358948a2e8c398fc9aed167cb1f0b0288bf9a1479::coin_decimals_registry::CoinDecimalsRegistry, arg5: u64, arg6: &0x64d704ec79adb95f308732d510907b6673db75fb3edabb3f7dc1e527094d3143::x_oracle::XOracle, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(!0xa1bfbe88858dad2d113585ef40e86220fa67086ea7b860a34f46e69c82761549::market::is_paused(arg3), 0xa1bfbe88858dad2d113585ef40e86220fa67086ea7b860a34f46e69c82761549::error::market_paused_error());
        let v0 = borrow(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x5f783fa9d2af7423e98747d0a0b39d0c6e06c6551e712e9c11d86a5721458e4f::coin_gusd::COIN_GUSD>>(v0, 0x2::tx_context::sender(arg8));
    }

    fun borrow_internal(arg0: &mut 0xa1bfbe88858dad2d113585ef40e86220fa67086ea7b860a34f46e69c82761549::obligation::Obligation, arg1: &0xa1bfbe88858dad2d113585ef40e86220fa67086ea7b860a34f46e69c82761549::obligation::ObligationKey, arg2: &mut 0xa1bfbe88858dad2d113585ef40e86220fa67086ea7b860a34f46e69c82761549::market::Market, arg3: &0x85f92dbca022a519c6071cc358948a2e8c398fc9aed167cb1f0b0288bf9a1479::coin_decimals_registry::CoinDecimalsRegistry, arg4: u64, arg5: &0x64d704ec79adb95f308732d510907b6673db75fb3edabb3f7dc1e527094d3143::x_oracle::XOracle, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x5f783fa9d2af7423e98747d0a0b39d0c6e06c6551e712e9c11d86a5721458e4f::coin_gusd::COIN_GUSD> {
        assert!(0xa1bfbe88858dad2d113585ef40e86220fa67086ea7b860a34f46e69c82761549::obligation::borrow_locked(arg0) == false, 0xa1bfbe88858dad2d113585ef40e86220fa67086ea7b860a34f46e69c82761549::error::obligation_locked());
        let v0 = 0x1::type_name::get<0x5f783fa9d2af7423e98747d0a0b39d0c6e06c6551e712e9c11d86a5721458e4f::coin_gusd::COIN_GUSD>();
        let v1 = 0x2::clock::timestamp_ms(arg6) / 1000;
        0xa1bfbe88858dad2d113585ef40e86220fa67086ea7b860a34f46e69c82761549::obligation::assert_key_match(arg0, arg1);
        let v2 = 0x1::fixed_point32::multiply_u64(arg4, *0x2::dynamic_field::borrow<0xa1bfbe88858dad2d113585ef40e86220fa67086ea7b860a34f46e69c82761549::market_dynamic_keys::BorrowFeeKey, 0x1::fixed_point32::FixedPoint32>(0xa1bfbe88858dad2d113585ef40e86220fa67086ea7b860a34f46e69c82761549::market::uid(arg2), 0xa1bfbe88858dad2d113585ef40e86220fa67086ea7b860a34f46e69c82761549::market_dynamic_keys::borrow_fee_key(v0)));
        assert!(arg4 >= 0xa1bfbe88858dad2d113585ef40e86220fa67086ea7b860a34f46e69c82761549::interest_model::min_borrow_amount(0xa1bfbe88858dad2d113585ef40e86220fa67086ea7b860a34f46e69c82761549::market::interest_model(arg2, v0)) + v2, 0xa1bfbe88858dad2d113585ef40e86220fa67086ea7b860a34f46e69c82761549::error::borrow_too_small_error());
        assert!((0xa1bfbe88858dad2d113585ef40e86220fa67086ea7b860a34f46e69c82761549::market::total_global_debt(arg2, v0) as u128) + (arg4 as u128) <= *0x2::dynamic_field::borrow<0xa1bfbe88858dad2d113585ef40e86220fa67086ea7b860a34f46e69c82761549::market_dynamic_keys::BorrowLimitKey, u128>(0xa1bfbe88858dad2d113585ef40e86220fa67086ea7b860a34f46e69c82761549::market::uid(arg2), 0xa1bfbe88858dad2d113585ef40e86220fa67086ea7b860a34f46e69c82761549::market_dynamic_keys::borrow_limit_key(v0)), 0xa1bfbe88858dad2d113585ef40e86220fa67086ea7b860a34f46e69c82761549::error::borrow_limit_reached_error());
        0xa1bfbe88858dad2d113585ef40e86220fa67086ea7b860a34f46e69c82761549::market::handle_outflow<0x5f783fa9d2af7423e98747d0a0b39d0c6e06c6551e712e9c11d86a5721458e4f::coin_gusd::COIN_GUSD>(arg2, arg4, v1);
        let v3 = 0xa1bfbe88858dad2d113585ef40e86220fa67086ea7b860a34f46e69c82761549::market::handle_borrow(arg2, arg4, v1, arg7);
        0xa1bfbe88858dad2d113585ef40e86220fa67086ea7b860a34f46e69c82761549::obligation::init_debt(arg0, arg2, v0);
        0xa1bfbe88858dad2d113585ef40e86220fa67086ea7b860a34f46e69c82761549::obligation::accrue_interests_and_rewards(arg0, arg2);
        assert!(arg4 <= 0xa1bfbe88858dad2d113585ef40e86220fa67086ea7b860a34f46e69c82761549::borrow_withdraw_evaluator::max_borrow_amount<0x5f783fa9d2af7423e98747d0a0b39d0c6e06c6551e712e9c11d86a5721458e4f::coin_gusd::COIN_GUSD>(arg0, arg2, arg3, arg5, arg6), 0xa1bfbe88858dad2d113585ef40e86220fa67086ea7b860a34f46e69c82761549::error::borrow_too_much_error());
        0xa1bfbe88858dad2d113585ef40e86220fa67086ea7b860a34f46e69c82761549::obligation::increase_debt(arg0, v0, arg4);
        assert!(0xb7bf1daa413c2d5357f9d0323234a664a1bbf49c1565a72264035f98c37365cf::fixed_point32_empower::gt(0xa1bfbe88858dad2d113585ef40e86220fa67086ea7b860a34f46e69c82761549::collateral_value::collaterals_value_usd_for_borrow(arg0, arg2, arg3, arg5, arg6), 0xa1bfbe88858dad2d113585ef40e86220fa67086ea7b860a34f46e69c82761549::debt_value::debts_value_usd(arg0, arg3, arg5, arg6)), 0xa1bfbe88858dad2d113585ef40e86220fa67086ea7b860a34f46e69c82761549::error::borrow_too_much_error());
        0xa1bfbe88858dad2d113585ef40e86220fa67086ea7b860a34f46e69c82761549::market::add_borrow_fee<0x5f783fa9d2af7423e98747d0a0b39d0c6e06c6551e712e9c11d86a5721458e4f::coin_gusd::COIN_GUSD>(arg2, 0x2::coin::into_balance<0x5f783fa9d2af7423e98747d0a0b39d0c6e06c6551e712e9c11d86a5721458e4f::coin_gusd::COIN_GUSD>(0x2::coin::split<0x5f783fa9d2af7423e98747d0a0b39d0c6e06c6551e712e9c11d86a5721458e4f::coin_gusd::COIN_GUSD>(&mut v3, v2, arg7)), arg7);
        let v4 = BorrowEvent{
            borrower   : 0x2::tx_context::sender(arg7),
            obligation : 0x2::object::id<0xa1bfbe88858dad2d113585ef40e86220fa67086ea7b860a34f46e69c82761549::obligation::Obligation>(arg0),
            amount     : arg4,
            borrow_fee : v2,
            time       : v1,
        };
        0x2::event::emit<BorrowEvent>(v4);
        v3
    }

    // decompiled from Move bytecode v6
}

