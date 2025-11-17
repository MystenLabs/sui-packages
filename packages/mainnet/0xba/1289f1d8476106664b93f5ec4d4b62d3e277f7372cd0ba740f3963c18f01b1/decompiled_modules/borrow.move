module 0xba1289f1d8476106664b93f5ec4d4b62d3e277f7372cd0ba740f3963c18f01b1::borrow {
    struct BorrowEvent has copy, drop {
        borrower: address,
        obligation: 0x2::object::ID,
        amount: u64,
        borrow_fee: u64,
        time: u64,
    }

    public fun borrow(arg0: &0xba1289f1d8476106664b93f5ec4d4b62d3e277f7372cd0ba740f3963c18f01b1::version::Version, arg1: &mut 0xba1289f1d8476106664b93f5ec4d4b62d3e277f7372cd0ba740f3963c18f01b1::obligation::Obligation, arg2: &0xba1289f1d8476106664b93f5ec4d4b62d3e277f7372cd0ba740f3963c18f01b1::obligation::ObligationKey, arg3: &mut 0xba1289f1d8476106664b93f5ec4d4b62d3e277f7372cd0ba740f3963c18f01b1::market::Market, arg4: &0xd2340f9ef1088b9fdc4d02d2628fcca4b4552f71ffdb03049425fc0a3b19ce41::coin_decimals_registry::CoinDecimalsRegistry, arg5: u64, arg6: &0x95fd973aea15879e75407f4e4c66a8d1026ad10a25360275a73b0ce44c7b09e8::x_oracle::XOracle, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xf028af390aef73ad70f8bbbeb380321933a0c8a4fc8b405706d669862a762d88::coin_gusd::COIN_GUSD> {
        0xba1289f1d8476106664b93f5ec4d4b62d3e277f7372cd0ba740f3963c18f01b1::version::assert_current_version(arg0);
        assert!(!0xba1289f1d8476106664b93f5ec4d4b62d3e277f7372cd0ba740f3963c18f01b1::market::is_paused(arg3), 0xba1289f1d8476106664b93f5ec4d4b62d3e277f7372cd0ba740f3963c18f01b1::error::market_paused_error());
        borrow_internal(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
    }

    public entry fun borrow_entry(arg0: &0xba1289f1d8476106664b93f5ec4d4b62d3e277f7372cd0ba740f3963c18f01b1::version::Version, arg1: &mut 0xba1289f1d8476106664b93f5ec4d4b62d3e277f7372cd0ba740f3963c18f01b1::obligation::Obligation, arg2: &0xba1289f1d8476106664b93f5ec4d4b62d3e277f7372cd0ba740f3963c18f01b1::obligation::ObligationKey, arg3: &mut 0xba1289f1d8476106664b93f5ec4d4b62d3e277f7372cd0ba740f3963c18f01b1::market::Market, arg4: &0xd2340f9ef1088b9fdc4d02d2628fcca4b4552f71ffdb03049425fc0a3b19ce41::coin_decimals_registry::CoinDecimalsRegistry, arg5: u64, arg6: &0x95fd973aea15879e75407f4e4c66a8d1026ad10a25360275a73b0ce44c7b09e8::x_oracle::XOracle, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(!0xba1289f1d8476106664b93f5ec4d4b62d3e277f7372cd0ba740f3963c18f01b1::market::is_paused(arg3), 0xba1289f1d8476106664b93f5ec4d4b62d3e277f7372cd0ba740f3963c18f01b1::error::market_paused_error());
        let v0 = borrow(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xf028af390aef73ad70f8bbbeb380321933a0c8a4fc8b405706d669862a762d88::coin_gusd::COIN_GUSD>>(v0, 0x2::tx_context::sender(arg8));
    }

    fun borrow_internal(arg0: &mut 0xba1289f1d8476106664b93f5ec4d4b62d3e277f7372cd0ba740f3963c18f01b1::obligation::Obligation, arg1: &0xba1289f1d8476106664b93f5ec4d4b62d3e277f7372cd0ba740f3963c18f01b1::obligation::ObligationKey, arg2: &mut 0xba1289f1d8476106664b93f5ec4d4b62d3e277f7372cd0ba740f3963c18f01b1::market::Market, arg3: &0xd2340f9ef1088b9fdc4d02d2628fcca4b4552f71ffdb03049425fc0a3b19ce41::coin_decimals_registry::CoinDecimalsRegistry, arg4: u64, arg5: &0x95fd973aea15879e75407f4e4c66a8d1026ad10a25360275a73b0ce44c7b09e8::x_oracle::XOracle, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xf028af390aef73ad70f8bbbeb380321933a0c8a4fc8b405706d669862a762d88::coin_gusd::COIN_GUSD> {
        assert!(0xba1289f1d8476106664b93f5ec4d4b62d3e277f7372cd0ba740f3963c18f01b1::obligation::borrow_locked(arg0) == false, 0xba1289f1d8476106664b93f5ec4d4b62d3e277f7372cd0ba740f3963c18f01b1::error::obligation_locked());
        let v0 = 0x1::type_name::get<0xf028af390aef73ad70f8bbbeb380321933a0c8a4fc8b405706d669862a762d88::coin_gusd::COIN_GUSD>();
        let v1 = 0x2::clock::timestamp_ms(arg6) / 1000;
        0xba1289f1d8476106664b93f5ec4d4b62d3e277f7372cd0ba740f3963c18f01b1::obligation::assert_key_match(arg0, arg1);
        let v2 = 0x1::fixed_point32::multiply_u64(arg4, *0x2::dynamic_field::borrow<0xba1289f1d8476106664b93f5ec4d4b62d3e277f7372cd0ba740f3963c18f01b1::market_dynamic_keys::BorrowFeeKey, 0x1::fixed_point32::FixedPoint32>(0xba1289f1d8476106664b93f5ec4d4b62d3e277f7372cd0ba740f3963c18f01b1::market::uid(arg2), 0xba1289f1d8476106664b93f5ec4d4b62d3e277f7372cd0ba740f3963c18f01b1::market_dynamic_keys::borrow_fee_key(v0)));
        assert!(arg4 >= 0xba1289f1d8476106664b93f5ec4d4b62d3e277f7372cd0ba740f3963c18f01b1::interest_model::min_borrow_amount(0xba1289f1d8476106664b93f5ec4d4b62d3e277f7372cd0ba740f3963c18f01b1::market::interest_model(arg2, v0)) + v2, 0xba1289f1d8476106664b93f5ec4d4b62d3e277f7372cd0ba740f3963c18f01b1::error::borrow_too_small_error());
        assert!((0xba1289f1d8476106664b93f5ec4d4b62d3e277f7372cd0ba740f3963c18f01b1::market::total_global_debt(arg2, v0) as u128) + (arg4 as u128) <= *0x2::dynamic_field::borrow<0xba1289f1d8476106664b93f5ec4d4b62d3e277f7372cd0ba740f3963c18f01b1::market_dynamic_keys::BorrowLimitKey, u128>(0xba1289f1d8476106664b93f5ec4d4b62d3e277f7372cd0ba740f3963c18f01b1::market::uid(arg2), 0xba1289f1d8476106664b93f5ec4d4b62d3e277f7372cd0ba740f3963c18f01b1::market_dynamic_keys::borrow_limit_key(v0)), 0xba1289f1d8476106664b93f5ec4d4b62d3e277f7372cd0ba740f3963c18f01b1::error::borrow_limit_reached_error());
        0xba1289f1d8476106664b93f5ec4d4b62d3e277f7372cd0ba740f3963c18f01b1::market::handle_outflow<0xf028af390aef73ad70f8bbbeb380321933a0c8a4fc8b405706d669862a762d88::coin_gusd::COIN_GUSD>(arg2, arg4, v1);
        let v3 = 0xba1289f1d8476106664b93f5ec4d4b62d3e277f7372cd0ba740f3963c18f01b1::market::handle_borrow(arg2, arg4, v1, arg7);
        0xba1289f1d8476106664b93f5ec4d4b62d3e277f7372cd0ba740f3963c18f01b1::obligation::init_debt(arg0, arg2, v0);
        0xba1289f1d8476106664b93f5ec4d4b62d3e277f7372cd0ba740f3963c18f01b1::obligation::accrue_interests_and_rewards(arg0, arg2);
        assert!(arg4 <= 0xba1289f1d8476106664b93f5ec4d4b62d3e277f7372cd0ba740f3963c18f01b1::borrow_withdraw_evaluator::max_borrow_amount<0xf028af390aef73ad70f8bbbeb380321933a0c8a4fc8b405706d669862a762d88::coin_gusd::COIN_GUSD>(arg0, arg2, arg3, arg5, arg6), 0xba1289f1d8476106664b93f5ec4d4b62d3e277f7372cd0ba740f3963c18f01b1::error::borrow_too_much_error());
        0xba1289f1d8476106664b93f5ec4d4b62d3e277f7372cd0ba740f3963c18f01b1::obligation::increase_debt(arg0, v0, arg4);
        assert!(0xdb2f245331502370e5518886b9ef2ea52293df6d1238baa0a25de1341297feb0::fixed_point32_empower::gt(0xba1289f1d8476106664b93f5ec4d4b62d3e277f7372cd0ba740f3963c18f01b1::collateral_value::collaterals_value_usd_for_borrow(arg0, arg2, arg3, arg5, arg6), 0xba1289f1d8476106664b93f5ec4d4b62d3e277f7372cd0ba740f3963c18f01b1::debt_value::debts_value_usd(arg0, arg3, arg5, arg6)), 0xba1289f1d8476106664b93f5ec4d4b62d3e277f7372cd0ba740f3963c18f01b1::error::borrow_too_much_error());
        0xba1289f1d8476106664b93f5ec4d4b62d3e277f7372cd0ba740f3963c18f01b1::market::add_borrow_fee<0xf028af390aef73ad70f8bbbeb380321933a0c8a4fc8b405706d669862a762d88::coin_gusd::COIN_GUSD>(arg2, 0x2::coin::into_balance<0xf028af390aef73ad70f8bbbeb380321933a0c8a4fc8b405706d669862a762d88::coin_gusd::COIN_GUSD>(0x2::coin::split<0xf028af390aef73ad70f8bbbeb380321933a0c8a4fc8b405706d669862a762d88::coin_gusd::COIN_GUSD>(&mut v3, v2, arg7)), arg7);
        let v4 = BorrowEvent{
            borrower   : 0x2::tx_context::sender(arg7),
            obligation : 0x2::object::id<0xba1289f1d8476106664b93f5ec4d4b62d3e277f7372cd0ba740f3963c18f01b1::obligation::Obligation>(arg0),
            amount     : arg4,
            borrow_fee : v2,
            time       : v1,
        };
        0x2::event::emit<BorrowEvent>(v4);
        v3
    }

    // decompiled from Move bytecode v6
}

