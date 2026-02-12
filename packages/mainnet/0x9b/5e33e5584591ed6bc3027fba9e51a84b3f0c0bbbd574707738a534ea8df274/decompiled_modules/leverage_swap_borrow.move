module 0xb24d2c9ae39a07cabfeaa8afa89fc99b87486ee329ae3d99816bcdd2c5c6351d::leverage_swap_borrow {
    struct NewSwapBorrowEvent has copy, drop {
        leverage_owner_cap: 0x2::object::ID,
        operation: 0xb24d2c9ae39a07cabfeaa8afa89fc99b87486ee329ae3d99816bcdd2c5c6351d::leverage_obligation::Operation,
        collateral: 0x1::type_name::TypeName,
        debt: 0x1::type_name::TypeName,
        initial_debt_amount: u64,
        collateral_price: 0x6a9f1a9dbc42ae30b45eca93faf2334a7a237749dd65395fdcab5be361da6d00::float::Decimal,
    }

    public fun complete_leverage<T0, T1, T2>(arg0: &mut 0xb0cb7d234cca8c3554767ce007d7e1e54424db6db8fb24e992da7336a830904::app::ProtocolApp, arg1: &mut 0xb0cb7d234cca8c3554767ce007d7e1e54424db6db8fb24e992da7336a830904::market::Market<T0>, arg2: &mut 0xb24d2c9ae39a07cabfeaa8afa89fc99b87486ee329ae3d99816bcdd2c5c6351d::leverage_market::LeverageMarket, arg3: &mut 0xb24d2c9ae39a07cabfeaa8afa89fc99b87486ee329ae3d99816bcdd2c5c6351d::leverage_obligation::LeverageMarketOwnerCap, arg4: 0xb0cb7d234cca8c3554767ce007d7e1e54424db6db8fb24e992da7336a830904::market::FlashLoan<T0, T2>, arg5: 0x2::coin::Coin<T1>, arg6: 0x1::option::Option<0x1::string::String>, arg7: &0xb0cb7d234cca8c3554767ce007d7e1e54424db6db8fb24e992da7336a830904::coin_decimals_registry::CoinDecimalsRegistry, arg8: &0x82b78a855db4069292c5c88118121d52c47c536b08cfbc982df030f6f2d4a538::x_oracle::XOracle, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        0xb0cb7d234cca8c3554767ce007d7e1e54424db6db8fb24e992da7336a830904::deposit::deposit<T0, T1>(arg0, arg1, 0xb24d2c9ae39a07cabfeaa8afa89fc99b87486ee329ae3d99816bcdd2c5c6351d::leverage_obligation::market_obligation(arg3), arg5, arg9, arg10);
        let v0 = 0xb0cb7d234cca8c3554767ce007d7e1e54424db6db8fb24e992da7336a830904::market::fee<T0, T2>(&arg4) + 0xb0cb7d234cca8c3554767ce007d7e1e54424db6db8fb24e992da7336a830904::market::loan_amount<T0, T2>(&arg4);
        let v1 = 0xb0cb7d234cca8c3554767ce007d7e1e54424db6db8fb24e992da7336a830904::borrow::borrow<T0, T2>(0xb24d2c9ae39a07cabfeaa8afa89fc99b87486ee329ae3d99816bcdd2c5c6351d::leverage_obligation::market_obligation(arg3), arg1, arg7, v0, arg8, arg9, arg10);
        assert!(0x2::coin::value<T2>(&v1) == v0, 13906834651084750847);
        0xb24d2c9ae39a07cabfeaa8afa89fc99b87486ee329ae3d99816bcdd2c5c6351d::leverage_repay::complete_leverage<T0, T2>(arg0, arg1, arg2, arg3, arg4, arg6, v1, arg8, arg9, arg7, arg10)
    }

    public fun request_leverage<T0, T1, T2>(arg0: &mut 0xb0cb7d234cca8c3554767ce007d7e1e54424db6db8fb24e992da7336a830904::app::ProtocolApp, arg1: &mut 0xb24d2c9ae39a07cabfeaa8afa89fc99b87486ee329ae3d99816bcdd2c5c6351d::leverage_app::LeverageApp, arg2: &mut 0xb0cb7d234cca8c3554767ce007d7e1e54424db6db8fb24e992da7336a830904::market::Market<T0>, arg3: &mut 0xb24d2c9ae39a07cabfeaa8afa89fc99b87486ee329ae3d99816bcdd2c5c6351d::leverage_market::LeverageMarket, arg4: &mut 0xb24d2c9ae39a07cabfeaa8afa89fc99b87486ee329ae3d99816bcdd2c5c6351d::leverage_obligation::LeverageMarketOwnerCap, arg5: 0x2::coin::Coin<T2>, arg6: u64, arg7: &0x82b78a855db4069292c5c88118121d52c47c536b08cfbc982df030f6f2d4a538::x_oracle::XOracle, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : (0xb0cb7d234cca8c3554767ce007d7e1e54424db6db8fb24e992da7336a830904::market::FlashLoan<T0, T2>, 0x2::coin::Coin<T2>) {
        0xb24d2c9ae39a07cabfeaa8afa89fc99b87486ee329ae3d99816bcdd2c5c6351d::leverage_market::ensure_no_leverage_on_going(arg3);
        0xb24d2c9ae39a07cabfeaa8afa89fc99b87486ee329ae3d99816bcdd2c5c6351d::leverage_market::mark_leverage_ongoing(arg3);
        0xb24d2c9ae39a07cabfeaa8afa89fc99b87486ee329ae3d99816bcdd2c5c6351d::leverage_obligation::ensure_same_market<T0>(arg4);
        0xb24d2c9ae39a07cabfeaa8afa89fc99b87486ee329ae3d99816bcdd2c5c6351d::leverage_obligation::set_or_check_position<T1, T2>(arg4, 0xb24d2c9ae39a07cabfeaa8afa89fc99b87486ee329ae3d99816bcdd2c5c6351d::leverage_obligation::swap_borrow());
        let v0 = NewSwapBorrowEvent{
            leverage_owner_cap  : 0xb24d2c9ae39a07cabfeaa8afa89fc99b87486ee329ae3d99816bcdd2c5c6351d::leverage_obligation::id(arg4),
            operation           : 0xb24d2c9ae39a07cabfeaa8afa89fc99b87486ee329ae3d99816bcdd2c5c6351d::leverage_obligation::swap_borrow(),
            collateral          : 0x1::type_name::with_defining_ids<T1>(),
            debt                : 0x1::type_name::with_defining_ids<T2>(),
            initial_debt_amount : 0x2::coin::value<T2>(&arg5),
            collateral_price    : 0xb24d2c9ae39a07cabfeaa8afa89fc99b87486ee329ae3d99816bcdd2c5c6351d::leverage_obligation::get_collateral_price<T1, T2>(arg7, arg8),
        };
        0x2::event::emit<NewSwapBorrowEvent>(v0);
        let (v1, v2) = 0xb0cb7d234cca8c3554767ce007d7e1e54424db6db8fb24e992da7336a830904::flash_loan::borrow_flash_loan<T0, T2>(arg0, 0xb24d2c9ae39a07cabfeaa8afa89fc99b87486ee329ae3d99816bcdd2c5c6351d::leverage_app::borrow_protocol_caller_cap(arg1), arg2, 0xb24d2c9ae39a07cabfeaa8afa89fc99b87486ee329ae3d99816bcdd2c5c6351d::leverage_market::emode_group(arg3), arg6 - 0x2::coin::value<T2>(&arg5), arg9);
        let v3 = v1;
        0x2::coin::join<T2>(&mut v3, arg5);
        assert!(0x2::coin::value<T2>(&v3) == arg6, 13906834509350830079);
        (v2, v3)
    }

    // decompiled from Move bytecode v6
}

