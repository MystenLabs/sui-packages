module 0xae62107ac6d3865863a5b6949dcf1c52ba12ba99e7086a16dcf1ab659144bc69::leverage_borrow_swap {
    struct NewBorrowSwapEvent has copy, drop {
        leverage_owner_cap: 0x2::object::ID,
        operation: 0xae62107ac6d3865863a5b6949dcf1c52ba12ba99e7086a16dcf1ab659144bc69::leverage_obligation::Operation,
        collateral: 0x1::type_name::TypeName,
        debt: 0x1::type_name::TypeName,
        collateral_amount: u64,
        collateral_price: 0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::Decimal,
    }

    public fun request_leverage<T0, T1, T2>(arg0: &0x936023cfa3fe5b9ae6dd8b4acead70e3c1e0b9f2693e7b073980f34bdc74644b::app::ProtocolApp, arg1: &0xae62107ac6d3865863a5b6949dcf1c52ba12ba99e7086a16dcf1ab659144bc69::leverage_app::LeverageApp, arg2: &mut 0x936023cfa3fe5b9ae6dd8b4acead70e3c1e0b9f2693e7b073980f34bdc74644b::market::Market<T0>, arg3: &mut 0xae62107ac6d3865863a5b6949dcf1c52ba12ba99e7086a16dcf1ab659144bc69::leverage_market::LeverageMarket, arg4: &mut 0xae62107ac6d3865863a5b6949dcf1c52ba12ba99e7086a16dcf1ab659144bc69::leverage_obligation::LeverageMarketOwnerCap, arg5: 0x2::coin::Coin<T1>, arg6: u64, arg7: u64, arg8: &0x936023cfa3fe5b9ae6dd8b4acead70e3c1e0b9f2693e7b073980f34bdc74644b::coin_decimals_registry::CoinDecimalsRegistry, arg9: &0x2::clock::Clock, arg10: &0xa5c42487226f39847b90db5110520084d76c282cee473f6674fe0787d54f7829::x_oracle::XOracle, arg11: &mut 0x2::tx_context::TxContext) : (0xae62107ac6d3865863a5b6949dcf1c52ba12ba99e7086a16dcf1ab659144bc69::leverage_repay::LeverageHotPotato<T0, T1>, 0x2::coin::Coin<T2>) {
        0xae62107ac6d3865863a5b6949dcf1c52ba12ba99e7086a16dcf1ab659144bc69::leverage_app::ensure_version_matches(arg1);
        0xae62107ac6d3865863a5b6949dcf1c52ba12ba99e7086a16dcf1ab659144bc69::leverage_market::ensure_no_leverage_on_going(arg3);
        0xae62107ac6d3865863a5b6949dcf1c52ba12ba99e7086a16dcf1ab659144bc69::leverage_market::mark_leverage_ongoing(arg3);
        0xae62107ac6d3865863a5b6949dcf1c52ba12ba99e7086a16dcf1ab659144bc69::leverage_market::ensure_supporting_market<T0>(arg3, arg2);
        0xae62107ac6d3865863a5b6949dcf1c52ba12ba99e7086a16dcf1ab659144bc69::leverage_obligation::ensure_same_market<T0>(arg4);
        0xae62107ac6d3865863a5b6949dcf1c52ba12ba99e7086a16dcf1ab659144bc69::leverage_obligation::set_or_check_position<T1, T2>(arg4, 0xae62107ac6d3865863a5b6949dcf1c52ba12ba99e7086a16dcf1ab659144bc69::leverage_obligation::borrow_swap());
        let v0 = NewBorrowSwapEvent{
            leverage_owner_cap : 0xae62107ac6d3865863a5b6949dcf1c52ba12ba99e7086a16dcf1ab659144bc69::leverage_obligation::id(arg4),
            operation          : 0xae62107ac6d3865863a5b6949dcf1c52ba12ba99e7086a16dcf1ab659144bc69::leverage_obligation::borrow_swap(),
            collateral         : 0x1::type_name::with_defining_ids<T1>(),
            debt               : 0x1::type_name::with_defining_ids<T2>(),
            collateral_amount  : 0x2::coin::value<T1>(&arg5),
            collateral_price   : 0xae62107ac6d3865863a5b6949dcf1c52ba12ba99e7086a16dcf1ab659144bc69::leverage_obligation::get_collateral_price<T1, T2>(arg10, arg9),
        };
        0x2::event::emit<NewBorrowSwapEvent>(v0);
        let (v1, v2) = 0x936023cfa3fe5b9ae6dd8b4acead70e3c1e0b9f2693e7b073980f34bdc74644b::flash_loan::borrow_flash_loan<T0, T1>(arg0, 0xae62107ac6d3865863a5b6949dcf1c52ba12ba99e7086a16dcf1ab659144bc69::leverage_app::borrow_protocol_caller_cap(arg1), arg2, 0xae62107ac6d3865863a5b6949dcf1c52ba12ba99e7086a16dcf1ab659144bc69::leverage_market::emode_group(arg3), arg6 - 0x2::coin::value<T1>(&arg5), arg11);
        let v3 = v1;
        0x2::coin::join<T1>(&mut v3, arg5);
        assert!(0x2::coin::value<T1>(&v3) == arg6, 0xae62107ac6d3865863a5b6949dcf1c52ba12ba99e7086a16dcf1ab659144bc69::leverage_error::token_amount_not_expected_value());
        0x936023cfa3fe5b9ae6dd8b4acead70e3c1e0b9f2693e7b073980f34bdc74644b::deposit::deposit<T0, T1>(arg0, arg2, 0xae62107ac6d3865863a5b6949dcf1c52ba12ba99e7086a16dcf1ab659144bc69::leverage_obligation::market_obligation(arg4), v3, arg9, arg11);
        (0xae62107ac6d3865863a5b6949dcf1c52ba12ba99e7086a16dcf1ab659144bc69::leverage_repay::new_leverage_hot_potato<T0, T1>(v2), 0x936023cfa3fe5b9ae6dd8b4acead70e3c1e0b9f2693e7b073980f34bdc74644b::borrow::borrow<T0, T2>(arg0, 0xae62107ac6d3865863a5b6949dcf1c52ba12ba99e7086a16dcf1ab659144bc69::leverage_obligation::market_obligation(arg4), arg2, arg8, arg7, arg10, arg9, arg11))
    }

    // decompiled from Move bytecode v6
}

