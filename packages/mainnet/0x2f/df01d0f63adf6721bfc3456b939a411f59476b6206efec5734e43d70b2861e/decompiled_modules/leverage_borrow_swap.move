module 0x2fdf01d0f63adf6721bfc3456b939a411f59476b6206efec5734e43d70b2861e::leverage_borrow_swap {
    struct NewBorrowSwapEvent has copy, drop {
        leverage_owner_cap: 0x2::object::ID,
        operation: 0x2fdf01d0f63adf6721bfc3456b939a411f59476b6206efec5734e43d70b2861e::leverage_obligation::Operation,
        collateral: 0x1::type_name::TypeName,
        debt: 0x1::type_name::TypeName,
        deposit_amount: u64,
        deposit_usd: 0xa66da896777763298f7a678e25cd99d92ff53a5a27df201f4a86225e11117eff::float::Decimal,
    }

    public fun request_leverage<T0, T1, T2>(arg0: &mut 0x59dcb7cf2b98d5f00f9e51dcfa45e27e92d51604052fa1603af8d3fff2a6df46::app::ProtocolApp, arg1: &mut 0x2fdf01d0f63adf6721bfc3456b939a411f59476b6206efec5734e43d70b2861e::leverage_app::LeverageApp, arg2: &mut 0x59dcb7cf2b98d5f00f9e51dcfa45e27e92d51604052fa1603af8d3fff2a6df46::market::Market<T0>, arg3: &mut 0x2fdf01d0f63adf6721bfc3456b939a411f59476b6206efec5734e43d70b2861e::leverage_market::LeverageMarket, arg4: &mut 0x2fdf01d0f63adf6721bfc3456b939a411f59476b6206efec5734e43d70b2861e::leverage_obligation::LeverageMarketOwnerCap, arg5: 0x2::coin::Coin<T1>, arg6: u64, arg7: u64, arg8: &0x59dcb7cf2b98d5f00f9e51dcfa45e27e92d51604052fa1603af8d3fff2a6df46::coin_decimals_registry::CoinDecimalsRegistry, arg9: &0x2::clock::Clock, arg10: &0xa6ee3c6b4b6c0fb4e3240716afda5bdd23939dfdb9ef1e5a6055d038265077ad::x_oracle::XOracle, arg11: &mut 0x2::tx_context::TxContext) : (0x59dcb7cf2b98d5f00f9e51dcfa45e27e92d51604052fa1603af8d3fff2a6df46::market::FlashLoan<T0, T1>, 0x2::coin::Coin<T2>) {
        assert!(!0x2fdf01d0f63adf6721bfc3456b939a411f59476b6206efec5734e43d70b2861e::leverage_market::is_leverate_on_going(arg3), 13906834406271614975);
        0x2fdf01d0f63adf6721bfc3456b939a411f59476b6206efec5734e43d70b2861e::leverage_market::mark_leverage_ongoing(arg3);
        let v0 = NewBorrowSwapEvent{
            leverage_owner_cap : 0x2fdf01d0f63adf6721bfc3456b939a411f59476b6206efec5734e43d70b2861e::leverage_obligation::id(arg4),
            operation          : 0x2fdf01d0f63adf6721bfc3456b939a411f59476b6206efec5734e43d70b2861e::leverage_obligation::borrow_swap(),
            collateral         : 0x1::type_name::get<T1>(),
            debt               : 0x1::type_name::get<T2>(),
            deposit_amount     : 0x2::coin::value<T1>(&arg5),
            deposit_usd        : 0x2fdf01d0f63adf6721bfc3456b939a411f59476b6206efec5734e43d70b2861e::leverage_obligation::get_usd_value<T1>(arg10, arg9, 0x2::coin::value<T1>(&arg5), arg8),
        };
        0x2::event::emit<NewBorrowSwapEvent>(v0);
        0x2fdf01d0f63adf6721bfc3456b939a411f59476b6206efec5734e43d70b2861e::leverage_obligation::set_or_check_position<T0, T1, T2>(arg4, arg2, 0x2fdf01d0f63adf6721bfc3456b939a411f59476b6206efec5734e43d70b2861e::leverage_obligation::borrow_swap());
        let (v1, v2) = 0x59dcb7cf2b98d5f00f9e51dcfa45e27e92d51604052fa1603af8d3fff2a6df46::flash_loan::borrow_flash_loan<T0, T1>(arg0, 0x2fdf01d0f63adf6721bfc3456b939a411f59476b6206efec5734e43d70b2861e::leverage_app::borrow_protocol_caller_cap(arg1), arg2, 0x2fdf01d0f63adf6721bfc3456b939a411f59476b6206efec5734e43d70b2861e::leverage_market::emode_group(arg3), arg6 - 0x2::coin::value<T1>(&arg5), arg11);
        let v3 = v1;
        0x2fdf01d0f63adf6721bfc3456b939a411f59476b6206efec5734e43d70b2861e::leverage_obligation::increase_collateral(arg4, 0x2::coin::value<T1>(&arg5), 0x2fdf01d0f63adf6721bfc3456b939a411f59476b6206efec5734e43d70b2861e::leverage_obligation::get_collateral_price<T1, T2>(arg10, arg9));
        0x2::coin::join<T1>(&mut v3, arg5);
        assert!(0x2::coin::value<T1>(&v3) == arg6, 13906834535120633855);
        0x59dcb7cf2b98d5f00f9e51dcfa45e27e92d51604052fa1603af8d3fff2a6df46::deposit::deposit<T0, T1>(arg0, arg2, 0x2fdf01d0f63adf6721bfc3456b939a411f59476b6206efec5734e43d70b2861e::leverage_obligation::market_obligation(arg4), v3, arg8, arg10, arg9, arg11);
        (v2, 0x59dcb7cf2b98d5f00f9e51dcfa45e27e92d51604052fa1603af8d3fff2a6df46::borrow::borrow<T0, T2>(0x2fdf01d0f63adf6721bfc3456b939a411f59476b6206efec5734e43d70b2861e::leverage_obligation::market_obligation(arg4), arg2, arg8, arg7, arg10, arg9, arg11))
    }

    // decompiled from Move bytecode v6
}

