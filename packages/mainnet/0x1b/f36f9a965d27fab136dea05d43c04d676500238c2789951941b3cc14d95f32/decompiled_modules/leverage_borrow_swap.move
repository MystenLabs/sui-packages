module 0x1bf36f9a965d27fab136dea05d43c04d676500238c2789951941b3cc14d95f32::leverage_borrow_swap {
    struct NewBorrowSwapEvent has copy, drop {
        leverage_owner_cap: 0x2::object::ID,
        operation: 0x1bf36f9a965d27fab136dea05d43c04d676500238c2789951941b3cc14d95f32::leverage_obligation::Operation,
        collateral: 0x1::type_name::TypeName,
        debt: 0x1::type_name::TypeName,
        collateral_amount: u64,
        collateral_price: 0x3912ba0e6903a9c51f43d46c4fce460af4990cc33296b0c1e2d7294cfb9110ce::float::Decimal,
    }

    public fun request_leverage<T0, T1, T2>(arg0: &0x9c5d5dbf497d8eab6b06bb64445b7c7e3c7f0483ae451c2cf83028c9b382473a::app::ProtocolApp, arg1: &0x1bf36f9a965d27fab136dea05d43c04d676500238c2789951941b3cc14d95f32::leverage_app::LeverageApp, arg2: &mut 0x9c5d5dbf497d8eab6b06bb64445b7c7e3c7f0483ae451c2cf83028c9b382473a::market::Market<T0>, arg3: &mut 0x1bf36f9a965d27fab136dea05d43c04d676500238c2789951941b3cc14d95f32::leverage_market::LeverageMarket, arg4: &mut 0x1bf36f9a965d27fab136dea05d43c04d676500238c2789951941b3cc14d95f32::leverage_obligation::LeverageMarketOwnerCap, arg5: 0x2::coin::Coin<T1>, arg6: u64, arg7: u64, arg8: &0x9c5d5dbf497d8eab6b06bb64445b7c7e3c7f0483ae451c2cf83028c9b382473a::coin_decimals_registry::CoinDecimalsRegistry, arg9: &0x2::clock::Clock, arg10: &0x91eff0477a2ed085f95d0e72a83b63e40e7258e3b3dcc7d54554ca4038794463::x_oracle::XOracle, arg11: &mut 0x2::tx_context::TxContext) : (0x1bf36f9a965d27fab136dea05d43c04d676500238c2789951941b3cc14d95f32::leverage_repay::LeverageHotPotato<T0, T1>, 0x2::coin::Coin<T2>) {
        0x1bf36f9a965d27fab136dea05d43c04d676500238c2789951941b3cc14d95f32::leverage_app::ensure_version_matches(arg1);
        0x1bf36f9a965d27fab136dea05d43c04d676500238c2789951941b3cc14d95f32::leverage_market::ensure_no_leverage_on_going(arg3);
        0x1bf36f9a965d27fab136dea05d43c04d676500238c2789951941b3cc14d95f32::leverage_market::mark_leverage_ongoing(arg3);
        0x1bf36f9a965d27fab136dea05d43c04d676500238c2789951941b3cc14d95f32::leverage_market::ensure_supporting_market<T0>(arg3, arg2);
        0x1bf36f9a965d27fab136dea05d43c04d676500238c2789951941b3cc14d95f32::leverage_obligation::ensure_same_market<T0>(arg4);
        0x1bf36f9a965d27fab136dea05d43c04d676500238c2789951941b3cc14d95f32::leverage_obligation::ensure_same_emode(arg4, 0x1bf36f9a965d27fab136dea05d43c04d676500238c2789951941b3cc14d95f32::leverage_market::emode_group(arg3));
        0x1bf36f9a965d27fab136dea05d43c04d676500238c2789951941b3cc14d95f32::leverage_obligation::set_or_check_position<T1, T2>(arg4, 0x1bf36f9a965d27fab136dea05d43c04d676500238c2789951941b3cc14d95f32::leverage_obligation::borrow_swap());
        let v0 = NewBorrowSwapEvent{
            leverage_owner_cap : 0x1bf36f9a965d27fab136dea05d43c04d676500238c2789951941b3cc14d95f32::leverage_obligation::id(arg4),
            operation          : 0x1bf36f9a965d27fab136dea05d43c04d676500238c2789951941b3cc14d95f32::leverage_obligation::borrow_swap(),
            collateral         : 0x1::type_name::with_defining_ids<T1>(),
            debt               : 0x1::type_name::with_defining_ids<T2>(),
            collateral_amount  : 0x2::coin::value<T1>(&arg5),
            collateral_price   : 0x1bf36f9a965d27fab136dea05d43c04d676500238c2789951941b3cc14d95f32::leverage_obligation::get_collateral_price<T1, T2>(arg10, arg9),
        };
        0x2::event::emit<NewBorrowSwapEvent>(v0);
        let (v1, v2) = 0x9c5d5dbf497d8eab6b06bb64445b7c7e3c7f0483ae451c2cf83028c9b382473a::flash_loan::borrow_flash_loan<T0, T1>(arg0, 0x1bf36f9a965d27fab136dea05d43c04d676500238c2789951941b3cc14d95f32::leverage_app::borrow_protocol_caller_cap(arg1), arg2, 0x1bf36f9a965d27fab136dea05d43c04d676500238c2789951941b3cc14d95f32::leverage_market::emode_group(arg3), arg6 - 0x2::coin::value<T1>(&arg5), arg11);
        let v3 = v1;
        0x2::coin::join<T1>(&mut v3, arg5);
        assert!(0x2::coin::value<T1>(&v3) == arg6, 0x1bf36f9a965d27fab136dea05d43c04d676500238c2789951941b3cc14d95f32::leverage_error::token_amount_not_expected_value());
        0x9c5d5dbf497d8eab6b06bb64445b7c7e3c7f0483ae451c2cf83028c9b382473a::deposit::deposit<T0, T1>(arg0, arg2, 0x1bf36f9a965d27fab136dea05d43c04d676500238c2789951941b3cc14d95f32::leverage_obligation::market_obligation(arg4), v3, arg9, arg11);
        (0x1bf36f9a965d27fab136dea05d43c04d676500238c2789951941b3cc14d95f32::leverage_repay::new_leverage_hot_potato<T0, T1>(v2), 0x9c5d5dbf497d8eab6b06bb64445b7c7e3c7f0483ae451c2cf83028c9b382473a::borrow::borrow<T0, T2>(arg0, 0x1bf36f9a965d27fab136dea05d43c04d676500238c2789951941b3cc14d95f32::leverage_obligation::market_obligation(arg4), arg2, arg8, arg7, arg10, arg9, arg11))
    }

    // decompiled from Move bytecode v6
}

