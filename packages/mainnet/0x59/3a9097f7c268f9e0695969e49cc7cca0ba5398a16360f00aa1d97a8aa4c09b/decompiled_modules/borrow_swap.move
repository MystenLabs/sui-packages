module 0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::borrow_swap {
    struct NewBorrowSwapEvent has copy, drop {
        leverage_owner_cap: 0x2::object::ID,
        operation: 0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::leverage_obligation::Operation,
        collateral: 0x1::type_name::TypeName,
        debt: 0x1::type_name::TypeName,
        deposit_amount: u64,
        deposit_usd: 0x7f885241ae708ff7407c1eba20d6fabaf08c7ce817b8302490aff997635d722::float::Decimal,
    }

    public fun request_leverage<T0, T1, T2>(arg0: &mut 0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::market::Market<T0>, arg1: &mut 0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::leverage_market::LeverageMarket, arg2: &mut 0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::leverage_obligation::LeverageMarketOwnerCap, arg3: 0x2::coin::Coin<T1>, arg4: u64, arg5: u64, arg6: &0xcfa25712c883ea080ae7cbd067998a134eee2e39cfbcbc4b6b29674117a021ee::coin_decimals_registry::CoinDecimalsRegistry, arg7: &0x2::clock::Clock, arg8: &0x64442484ac47ad2547a37432b8bb393b90f5db7e167a20f649f90386a7e23e80::x_oracle::XOracle, arg9: &mut 0x2::tx_context::TxContext) : (0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::reserve::FlashLoan<T0, T1>, 0x2::coin::Coin<T2>) {
        assert!(!0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::leverage_market::is_leverate_on_going(arg1), 13906834384796778495);
        0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::leverage_market::mark_leverage_ongoing(arg1);
        let v0 = NewBorrowSwapEvent{
            leverage_owner_cap : 0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::leverage_obligation::id(arg2),
            operation          : 0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::leverage_obligation::borrow_swap(),
            collateral         : 0x1::type_name::get<T1>(),
            debt               : 0x1::type_name::get<T2>(),
            deposit_amount     : 0x2::coin::value<T1>(&arg3),
            deposit_usd        : 0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::leverage_obligation::get_usd_value<T1>(arg8, arg7, 0x2::coin::value<T1>(&arg3), arg6),
        };
        0x2::event::emit<NewBorrowSwapEvent>(v0);
        0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::leverage_obligation::set_or_check_position<T0, T1, T2>(arg2, arg0, 0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::leverage_obligation::borrow_swap());
        let (v1, v2) = 0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::flash_loan::borrow_flash_loan_inner<T0, T1>(arg0, arg4 - 0x2::coin::value<T1>(&arg3), 0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::leverage_market::emode_group(arg1), arg9);
        let v3 = v1;
        0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::leverage_obligation::increase_collateral(arg2, 0x2::coin::value<T1>(&arg3), 0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::leverage_obligation::get_collateral_price<T1, T2>(arg8, arg7));
        0x2::coin::join<T1>(&mut v3, arg3);
        assert!(0x2::coin::value<T1>(&v3) == arg4, 13906834505055862783);
        0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::deposit::deposit<T0, T1>(0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::leverage_obligation::market_obligation(arg2), arg0, v3, arg7, arg9);
        (v2, 0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::borrow::borrow<T0, T2>(0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::leverage_obligation::market_obligation(arg2), arg0, arg6, arg5, arg8, arg7, arg9))
    }

    // decompiled from Move bytecode v6
}

