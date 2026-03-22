module 0xc640c0be4e6e502ebf7e37456c8501ec2e102d5cfe4fac827c1b3ebcef544f94::leverage_borrow_swap {
    struct NewBorrowSwapEvent has copy, drop {
        leverage_owner_cap: 0x2::object::ID,
        operation: 0xc640c0be4e6e502ebf7e37456c8501ec2e102d5cfe4fac827c1b3ebcef544f94::leverage_obligation::Operation,
        collateral: 0x1::type_name::TypeName,
        debt: 0x1::type_name::TypeName,
        collateral_amount: u64,
        collateral_price: 0xf01bf3d01c8f50247fdf597e3f565b865e00b4a20a01b353d44d71c993f36e9a::float::Decimal,
    }

    public fun request_leverage<T0, T1, T2>(arg0: &0x4ad0cdb92efdaf00ba808d097af9746923150d1769046d4f8aeac9a466d8c1db::app::ProtocolApp, arg1: &0xc640c0be4e6e502ebf7e37456c8501ec2e102d5cfe4fac827c1b3ebcef544f94::leverage_app::LeverageApp, arg2: &mut 0x4ad0cdb92efdaf00ba808d097af9746923150d1769046d4f8aeac9a466d8c1db::market::Market<T0>, arg3: &mut 0xc640c0be4e6e502ebf7e37456c8501ec2e102d5cfe4fac827c1b3ebcef544f94::leverage_market::LeverageMarket, arg4: &mut 0xc640c0be4e6e502ebf7e37456c8501ec2e102d5cfe4fac827c1b3ebcef544f94::leverage_obligation::LeverageMarketOwnerCap, arg5: 0x2::coin::Coin<T1>, arg6: u64, arg7: u64, arg8: &0x4ad0cdb92efdaf00ba808d097af9746923150d1769046d4f8aeac9a466d8c1db::coin_decimals_registry::CoinDecimalsRegistry, arg9: &0x2::clock::Clock, arg10: &0xcb8499accc8d72fc498287808427fb1bc76b509b3127df63b5859919427dbc::x_oracle::XOracle, arg11: &mut 0x2::tx_context::TxContext) : (0xc640c0be4e6e502ebf7e37456c8501ec2e102d5cfe4fac827c1b3ebcef544f94::leverage_repay::LeverageHotPotato<T0, T1>, 0x2::coin::Coin<T2>) {
        0xc640c0be4e6e502ebf7e37456c8501ec2e102d5cfe4fac827c1b3ebcef544f94::leverage_app::ensure_version_matches(arg1);
        0xc640c0be4e6e502ebf7e37456c8501ec2e102d5cfe4fac827c1b3ebcef544f94::leverage_market::ensure_no_leverage_on_going(arg3);
        0xc640c0be4e6e502ebf7e37456c8501ec2e102d5cfe4fac827c1b3ebcef544f94::leverage_market::mark_leverage_ongoing(arg3);
        0xc640c0be4e6e502ebf7e37456c8501ec2e102d5cfe4fac827c1b3ebcef544f94::leverage_market::ensure_supporting_market<T0>(arg3, arg2);
        0xc640c0be4e6e502ebf7e37456c8501ec2e102d5cfe4fac827c1b3ebcef544f94::leverage_obligation::ensure_same_market<T0>(arg4);
        0xc640c0be4e6e502ebf7e37456c8501ec2e102d5cfe4fac827c1b3ebcef544f94::leverage_obligation::ensure_same_emode(arg4, 0xc640c0be4e6e502ebf7e37456c8501ec2e102d5cfe4fac827c1b3ebcef544f94::leverage_market::emode_group(arg3));
        0xc640c0be4e6e502ebf7e37456c8501ec2e102d5cfe4fac827c1b3ebcef544f94::leverage_obligation::set_or_check_position<T1, T2>(arg4, 0xc640c0be4e6e502ebf7e37456c8501ec2e102d5cfe4fac827c1b3ebcef544f94::leverage_obligation::borrow_swap());
        let v0 = NewBorrowSwapEvent{
            leverage_owner_cap : 0xc640c0be4e6e502ebf7e37456c8501ec2e102d5cfe4fac827c1b3ebcef544f94::leverage_obligation::id(arg4),
            operation          : 0xc640c0be4e6e502ebf7e37456c8501ec2e102d5cfe4fac827c1b3ebcef544f94::leverage_obligation::borrow_swap(),
            collateral         : 0x1::type_name::with_defining_ids<T1>(),
            debt               : 0x1::type_name::with_defining_ids<T2>(),
            collateral_amount  : 0x2::coin::value<T1>(&arg5),
            collateral_price   : 0xc640c0be4e6e502ebf7e37456c8501ec2e102d5cfe4fac827c1b3ebcef544f94::leverage_obligation::get_collateral_price<T1, T2>(arg10, arg9),
        };
        0x2::event::emit<NewBorrowSwapEvent>(v0);
        let (v1, v2) = 0x4ad0cdb92efdaf00ba808d097af9746923150d1769046d4f8aeac9a466d8c1db::flash_loan::borrow_flash_loan<T0, T1>(arg0, 0xc640c0be4e6e502ebf7e37456c8501ec2e102d5cfe4fac827c1b3ebcef544f94::leverage_app::borrow_protocol_caller_cap(arg1), arg2, 0xc640c0be4e6e502ebf7e37456c8501ec2e102d5cfe4fac827c1b3ebcef544f94::leverage_market::emode_group(arg3), arg6 - 0x2::coin::value<T1>(&arg5), arg11);
        let v3 = v1;
        0x2::coin::join<T1>(&mut v3, arg5);
        assert!(0x2::coin::value<T1>(&v3) == arg6, 0xc640c0be4e6e502ebf7e37456c8501ec2e102d5cfe4fac827c1b3ebcef544f94::leverage_error::token_amount_not_expected_value());
        0x4ad0cdb92efdaf00ba808d097af9746923150d1769046d4f8aeac9a466d8c1db::deposit::deposit<T0, T1>(arg0, arg2, 0xc640c0be4e6e502ebf7e37456c8501ec2e102d5cfe4fac827c1b3ebcef544f94::leverage_obligation::market_obligation(arg4), v3, arg9, arg11);
        (0xc640c0be4e6e502ebf7e37456c8501ec2e102d5cfe4fac827c1b3ebcef544f94::leverage_repay::new_leverage_hot_potato<T0, T1>(v2), 0x4ad0cdb92efdaf00ba808d097af9746923150d1769046d4f8aeac9a466d8c1db::borrow::borrow<T0, T2>(arg0, 0xc640c0be4e6e502ebf7e37456c8501ec2e102d5cfe4fac827c1b3ebcef544f94::leverage_obligation::market_obligation(arg4), arg2, arg8, arg7, arg10, arg9, arg11))
    }

    // decompiled from Move bytecode v6
}

