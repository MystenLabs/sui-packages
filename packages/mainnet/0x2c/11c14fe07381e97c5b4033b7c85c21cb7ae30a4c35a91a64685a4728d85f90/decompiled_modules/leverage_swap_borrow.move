module 0x2c11c14fe07381e97c5b4033b7c85c21cb7ae30a4c35a91a64685a4728d85f90::leverage_swap_borrow {
    struct NewSwapBorrowEvent has copy, drop {
        leverage_owner_cap: 0x2::object::ID,
        operation: 0x2c11c14fe07381e97c5b4033b7c85c21cb7ae30a4c35a91a64685a4728d85f90::leverage_obligation::Operation,
        collateral: 0x1::type_name::TypeName,
        debt: 0x1::type_name::TypeName,
        deposit: u64,
        deposit_usd: 0x4bc9fe7e053de46aa9789fdcb1ad031389cf4f710cde859ab40c7e9cc2dee7c3::float::Decimal,
    }

    struct SwapBorrowPotato<phantom T0, phantom T1> {
        flash_loan: 0x5ba8b0d04af44f1270412cac98ab288e60fcfc449f3bfefbf4db953d32908866::market::FlashLoan<T0, T1>,
        maybe_leverage: 0x1::option::Option<0x4bc9fe7e053de46aa9789fdcb1ad031389cf4f710cde859ab40c7e9cc2dee7c3::float::Decimal>,
    }

    public fun complete_leverage<T0, T1, T2>(arg0: &mut 0x5ba8b0d04af44f1270412cac98ab288e60fcfc449f3bfefbf4db953d32908866::app::ProtocolApp, arg1: &mut 0x5ba8b0d04af44f1270412cac98ab288e60fcfc449f3bfefbf4db953d32908866::market::Market<T0>, arg2: &mut 0x2c11c14fe07381e97c5b4033b7c85c21cb7ae30a4c35a91a64685a4728d85f90::leverage_market::LeverageMarket, arg3: &mut 0x2c11c14fe07381e97c5b4033b7c85c21cb7ae30a4c35a91a64685a4728d85f90::leverage_obligation::LeverageMarketOwnerCap, arg4: SwapBorrowPotato<T0, T2>, arg5: 0x2::coin::Coin<T1>, arg6: 0x1::option::Option<0x1::string::String>, arg7: &0x5ba8b0d04af44f1270412cac98ab288e60fcfc449f3bfefbf4db953d32908866::coin_decimals_registry::CoinDecimalsRegistry, arg8: &0xcc225fc85e4be2167573358a32df7a7c2d9bcb745d0581843413688e6f0a8f3e::x_oracle::XOracle, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        let SwapBorrowPotato {
            flash_loan     : v0,
            maybe_leverage : v1,
        } = arg4;
        let v2 = v1;
        let v3 = v0;
        let v4 = if (0x1::option::is_some<0x4bc9fe7e053de46aa9789fdcb1ad031389cf4f710cde859ab40c7e9cc2dee7c3::float::Decimal>(&v2)) {
            let v5 = 0x4bc9fe7e053de46aa9789fdcb1ad031389cf4f710cde859ab40c7e9cc2dee7c3::float::floor(0x4bc9fe7e053de46aa9789fdcb1ad031389cf4f710cde859ab40c7e9cc2dee7c3::float::div(0x4bc9fe7e053de46aa9789fdcb1ad031389cf4f710cde859ab40c7e9cc2dee7c3::float::from(0x2::coin::value<T1>(&arg5)), *0x1::option::borrow<0x4bc9fe7e053de46aa9789fdcb1ad031389cf4f710cde859ab40c7e9cc2dee7c3::float::Decimal>(&v2)));
            0x2c11c14fe07381e97c5b4033b7c85c21cb7ae30a4c35a91a64685a4728d85f90::leverage_obligation::increase_collateral(arg3, v5, 0x2c11c14fe07381e97c5b4033b7c85c21cb7ae30a4c35a91a64685a4728d85f90::leverage_obligation::get_collateral_price<T1, T2>(arg8, arg9));
            v5
        } else {
            0
        };
        0x5ba8b0d04af44f1270412cac98ab288e60fcfc449f3bfefbf4db953d32908866::deposit::deposit<T0, T1>(arg0, arg1, 0x2c11c14fe07381e97c5b4033b7c85c21cb7ae30a4c35a91a64685a4728d85f90::leverage_obligation::market_obligation(arg3), arg5, arg7, arg8, arg9, arg10);
        let v6 = 0x5ba8b0d04af44f1270412cac98ab288e60fcfc449f3bfefbf4db953d32908866::market::fee<T0, T2>(&v3) + 0x5ba8b0d04af44f1270412cac98ab288e60fcfc449f3bfefbf4db953d32908866::market::loan_amount<T0, T2>(&v3);
        let v7 = 0x5ba8b0d04af44f1270412cac98ab288e60fcfc449f3bfefbf4db953d32908866::borrow::borrow<T0, T2>(0x2c11c14fe07381e97c5b4033b7c85c21cb7ae30a4c35a91a64685a4728d85f90::leverage_obligation::market_obligation(arg3), arg1, arg7, v6, arg8, arg9, arg10);
        assert!(0x2::coin::value<T2>(&v7) == v6, 13906834702624358399);
        let v8 = NewSwapBorrowEvent{
            leverage_owner_cap : 0x2c11c14fe07381e97c5b4033b7c85c21cb7ae30a4c35a91a64685a4728d85f90::leverage_obligation::id(arg3),
            operation          : 0x2c11c14fe07381e97c5b4033b7c85c21cb7ae30a4c35a91a64685a4728d85f90::leverage_obligation::swap_borrow(),
            collateral         : 0x1::type_name::get<T1>(),
            debt               : 0x1::type_name::get<T2>(),
            deposit            : v4,
            deposit_usd        : 0x2c11c14fe07381e97c5b4033b7c85c21cb7ae30a4c35a91a64685a4728d85f90::leverage_obligation::get_usd_value<T1>(arg8, arg9, v4, arg7),
        };
        0x2::event::emit<NewSwapBorrowEvent>(v8);
        0x2c11c14fe07381e97c5b4033b7c85c21cb7ae30a4c35a91a64685a4728d85f90::leverage_repay::complete_leverage<T0, T2>(arg0, arg1, arg2, arg3, v3, arg6, v7, arg8, arg9, arg7, arg10)
    }

    public fun request_leverage<T0, T1, T2>(arg0: &mut 0x5ba8b0d04af44f1270412cac98ab288e60fcfc449f3bfefbf4db953d32908866::app::ProtocolApp, arg1: &mut 0x2c11c14fe07381e97c5b4033b7c85c21cb7ae30a4c35a91a64685a4728d85f90::leverage_app::LeverageApp, arg2: &mut 0x5ba8b0d04af44f1270412cac98ab288e60fcfc449f3bfefbf4db953d32908866::market::Market<T0>, arg3: &mut 0x2c11c14fe07381e97c5b4033b7c85c21cb7ae30a4c35a91a64685a4728d85f90::leverage_market::LeverageMarket, arg4: &mut 0x2c11c14fe07381e97c5b4033b7c85c21cb7ae30a4c35a91a64685a4728d85f90::leverage_obligation::LeverageMarketOwnerCap, arg5: 0x2::coin::Coin<T2>, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : (SwapBorrowPotato<T0, T2>, 0x2::coin::Coin<T2>) {
        assert!(!0x2c11c14fe07381e97c5b4033b7c85c21cb7ae30a4c35a91a64685a4728d85f90::leverage_market::is_leverate_on_going(arg3), 13906834406271614975);
        0x2c11c14fe07381e97c5b4033b7c85c21cb7ae30a4c35a91a64685a4728d85f90::leverage_market::mark_leverage_ongoing(arg3);
        0x2c11c14fe07381e97c5b4033b7c85c21cb7ae30a4c35a91a64685a4728d85f90::leverage_obligation::set_or_check_position<T0, T1, T2>(arg4, arg2, 0x2c11c14fe07381e97c5b4033b7c85c21cb7ae30a4c35a91a64685a4728d85f90::leverage_obligation::swap_borrow());
        let v0 = if (0x2::coin::value<T2>(&arg5) == 0) {
            0x1::option::none<0x4bc9fe7e053de46aa9789fdcb1ad031389cf4f710cde859ab40c7e9cc2dee7c3::float::Decimal>()
        } else {
            0x1::option::some<0x4bc9fe7e053de46aa9789fdcb1ad031389cf4f710cde859ab40c7e9cc2dee7c3::float::Decimal>(0x4bc9fe7e053de46aa9789fdcb1ad031389cf4f710cde859ab40c7e9cc2dee7c3::float::from_quotient(arg6, 0x2::coin::value<T2>(&arg5)))
        };
        let (v1, v2) = 0x5ba8b0d04af44f1270412cac98ab288e60fcfc449f3bfefbf4db953d32908866::flash_loan::borrow_flash_loan<T0, T2>(arg0, 0x2c11c14fe07381e97c5b4033b7c85c21cb7ae30a4c35a91a64685a4728d85f90::leverage_app::borrow_protocol_caller_cap(arg1), arg2, 0x2c11c14fe07381e97c5b4033b7c85c21cb7ae30a4c35a91a64685a4728d85f90::leverage_market::emode_group(arg3), arg6 - 0x2::coin::value<T2>(&arg5), arg7);
        let v3 = v1;
        0x2::coin::join<T2>(&mut v3, arg5);
        assert!(0x2::coin::value<T2>(&v3) == arg6, 13906834500760895487);
        let v4 = SwapBorrowPotato<T0, T2>{
            flash_loan     : v2,
            maybe_leverage : v0,
        };
        (v4, v3)
    }

    // decompiled from Move bytecode v6
}

