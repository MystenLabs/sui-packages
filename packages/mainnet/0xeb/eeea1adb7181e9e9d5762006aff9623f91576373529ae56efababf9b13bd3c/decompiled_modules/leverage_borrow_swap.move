module 0xebeeea1adb7181e9e9d5762006aff9623f91576373529ae56efababf9b13bd3c::leverage_borrow_swap {
    struct NewBorrowSwapEvent has copy, drop {
        leverage_owner_cap: 0x2::object::ID,
        operation: 0xebeeea1adb7181e9e9d5762006aff9623f91576373529ae56efababf9b13bd3c::leverage_obligation::Operation,
        collateral: 0x1::type_name::TypeName,
        debt: 0x1::type_name::TypeName,
        collateral_amount: u64,
        collateral_price: 0x6a9f1a9dbc42ae30b45eca93faf2334a7a237749dd65395fdcab5be361da6d00::float::Decimal,
    }

    public fun request_leverage<T0, T1, T2>(arg0: &mut 0x74d918b1895cc35d3710ca5b36bd6769a9551e3833aa9177f19b02316a48dcd4::app::ProtocolApp, arg1: &mut 0xebeeea1adb7181e9e9d5762006aff9623f91576373529ae56efababf9b13bd3c::leverage_app::LeverageApp, arg2: &mut 0x74d918b1895cc35d3710ca5b36bd6769a9551e3833aa9177f19b02316a48dcd4::market::Market<T0>, arg3: &mut 0xebeeea1adb7181e9e9d5762006aff9623f91576373529ae56efababf9b13bd3c::leverage_market::LeverageMarket, arg4: &mut 0xebeeea1adb7181e9e9d5762006aff9623f91576373529ae56efababf9b13bd3c::leverage_obligation::LeverageMarketOwnerCap, arg5: 0x2::coin::Coin<T1>, arg6: u64, arg7: u64, arg8: &0x74d918b1895cc35d3710ca5b36bd6769a9551e3833aa9177f19b02316a48dcd4::coin_decimals_registry::CoinDecimalsRegistry, arg9: &0x2::clock::Clock, arg10: &0x7ff85dfbd93ac4c66df8560fb89a2af615d3227d35fe3e6c34fc7e1c0973412b::x_oracle::XOracle, arg11: &mut 0x2::tx_context::TxContext) : (0x74d918b1895cc35d3710ca5b36bd6769a9551e3833aa9177f19b02316a48dcd4::market::FlashLoan<T0, T1>, 0x2::coin::Coin<T2>) {
        0xebeeea1adb7181e9e9d5762006aff9623f91576373529ae56efababf9b13bd3c::leverage_market::ensure_no_leverage_on_going(arg3);
        0xebeeea1adb7181e9e9d5762006aff9623f91576373529ae56efababf9b13bd3c::leverage_market::mark_leverage_ongoing(arg3);
        let v0 = NewBorrowSwapEvent{
            leverage_owner_cap : 0xebeeea1adb7181e9e9d5762006aff9623f91576373529ae56efababf9b13bd3c::leverage_obligation::id(arg4),
            operation          : 0xebeeea1adb7181e9e9d5762006aff9623f91576373529ae56efababf9b13bd3c::leverage_obligation::borrow_swap(),
            collateral         : 0x1::type_name::with_defining_ids<T1>(),
            debt               : 0x1::type_name::with_defining_ids<T2>(),
            collateral_amount  : 0x2::coin::value<T1>(&arg5),
            collateral_price   : 0xebeeea1adb7181e9e9d5762006aff9623f91576373529ae56efababf9b13bd3c::leverage_obligation::get_collateral_price<T1, T2>(arg10, arg9),
        };
        0x2::event::emit<NewBorrowSwapEvent>(v0);
        0xebeeea1adb7181e9e9d5762006aff9623f91576373529ae56efababf9b13bd3c::leverage_obligation::ensure_same_market<T0>(arg4);
        0xebeeea1adb7181e9e9d5762006aff9623f91576373529ae56efababf9b13bd3c::leverage_obligation::set_or_check_position<T1, T2>(arg4, 0xebeeea1adb7181e9e9d5762006aff9623f91576373529ae56efababf9b13bd3c::leverage_obligation::borrow_swap());
        let (v1, v2) = 0x74d918b1895cc35d3710ca5b36bd6769a9551e3833aa9177f19b02316a48dcd4::flash_loan::borrow_flash_loan<T0, T1>(arg0, 0xebeeea1adb7181e9e9d5762006aff9623f91576373529ae56efababf9b13bd3c::leverage_app::borrow_protocol_caller_cap(arg1), arg2, 0xebeeea1adb7181e9e9d5762006aff9623f91576373529ae56efababf9b13bd3c::leverage_market::emode_group(arg3), arg6 - 0x2::coin::value<T1>(&arg5), arg11);
        let v3 = v1;
        0x2::coin::join<T1>(&mut v3, arg5);
        assert!(0x2::coin::value<T1>(&v3) == arg6, 0xebeeea1adb7181e9e9d5762006aff9623f91576373529ae56efababf9b13bd3c::leverage_error::token_amount_not_expected_value());
        0x74d918b1895cc35d3710ca5b36bd6769a9551e3833aa9177f19b02316a48dcd4::deposit::deposit<T0, T1>(arg0, arg2, 0xebeeea1adb7181e9e9d5762006aff9623f91576373529ae56efababf9b13bd3c::leverage_obligation::market_obligation(arg4), v3, arg9, arg11);
        (v2, 0x74d918b1895cc35d3710ca5b36bd6769a9551e3833aa9177f19b02316a48dcd4::borrow::borrow<T0, T2>(0xebeeea1adb7181e9e9d5762006aff9623f91576373529ae56efababf9b13bd3c::leverage_obligation::market_obligation(arg4), arg2, arg8, arg7, arg10, arg9, arg11))
    }

    // decompiled from Move bytecode v6
}

