module 0x44621169b24fb8bbb238726a47e79ddabe9669d596fcabcae1531e0aadc64256::leverage_swap_borrow {
    struct NewSwapBorrowEvent has copy, drop {
        leverage_owner_cap: 0x2::object::ID,
        operation: 0x44621169b24fb8bbb238726a47e79ddabe9669d596fcabcae1531e0aadc64256::leverage_obligation::Operation,
        collateral: 0x1::type_name::TypeName,
        debt: 0x1::type_name::TypeName,
        initial_debt_amount: u64,
        collateral_price: 0xf01bf3d01c8f50247fdf597e3f565b865e00b4a20a01b353d44d71c993f36e9a::float::Decimal,
    }

    public fun complete_leverage<T0, T1, T2>(arg0: &mut 0x273468dc036f1b797a1c8b04c5d6aefcdd5c2befd94160c2f1078ce9c7813420::app::ProtocolApp, arg1: &mut 0x273468dc036f1b797a1c8b04c5d6aefcdd5c2befd94160c2f1078ce9c7813420::market::Market<T0>, arg2: &mut 0x44621169b24fb8bbb238726a47e79ddabe9669d596fcabcae1531e0aadc64256::leverage_market::LeverageMarket, arg3: &0x44621169b24fb8bbb238726a47e79ddabe9669d596fcabcae1531e0aadc64256::leverage_obligation::LeverageMarketOwnerCap, arg4: 0x44621169b24fb8bbb238726a47e79ddabe9669d596fcabcae1531e0aadc64256::leverage_repay::LeverageHotPotato<T0, T2>, arg5: 0x2::coin::Coin<T1>, arg6: 0x1::option::Option<0x1::string::String>, arg7: &0x273468dc036f1b797a1c8b04c5d6aefcdd5c2befd94160c2f1078ce9c7813420::coin_decimals_registry::CoinDecimalsRegistry, arg8: &0xf04916dd9886f2404e7ab846fb3e7ef6134ea06d242f86c33192a7e4877e42c4::x_oracle::XOracle, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        0x44621169b24fb8bbb238726a47e79ddabe9669d596fcabcae1531e0aadc64256::leverage_market::ensure_supporting_market<T0>(arg2, arg1);
        0x44621169b24fb8bbb238726a47e79ddabe9669d596fcabcae1531e0aadc64256::leverage_obligation::ensure_coins_match<T1, T2>(arg3);
        0x273468dc036f1b797a1c8b04c5d6aefcdd5c2befd94160c2f1078ce9c7813420::deposit::deposit<T0, T1>(arg0, arg1, 0x44621169b24fb8bbb238726a47e79ddabe9669d596fcabcae1531e0aadc64256::leverage_obligation::market_obligation(arg3), arg5, arg9, arg10);
        0x44621169b24fb8bbb238726a47e79ddabe9669d596fcabcae1531e0aadc64256::leverage_repay::complete_leverage<T0, T2>(arg0, arg1, arg2, arg3, arg4, arg6, 0x273468dc036f1b797a1c8b04c5d6aefcdd5c2befd94160c2f1078ce9c7813420::borrow::borrow<T0, T2>(arg0, 0x44621169b24fb8bbb238726a47e79ddabe9669d596fcabcae1531e0aadc64256::leverage_obligation::market_obligation(arg3), arg1, arg7, 0x273468dc036f1b797a1c8b04c5d6aefcdd5c2befd94160c2f1078ce9c7813420::market::fee<T0, T2>(0x44621169b24fb8bbb238726a47e79ddabe9669d596fcabcae1531e0aadc64256::leverage_repay::flash_loan<T0, T2>(&arg4)) + 0x273468dc036f1b797a1c8b04c5d6aefcdd5c2befd94160c2f1078ce9c7813420::market::loan_amount<T0, T2>(0x44621169b24fb8bbb238726a47e79ddabe9669d596fcabcae1531e0aadc64256::leverage_repay::flash_loan<T0, T2>(&arg4)), arg8, arg9, arg10), arg8, arg9, arg7, arg10)
    }

    public fun request_leverage<T0, T1, T2>(arg0: &0x273468dc036f1b797a1c8b04c5d6aefcdd5c2befd94160c2f1078ce9c7813420::app::ProtocolApp, arg1: &0x44621169b24fb8bbb238726a47e79ddabe9669d596fcabcae1531e0aadc64256::leverage_app::LeverageApp, arg2: &mut 0x273468dc036f1b797a1c8b04c5d6aefcdd5c2befd94160c2f1078ce9c7813420::market::Market<T0>, arg3: &mut 0x44621169b24fb8bbb238726a47e79ddabe9669d596fcabcae1531e0aadc64256::leverage_market::LeverageMarket, arg4: &mut 0x44621169b24fb8bbb238726a47e79ddabe9669d596fcabcae1531e0aadc64256::leverage_obligation::LeverageMarketOwnerCap, arg5: 0x2::coin::Coin<T2>, arg6: u64, arg7: &0xf04916dd9886f2404e7ab846fb3e7ef6134ea06d242f86c33192a7e4877e42c4::x_oracle::XOracle, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : (0x44621169b24fb8bbb238726a47e79ddabe9669d596fcabcae1531e0aadc64256::leverage_repay::LeverageHotPotato<T0, T2>, 0x2::coin::Coin<T2>) {
        0x44621169b24fb8bbb238726a47e79ddabe9669d596fcabcae1531e0aadc64256::leverage_app::ensure_version_matches(arg1);
        0x44621169b24fb8bbb238726a47e79ddabe9669d596fcabcae1531e0aadc64256::leverage_market::ensure_no_leverage_on_going(arg3);
        0x44621169b24fb8bbb238726a47e79ddabe9669d596fcabcae1531e0aadc64256::leverage_market::mark_leverage_ongoing(arg3);
        0x44621169b24fb8bbb238726a47e79ddabe9669d596fcabcae1531e0aadc64256::leverage_market::ensure_supporting_market<T0>(arg3, arg2);
        0x44621169b24fb8bbb238726a47e79ddabe9669d596fcabcae1531e0aadc64256::leverage_obligation::ensure_same_market<T0>(arg4);
        0x44621169b24fb8bbb238726a47e79ddabe9669d596fcabcae1531e0aadc64256::leverage_obligation::ensure_same_emode(arg4, 0x44621169b24fb8bbb238726a47e79ddabe9669d596fcabcae1531e0aadc64256::leverage_market::emode_group(arg3));
        0x44621169b24fb8bbb238726a47e79ddabe9669d596fcabcae1531e0aadc64256::leverage_obligation::set_or_check_position<T1, T2>(arg4, 0x44621169b24fb8bbb238726a47e79ddabe9669d596fcabcae1531e0aadc64256::leverage_obligation::swap_borrow());
        let v0 = NewSwapBorrowEvent{
            leverage_owner_cap  : 0x44621169b24fb8bbb238726a47e79ddabe9669d596fcabcae1531e0aadc64256::leverage_obligation::id(arg4),
            operation           : 0x44621169b24fb8bbb238726a47e79ddabe9669d596fcabcae1531e0aadc64256::leverage_obligation::swap_borrow(),
            collateral          : 0x1::type_name::with_defining_ids<T1>(),
            debt                : 0x1::type_name::with_defining_ids<T2>(),
            initial_debt_amount : 0x2::coin::value<T2>(&arg5),
            collateral_price    : 0x44621169b24fb8bbb238726a47e79ddabe9669d596fcabcae1531e0aadc64256::leverage_obligation::get_collateral_price<T1, T2>(arg7, arg8),
        };
        0x2::event::emit<NewSwapBorrowEvent>(v0);
        let (v1, v2) = 0x273468dc036f1b797a1c8b04c5d6aefcdd5c2befd94160c2f1078ce9c7813420::flash_loan::borrow_flash_loan<T0, T2>(arg0, 0x44621169b24fb8bbb238726a47e79ddabe9669d596fcabcae1531e0aadc64256::leverage_app::borrow_protocol_caller_cap(arg1), arg2, 0x44621169b24fb8bbb238726a47e79ddabe9669d596fcabcae1531e0aadc64256::leverage_market::emode_group(arg3), arg6 - 0x2::coin::value<T2>(&arg5), arg9);
        let v3 = v1;
        0x2::coin::join<T2>(&mut v3, arg5);
        assert!(0x2::coin::value<T2>(&v3) == arg6, 0x44621169b24fb8bbb238726a47e79ddabe9669d596fcabcae1531e0aadc64256::leverage_error::inconsistent_total_leverage_value());
        (0x44621169b24fb8bbb238726a47e79ddabe9669d596fcabcae1531e0aadc64256::leverage_repay::new_leverage_hot_potato<T0, T2>(v2), v3)
    }

    // decompiled from Move bytecode v6
}

