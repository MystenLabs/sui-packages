module 0xe58d427b66cce0b2cef90ec9d353c05e64fd7598e678ebaf63e993b0f77c6191::leverage_borrow_swap {
    struct NewBorrowSwapEvent has copy, drop {
        leverage_owner_cap: 0x2::object::ID,
        operation: 0xe58d427b66cce0b2cef90ec9d353c05e64fd7598e678ebaf63e993b0f77c6191::leverage_obligation::Operation,
        collateral: 0x1::type_name::TypeName,
        debt: 0x1::type_name::TypeName,
        deposit_amount: u64,
        deposit_usd: 0x44868dc6a319dd47330602de8c8afdfdeb4ca57af33f1961127ce17f5c5fdd77::float::Decimal,
    }

    public fun request_leverage<T0, T1, T2>(arg0: &mut 0xbeb04086025ad90f2baacd186f10f81139d464d4350cb46c1804ff8dd10a2fc8::app::ProtocolApp, arg1: &mut 0xe58d427b66cce0b2cef90ec9d353c05e64fd7598e678ebaf63e993b0f77c6191::leverage_app::LeverageApp, arg2: &mut 0xbeb04086025ad90f2baacd186f10f81139d464d4350cb46c1804ff8dd10a2fc8::market::Market<T0>, arg3: &mut 0xe58d427b66cce0b2cef90ec9d353c05e64fd7598e678ebaf63e993b0f77c6191::leverage_market::LeverageMarket, arg4: &mut 0xe58d427b66cce0b2cef90ec9d353c05e64fd7598e678ebaf63e993b0f77c6191::leverage_obligation::LeverageMarketOwnerCap, arg5: 0x2::coin::Coin<T1>, arg6: u64, arg7: u64, arg8: &0xbeb04086025ad90f2baacd186f10f81139d464d4350cb46c1804ff8dd10a2fc8::coin_decimals_registry::CoinDecimalsRegistry, arg9: &0x2::clock::Clock, arg10: &0x1e1e32c7e9b4dd68fe84eb7285005ad5c23099e2e8b215ab32b2facf750029f::x_oracle::XOracle, arg11: &mut 0x2::tx_context::TxContext) : (0xbeb04086025ad90f2baacd186f10f81139d464d4350cb46c1804ff8dd10a2fc8::market::FlashLoan<T0, T1>, 0x2::coin::Coin<T2>) {
        assert!(!0xe58d427b66cce0b2cef90ec9d353c05e64fd7598e678ebaf63e993b0f77c6191::leverage_market::is_leverate_on_going(arg3), 13906834406271614975);
        0xe58d427b66cce0b2cef90ec9d353c05e64fd7598e678ebaf63e993b0f77c6191::leverage_market::mark_leverage_ongoing(arg3);
        let v0 = NewBorrowSwapEvent{
            leverage_owner_cap : 0xe58d427b66cce0b2cef90ec9d353c05e64fd7598e678ebaf63e993b0f77c6191::leverage_obligation::id(arg4),
            operation          : 0xe58d427b66cce0b2cef90ec9d353c05e64fd7598e678ebaf63e993b0f77c6191::leverage_obligation::borrow_swap(),
            collateral         : 0x1::type_name::get<T1>(),
            debt               : 0x1::type_name::get<T2>(),
            deposit_amount     : 0x2::coin::value<T1>(&arg5),
            deposit_usd        : 0xe58d427b66cce0b2cef90ec9d353c05e64fd7598e678ebaf63e993b0f77c6191::leverage_obligation::get_usd_value<T1>(arg10, arg9, 0x2::coin::value<T1>(&arg5), arg8),
        };
        0x2::event::emit<NewBorrowSwapEvent>(v0);
        0xe58d427b66cce0b2cef90ec9d353c05e64fd7598e678ebaf63e993b0f77c6191::leverage_obligation::set_or_check_position<T0, T1, T2>(arg4, arg2, 0xe58d427b66cce0b2cef90ec9d353c05e64fd7598e678ebaf63e993b0f77c6191::leverage_obligation::borrow_swap());
        let (v1, v2) = 0xbeb04086025ad90f2baacd186f10f81139d464d4350cb46c1804ff8dd10a2fc8::flash_loan::borrow_flash_loan<T0, T1>(arg0, 0xe58d427b66cce0b2cef90ec9d353c05e64fd7598e678ebaf63e993b0f77c6191::leverage_app::borrow_protocol_caller_cap(arg1), arg2, 0xe58d427b66cce0b2cef90ec9d353c05e64fd7598e678ebaf63e993b0f77c6191::leverage_market::emode_group(arg3), arg6 - 0x2::coin::value<T1>(&arg5), arg11);
        let v3 = v1;
        0xe58d427b66cce0b2cef90ec9d353c05e64fd7598e678ebaf63e993b0f77c6191::leverage_obligation::increase_collateral(arg4, 0x2::coin::value<T1>(&arg5), 0xe58d427b66cce0b2cef90ec9d353c05e64fd7598e678ebaf63e993b0f77c6191::leverage_obligation::get_collateral_price<T1, T2>(arg10, arg9));
        0x2::coin::join<T1>(&mut v3, arg5);
        assert!(0x2::coin::value<T1>(&v3) == arg6, 13906834535120633855);
        0xbeb04086025ad90f2baacd186f10f81139d464d4350cb46c1804ff8dd10a2fc8::deposit::deposit<T0, T1>(arg0, arg2, 0xe58d427b66cce0b2cef90ec9d353c05e64fd7598e678ebaf63e993b0f77c6191::leverage_obligation::market_obligation(arg4), v3, arg8, arg10, arg9, arg11);
        (v2, 0xbeb04086025ad90f2baacd186f10f81139d464d4350cb46c1804ff8dd10a2fc8::borrow::borrow<T0, T2>(0xe58d427b66cce0b2cef90ec9d353c05e64fd7598e678ebaf63e993b0f77c6191::leverage_obligation::market_obligation(arg4), arg2, arg8, arg7, arg10, arg9, arg11))
    }

    // decompiled from Move bytecode v6
}

