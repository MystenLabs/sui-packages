module 0x786a461fd6ac9df351a867181f8cf2679df9e1912201daa8dc4c9452970c1da8::leverage_repay {
    struct NewRepayEvent has copy, drop {
        leverage_owner_cap: 0x2::object::ID,
        operation: 0x1::option::Option<0x786a461fd6ac9df351a867181f8cf2679df9e1912201daa8dc4c9452970c1da8::leverage_obligation::Operation>,
        principle: u64,
    }

    public fun complete_leverage<T0, T1>(arg0: &mut 0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::market::Market<T0>, arg1: &mut 0x786a461fd6ac9df351a867181f8cf2679df9e1912201daa8dc4c9452970c1da8::leverage_market::LeverageMarket, arg2: 0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::reserve::FlashLoan<T0, T1>, arg3: 0x2::coin::Coin<T1>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(0x786a461fd6ac9df351a867181f8cf2679df9e1912201daa8dc4c9452970c1da8::leverage_market::is_leverate_on_going(arg1), 13906834535120633855);
        0x786a461fd6ac9df351a867181f8cf2679df9e1912201daa8dc4c9452970c1da8::leverage_market::mark_leverage_finished(arg1);
        let v0 = 0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::reserve::fee<T0, T1>(&arg2) + 0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::reserve::loan_amount<T0, T1>(&arg2);
        assert!(0x2::coin::value<T1>(&arg3) >= v0, 13906834552300503039);
        0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::flash_loan::repay_flash_loan<T0, T1>(arg0, 0x2::coin::split<T1>(&mut arg3, v0, arg4), arg2, arg4);
        arg3
    }

    public fun request_repay<T0, T1, T2>(arg0: &mut 0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::market::Market<T0>, arg1: &mut 0x786a461fd6ac9df351a867181f8cf2679df9e1912201daa8dc4c9452970c1da8::leverage_obligation::LeverageMarketOwnerCap, arg2: &mut 0x786a461fd6ac9df351a867181f8cf2679df9e1912201daa8dc4c9452970c1da8::leverage_market::LeverageMarket, arg3: u64, arg4: u64, arg5: &0x8df1d001c6cb220f28cf2ba330ed7ea9febaac2d797329e2196133eb02bec894::x_oracle::XOracle, arg6: &0x2::clock::Clock, arg7: &0x6a79a9f82463e3c554cd5106e3878882c40568d264f0d43002bc4e9eba025159::coin_decimals_registry::CoinDecimalsRegistry, arg8: &mut 0x2::tx_context::TxContext) : (0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::reserve::FlashLoan<T0, T2>, 0x2::coin::Coin<T1>) {
        assert!(!0x786a461fd6ac9df351a867181f8cf2679df9e1912201daa8dc4c9452970c1da8::leverage_market::is_leverate_on_going(arg2), 13906834350437040127);
        0x786a461fd6ac9df351a867181f8cf2679df9e1912201daa8dc4c9452970c1da8::leverage_market::mark_leverage_ongoing(arg2);
        assert!(0x786a461fd6ac9df351a867181f8cf2679df9e1912201daa8dc4c9452970c1da8::leverage_obligation::has_position(arg1), 0x786a461fd6ac9df351a867181f8cf2679df9e1912201daa8dc4c9452970c1da8::leverage_error::obligation_no_position());
        let v0 = if (0x786a461fd6ac9df351a867181f8cf2679df9e1912201daa8dc4c9452970c1da8::leverage_obligation::is_borrow_then_swap(arg1)) {
            0x786a461fd6ac9df351a867181f8cf2679df9e1912201daa8dc4c9452970c1da8::leverage_obligation::reduce_amount(arg1, arg4)
        } else {
            0x786a461fd6ac9df351a867181f8cf2679df9e1912201daa8dc4c9452970c1da8::leverage_obligation::reduce_amount(arg1, arg3)
        };
        let v1 = NewRepayEvent{
            leverage_owner_cap : 0x786a461fd6ac9df351a867181f8cf2679df9e1912201daa8dc4c9452970c1da8::leverage_obligation::id(arg1),
            operation          : 0x1::option::none<0x786a461fd6ac9df351a867181f8cf2679df9e1912201daa8dc4c9452970c1da8::leverage_obligation::Operation>(),
            principle          : v0,
        };
        0x2::event::emit<NewRepayEvent>(v1);
        let (v2, v3) = 0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::flash_loan::borrow_flash_loan<T0, T2>(arg0, arg3, arg8);
        let v4 = v2;
        assert!(0x2::coin::value<T2>(&v4) == arg3, 13906834423451484159);
        0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::repay::repay<T0, T2>(0x786a461fd6ac9df351a867181f8cf2679df9e1912201daa8dc4c9452970c1da8::leverage_obligation::market_obligation(arg1), arg0, v4, arg6, arg8);
        (v3, 0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::withdraw::withdraw_as_coin<T0, T1>(arg0, 0x786a461fd6ac9df351a867181f8cf2679df9e1912201daa8dc4c9452970c1da8::leverage_obligation::market_obligation(arg1), arg7, arg4, arg5, arg6, arg8))
    }

    // decompiled from Move bytecode v6
}

