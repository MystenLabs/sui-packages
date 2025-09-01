module 0x6951e7b5d730797ebe05badbc1db04c9c88e49a5c8f1a8b7dbed1ec83f1dd80c::leverage_reduce_to_collateral_coin {
    public fun complete_reduce<T0, T1, T2>(arg0: &mut 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::market::Market<T0>, arg1: &0x6951e7b5d730797ebe05badbc1db04c9c88e49a5c8f1a8b7dbed1ec83f1dd80c::leverage_obligation::LeverageMarketOwnerCap, arg2: &mut 0x6951e7b5d730797ebe05badbc1db04c9c88e49a5c8f1a8b7dbed1ec83f1dd80c::leverage_market::LeverageMarket, arg3: 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::reserve::FlashLoan<T0, T1>, arg4: 0x2::coin::Coin<T2>, arg5: &0x988609a6772a8ce45037fa78bdc1eda593c5872c16dd883002c8aa4939a2a7bb::x_oracle::XOracle, arg6: &0x2::clock::Clock, arg7: &0x4bf60b34197a0246a1f916cb51ccd215ac7f4ddf1ec83e00eeecdc355630d998::coin_decimals_registry::CoinDecimalsRegistry, arg8: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x2::coin::Coin<T2>) {
        let v0 = 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::repay::repay_coin_refund<T0, T2>(0x6951e7b5d730797ebe05badbc1db04c9c88e49a5c8f1a8b7dbed1ec83f1dd80c::leverage_obligation::market_obligation(arg1), arg0, arg4, arg6, arg8);
        0x6951e7b5d730797ebe05badbc1db04c9c88e49a5c8f1a8b7dbed1ec83f1dd80c::leverage_repay::emit_new_refunded_event<T2>(0x6951e7b5d730797ebe05badbc1db04c9c88e49a5c8f1a8b7dbed1ec83f1dd80c::leverage_obligation::id(arg1), arg5, arg6, 0x2::coin::value<T2>(&v0), arg7);
        (0x6951e7b5d730797ebe05badbc1db04c9c88e49a5c8f1a8b7dbed1ec83f1dd80c::leverage_repay::complete_leverage<T0, T1>(arg0, arg2, arg1, arg3, 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::withdraw::withdraw_as_coin<T0, T1>(arg0, 0x6951e7b5d730797ebe05badbc1db04c9c88e49a5c8f1a8b7dbed1ec83f1dd80c::leverage_obligation::market_obligation(arg1), arg7, 0x6951e7b5d730797ebe05badbc1db04c9c88e49a5c8f1a8b7dbed1ec83f1dd80c::leverage_reduce_to_borrow_coin::calculate_reduce_ctoken_deduciton<T0, T1>(arg0, arg1, 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::reserve::fee<T0, T1>(&arg3) + 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::reserve::loan_amount<T0, T1>(&arg3)), arg5, arg6, arg8), arg5, arg6, arg7, arg8), v0)
    }

    fun request_reduce<T0, T1, T2>(arg0: &mut 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::market::Market<T0>, arg1: &0x6951e7b5d730797ebe05badbc1db04c9c88e49a5c8f1a8b7dbed1ec83f1dd80c::leverage_obligation::LeverageMarketOwnerCap, arg2: &mut 0x6951e7b5d730797ebe05badbc1db04c9c88e49a5c8f1a8b7dbed1ec83f1dd80c::leverage_market::LeverageMarket, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : (0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::reserve::FlashLoan<T0, T1>, 0x2::coin::Coin<T1>) {
        assert!(!0x6951e7b5d730797ebe05badbc1db04c9c88e49a5c8f1a8b7dbed1ec83f1dd80c::leverage_market::is_leverate_on_going(arg2), 13906834539415601151);
        0x6951e7b5d730797ebe05badbc1db04c9c88e49a5c8f1a8b7dbed1ec83f1dd80c::leverage_market::mark_leverage_ongoing(arg2);
        0x6951e7b5d730797ebe05badbc1db04c9c88e49a5c8f1a8b7dbed1ec83f1dd80c::leverage_obligation::ensure_coins_match<T1, T2>(arg1);
        let (v0, v1) = 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::flash_loan::borrow_flash_loan<T0, T1>(arg0, arg3, arg4);
        let v2 = v0;
        assert!(0x2::coin::value<T1>(&v2) == arg3, 13906834565185404927);
        (v1, v2)
    }

    public fun request_reduce_leverage<T0, T1, T2>(arg0: &mut 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::market::Market<T0>, arg1: &0x6951e7b5d730797ebe05badbc1db04c9c88e49a5c8f1a8b7dbed1ec83f1dd80c::leverage_obligation::LeverageMarketOwnerCap, arg2: &mut 0x6951e7b5d730797ebe05badbc1db04c9c88e49a5c8f1a8b7dbed1ec83f1dd80c::leverage_market::LeverageMarket, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : (0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::reserve::FlashLoan<T0, T1>, 0x2::coin::Coin<T1>) {
        0x6951e7b5d730797ebe05badbc1db04c9c88e49a5c8f1a8b7dbed1ec83f1dd80c::leverage_reduce_to_borrow_coin::emit_reduce_leverage_event(0x6951e7b5d730797ebe05badbc1db04c9c88e49a5c8f1a8b7dbed1ec83f1dd80c::leverage_obligation::id(arg1), arg4, arg3);
        request_reduce<T0, T1, T2>(arg0, arg1, arg2, arg4, arg5)
    }

    public fun request_reduce_size<T0, T1, T2>(arg0: &mut 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::market::Market<T0>, arg1: &mut 0x6951e7b5d730797ebe05badbc1db04c9c88e49a5c8f1a8b7dbed1ec83f1dd80c::leverage_obligation::LeverageMarketOwnerCap, arg2: &mut 0x6951e7b5d730797ebe05badbc1db04c9c88e49a5c8f1a8b7dbed1ec83f1dd80c::leverage_market::LeverageMarket, arg3: u8, arg4: u64, arg5: &0x988609a6772a8ce45037fa78bdc1eda593c5872c16dd883002c8aa4939a2a7bb::x_oracle::XOracle, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::reserve::FlashLoan<T0, T1>, 0x2::coin::Coin<T1>) {
        let (_, v1) = 0x6951e7b5d730797ebe05badbc1db04c9c88e49a5c8f1a8b7dbed1ec83f1dd80c::leverage_reduce_to_borrow_coin::calculate_reduce_collateral_deduciton<T0, T1, T2>(arg0, arg1, arg3, arg5, arg6);
        0x6951e7b5d730797ebe05badbc1db04c9c88e49a5c8f1a8b7dbed1ec83f1dd80c::leverage_reduce_to_borrow_coin::emit_reduce_size_event(0x6951e7b5d730797ebe05badbc1db04c9c88e49a5c8f1a8b7dbed1ec83f1dd80c::leverage_obligation::id(arg1), v1, arg4);
        request_reduce<T0, T1, T2>(arg0, arg1, arg2, v1, arg7)
    }

    // decompiled from Move bytecode v6
}

