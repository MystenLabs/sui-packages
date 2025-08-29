module 0xd7ba1a74da0cb8c69e26a2e0b6fe7540abb761df446bd0b7bf66139380701bfd::leverage_repay {
    struct NewRepayEvent has copy, drop {
        leverage_owner_cap: 0x2::object::ID,
        operation: 0x1::option::Option<0xd7ba1a74da0cb8c69e26a2e0b6fe7540abb761df446bd0b7bf66139380701bfd::leverage_obligation::Operation>,
        collateral_withdrawn: u64,
        borrow_repaid: u64,
    }

    public fun complete_leverage<T0, T1>(arg0: &mut 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::market::Market<T0>, arg1: &mut 0xd7ba1a74da0cb8c69e26a2e0b6fe7540abb761df446bd0b7bf66139380701bfd::leverage_market::LeverageMarket, arg2: 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::reserve::FlashLoan<T0, T1>, arg3: 0x2::coin::Coin<T1>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(0xd7ba1a74da0cb8c69e26a2e0b6fe7540abb761df446bd0b7bf66139380701bfd::leverage_market::is_leverate_on_going(arg1), 13906834788523704319);
        0xd7ba1a74da0cb8c69e26a2e0b6fe7540abb761df446bd0b7bf66139380701bfd::leverage_market::mark_leverage_finished(arg1);
        let v0 = 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::reserve::fee<T0, T1>(&arg2) + 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::reserve::loan_amount<T0, T1>(&arg2);
        assert!(0x2::coin::value<T1>(&arg3) >= v0, 0xd7ba1a74da0cb8c69e26a2e0b6fe7540abb761df446bd0b7bf66139380701bfd::leverage_error::cannot_repay_flash_loan());
        0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::flash_loan::repay_flash_loan<T0, T1>(arg0, 0x2::coin::split<T1>(&mut arg3, v0, arg4), arg2, arg4);
        arg3
    }

    public fun request_reduce_leverage<T0, T1, T2>(arg0: &mut 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::market::Market<T0>, arg1: &0xd7ba1a74da0cb8c69e26a2e0b6fe7540abb761df446bd0b7bf66139380701bfd::leverage_obligation::LeverageMarketOwnerCap, arg2: &mut 0xd7ba1a74da0cb8c69e26a2e0b6fe7540abb761df446bd0b7bf66139380701bfd::leverage_market::LeverageMarket, arg3: u64, arg4: u64, arg5: &0x988609a6772a8ce45037fa78bdc1eda593c5872c16dd883002c8aa4939a2a7bb::x_oracle::XOracle, arg6: &0x2::clock::Clock, arg7: &0x4bf60b34197a0246a1f916cb51ccd215ac7f4ddf1ec83e00eeecdc355630d998::coin_decimals_registry::CoinDecimalsRegistry, arg8: &mut 0x2::tx_context::TxContext) : (0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::reserve::FlashLoan<T0, T2>, 0x2::coin::Coin<T1>) {
        let (v0, _, v2) = 0xd7ba1a74da0cb8c69e26a2e0b6fe7540abb761df446bd0b7bf66139380701bfd::leverage_obligation::collateral_amount<T0, T1>(arg1, arg0);
        assert!(arg4 <= v0, 0xd7ba1a74da0cb8c69e26a2e0b6fe7540abb761df446bd0b7bf66139380701bfd::leverage_error::withdrawn_too_much_collateral());
        assert!(v0 - arg4 > 0xd7ba1a74da0cb8c69e26a2e0b6fe7540abb761df446bd0b7bf66139380701bfd::leverage_obligation::principle(arg1), 0xd7ba1a74da0cb8c69e26a2e0b6fe7540abb761df446bd0b7bf66139380701bfd::leverage_error::withdrawn_more_than_principle());
        request_repay<T0, T1, T2>(arg0, arg1, arg2, arg3, 0x684131467d610004df3734295dc4604132f8d2af79479874a3bc69a06b676aca::float::floor(0x684131467d610004df3734295dc4604132f8d2af79479874a3bc69a06b676aca::float::div(0x684131467d610004df3734295dc4604132f8d2af79479874a3bc69a06b676aca::float::from(arg4), v2)), arg5, arg6, arg7, arg8)
    }

    public fun request_reduce_size<T0, T1, T2>(arg0: &mut 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::market::Market<T0>, arg1: &mut 0xd7ba1a74da0cb8c69e26a2e0b6fe7540abb761df446bd0b7bf66139380701bfd::leverage_obligation::LeverageMarketOwnerCap, arg2: &mut 0xd7ba1a74da0cb8c69e26a2e0b6fe7540abb761df446bd0b7bf66139380701bfd::leverage_market::LeverageMarket, arg3: u8, arg4: u64, arg5: &0x988609a6772a8ce45037fa78bdc1eda593c5872c16dd883002c8aa4939a2a7bb::x_oracle::XOracle, arg6: &0x2::clock::Clock, arg7: &0x4bf60b34197a0246a1f916cb51ccd215ac7f4ddf1ec83e00eeecdc355630d998::coin_decimals_registry::CoinDecimalsRegistry, arg8: &mut 0x2::tx_context::TxContext) : (0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::reserve::FlashLoan<T0, T2>, 0x2::coin::Coin<T1>) {
        let (_, v1, _) = 0xd7ba1a74da0cb8c69e26a2e0b6fe7540abb761df446bd0b7bf66139380701bfd::leverage_obligation::collateral_amount<T0, T1>(arg1, arg0);
        let v3 = if (arg3 >= 100) {
            0xd7ba1a74da0cb8c69e26a2e0b6fe7540abb761df446bd0b7bf66139380701bfd::leverage_obligation::reset_collateral(arg1);
            v1
        } else {
            let v4 = 0x684131467d610004df3734295dc4604132f8d2af79479874a3bc69a06b676aca::float::from_percent(arg3);
            0xd7ba1a74da0cb8c69e26a2e0b6fe7540abb761df446bd0b7bf66139380701bfd::leverage_obligation::reduce_collateral_by_percentage(arg1, v4, 0xd7ba1a74da0cb8c69e26a2e0b6fe7540abb761df446bd0b7bf66139380701bfd::leverage_obligation::get_collateral_price<T1, T2>(arg5, arg6));
            0x684131467d610004df3734295dc4604132f8d2af79479874a3bc69a06b676aca::float::floor(0x684131467d610004df3734295dc4604132f8d2af79479874a3bc69a06b676aca::float::mul_u64(v4, v1))
        };
        request_repay<T0, T1, T2>(arg0, arg1, arg2, arg4, v3, arg5, arg6, arg7, arg8)
    }

    fun request_repay<T0, T1, T2>(arg0: &mut 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::market::Market<T0>, arg1: &0xd7ba1a74da0cb8c69e26a2e0b6fe7540abb761df446bd0b7bf66139380701bfd::leverage_obligation::LeverageMarketOwnerCap, arg2: &mut 0xd7ba1a74da0cb8c69e26a2e0b6fe7540abb761df446bd0b7bf66139380701bfd::leverage_market::LeverageMarket, arg3: u64, arg4: u64, arg5: &0x988609a6772a8ce45037fa78bdc1eda593c5872c16dd883002c8aa4939a2a7bb::x_oracle::XOracle, arg6: &0x2::clock::Clock, arg7: &0x4bf60b34197a0246a1f916cb51ccd215ac7f4ddf1ec83e00eeecdc355630d998::coin_decimals_registry::CoinDecimalsRegistry, arg8: &mut 0x2::tx_context::TxContext) : (0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::reserve::FlashLoan<T0, T2>, 0x2::coin::Coin<T1>) {
        assert!(!0xd7ba1a74da0cb8c69e26a2e0b6fe7540abb761df446bd0b7bf66139380701bfd::leverage_market::is_leverate_on_going(arg2), 13906834621019979775);
        0xd7ba1a74da0cb8c69e26a2e0b6fe7540abb761df446bd0b7bf66139380701bfd::leverage_market::mark_leverage_ongoing(arg2);
        0xd7ba1a74da0cb8c69e26a2e0b6fe7540abb761df446bd0b7bf66139380701bfd::leverage_obligation::ensure_coins_match<T1, T2>(arg1);
        let (v0, v1) = 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::flash_loan::borrow_flash_loan<T0, T2>(arg0, arg3, arg8);
        let v2 = v0;
        assert!(0x2::coin::value<T2>(&v2) == arg3, 13906834646789783551);
        0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::repay::repay<T0, T2>(0xd7ba1a74da0cb8c69e26a2e0b6fe7540abb761df446bd0b7bf66139380701bfd::leverage_obligation::market_obligation(arg1), arg0, v2, arg6, arg8);
        let v3 = 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::withdraw::withdraw_as_coin<T0, T1>(arg0, 0xd7ba1a74da0cb8c69e26a2e0b6fe7540abb761df446bd0b7bf66139380701bfd::leverage_obligation::market_obligation(arg1), arg7, arg4, arg5, arg6, arg8);
        let v4 = NewRepayEvent{
            leverage_owner_cap   : 0xd7ba1a74da0cb8c69e26a2e0b6fe7540abb761df446bd0b7bf66139380701bfd::leverage_obligation::id(arg1),
            operation            : 0x1::option::none<0xd7ba1a74da0cb8c69e26a2e0b6fe7540abb761df446bd0b7bf66139380701bfd::leverage_obligation::Operation>(),
            collateral_withdrawn : 0x2::coin::value<T1>(&v3),
            borrow_repaid        : arg3,
        };
        0x2::event::emit<NewRepayEvent>(v4);
        (v1, v3)
    }

    // decompiled from Move bytecode v6
}

