module 0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::borrow {
    struct BorrowEvent has copy, drop {
        borrower: address,
        obligation: 0x2::object::ID,
        amount: u64,
        borrow_fee: u64,
        time: u64,
    }

    public fun borrow(arg0: &0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::version::Version, arg1: &mut 0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::obligation::Obligation, arg2: &0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::obligation::ObligationKey, arg3: &mut 0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::market::Market, arg4: &0x177afe2b7c818730b4980df53cc683be7393d20cada006b02152d92210983a74::coin_decimals_registry::CoinDecimalsRegistry, arg5: u64, arg6: &0x7fdc2bc8e78c3e133728c75e54fe5587b868ad59f849d8c7611147cc0394f305::x_oracle::XOracle, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xa4d5fe28cdff0c3427ee0c9a2eba81e6cfef7e45676268729204071896836394::coin_gusd::COIN_GUSD> {
        0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::version::assert_current_version(arg0);
        assert!(!0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::market::is_paused(arg3), 0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::error::market_paused_error());
        borrow_internal(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
    }

    public entry fun borrow_entry(arg0: &0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::version::Version, arg1: &mut 0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::obligation::Obligation, arg2: &0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::obligation::ObligationKey, arg3: &mut 0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::market::Market, arg4: &0x177afe2b7c818730b4980df53cc683be7393d20cada006b02152d92210983a74::coin_decimals_registry::CoinDecimalsRegistry, arg5: u64, arg6: &0x7fdc2bc8e78c3e133728c75e54fe5587b868ad59f849d8c7611147cc0394f305::x_oracle::XOracle, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(!0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::market::is_paused(arg3), 0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::error::market_paused_error());
        let v0 = borrow(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xa4d5fe28cdff0c3427ee0c9a2eba81e6cfef7e45676268729204071896836394::coin_gusd::COIN_GUSD>>(v0, 0x2::tx_context::sender(arg8));
    }

    fun borrow_internal(arg0: &mut 0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::obligation::Obligation, arg1: &0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::obligation::ObligationKey, arg2: &mut 0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::market::Market, arg3: &0x177afe2b7c818730b4980df53cc683be7393d20cada006b02152d92210983a74::coin_decimals_registry::CoinDecimalsRegistry, arg4: u64, arg5: &0x7fdc2bc8e78c3e133728c75e54fe5587b868ad59f849d8c7611147cc0394f305::x_oracle::XOracle, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xa4d5fe28cdff0c3427ee0c9a2eba81e6cfef7e45676268729204071896836394::coin_gusd::COIN_GUSD> {
        assert!(0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::obligation::borrow_locked(arg0) == false, 0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::error::obligation_locked());
        let v0 = 0x1::type_name::get<0xa4d5fe28cdff0c3427ee0c9a2eba81e6cfef7e45676268729204071896836394::coin_gusd::COIN_GUSD>();
        let v1 = 0x2::clock::timestamp_ms(arg6) / 1000;
        0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::obligation::assert_key_match(arg0, arg1);
        let v2 = 0x1::fixed_point32::multiply_u64(arg4, *0x2::dynamic_field::borrow<0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::market_dynamic_keys::BorrowFeeKey, 0x1::fixed_point32::FixedPoint32>(0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::market::uid(arg2), 0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::market_dynamic_keys::borrow_fee_key(v0)));
        assert!(arg4 >= 0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::interest_model::min_borrow_amount(0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::market::interest_model(arg2, v0)) + v2, 0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::error::borrow_too_small_error());
        assert!((0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::market::total_global_debt(arg2, v0) as u128) + (arg4 as u128) <= *0x2::dynamic_field::borrow<0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::market_dynamic_keys::BorrowLimitKey, u128>(0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::market::uid(arg2), 0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::market_dynamic_keys::borrow_limit_key(v0)), 0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::error::borrow_limit_reached_error());
        0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::market::handle_outflow<0xa4d5fe28cdff0c3427ee0c9a2eba81e6cfef7e45676268729204071896836394::coin_gusd::COIN_GUSD>(arg2, arg4, v1);
        let v3 = 0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::market::handle_borrow(arg2, arg4, v1, arg7);
        0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::obligation::init_debt(arg0, arg2, v0);
        0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::obligation::accrue_interests_and_rewards(arg0, arg2);
        assert!(arg4 <= 0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::borrow_withdraw_evaluator::max_borrow_amount<0xa4d5fe28cdff0c3427ee0c9a2eba81e6cfef7e45676268729204071896836394::coin_gusd::COIN_GUSD>(arg0, arg2, arg3, arg5, arg6), 0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::error::borrow_too_much_error());
        0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::obligation::increase_debt(arg0, v0, arg4);
        assert!(0x47aee540b4cf13763b58341097db066dc43dfa0574cd74729b64694f097a4d5d::fixed_point32_empower::gt(0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::collateral_value::collaterals_value_usd_for_borrow(arg0, arg2, arg3, arg5, arg6), 0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::debt_value::debts_value_usd(arg0, arg3, arg5, arg6)), 0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::error::borrow_too_much_error());
        0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::market::add_borrow_fee<0xa4d5fe28cdff0c3427ee0c9a2eba81e6cfef7e45676268729204071896836394::coin_gusd::COIN_GUSD>(arg2, 0x2::coin::into_balance<0xa4d5fe28cdff0c3427ee0c9a2eba81e6cfef7e45676268729204071896836394::coin_gusd::COIN_GUSD>(0x2::coin::split<0xa4d5fe28cdff0c3427ee0c9a2eba81e6cfef7e45676268729204071896836394::coin_gusd::COIN_GUSD>(&mut v3, v2, arg7)), arg7);
        let v4 = BorrowEvent{
            borrower   : 0x2::tx_context::sender(arg7),
            obligation : 0x2::object::id<0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::obligation::Obligation>(arg0),
            amount     : arg4,
            borrow_fee : v2,
            time       : v1,
        };
        0x2::event::emit<BorrowEvent>(v4);
        v3
    }

    // decompiled from Move bytecode v6
}

