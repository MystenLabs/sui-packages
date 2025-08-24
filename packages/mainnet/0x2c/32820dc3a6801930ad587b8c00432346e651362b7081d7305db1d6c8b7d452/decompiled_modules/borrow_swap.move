module 0x2c32820dc3a6801930ad587b8c00432346e651362b7081d7305db1d6c8b7d452::borrow_swap {
    struct NewBorrowSwapEvent has copy, drop {
        leverage_owner_cap: 0x2::object::ID,
        operation: 0x1::option::Option<0x2c32820dc3a6801930ad587b8c00432346e651362b7081d7305db1d6c8b7d452::leverage_obligation::Operation>,
        principle: u64,
    }

    public fun request_leverage<T0, T1, T2>(arg0: &mut 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::market::Market<T0>, arg1: &mut 0x2c32820dc3a6801930ad587b8c00432346e651362b7081d7305db1d6c8b7d452::leverage_market::LeverageMarket, arg2: &mut 0x2c32820dc3a6801930ad587b8c00432346e651362b7081d7305db1d6c8b7d452::leverage_obligation::LeverageMarketOwnerCap, arg3: 0x2::coin::Coin<T1>, arg4: u64, arg5: u64, arg6: bool, arg7: &0x4bf60b34197a0246a1f916cb51ccd215ac7f4ddf1ec83e00eeecdc355630d998::coin_decimals_registry::CoinDecimalsRegistry, arg8: &0x2::clock::Clock, arg9: &0x988609a6772a8ce45037fa78bdc1eda593c5872c16dd883002c8aa4939a2a7bb::x_oracle::XOracle, arg10: &mut 0x2::tx_context::TxContext) : (0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::reserve::FlashLoan<T0, T1>, 0x2::coin::Coin<T2>) {
        assert!(!0x2c32820dc3a6801930ad587b8c00432346e651362b7081d7305db1d6c8b7d452::leverage_market::is_leverate_on_going(arg1), 13906834367616909311);
        0x2c32820dc3a6801930ad587b8c00432346e651362b7081d7305db1d6c8b7d452::leverage_market::mark_leverage_ongoing(arg1);
        0x2c32820dc3a6801930ad587b8c00432346e651362b7081d7305db1d6c8b7d452::leverage_obligation::set_or_check_position<T1, T2>(arg2, 0x2c32820dc3a6801930ad587b8c00432346e651362b7081d7305db1d6c8b7d452::leverage_obligation::get_entry_price<T1, T2>(arg9, arg8, arg6), arg6, 0x2c32820dc3a6801930ad587b8c00432346e651362b7081d7305db1d6c8b7d452::leverage_obligation::swap_borrow());
        let (v0, v1) = 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::flash_loan::borrow_flash_loan<T0, T1>(arg0, arg4 - 0x2::coin::value<T1>(&arg3), arg10);
        let v2 = v0;
        let v3 = NewBorrowSwapEvent{
            leverage_owner_cap : 0x2c32820dc3a6801930ad587b8c00432346e651362b7081d7305db1d6c8b7d452::leverage_obligation::id(arg2),
            operation          : 0x1::option::some<0x2c32820dc3a6801930ad587b8c00432346e651362b7081d7305db1d6c8b7d452::leverage_obligation::Operation>(0x2c32820dc3a6801930ad587b8c00432346e651362b7081d7305db1d6c8b7d452::leverage_obligation::borrow_swap()),
            principle          : 0x2c32820dc3a6801930ad587b8c00432346e651362b7081d7305db1d6c8b7d452::leverage_obligation::increase_amount(arg2, 0x2::coin::value<T1>(&arg3)),
        };
        0x2::event::emit<NewBorrowSwapEvent>(v3);
        0x2::coin::join<T1>(&mut v2, arg3);
        assert!(0x2::coin::value<T1>(&v2) == arg4, 13906834440631353343);
        0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::deposit::deposit<T0, T1>(0x2c32820dc3a6801930ad587b8c00432346e651362b7081d7305db1d6c8b7d452::leverage_obligation::market_obligation(arg2), arg0, v2, arg8, arg10);
        (v1, 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::borrow::borrow<T0, T2>(0x2c32820dc3a6801930ad587b8c00432346e651362b7081d7305db1d6c8b7d452::leverage_obligation::market_obligation(arg2), arg0, arg7, arg5, arg9, arg8, arg10))
    }

    // decompiled from Move bytecode v6
}

