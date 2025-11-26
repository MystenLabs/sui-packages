module 0x814b1189ed8ce8c021803aa403e698b247cbc0accd295cd3652b982496af704e::borrow {
    struct BorrowEvent has copy, drop {
        borrower: address,
        obligation: 0x2::object::ID,
        amount: u64,
        borrow_fee: u64,
        time: u64,
    }

    public fun borrow(arg0: &0x814b1189ed8ce8c021803aa403e698b247cbc0accd295cd3652b982496af704e::version::Version, arg1: &mut 0x814b1189ed8ce8c021803aa403e698b247cbc0accd295cd3652b982496af704e::obligation::Obligation, arg2: &0x814b1189ed8ce8c021803aa403e698b247cbc0accd295cd3652b982496af704e::obligation::ObligationKey, arg3: &mut 0x814b1189ed8ce8c021803aa403e698b247cbc0accd295cd3652b982496af704e::market::Market, arg4: &0xf02732656b4dc135a20a52ff5495425541d4280c54aa93ef5f8bceecf49b9f9::coin_decimals_registry::CoinDecimalsRegistry, arg5: u64, arg6: &0x901a0eda69c69f5ed9ccd6e94b01e2a4d3e36c88f0b5c0da90978a2a92979007::x_oracle::XOracle, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xabb3631bd2a91461b61e0b16a8e4e4e88185a3dd410e12186f65f18b1b98da17::coin_gusd::COIN_GUSD> {
        0x814b1189ed8ce8c021803aa403e698b247cbc0accd295cd3652b982496af704e::version::assert_current_version(arg0);
        assert!(!0x814b1189ed8ce8c021803aa403e698b247cbc0accd295cd3652b982496af704e::market::is_paused(arg3), 0x814b1189ed8ce8c021803aa403e698b247cbc0accd295cd3652b982496af704e::error::market_paused_error());
        borrow_internal(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
    }

    public entry fun borrow_entry(arg0: &0x814b1189ed8ce8c021803aa403e698b247cbc0accd295cd3652b982496af704e::version::Version, arg1: &mut 0x814b1189ed8ce8c021803aa403e698b247cbc0accd295cd3652b982496af704e::obligation::Obligation, arg2: &0x814b1189ed8ce8c021803aa403e698b247cbc0accd295cd3652b982496af704e::obligation::ObligationKey, arg3: &mut 0x814b1189ed8ce8c021803aa403e698b247cbc0accd295cd3652b982496af704e::market::Market, arg4: &0xf02732656b4dc135a20a52ff5495425541d4280c54aa93ef5f8bceecf49b9f9::coin_decimals_registry::CoinDecimalsRegistry, arg5: u64, arg6: &0x901a0eda69c69f5ed9ccd6e94b01e2a4d3e36c88f0b5c0da90978a2a92979007::x_oracle::XOracle, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(!0x814b1189ed8ce8c021803aa403e698b247cbc0accd295cd3652b982496af704e::market::is_paused(arg3), 0x814b1189ed8ce8c021803aa403e698b247cbc0accd295cd3652b982496af704e::error::market_paused_error());
        let v0 = borrow(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xabb3631bd2a91461b61e0b16a8e4e4e88185a3dd410e12186f65f18b1b98da17::coin_gusd::COIN_GUSD>>(v0, 0x2::tx_context::sender(arg8));
    }

    fun borrow_internal(arg0: &mut 0x814b1189ed8ce8c021803aa403e698b247cbc0accd295cd3652b982496af704e::obligation::Obligation, arg1: &0x814b1189ed8ce8c021803aa403e698b247cbc0accd295cd3652b982496af704e::obligation::ObligationKey, arg2: &mut 0x814b1189ed8ce8c021803aa403e698b247cbc0accd295cd3652b982496af704e::market::Market, arg3: &0xf02732656b4dc135a20a52ff5495425541d4280c54aa93ef5f8bceecf49b9f9::coin_decimals_registry::CoinDecimalsRegistry, arg4: u64, arg5: &0x901a0eda69c69f5ed9ccd6e94b01e2a4d3e36c88f0b5c0da90978a2a92979007::x_oracle::XOracle, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xabb3631bd2a91461b61e0b16a8e4e4e88185a3dd410e12186f65f18b1b98da17::coin_gusd::COIN_GUSD> {
        assert!(0x814b1189ed8ce8c021803aa403e698b247cbc0accd295cd3652b982496af704e::obligation::borrow_locked(arg0) == false, 0x814b1189ed8ce8c021803aa403e698b247cbc0accd295cd3652b982496af704e::error::obligation_locked());
        let v0 = 0x1::type_name::get<0xabb3631bd2a91461b61e0b16a8e4e4e88185a3dd410e12186f65f18b1b98da17::coin_gusd::COIN_GUSD>();
        let v1 = 0x2::clock::timestamp_ms(arg6) / 1000;
        0x814b1189ed8ce8c021803aa403e698b247cbc0accd295cd3652b982496af704e::obligation::assert_key_match(arg0, arg1);
        let v2 = 0x1::fixed_point32::multiply_u64(arg4, *0x2::dynamic_field::borrow<0x814b1189ed8ce8c021803aa403e698b247cbc0accd295cd3652b982496af704e::market_dynamic_keys::BorrowFeeKey, 0x1::fixed_point32::FixedPoint32>(0x814b1189ed8ce8c021803aa403e698b247cbc0accd295cd3652b982496af704e::market::uid(arg2), 0x814b1189ed8ce8c021803aa403e698b247cbc0accd295cd3652b982496af704e::market_dynamic_keys::borrow_fee_key(v0)));
        assert!(arg4 >= 0x814b1189ed8ce8c021803aa403e698b247cbc0accd295cd3652b982496af704e::interest_model::min_borrow_amount(0x814b1189ed8ce8c021803aa403e698b247cbc0accd295cd3652b982496af704e::market::interest_model(arg2, v0)) + v2, 0x814b1189ed8ce8c021803aa403e698b247cbc0accd295cd3652b982496af704e::error::borrow_too_small_error());
        assert!((0x814b1189ed8ce8c021803aa403e698b247cbc0accd295cd3652b982496af704e::market::total_global_debt(arg2, v0) as u128) + (arg4 as u128) <= *0x2::dynamic_field::borrow<0x814b1189ed8ce8c021803aa403e698b247cbc0accd295cd3652b982496af704e::market_dynamic_keys::BorrowLimitKey, u128>(0x814b1189ed8ce8c021803aa403e698b247cbc0accd295cd3652b982496af704e::market::uid(arg2), 0x814b1189ed8ce8c021803aa403e698b247cbc0accd295cd3652b982496af704e::market_dynamic_keys::borrow_limit_key(v0)), 0x814b1189ed8ce8c021803aa403e698b247cbc0accd295cd3652b982496af704e::error::borrow_limit_reached_error());
        0x814b1189ed8ce8c021803aa403e698b247cbc0accd295cd3652b982496af704e::market::handle_outflow<0xabb3631bd2a91461b61e0b16a8e4e4e88185a3dd410e12186f65f18b1b98da17::coin_gusd::COIN_GUSD>(arg2, arg4, v1);
        let v3 = 0x814b1189ed8ce8c021803aa403e698b247cbc0accd295cd3652b982496af704e::market::handle_borrow(arg2, arg4, v1, arg7);
        0x814b1189ed8ce8c021803aa403e698b247cbc0accd295cd3652b982496af704e::obligation::init_debt(arg0, arg2, v0);
        0x814b1189ed8ce8c021803aa403e698b247cbc0accd295cd3652b982496af704e::obligation::accrue_interests_and_rewards(arg0, arg2);
        assert!(arg4 <= 0x814b1189ed8ce8c021803aa403e698b247cbc0accd295cd3652b982496af704e::borrow_withdraw_evaluator::max_borrow_amount<0xabb3631bd2a91461b61e0b16a8e4e4e88185a3dd410e12186f65f18b1b98da17::coin_gusd::COIN_GUSD>(arg0, arg2, arg3, arg5, arg6), 0x814b1189ed8ce8c021803aa403e698b247cbc0accd295cd3652b982496af704e::error::borrow_too_much_error());
        0x814b1189ed8ce8c021803aa403e698b247cbc0accd295cd3652b982496af704e::obligation::increase_debt(arg0, v0, arg4);
        assert!(0x724ff007e3cb5e2464e94283edecd0c610567d475a980beaa8f404d9c15d3ba7::fixed_point32_empower::gt(0x814b1189ed8ce8c021803aa403e698b247cbc0accd295cd3652b982496af704e::collateral_value::collaterals_value_usd_for_borrow(arg0, arg2, arg3, arg5, arg6), 0x814b1189ed8ce8c021803aa403e698b247cbc0accd295cd3652b982496af704e::debt_value::debts_value_usd(arg0, arg3, arg5, arg6)), 0x814b1189ed8ce8c021803aa403e698b247cbc0accd295cd3652b982496af704e::error::borrow_too_much_error());
        0x814b1189ed8ce8c021803aa403e698b247cbc0accd295cd3652b982496af704e::market::add_borrow_fee<0xabb3631bd2a91461b61e0b16a8e4e4e88185a3dd410e12186f65f18b1b98da17::coin_gusd::COIN_GUSD>(arg2, 0x2::coin::into_balance<0xabb3631bd2a91461b61e0b16a8e4e4e88185a3dd410e12186f65f18b1b98da17::coin_gusd::COIN_GUSD>(0x2::coin::split<0xabb3631bd2a91461b61e0b16a8e4e4e88185a3dd410e12186f65f18b1b98da17::coin_gusd::COIN_GUSD>(&mut v3, v2, arg7)), arg7);
        let v4 = BorrowEvent{
            borrower   : 0x2::tx_context::sender(arg7),
            obligation : 0x2::object::id<0x814b1189ed8ce8c021803aa403e698b247cbc0accd295cd3652b982496af704e::obligation::Obligation>(arg0),
            amount     : arg4,
            borrow_fee : v2,
            time       : v1,
        };
        0x2::event::emit<BorrowEvent>(v4);
        v3
    }

    // decompiled from Move bytecode v6
}

