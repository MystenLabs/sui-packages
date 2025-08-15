module 0x4b62c9851bc22cbee7ae653db0c1ba6637aa9c07fc202d0d724cf36fbaed96c9::swap_borrow {
    struct NewSwapBorrowEvent has copy, drop {
        leverage_owner_cap: 0x2::object::ID,
        operation: 0x1::option::Option<0x4b62c9851bc22cbee7ae653db0c1ba6637aa9c07fc202d0d724cf36fbaed96c9::leverage_obligation::Operation>,
        principle: u64,
    }

    public fun complete_leverage<T0, T1, T2>(arg0: &mut 0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::market::Market<T0>, arg1: &mut 0x4b62c9851bc22cbee7ae653db0c1ba6637aa9c07fc202d0d724cf36fbaed96c9::leverage_market::LeverageMarket, arg2: &0x4b62c9851bc22cbee7ae653db0c1ba6637aa9c07fc202d0d724cf36fbaed96c9::leverage_obligation::LeverageMarketOwnerCap, arg3: 0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::reserve::FlashLoan<T0, T2>, arg4: 0x2::coin::Coin<T1>, arg5: &0x6a79a9f82463e3c554cd5106e3878882c40568d264f0d43002bc4e9eba025159::coin_decimals_registry::CoinDecimalsRegistry, arg6: &0x8df1d001c6cb220f28cf2ba330ed7ea9febaac2d797329e2196133eb02bec894::x_oracle::XOracle, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        assert!(0x4b62c9851bc22cbee7ae653db0c1ba6637aa9c07fc202d0d724cf36fbaed96c9::leverage_market::is_leverate_on_going(arg1), 13906834483581026303);
        0x4b62c9851bc22cbee7ae653db0c1ba6637aa9c07fc202d0d724cf36fbaed96c9::leverage_market::mark_leverage_finished(arg1);
        0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::deposit::deposit<T0, T1>(0x4b62c9851bc22cbee7ae653db0c1ba6637aa9c07fc202d0d724cf36fbaed96c9::leverage_obligation::market_obligation(arg2), arg0, arg4, arg7, arg8);
        let v0 = 0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::reserve::fee<T0, T2>(&arg3) + 0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::reserve::loan_amount<T0, T2>(&arg3);
        let v1 = 0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::borrow::borrow<T0, T2>(0x4b62c9851bc22cbee7ae653db0c1ba6637aa9c07fc202d0d724cf36fbaed96c9::leverage_obligation::market_obligation(arg2), arg0, arg5, v0, arg6, arg7, arg8);
        assert!(0x2::coin::value<T2>(&v1) == v0, 13906834517940764671);
        0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::flash_loan::repay_flash_loan<T0, T2>(arg0, 0x2::coin::split<T2>(&mut v1, v0, arg8), arg3, arg8);
        v1
    }

    public fun request_leverage<T0, T1, T2>(arg0: &mut 0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::market::Market<T0>, arg1: &mut 0x4b62c9851bc22cbee7ae653db0c1ba6637aa9c07fc202d0d724cf36fbaed96c9::leverage_market::LeverageMarket, arg2: &mut 0x4b62c9851bc22cbee7ae653db0c1ba6637aa9c07fc202d0d724cf36fbaed96c9::leverage_obligation::LeverageMarketOwnerCap, arg3: 0x2::coin::Coin<T2>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : (0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::reserve::FlashLoan<T0, T2>, 0x2::coin::Coin<T2>) {
        assert!(!0x4b62c9851bc22cbee7ae653db0c1ba6637aa9c07fc202d0d724cf36fbaed96c9::leverage_market::is_leverate_on_going(arg1), 13906834324667236351);
        0x4b62c9851bc22cbee7ae653db0c1ba6637aa9c07fc202d0d724cf36fbaed96c9::leverage_market::mark_leverage_ongoing(arg1);
        assert!(!0x4b62c9851bc22cbee7ae653db0c1ba6637aa9c07fc202d0d724cf36fbaed96c9::leverage_obligation::has_position(arg2), 0x4b62c9851bc22cbee7ae653db0c1ba6637aa9c07fc202d0d724cf36fbaed96c9::leverage_error::obligation_already_has_position());
        0x4b62c9851bc22cbee7ae653db0c1ba6637aa9c07fc202d0d724cf36fbaed96c9::leverage_obligation::set_position<T1, T2>(arg2, 0x4b62c9851bc22cbee7ae653db0c1ba6637aa9c07fc202d0d724cf36fbaed96c9::leverage_obligation::swap_borrow());
        let (v0, v1) = 0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::flash_loan::borrow_flash_loan<T0, T2>(arg0, arg4 - 0x2::coin::value<T2>(&arg3), arg5);
        let v2 = v0;
        let v3 = NewSwapBorrowEvent{
            leverage_owner_cap : 0x4b62c9851bc22cbee7ae653db0c1ba6637aa9c07fc202d0d724cf36fbaed96c9::leverage_obligation::id(arg2),
            operation          : 0x1::option::some<0x4b62c9851bc22cbee7ae653db0c1ba6637aa9c07fc202d0d724cf36fbaed96c9::leverage_obligation::Operation>(0x4b62c9851bc22cbee7ae653db0c1ba6637aa9c07fc202d0d724cf36fbaed96c9::leverage_obligation::swap_borrow()),
            principle          : 0x4b62c9851bc22cbee7ae653db0c1ba6637aa9c07fc202d0d724cf36fbaed96c9::leverage_obligation::increase_amount(arg2, 0x2::coin::value<T2>(&arg3)),
        };
        0x2::event::emit<NewSwapBorrowEvent>(v3);
        0x2::coin::join<T2>(&mut v2, arg3);
        assert!(0x2::coin::value<T2>(&v2) == arg4, 13906834401976647679);
        (v1, v2)
    }

    // decompiled from Move bytecode v6
}

