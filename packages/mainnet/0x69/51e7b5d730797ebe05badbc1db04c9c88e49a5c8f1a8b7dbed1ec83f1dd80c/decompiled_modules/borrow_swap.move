module 0x6951e7b5d730797ebe05badbc1db04c9c88e49a5c8f1a8b7dbed1ec83f1dd80c::borrow_swap {
    struct NewBorrowSwapEvent has copy, drop {
        leverage_owner_cap: 0x2::object::ID,
        operation: 0x6951e7b5d730797ebe05badbc1db04c9c88e49a5c8f1a8b7dbed1ec83f1dd80c::leverage_obligation::Operation,
        collateral: 0x1::type_name::TypeName,
        debt: 0x1::type_name::TypeName,
        deposit_amount: u64,
        deposit_usd: 0x684131467d610004df3734295dc4604132f8d2af79479874a3bc69a06b676aca::float::Decimal,
    }

    public fun request_leverage<T0, T1, T2>(arg0: &mut 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::market::Market<T0>, arg1: &mut 0x6951e7b5d730797ebe05badbc1db04c9c88e49a5c8f1a8b7dbed1ec83f1dd80c::leverage_market::LeverageMarket, arg2: &mut 0x6951e7b5d730797ebe05badbc1db04c9c88e49a5c8f1a8b7dbed1ec83f1dd80c::leverage_obligation::LeverageMarketOwnerCap, arg3: 0x2::coin::Coin<T1>, arg4: u64, arg5: u64, arg6: &0x4bf60b34197a0246a1f916cb51ccd215ac7f4ddf1ec83e00eeecdc355630d998::coin_decimals_registry::CoinDecimalsRegistry, arg7: &0x2::clock::Clock, arg8: &0x988609a6772a8ce45037fa78bdc1eda593c5872c16dd883002c8aa4939a2a7bb::x_oracle::XOracle, arg9: &mut 0x2::tx_context::TxContext) : (0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::reserve::FlashLoan<T0, T1>, 0x2::coin::Coin<T2>) {
        assert!(!0x6951e7b5d730797ebe05badbc1db04c9c88e49a5c8f1a8b7dbed1ec83f1dd80c::leverage_market::is_leverate_on_going(arg1), 13906834384796778495);
        0x6951e7b5d730797ebe05badbc1db04c9c88e49a5c8f1a8b7dbed1ec83f1dd80c::leverage_market::mark_leverage_ongoing(arg1);
        let v0 = NewBorrowSwapEvent{
            leverage_owner_cap : 0x6951e7b5d730797ebe05badbc1db04c9c88e49a5c8f1a8b7dbed1ec83f1dd80c::leverage_obligation::id(arg2),
            operation          : 0x6951e7b5d730797ebe05badbc1db04c9c88e49a5c8f1a8b7dbed1ec83f1dd80c::leverage_obligation::borrow_swap(),
            collateral         : 0x1::type_name::get<T1>(),
            debt               : 0x1::type_name::get<T2>(),
            deposit_amount     : 0x2::coin::value<T1>(&arg3),
            deposit_usd        : 0x6951e7b5d730797ebe05badbc1db04c9c88e49a5c8f1a8b7dbed1ec83f1dd80c::leverage_obligation::get_usd_value<T1>(arg8, arg7, 0x2::coin::value<T1>(&arg3), arg6),
        };
        0x2::event::emit<NewBorrowSwapEvent>(v0);
        0x6951e7b5d730797ebe05badbc1db04c9c88e49a5c8f1a8b7dbed1ec83f1dd80c::leverage_obligation::set_or_check_position<T0, T1, T2>(arg2, arg0, 0x6951e7b5d730797ebe05badbc1db04c9c88e49a5c8f1a8b7dbed1ec83f1dd80c::leverage_obligation::borrow_swap());
        let (v1, v2) = 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::flash_loan::borrow_flash_loan<T0, T1>(arg0, arg4 - 0x2::coin::value<T1>(&arg3), arg9);
        let v3 = v1;
        0x6951e7b5d730797ebe05badbc1db04c9c88e49a5c8f1a8b7dbed1ec83f1dd80c::leverage_obligation::increase_collateral(arg2, 0x2::coin::value<T1>(&arg3), 0x6951e7b5d730797ebe05badbc1db04c9c88e49a5c8f1a8b7dbed1ec83f1dd80c::leverage_obligation::get_collateral_price<T1, T2>(arg8, arg7));
        0x2::coin::join<T1>(&mut v3, arg3);
        assert!(0x2::coin::value<T1>(&v3) == arg4, 13906834483581026303);
        0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::deposit::deposit<T0, T1>(0x6951e7b5d730797ebe05badbc1db04c9c88e49a5c8f1a8b7dbed1ec83f1dd80c::leverage_obligation::market_obligation(arg2), arg0, v3, arg7, arg9);
        (v2, 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::borrow::borrow<T0, T2>(0x6951e7b5d730797ebe05badbc1db04c9c88e49a5c8f1a8b7dbed1ec83f1dd80c::leverage_obligation::market_obligation(arg2), arg0, arg6, arg5, arg8, arg7, arg9))
    }

    // decompiled from Move bytecode v6
}

