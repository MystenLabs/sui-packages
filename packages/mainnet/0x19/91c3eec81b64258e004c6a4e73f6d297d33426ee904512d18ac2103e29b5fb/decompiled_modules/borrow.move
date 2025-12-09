module 0x1991c3eec81b64258e004c6a4e73f6d297d33426ee904512d18ac2103e29b5fb::borrow {
    struct BorrowEvent has copy, drop {
        borrower: address,
        obligation: 0x2::object::ID,
        amount: u64,
        borrow_fee: u64,
        time: u64,
    }

    public fun borrow(arg0: &0x1991c3eec81b64258e004c6a4e73f6d297d33426ee904512d18ac2103e29b5fb::version::Version, arg1: &mut 0x1991c3eec81b64258e004c6a4e73f6d297d33426ee904512d18ac2103e29b5fb::obligation::Obligation, arg2: &0x1991c3eec81b64258e004c6a4e73f6d297d33426ee904512d18ac2103e29b5fb::obligation::ObligationKey, arg3: &mut 0x1991c3eec81b64258e004c6a4e73f6d297d33426ee904512d18ac2103e29b5fb::market::Market, arg4: &0x5f7929b94887cddc14ddfe7bfe9ae9e94d79ca3d06df174defe76e1646a715f6::coin_decimals_registry::CoinDecimalsRegistry, arg5: u64, arg6: &0x4b8da0adfc3b829d63878104400a195a1864c347446b27947a28e4201ddffbbe::x_oracle::XOracle, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xac1462fcab23fb2408d22ec26bc472c1e76d0851b9283d11ff491faffde1be51::coin_gusd::COIN_GUSD> {
        0x1991c3eec81b64258e004c6a4e73f6d297d33426ee904512d18ac2103e29b5fb::version::assert_current_version(arg0);
        assert!(!0x1991c3eec81b64258e004c6a4e73f6d297d33426ee904512d18ac2103e29b5fb::market::is_paused(arg3), 0x1991c3eec81b64258e004c6a4e73f6d297d33426ee904512d18ac2103e29b5fb::error::market_paused_error());
        borrow_internal(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
    }

    public entry fun borrow_entry(arg0: &0x1991c3eec81b64258e004c6a4e73f6d297d33426ee904512d18ac2103e29b5fb::version::Version, arg1: &mut 0x1991c3eec81b64258e004c6a4e73f6d297d33426ee904512d18ac2103e29b5fb::obligation::Obligation, arg2: &0x1991c3eec81b64258e004c6a4e73f6d297d33426ee904512d18ac2103e29b5fb::obligation::ObligationKey, arg3: &mut 0x1991c3eec81b64258e004c6a4e73f6d297d33426ee904512d18ac2103e29b5fb::market::Market, arg4: &0x5f7929b94887cddc14ddfe7bfe9ae9e94d79ca3d06df174defe76e1646a715f6::coin_decimals_registry::CoinDecimalsRegistry, arg5: u64, arg6: &0x4b8da0adfc3b829d63878104400a195a1864c347446b27947a28e4201ddffbbe::x_oracle::XOracle, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(!0x1991c3eec81b64258e004c6a4e73f6d297d33426ee904512d18ac2103e29b5fb::market::is_paused(arg3), 0x1991c3eec81b64258e004c6a4e73f6d297d33426ee904512d18ac2103e29b5fb::error::market_paused_error());
        let v0 = borrow(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xac1462fcab23fb2408d22ec26bc472c1e76d0851b9283d11ff491faffde1be51::coin_gusd::COIN_GUSD>>(v0, 0x2::tx_context::sender(arg8));
    }

    fun borrow_internal(arg0: &mut 0x1991c3eec81b64258e004c6a4e73f6d297d33426ee904512d18ac2103e29b5fb::obligation::Obligation, arg1: &0x1991c3eec81b64258e004c6a4e73f6d297d33426ee904512d18ac2103e29b5fb::obligation::ObligationKey, arg2: &mut 0x1991c3eec81b64258e004c6a4e73f6d297d33426ee904512d18ac2103e29b5fb::market::Market, arg3: &0x5f7929b94887cddc14ddfe7bfe9ae9e94d79ca3d06df174defe76e1646a715f6::coin_decimals_registry::CoinDecimalsRegistry, arg4: u64, arg5: &0x4b8da0adfc3b829d63878104400a195a1864c347446b27947a28e4201ddffbbe::x_oracle::XOracle, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xac1462fcab23fb2408d22ec26bc472c1e76d0851b9283d11ff491faffde1be51::coin_gusd::COIN_GUSD> {
        assert!(0x1991c3eec81b64258e004c6a4e73f6d297d33426ee904512d18ac2103e29b5fb::obligation::borrow_locked(arg0) == false, 0x1991c3eec81b64258e004c6a4e73f6d297d33426ee904512d18ac2103e29b5fb::error::obligation_locked());
        let v0 = 0x1::type_name::get<0xac1462fcab23fb2408d22ec26bc472c1e76d0851b9283d11ff491faffde1be51::coin_gusd::COIN_GUSD>();
        let v1 = 0x2::clock::timestamp_ms(arg6) / 1000;
        0x1991c3eec81b64258e004c6a4e73f6d297d33426ee904512d18ac2103e29b5fb::obligation::assert_key_match(arg0, arg1);
        let v2 = 0x1::fixed_point32::multiply_u64(arg4, *0x2::dynamic_field::borrow<0x1991c3eec81b64258e004c6a4e73f6d297d33426ee904512d18ac2103e29b5fb::market_dynamic_keys::BorrowFeeKey, 0x1::fixed_point32::FixedPoint32>(0x1991c3eec81b64258e004c6a4e73f6d297d33426ee904512d18ac2103e29b5fb::market::uid(arg2), 0x1991c3eec81b64258e004c6a4e73f6d297d33426ee904512d18ac2103e29b5fb::market_dynamic_keys::borrow_fee_key(v0)));
        assert!(arg4 >= 0x1991c3eec81b64258e004c6a4e73f6d297d33426ee904512d18ac2103e29b5fb::interest_model::min_borrow_amount(0x1991c3eec81b64258e004c6a4e73f6d297d33426ee904512d18ac2103e29b5fb::market::interest_model(arg2, v0)) + v2, 0x1991c3eec81b64258e004c6a4e73f6d297d33426ee904512d18ac2103e29b5fb::error::borrow_too_small_error());
        assert!((0x1991c3eec81b64258e004c6a4e73f6d297d33426ee904512d18ac2103e29b5fb::market::total_global_debt(arg2, v0) as u128) + (arg4 as u128) <= *0x2::dynamic_field::borrow<0x1991c3eec81b64258e004c6a4e73f6d297d33426ee904512d18ac2103e29b5fb::market_dynamic_keys::BorrowLimitKey, u128>(0x1991c3eec81b64258e004c6a4e73f6d297d33426ee904512d18ac2103e29b5fb::market::uid(arg2), 0x1991c3eec81b64258e004c6a4e73f6d297d33426ee904512d18ac2103e29b5fb::market_dynamic_keys::borrow_limit_key(v0)), 0x1991c3eec81b64258e004c6a4e73f6d297d33426ee904512d18ac2103e29b5fb::error::borrow_limit_reached_error());
        0x1991c3eec81b64258e004c6a4e73f6d297d33426ee904512d18ac2103e29b5fb::market::handle_outflow<0xac1462fcab23fb2408d22ec26bc472c1e76d0851b9283d11ff491faffde1be51::coin_gusd::COIN_GUSD>(arg2, arg4, v1);
        let v3 = 0x1991c3eec81b64258e004c6a4e73f6d297d33426ee904512d18ac2103e29b5fb::market::handle_borrow(arg2, arg4, v1, arg7);
        0x1991c3eec81b64258e004c6a4e73f6d297d33426ee904512d18ac2103e29b5fb::obligation::init_debt(arg0, arg2, v0);
        0x1991c3eec81b64258e004c6a4e73f6d297d33426ee904512d18ac2103e29b5fb::obligation::accrue_interests_and_rewards(arg0, arg2);
        assert!(arg4 <= 0x1991c3eec81b64258e004c6a4e73f6d297d33426ee904512d18ac2103e29b5fb::borrow_withdraw_evaluator::max_borrow_amount<0xac1462fcab23fb2408d22ec26bc472c1e76d0851b9283d11ff491faffde1be51::coin_gusd::COIN_GUSD>(arg0, arg2, arg3, arg5, arg6), 0x1991c3eec81b64258e004c6a4e73f6d297d33426ee904512d18ac2103e29b5fb::error::borrow_too_much_error());
        0x1991c3eec81b64258e004c6a4e73f6d297d33426ee904512d18ac2103e29b5fb::obligation::increase_debt(arg0, v0, arg4);
        assert!(0x6af05aeef77d9111b2135a46f6eccc7f307c356f35c73d19a00ee440b5671616::fixed_point32_empower::gt(0x1991c3eec81b64258e004c6a4e73f6d297d33426ee904512d18ac2103e29b5fb::collateral_value::collaterals_value_usd_for_borrow(arg0, arg2, arg3, arg5, arg6), 0x1991c3eec81b64258e004c6a4e73f6d297d33426ee904512d18ac2103e29b5fb::debt_value::debts_value_usd(arg0, arg3, arg5, arg6)), 0x1991c3eec81b64258e004c6a4e73f6d297d33426ee904512d18ac2103e29b5fb::error::borrow_too_much_error());
        0x1991c3eec81b64258e004c6a4e73f6d297d33426ee904512d18ac2103e29b5fb::market::add_borrow_fee<0xac1462fcab23fb2408d22ec26bc472c1e76d0851b9283d11ff491faffde1be51::coin_gusd::COIN_GUSD>(arg2, 0x2::coin::into_balance<0xac1462fcab23fb2408d22ec26bc472c1e76d0851b9283d11ff491faffde1be51::coin_gusd::COIN_GUSD>(0x2::coin::split<0xac1462fcab23fb2408d22ec26bc472c1e76d0851b9283d11ff491faffde1be51::coin_gusd::COIN_GUSD>(&mut v3, v2, arg7)), arg7);
        let v4 = BorrowEvent{
            borrower   : 0x2::tx_context::sender(arg7),
            obligation : 0x2::object::id<0x1991c3eec81b64258e004c6a4e73f6d297d33426ee904512d18ac2103e29b5fb::obligation::Obligation>(arg0),
            amount     : arg4,
            borrow_fee : v2,
            time       : v1,
        };
        0x2::event::emit<BorrowEvent>(v4);
        v3
    }

    // decompiled from Move bytecode v6
}

