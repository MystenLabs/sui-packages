module 0xd06d74e1b1e6509356142fb274ddfdb31c28e1feca57ba7d03b6482953db1600::borrow {
    struct BorrowEvent has copy, drop {
        borrower: address,
        obligation: 0x2::object::ID,
        amount: u64,
        borrow_fee: u64,
        time: u64,
    }

    public fun borrow(arg0: &0xd06d74e1b1e6509356142fb274ddfdb31c28e1feca57ba7d03b6482953db1600::version::Version, arg1: &mut 0xd06d74e1b1e6509356142fb274ddfdb31c28e1feca57ba7d03b6482953db1600::obligation::Obligation, arg2: &0xd06d74e1b1e6509356142fb274ddfdb31c28e1feca57ba7d03b6482953db1600::obligation::ObligationKey, arg3: &mut 0xd06d74e1b1e6509356142fb274ddfdb31c28e1feca57ba7d03b6482953db1600::market::Market, arg4: &0xe6ddf4097f892306408ddbc8da0e84a86cc64f6fd09c3b4130a5591a32b2aec8::coin_decimals_registry::CoinDecimalsRegistry, arg5: u64, arg6: &0x6215446965938eaf3596a420047ed0da61a17c8c683b0941f9e54511ecad2b4b::x_oracle::XOracle, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xa62ad50462b658099e18c134a0b59140a04f8e88f2457a00a5287a4e3d068321::coin_gusd::COIN_GUSD> {
        0xd06d74e1b1e6509356142fb274ddfdb31c28e1feca57ba7d03b6482953db1600::version::assert_current_version(arg0);
        assert!(!0xd06d74e1b1e6509356142fb274ddfdb31c28e1feca57ba7d03b6482953db1600::market::is_paused(arg3), 0xd06d74e1b1e6509356142fb274ddfdb31c28e1feca57ba7d03b6482953db1600::error::market_paused_error());
        borrow_internal(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
    }

    public entry fun borrow_entry(arg0: &0xd06d74e1b1e6509356142fb274ddfdb31c28e1feca57ba7d03b6482953db1600::version::Version, arg1: &mut 0xd06d74e1b1e6509356142fb274ddfdb31c28e1feca57ba7d03b6482953db1600::obligation::Obligation, arg2: &0xd06d74e1b1e6509356142fb274ddfdb31c28e1feca57ba7d03b6482953db1600::obligation::ObligationKey, arg3: &mut 0xd06d74e1b1e6509356142fb274ddfdb31c28e1feca57ba7d03b6482953db1600::market::Market, arg4: &0xe6ddf4097f892306408ddbc8da0e84a86cc64f6fd09c3b4130a5591a32b2aec8::coin_decimals_registry::CoinDecimalsRegistry, arg5: u64, arg6: &0x6215446965938eaf3596a420047ed0da61a17c8c683b0941f9e54511ecad2b4b::x_oracle::XOracle, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(!0xd06d74e1b1e6509356142fb274ddfdb31c28e1feca57ba7d03b6482953db1600::market::is_paused(arg3), 0xd06d74e1b1e6509356142fb274ddfdb31c28e1feca57ba7d03b6482953db1600::error::market_paused_error());
        let v0 = borrow(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xa62ad50462b658099e18c134a0b59140a04f8e88f2457a00a5287a4e3d068321::coin_gusd::COIN_GUSD>>(v0, 0x2::tx_context::sender(arg8));
    }

    fun borrow_internal(arg0: &mut 0xd06d74e1b1e6509356142fb274ddfdb31c28e1feca57ba7d03b6482953db1600::obligation::Obligation, arg1: &0xd06d74e1b1e6509356142fb274ddfdb31c28e1feca57ba7d03b6482953db1600::obligation::ObligationKey, arg2: &mut 0xd06d74e1b1e6509356142fb274ddfdb31c28e1feca57ba7d03b6482953db1600::market::Market, arg3: &0xe6ddf4097f892306408ddbc8da0e84a86cc64f6fd09c3b4130a5591a32b2aec8::coin_decimals_registry::CoinDecimalsRegistry, arg4: u64, arg5: &0x6215446965938eaf3596a420047ed0da61a17c8c683b0941f9e54511ecad2b4b::x_oracle::XOracle, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xa62ad50462b658099e18c134a0b59140a04f8e88f2457a00a5287a4e3d068321::coin_gusd::COIN_GUSD> {
        assert!(0xd06d74e1b1e6509356142fb274ddfdb31c28e1feca57ba7d03b6482953db1600::obligation::borrow_locked(arg0) == false, 0xd06d74e1b1e6509356142fb274ddfdb31c28e1feca57ba7d03b6482953db1600::error::obligation_locked());
        let v0 = 0x1::type_name::get<0xa62ad50462b658099e18c134a0b59140a04f8e88f2457a00a5287a4e3d068321::coin_gusd::COIN_GUSD>();
        let v1 = 0x2::clock::timestamp_ms(arg6) / 1000;
        0xd06d74e1b1e6509356142fb274ddfdb31c28e1feca57ba7d03b6482953db1600::obligation::assert_key_match(arg0, arg1);
        let v2 = 0x1::fixed_point32::multiply_u64(arg4, *0x2::dynamic_field::borrow<0xd06d74e1b1e6509356142fb274ddfdb31c28e1feca57ba7d03b6482953db1600::market_dynamic_keys::BorrowFeeKey, 0x1::fixed_point32::FixedPoint32>(0xd06d74e1b1e6509356142fb274ddfdb31c28e1feca57ba7d03b6482953db1600::market::uid(arg2), 0xd06d74e1b1e6509356142fb274ddfdb31c28e1feca57ba7d03b6482953db1600::market_dynamic_keys::borrow_fee_key(v0)));
        assert!(arg4 >= 0xd06d74e1b1e6509356142fb274ddfdb31c28e1feca57ba7d03b6482953db1600::interest_model::min_borrow_amount(0xd06d74e1b1e6509356142fb274ddfdb31c28e1feca57ba7d03b6482953db1600::market::interest_model(arg2, v0)) + v2, 0xd06d74e1b1e6509356142fb274ddfdb31c28e1feca57ba7d03b6482953db1600::error::borrow_too_small_error());
        assert!((0xd06d74e1b1e6509356142fb274ddfdb31c28e1feca57ba7d03b6482953db1600::market::total_global_debt(arg2, v0) as u128) + (arg4 as u128) <= *0x2::dynamic_field::borrow<0xd06d74e1b1e6509356142fb274ddfdb31c28e1feca57ba7d03b6482953db1600::market_dynamic_keys::BorrowLimitKey, u128>(0xd06d74e1b1e6509356142fb274ddfdb31c28e1feca57ba7d03b6482953db1600::market::uid(arg2), 0xd06d74e1b1e6509356142fb274ddfdb31c28e1feca57ba7d03b6482953db1600::market_dynamic_keys::borrow_limit_key(v0)), 0xd06d74e1b1e6509356142fb274ddfdb31c28e1feca57ba7d03b6482953db1600::error::borrow_limit_reached_error());
        0xd06d74e1b1e6509356142fb274ddfdb31c28e1feca57ba7d03b6482953db1600::market::handle_outflow<0xa62ad50462b658099e18c134a0b59140a04f8e88f2457a00a5287a4e3d068321::coin_gusd::COIN_GUSD>(arg2, arg4, v1);
        let v3 = 0xd06d74e1b1e6509356142fb274ddfdb31c28e1feca57ba7d03b6482953db1600::market::handle_borrow(arg2, arg4, v1, arg7);
        0xd06d74e1b1e6509356142fb274ddfdb31c28e1feca57ba7d03b6482953db1600::obligation::init_debt(arg0, arg2, v0);
        0xd06d74e1b1e6509356142fb274ddfdb31c28e1feca57ba7d03b6482953db1600::obligation::accrue_interests_and_rewards(arg0, arg2);
        assert!(arg4 <= 0xd06d74e1b1e6509356142fb274ddfdb31c28e1feca57ba7d03b6482953db1600::borrow_withdraw_evaluator::max_borrow_amount<0xa62ad50462b658099e18c134a0b59140a04f8e88f2457a00a5287a4e3d068321::coin_gusd::COIN_GUSD>(arg0, arg2, arg3, arg5, arg6), 0xd06d74e1b1e6509356142fb274ddfdb31c28e1feca57ba7d03b6482953db1600::error::borrow_too_much_error());
        0xd06d74e1b1e6509356142fb274ddfdb31c28e1feca57ba7d03b6482953db1600::obligation::increase_debt(arg0, v0, arg4);
        assert!(0x7eaac45a28873a47c2de190f87f59e40e140017c6c4cc5e82b3a1baaaf7d20e::fixed_point32_empower::gt(0xd06d74e1b1e6509356142fb274ddfdb31c28e1feca57ba7d03b6482953db1600::collateral_value::collaterals_value_usd_for_borrow(arg0, arg2, arg3, arg5, arg6), 0xd06d74e1b1e6509356142fb274ddfdb31c28e1feca57ba7d03b6482953db1600::debt_value::debts_value_usd(arg0, arg3, arg5, arg6)), 0xd06d74e1b1e6509356142fb274ddfdb31c28e1feca57ba7d03b6482953db1600::error::borrow_too_much_error());
        0xd06d74e1b1e6509356142fb274ddfdb31c28e1feca57ba7d03b6482953db1600::market::add_borrow_fee<0xa62ad50462b658099e18c134a0b59140a04f8e88f2457a00a5287a4e3d068321::coin_gusd::COIN_GUSD>(arg2, 0x2::coin::into_balance<0xa62ad50462b658099e18c134a0b59140a04f8e88f2457a00a5287a4e3d068321::coin_gusd::COIN_GUSD>(0x2::coin::split<0xa62ad50462b658099e18c134a0b59140a04f8e88f2457a00a5287a4e3d068321::coin_gusd::COIN_GUSD>(&mut v3, v2, arg7)), arg7);
        let v4 = BorrowEvent{
            borrower   : 0x2::tx_context::sender(arg7),
            obligation : 0x2::object::id<0xd06d74e1b1e6509356142fb274ddfdb31c28e1feca57ba7d03b6482953db1600::obligation::Obligation>(arg0),
            amount     : arg4,
            borrow_fee : v2,
            time       : v1,
        };
        0x2::event::emit<BorrowEvent>(v4);
        v3
    }

    // decompiled from Move bytecode v6
}

