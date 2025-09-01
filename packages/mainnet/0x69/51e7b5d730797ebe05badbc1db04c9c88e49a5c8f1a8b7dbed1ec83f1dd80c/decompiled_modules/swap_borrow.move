module 0x6951e7b5d730797ebe05badbc1db04c9c88e49a5c8f1a8b7dbed1ec83f1dd80c::swap_borrow {
    struct NewSwapBorrowEvent has copy, drop {
        leverage_owner_cap: 0x2::object::ID,
        operation: 0x6951e7b5d730797ebe05badbc1db04c9c88e49a5c8f1a8b7dbed1ec83f1dd80c::leverage_obligation::Operation,
        collateral: 0x1::type_name::TypeName,
        debt: 0x1::type_name::TypeName,
        deposit: u64,
        deposit_usd: 0x684131467d610004df3734295dc4604132f8d2af79479874a3bc69a06b676aca::float::Decimal,
    }

    struct SwapBorrowPotato<phantom T0, phantom T1> {
        flash_loan: 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::reserve::FlashLoan<T0, T1>,
        maybe_leverage: 0x1::option::Option<0x684131467d610004df3734295dc4604132f8d2af79479874a3bc69a06b676aca::float::Decimal>,
    }

    public fun complete_leverage<T0, T1, T2>(arg0: &mut 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::market::Market<T0>, arg1: &mut 0x6951e7b5d730797ebe05badbc1db04c9c88e49a5c8f1a8b7dbed1ec83f1dd80c::leverage_market::LeverageMarket, arg2: &mut 0x6951e7b5d730797ebe05badbc1db04c9c88e49a5c8f1a8b7dbed1ec83f1dd80c::leverage_obligation::LeverageMarketOwnerCap, arg3: SwapBorrowPotato<T0, T2>, arg4: 0x2::coin::Coin<T1>, arg5: &0x4bf60b34197a0246a1f916cb51ccd215ac7f4ddf1ec83e00eeecdc355630d998::coin_decimals_registry::CoinDecimalsRegistry, arg6: &0x988609a6772a8ce45037fa78bdc1eda593c5872c16dd883002c8aa4939a2a7bb::x_oracle::XOracle, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        let SwapBorrowPotato {
            flash_loan     : v0,
            maybe_leverage : v1,
        } = arg3;
        let v2 = v1;
        let v3 = v0;
        let v4 = if (0x1::option::is_some<0x684131467d610004df3734295dc4604132f8d2af79479874a3bc69a06b676aca::float::Decimal>(&v2)) {
            let v5 = 0x684131467d610004df3734295dc4604132f8d2af79479874a3bc69a06b676aca::float::floor(0x684131467d610004df3734295dc4604132f8d2af79479874a3bc69a06b676aca::float::div(0x684131467d610004df3734295dc4604132f8d2af79479874a3bc69a06b676aca::float::from(0x2::coin::value<T1>(&arg4)), *0x1::option::borrow<0x684131467d610004df3734295dc4604132f8d2af79479874a3bc69a06b676aca::float::Decimal>(&v2)));
            0x6951e7b5d730797ebe05badbc1db04c9c88e49a5c8f1a8b7dbed1ec83f1dd80c::leverage_obligation::increase_collateral(arg2, v5, 0x6951e7b5d730797ebe05badbc1db04c9c88e49a5c8f1a8b7dbed1ec83f1dd80c::leverage_obligation::get_collateral_price<T1, T2>(arg6, arg7));
            v5
        } else {
            0
        };
        0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::deposit::deposit<T0, T1>(0x6951e7b5d730797ebe05badbc1db04c9c88e49a5c8f1a8b7dbed1ec83f1dd80c::leverage_obligation::market_obligation(arg2), arg0, arg4, arg7, arg8);
        let v6 = 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::reserve::fee<T0, T2>(&v3) + 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::reserve::loan_amount<T0, T2>(&v3);
        let v7 = 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::borrow::borrow<T0, T2>(0x6951e7b5d730797ebe05badbc1db04c9c88e49a5c8f1a8b7dbed1ec83f1dd80c::leverage_obligation::market_obligation(arg2), arg0, arg5, v6, arg6, arg7, arg8);
        assert!(0x2::coin::value<T2>(&v7) == v6, 13906834814293508095);
        let v8 = NewSwapBorrowEvent{
            leverage_owner_cap : 0x6951e7b5d730797ebe05badbc1db04c9c88e49a5c8f1a8b7dbed1ec83f1dd80c::leverage_obligation::id(arg2),
            operation          : 0x6951e7b5d730797ebe05badbc1db04c9c88e49a5c8f1a8b7dbed1ec83f1dd80c::leverage_obligation::swap_borrow(),
            collateral         : 0x1::type_name::get<T1>(),
            debt               : 0x1::type_name::get<T2>(),
            deposit            : v4,
            deposit_usd        : 0x6951e7b5d730797ebe05badbc1db04c9c88e49a5c8f1a8b7dbed1ec83f1dd80c::leverage_obligation::get_usd_value<T1>(arg6, arg7, v4, arg5),
        };
        0x2::event::emit<NewSwapBorrowEvent>(v8);
        0x6951e7b5d730797ebe05badbc1db04c9c88e49a5c8f1a8b7dbed1ec83f1dd80c::leverage_repay::complete_leverage<T0, T2>(arg0, arg1, arg2, v3, v7, arg6, arg7, arg5, arg8)
    }

    public fun request_leverage<T0, T1, T2>(arg0: &mut 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::market::Market<T0>, arg1: &mut 0x6951e7b5d730797ebe05badbc1db04c9c88e49a5c8f1a8b7dbed1ec83f1dd80c::leverage_market::LeverageMarket, arg2: &mut 0x6951e7b5d730797ebe05badbc1db04c9c88e49a5c8f1a8b7dbed1ec83f1dd80c::leverage_obligation::LeverageMarketOwnerCap, arg3: 0x2::coin::Coin<T2>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : (SwapBorrowPotato<T0, T2>, 0x2::coin::Coin<T2>) {
        assert!(!0x6951e7b5d730797ebe05badbc1db04c9c88e49a5c8f1a8b7dbed1ec83f1dd80c::leverage_market::is_leverate_on_going(arg1), 13906834384796778495);
        0x6951e7b5d730797ebe05badbc1db04c9c88e49a5c8f1a8b7dbed1ec83f1dd80c::leverage_market::mark_leverage_ongoing(arg1);
        0x6951e7b5d730797ebe05badbc1db04c9c88e49a5c8f1a8b7dbed1ec83f1dd80c::leverage_obligation::set_or_check_position<T0, T1, T2>(arg2, arg0, 0x6951e7b5d730797ebe05badbc1db04c9c88e49a5c8f1a8b7dbed1ec83f1dd80c::leverage_obligation::borrow_swap());
        let v0 = if (0x2::coin::value<T2>(&arg3) == 0) {
            0x1::option::none<0x684131467d610004df3734295dc4604132f8d2af79479874a3bc69a06b676aca::float::Decimal>()
        } else {
            0x1::option::some<0x684131467d610004df3734295dc4604132f8d2af79479874a3bc69a06b676aca::float::Decimal>(0x684131467d610004df3734295dc4604132f8d2af79479874a3bc69a06b676aca::float::from_quotient(arg4, 0x2::coin::value<T2>(&arg3)))
        };
        let (v1, v2) = 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::flash_loan::borrow_flash_loan<T0, T2>(arg0, arg4 - 0x2::coin::value<T2>(&arg3), arg5);
        let v3 = v1;
        0x2::coin::join<T2>(&mut v3, arg3);
        assert!(0x2::coin::value<T2>(&v3) == arg4, 13906834449221287935);
        let v4 = SwapBorrowPotato<T0, T2>{
            flash_loan     : v2,
            maybe_leverage : v0,
        };
        (v4, v3)
    }

    // decompiled from Move bytecode v6
}

