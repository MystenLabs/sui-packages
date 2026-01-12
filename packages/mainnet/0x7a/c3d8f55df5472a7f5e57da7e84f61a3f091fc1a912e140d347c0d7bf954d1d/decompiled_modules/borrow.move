module 0x7ac3d8f55df5472a7f5e57da7e84f61a3f091fc1a912e140d347c0d7bf954d1d::borrow {
    struct BorrowEvent has copy, drop {
        borrower: address,
        obligation: 0x2::object::ID,
        amount: u64,
        borrow_fee: u64,
        time: u64,
    }

    public fun borrow(arg0: &0x7ac3d8f55df5472a7f5e57da7e84f61a3f091fc1a912e140d347c0d7bf954d1d::version::Version, arg1: &mut 0x7ac3d8f55df5472a7f5e57da7e84f61a3f091fc1a912e140d347c0d7bf954d1d::obligation::Obligation, arg2: &0x7ac3d8f55df5472a7f5e57da7e84f61a3f091fc1a912e140d347c0d7bf954d1d::obligation::ObligationKey, arg3: &mut 0x7ac3d8f55df5472a7f5e57da7e84f61a3f091fc1a912e140d347c0d7bf954d1d::market::Market, arg4: &0x413d4cf3221e98f4096aabcab4edc84b9e66f60f2239e5cdbf6e49ee2916c7e0::coin_decimals_registry::CoinDecimalsRegistry, arg5: u64, arg6: &0x4f0be0e70afb81670fd135b4201270997f9a32a2dccddaa3925825fe5a8b4c2a::x_oracle::XOracle, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x46fe03da9891419ee9a20c2fa445a14aef81446a76f70324cd91abac543ec96a::coin_gusd::COIN_GUSD> {
        0x7ac3d8f55df5472a7f5e57da7e84f61a3f091fc1a912e140d347c0d7bf954d1d::version::assert_current_version(arg0);
        assert!(!0x7ac3d8f55df5472a7f5e57da7e84f61a3f091fc1a912e140d347c0d7bf954d1d::market::is_paused(arg3), 0x7ac3d8f55df5472a7f5e57da7e84f61a3f091fc1a912e140d347c0d7bf954d1d::error::market_paused_error());
        borrow_internal(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
    }

    public entry fun borrow_entry(arg0: &0x7ac3d8f55df5472a7f5e57da7e84f61a3f091fc1a912e140d347c0d7bf954d1d::version::Version, arg1: &mut 0x7ac3d8f55df5472a7f5e57da7e84f61a3f091fc1a912e140d347c0d7bf954d1d::obligation::Obligation, arg2: &0x7ac3d8f55df5472a7f5e57da7e84f61a3f091fc1a912e140d347c0d7bf954d1d::obligation::ObligationKey, arg3: &mut 0x7ac3d8f55df5472a7f5e57da7e84f61a3f091fc1a912e140d347c0d7bf954d1d::market::Market, arg4: &0x413d4cf3221e98f4096aabcab4edc84b9e66f60f2239e5cdbf6e49ee2916c7e0::coin_decimals_registry::CoinDecimalsRegistry, arg5: u64, arg6: &0x4f0be0e70afb81670fd135b4201270997f9a32a2dccddaa3925825fe5a8b4c2a::x_oracle::XOracle, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(!0x7ac3d8f55df5472a7f5e57da7e84f61a3f091fc1a912e140d347c0d7bf954d1d::market::is_paused(arg3), 0x7ac3d8f55df5472a7f5e57da7e84f61a3f091fc1a912e140d347c0d7bf954d1d::error::market_paused_error());
        let v0 = borrow(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x46fe03da9891419ee9a20c2fa445a14aef81446a76f70324cd91abac543ec96a::coin_gusd::COIN_GUSD>>(v0, 0x2::tx_context::sender(arg8));
    }

    fun borrow_internal(arg0: &mut 0x7ac3d8f55df5472a7f5e57da7e84f61a3f091fc1a912e140d347c0d7bf954d1d::obligation::Obligation, arg1: &0x7ac3d8f55df5472a7f5e57da7e84f61a3f091fc1a912e140d347c0d7bf954d1d::obligation::ObligationKey, arg2: &mut 0x7ac3d8f55df5472a7f5e57da7e84f61a3f091fc1a912e140d347c0d7bf954d1d::market::Market, arg3: &0x413d4cf3221e98f4096aabcab4edc84b9e66f60f2239e5cdbf6e49ee2916c7e0::coin_decimals_registry::CoinDecimalsRegistry, arg4: u64, arg5: &0x4f0be0e70afb81670fd135b4201270997f9a32a2dccddaa3925825fe5a8b4c2a::x_oracle::XOracle, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x46fe03da9891419ee9a20c2fa445a14aef81446a76f70324cd91abac543ec96a::coin_gusd::COIN_GUSD> {
        assert!(0x7ac3d8f55df5472a7f5e57da7e84f61a3f091fc1a912e140d347c0d7bf954d1d::obligation::borrow_locked(arg0) == false, 0x7ac3d8f55df5472a7f5e57da7e84f61a3f091fc1a912e140d347c0d7bf954d1d::error::obligation_locked());
        let v0 = 0x1::type_name::get<0x46fe03da9891419ee9a20c2fa445a14aef81446a76f70324cd91abac543ec96a::coin_gusd::COIN_GUSD>();
        let v1 = 0x2::clock::timestamp_ms(arg6) / 1000;
        0x7ac3d8f55df5472a7f5e57da7e84f61a3f091fc1a912e140d347c0d7bf954d1d::obligation::assert_key_match(arg0, arg1);
        let v2 = 0x1::fixed_point32::multiply_u64(arg4, *0x2::dynamic_field::borrow<0x7ac3d8f55df5472a7f5e57da7e84f61a3f091fc1a912e140d347c0d7bf954d1d::market_dynamic_keys::BorrowFeeKey, 0x1::fixed_point32::FixedPoint32>(0x7ac3d8f55df5472a7f5e57da7e84f61a3f091fc1a912e140d347c0d7bf954d1d::market::uid(arg2), 0x7ac3d8f55df5472a7f5e57da7e84f61a3f091fc1a912e140d347c0d7bf954d1d::market_dynamic_keys::borrow_fee_key(v0)));
        assert!(arg4 >= 0x7ac3d8f55df5472a7f5e57da7e84f61a3f091fc1a912e140d347c0d7bf954d1d::interest_model::min_borrow_amount(0x7ac3d8f55df5472a7f5e57da7e84f61a3f091fc1a912e140d347c0d7bf954d1d::market::interest_model(arg2, v0)) + v2, 0x7ac3d8f55df5472a7f5e57da7e84f61a3f091fc1a912e140d347c0d7bf954d1d::error::borrow_too_small_error());
        assert!((0x7ac3d8f55df5472a7f5e57da7e84f61a3f091fc1a912e140d347c0d7bf954d1d::market::total_global_debt(arg2, v0) as u128) + (arg4 as u128) <= *0x2::dynamic_field::borrow<0x7ac3d8f55df5472a7f5e57da7e84f61a3f091fc1a912e140d347c0d7bf954d1d::market_dynamic_keys::BorrowLimitKey, u128>(0x7ac3d8f55df5472a7f5e57da7e84f61a3f091fc1a912e140d347c0d7bf954d1d::market::uid(arg2), 0x7ac3d8f55df5472a7f5e57da7e84f61a3f091fc1a912e140d347c0d7bf954d1d::market_dynamic_keys::borrow_limit_key(v0)), 0x7ac3d8f55df5472a7f5e57da7e84f61a3f091fc1a912e140d347c0d7bf954d1d::error::borrow_limit_reached_error());
        0x7ac3d8f55df5472a7f5e57da7e84f61a3f091fc1a912e140d347c0d7bf954d1d::market::handle_outflow<0x46fe03da9891419ee9a20c2fa445a14aef81446a76f70324cd91abac543ec96a::coin_gusd::COIN_GUSD>(arg2, arg4, v1);
        0x7ac3d8f55df5472a7f5e57da7e84f61a3f091fc1a912e140d347c0d7bf954d1d::obligation::init_debt(arg0, arg2, v0);
        0x7ac3d8f55df5472a7f5e57da7e84f61a3f091fc1a912e140d347c0d7bf954d1d::obligation::accrue_interests_and_rewards(arg0, arg2);
        assert!(arg4 <= 0x7ac3d8f55df5472a7f5e57da7e84f61a3f091fc1a912e140d347c0d7bf954d1d::borrow_withdraw_evaluator::max_borrow_amount<0x46fe03da9891419ee9a20c2fa445a14aef81446a76f70324cd91abac543ec96a::coin_gusd::COIN_GUSD>(arg0, arg2, arg3, arg5, arg6), 0x7ac3d8f55df5472a7f5e57da7e84f61a3f091fc1a912e140d347c0d7bf954d1d::error::borrow_too_much_error());
        0x7ac3d8f55df5472a7f5e57da7e84f61a3f091fc1a912e140d347c0d7bf954d1d::obligation::increase_debt(arg0, v0, arg4);
        assert!(0xbf0ff2c916bccc759793a14cbd121f495f53f6121d8b5fd41c836a8ad8253d7c::fixed_point32_empower::gt(0x7ac3d8f55df5472a7f5e57da7e84f61a3f091fc1a912e140d347c0d7bf954d1d::collateral_value::collaterals_value_usd_for_borrow(arg0, arg2, arg3, arg5, arg6), 0x7ac3d8f55df5472a7f5e57da7e84f61a3f091fc1a912e140d347c0d7bf954d1d::debt_value::debts_value_usd(arg0, arg3, arg5, arg6)), 0x7ac3d8f55df5472a7f5e57da7e84f61a3f091fc1a912e140d347c0d7bf954d1d::error::borrow_too_much_error());
        let v3 = 0x7ac3d8f55df5472a7f5e57da7e84f61a3f091fc1a912e140d347c0d7bf954d1d::market::handle_borrow(arg2, arg4, v1, arg7);
        0x7ac3d8f55df5472a7f5e57da7e84f61a3f091fc1a912e140d347c0d7bf954d1d::market::add_borrow_fee<0x46fe03da9891419ee9a20c2fa445a14aef81446a76f70324cd91abac543ec96a::coin_gusd::COIN_GUSD>(arg2, 0x2::coin::into_balance<0x46fe03da9891419ee9a20c2fa445a14aef81446a76f70324cd91abac543ec96a::coin_gusd::COIN_GUSD>(0x2::coin::split<0x46fe03da9891419ee9a20c2fa445a14aef81446a76f70324cd91abac543ec96a::coin_gusd::COIN_GUSD>(&mut v3, v2, arg7)), arg7);
        let v4 = BorrowEvent{
            borrower   : 0x2::tx_context::sender(arg7),
            obligation : 0x2::object::id<0x7ac3d8f55df5472a7f5e57da7e84f61a3f091fc1a912e140d347c0d7bf954d1d::obligation::Obligation>(arg0),
            amount     : arg4,
            borrow_fee : v2,
            time       : v1,
        };
        0x2::event::emit<BorrowEvent>(v4);
        v3
    }

    // decompiled from Move bytecode v6
}

