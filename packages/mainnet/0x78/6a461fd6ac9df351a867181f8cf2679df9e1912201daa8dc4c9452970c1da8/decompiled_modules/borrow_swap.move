module 0x786a461fd6ac9df351a867181f8cf2679df9e1912201daa8dc4c9452970c1da8::borrow_swap {
    struct NewBorrowSwapEvent has copy, drop {
        leverage_owner_cap: 0x2::object::ID,
        operation: 0x1::option::Option<0x786a461fd6ac9df351a867181f8cf2679df9e1912201daa8dc4c9452970c1da8::leverage_obligation::Operation>,
        principle: u64,
    }

    public fun request_leverage<T0, T1, T2>(arg0: &mut 0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::market::Market<T0>, arg1: &mut 0x786a461fd6ac9df351a867181f8cf2679df9e1912201daa8dc4c9452970c1da8::leverage_market::LeverageMarket, arg2: &mut 0x786a461fd6ac9df351a867181f8cf2679df9e1912201daa8dc4c9452970c1da8::leverage_obligation::LeverageMarketOwnerCap, arg3: 0x2::coin::Coin<T1>, arg4: u64, arg5: u64, arg6: &0x6a79a9f82463e3c554cd5106e3878882c40568d264f0d43002bc4e9eba025159::coin_decimals_registry::CoinDecimalsRegistry, arg7: &0x2::clock::Clock, arg8: &0x8df1d001c6cb220f28cf2ba330ed7ea9febaac2d797329e2196133eb02bec894::x_oracle::XOracle, arg9: &mut 0x2::tx_context::TxContext) : (0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::reserve::FlashLoan<T0, T1>, 0x2::coin::Coin<T2>) {
        assert!(!0x786a461fd6ac9df351a867181f8cf2679df9e1912201daa8dc4c9452970c1da8::leverage_market::is_leverate_on_going(arg1), 13906834346142072831);
        0x786a461fd6ac9df351a867181f8cf2679df9e1912201daa8dc4c9452970c1da8::leverage_market::mark_leverage_ongoing(arg1);
        assert!(!0x786a461fd6ac9df351a867181f8cf2679df9e1912201daa8dc4c9452970c1da8::leverage_obligation::has_position(arg2), 0x786a461fd6ac9df351a867181f8cf2679df9e1912201daa8dc4c9452970c1da8::leverage_error::obligation_already_has_position());
        0x786a461fd6ac9df351a867181f8cf2679df9e1912201daa8dc4c9452970c1da8::leverage_obligation::set_position<T1, T2>(arg2, 0x786a461fd6ac9df351a867181f8cf2679df9e1912201daa8dc4c9452970c1da8::leverage_obligation::swap_borrow());
        let (v0, v1) = 0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::flash_loan::borrow_flash_loan<T0, T1>(arg0, arg4 - 0x2::coin::value<T1>(&arg3), arg9);
        let v2 = v0;
        let v3 = NewBorrowSwapEvent{
            leverage_owner_cap : 0x786a461fd6ac9df351a867181f8cf2679df9e1912201daa8dc4c9452970c1da8::leverage_obligation::id(arg2),
            operation          : 0x1::option::some<0x786a461fd6ac9df351a867181f8cf2679df9e1912201daa8dc4c9452970c1da8::leverage_obligation::Operation>(0x786a461fd6ac9df351a867181f8cf2679df9e1912201daa8dc4c9452970c1da8::leverage_obligation::borrow_swap()),
            principle          : 0x786a461fd6ac9df351a867181f8cf2679df9e1912201daa8dc4c9452970c1da8::leverage_obligation::increase_amount(arg2, 0x2::coin::value<T1>(&arg3)),
        };
        0x2::event::emit<NewBorrowSwapEvent>(v3);
        0x2::coin::join<T1>(&mut v2, arg3);
        assert!(0x2::coin::value<T1>(&v2) == arg4, 13906834423451484159);
        0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::deposit::deposit<T0, T1>(0x786a461fd6ac9df351a867181f8cf2679df9e1912201daa8dc4c9452970c1da8::leverage_obligation::market_obligation(arg2), arg0, v2, arg7, arg9);
        (v1, 0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::borrow::borrow<T0, T2>(0x786a461fd6ac9df351a867181f8cf2679df9e1912201daa8dc4c9452970c1da8::leverage_obligation::market_obligation(arg2), arg0, arg6, arg5, arg8, arg7, arg9))
    }

    // decompiled from Move bytecode v6
}

