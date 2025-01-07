module 0x2929af9c3feca396beab1b842841a6ece4aa534c5fae7f482e244d9583aacfb9::borrow {
    struct BorrowEvent has copy, drop {
        borrower: address,
        obligation: 0x2::object::ID,
        asset: 0x1::type_name::TypeName,
        amount: u64,
        time: u64,
    }

    struct BorrowEventV2 has copy, drop {
        borrower: address,
        obligation: 0x2::object::ID,
        asset: 0x1::type_name::TypeName,
        amount: u64,
        borrow_fee: u64,
        time: u64,
    }

    public fun borrow<T0>(arg0: &0x2929af9c3feca396beab1b842841a6ece4aa534c5fae7f482e244d9583aacfb9::version::Version, arg1: &mut 0x2929af9c3feca396beab1b842841a6ece4aa534c5fae7f482e244d9583aacfb9::obligation::Obligation, arg2: &0x2929af9c3feca396beab1b842841a6ece4aa534c5fae7f482e244d9583aacfb9::obligation::ObligationKey, arg3: &mut 0x2929af9c3feca396beab1b842841a6ece4aa534c5fae7f482e244d9583aacfb9::market::Market, arg4: &0x2929af9c3feca396beab1b842841a6ece4aa534c5fae7f482e244d9583aacfb9::coin_decimals_registry::CoinDecimalsRegistry, arg5: u64, arg6: &0x2929af9c3feca396beab1b842841a6ece4aa534c5fae7f482e244d9583aacfb9::x_oracle::XOracle, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2929af9c3feca396beab1b842841a6ece4aa534c5fae7f482e244d9583aacfb9::version::assert_current_version(arg0);
        let v0 = borrow_internal<T0>(arg1, arg2, arg3, arg4, arg5, 0x1::option::none<0x2929af9c3feca396beab1b842841a6ece4aa534c5fae7f482e244d9583aacfb9::ticket_accesses::TicketForBorrowingFeeDiscount>(), arg6, arg7, arg8);
        0x2::coin::from_balance<T0>(v0, arg8)
    }

    public entry fun borrow_entry<T0>(arg0: &0x2929af9c3feca396beab1b842841a6ece4aa534c5fae7f482e244d9583aacfb9::version::Version, arg1: &mut 0x2929af9c3feca396beab1b842841a6ece4aa534c5fae7f482e244d9583aacfb9::obligation::Obligation, arg2: &0x2929af9c3feca396beab1b842841a6ece4aa534c5fae7f482e244d9583aacfb9::obligation::ObligationKey, arg3: &mut 0x2929af9c3feca396beab1b842841a6ece4aa534c5fae7f482e244d9583aacfb9::market::Market, arg4: &0x2929af9c3feca396beab1b842841a6ece4aa534c5fae7f482e244d9583aacfb9::coin_decimals_registry::CoinDecimalsRegistry, arg5: u64, arg6: &0x2929af9c3feca396beab1b842841a6ece4aa534c5fae7f482e244d9583aacfb9::x_oracle::XOracle, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = borrow<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg8));
    }

    fun borrow_internal<T0>(arg0: &mut 0x2929af9c3feca396beab1b842841a6ece4aa534c5fae7f482e244d9583aacfb9::obligation::Obligation, arg1: &0x2929af9c3feca396beab1b842841a6ece4aa534c5fae7f482e244d9583aacfb9::obligation::ObligationKey, arg2: &mut 0x2929af9c3feca396beab1b842841a6ece4aa534c5fae7f482e244d9583aacfb9::market::Market, arg3: &0x2929af9c3feca396beab1b842841a6ece4aa534c5fae7f482e244d9583aacfb9::coin_decimals_registry::CoinDecimalsRegistry, arg4: u64, arg5: 0x1::option::Option<0x2929af9c3feca396beab1b842841a6ece4aa534c5fae7f482e244d9583aacfb9::ticket_accesses::TicketForBorrowingFeeDiscount>, arg6: &0x2929af9c3feca396beab1b842841a6ece4aa534c5fae7f482e244d9583aacfb9::x_oracle::XOracle, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        assert!(0x2929af9c3feca396beab1b842841a6ece4aa534c5fae7f482e244d9583aacfb9::whitelist::is_address_allowed(0x2929af9c3feca396beab1b842841a6ece4aa534c5fae7f482e244d9583aacfb9::market::uid(arg2), 0x2::tx_context::sender(arg8)), 0x2929af9c3feca396beab1b842841a6ece4aa534c5fae7f482e244d9583aacfb9::error::whitelist_error());
        assert!(0x2929af9c3feca396beab1b842841a6ece4aa534c5fae7f482e244d9583aacfb9::obligation::borrow_locked(arg0) == false, 0x2929af9c3feca396beab1b842841a6ece4aa534c5fae7f482e244d9583aacfb9::error::obligation_locked());
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2929af9c3feca396beab1b842841a6ece4aa534c5fae7f482e244d9583aacfb9::market::is_base_asset_active(arg2, v0), 0x2929af9c3feca396beab1b842841a6ece4aa534c5fae7f482e244d9583aacfb9::error::base_asset_not_active_error());
        let v1 = 0x2::clock::timestamp_ms(arg7) / 1000;
        0x2929af9c3feca396beab1b842841a6ece4aa534c5fae7f482e244d9583aacfb9::obligation::assert_key_match(arg0, arg1);
        assert!(!0x2929af9c3feca396beab1b842841a6ece4aa534c5fae7f482e244d9583aacfb9::obligation::has_coin_x_as_collateral(arg0, v0), 0x2929af9c3feca396beab1b842841a6ece4aa534c5fae7f482e244d9583aacfb9::error::unable_to_borrow_a_collateral_coin());
        assert!(arg4 > 0x2929af9c3feca396beab1b842841a6ece4aa534c5fae7f482e244d9583aacfb9::interest_model::min_borrow_amount(0x2929af9c3feca396beab1b842841a6ece4aa534c5fae7f482e244d9583aacfb9::market::interest_model(arg2, v0)), 0x2929af9c3feca396beab1b842841a6ece4aa534c5fae7f482e244d9583aacfb9::error::borrow_too_small_error());
        0x2929af9c3feca396beab1b842841a6ece4aa534c5fae7f482e244d9583aacfb9::market::handle_outflow<T0>(arg2, arg4, v1);
        let v2 = 0x2929af9c3feca396beab1b842841a6ece4aa534c5fae7f482e244d9583aacfb9::market::handle_borrow<T0>(arg2, arg4, v1);
        0x2929af9c3feca396beab1b842841a6ece4aa534c5fae7f482e244d9583aacfb9::obligation::init_debt(arg0, arg2, v0);
        0x2929af9c3feca396beab1b842841a6ece4aa534c5fae7f482e244d9583aacfb9::obligation::accrue_interests_and_rewards(arg0, arg2);
        assert!(arg4 <= 0x2929af9c3feca396beab1b842841a6ece4aa534c5fae7f482e244d9583aacfb9::borrow_withdraw_evaluator::max_borrow_amount<T0>(arg0, arg2, arg3, arg6, arg7), 0x2929af9c3feca396beab1b842841a6ece4aa534c5fae7f482e244d9583aacfb9::error::borrow_too_much_error());
        0x2929af9c3feca396beab1b842841a6ece4aa534c5fae7f482e244d9583aacfb9::obligation::increase_debt(arg0, v0, arg4);
        let v3 = 0x1::fixed_point32::multiply_u64(arg4, *0x2::dynamic_field::borrow<0x2929af9c3feca396beab1b842841a6ece4aa534c5fae7f482e244d9583aacfb9::market_dynamic_keys::BorrowFeeKey, 0x1::fixed_point32::FixedPoint32>(0x2929af9c3feca396beab1b842841a6ece4aa534c5fae7f482e244d9583aacfb9::market::uid(arg2), 0x2929af9c3feca396beab1b842841a6ece4aa534c5fae7f482e244d9583aacfb9::market_dynamic_keys::borrow_fee_key(0x1::type_name::get<T0>())));
        let v4 = if (0x1::option::is_some<0x2929af9c3feca396beab1b842841a6ece4aa534c5fae7f482e244d9583aacfb9::ticket_accesses::TicketForBorrowingFeeDiscount>(&arg5)) {
            let v5 = 0x1::option::extract<0x2929af9c3feca396beab1b842841a6ece4aa534c5fae7f482e244d9583aacfb9::ticket_accesses::TicketForBorrowingFeeDiscount>(&mut arg5);
            let (v6, v7) = 0x2929af9c3feca396beab1b842841a6ece4aa534c5fae7f482e244d9583aacfb9::ticket_accesses::get_borrowing_fee_discount(&v5);
            v3 - 0x2929af9c3feca396beab1b842841a6ece4aa534c5fae7f482e244d9583aacfb9::u64::mul_div(v3, v6, v7)
        } else {
            v3
        };
        if (v4 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v2, v4), arg8), *0x2::dynamic_field::borrow<0x2929af9c3feca396beab1b842841a6ece4aa534c5fae7f482e244d9583aacfb9::market_dynamic_keys::BorrowFeeRecipientKey, address>(0x2929af9c3feca396beab1b842841a6ece4aa534c5fae7f482e244d9583aacfb9::market::uid(arg2), 0x2929af9c3feca396beab1b842841a6ece4aa534c5fae7f482e244d9583aacfb9::market_dynamic_keys::borrow_fee_recipient_key()));
        };
        let v8 = BorrowEventV2{
            borrower   : 0x2::tx_context::sender(arg8),
            obligation : 0x2::object::id<0x2929af9c3feca396beab1b842841a6ece4aa534c5fae7f482e244d9583aacfb9::obligation::Obligation>(arg0),
            asset      : v0,
            amount     : arg4,
            borrow_fee : v4,
            time       : v1,
        };
        0x2::event::emit<BorrowEventV2>(v8);
        v2
    }

    public fun borrow_with_ticket<T0>(arg0: &0x2929af9c3feca396beab1b842841a6ece4aa534c5fae7f482e244d9583aacfb9::version::Version, arg1: &mut 0x2929af9c3feca396beab1b842841a6ece4aa534c5fae7f482e244d9583aacfb9::obligation::Obligation, arg2: &0x2929af9c3feca396beab1b842841a6ece4aa534c5fae7f482e244d9583aacfb9::obligation::ObligationKey, arg3: &mut 0x2929af9c3feca396beab1b842841a6ece4aa534c5fae7f482e244d9583aacfb9::market::Market, arg4: &0x2929af9c3feca396beab1b842841a6ece4aa534c5fae7f482e244d9583aacfb9::coin_decimals_registry::CoinDecimalsRegistry, arg5: u64, arg6: 0x2929af9c3feca396beab1b842841a6ece4aa534c5fae7f482e244d9583aacfb9::ticket_accesses::TicketForBorrowingFeeDiscount, arg7: &0x2929af9c3feca396beab1b842841a6ece4aa534c5fae7f482e244d9583aacfb9::x_oracle::XOracle, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2929af9c3feca396beab1b842841a6ece4aa534c5fae7f482e244d9583aacfb9::version::assert_current_version(arg0);
        let v0 = borrow_internal<T0>(arg1, arg2, arg3, arg4, arg5, 0x1::option::some<0x2929af9c3feca396beab1b842841a6ece4aa534c5fae7f482e244d9583aacfb9::ticket_accesses::TicketForBorrowingFeeDiscount>(arg6), arg7, arg8, arg9);
        0x2::coin::from_balance<T0>(v0, arg9)
    }

    // decompiled from Move bytecode v6
}

