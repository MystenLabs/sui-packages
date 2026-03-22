module 0x44621169b24fb8bbb238726a47e79ddabe9669d596fcabcae1531e0aadc64256::leverage_reduce_to_collateral_coin {
    public fun withdraw_leverage<T0, T1, T2>(arg0: &0x44621169b24fb8bbb238726a47e79ddabe9669d596fcabcae1531e0aadc64256::leverage_app::LeverageApp, arg1: &0x273468dc036f1b797a1c8b04c5d6aefcdd5c2befd94160c2f1078ce9c7813420::app::ProtocolApp, arg2: &mut 0x273468dc036f1b797a1c8b04c5d6aefcdd5c2befd94160c2f1078ce9c7813420::market::Market<T0>, arg3: &0x44621169b24fb8bbb238726a47e79ddabe9669d596fcabcae1531e0aadc64256::leverage_obligation::LeverageMarketOwnerCap, arg4: u64, arg5: &0xf04916dd9886f2404e7ab846fb3e7ef6134ea06d242f86c33192a7e4877e42c4::x_oracle::XOracle, arg6: &0x2::clock::Clock, arg7: &0x273468dc036f1b797a1c8b04c5d6aefcdd5c2befd94160c2f1078ce9c7813420::coin_decimals_registry::CoinDecimalsRegistry, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x44621169b24fb8bbb238726a47e79ddabe9669d596fcabcae1531e0aadc64256::leverage_app::ensure_version_matches(arg0);
        0x44621169b24fb8bbb238726a47e79ddabe9669d596fcabcae1531e0aadc64256::leverage_obligation::ensure_same_market<T0>(arg3);
        0x44621169b24fb8bbb238726a47e79ddabe9669d596fcabcae1531e0aadc64256::leverage_obligation::ensure_coins_match<T1, T2>(arg3);
        let v0 = 0x273468dc036f1b797a1c8b04c5d6aefcdd5c2befd94160c2f1078ce9c7813420::withdraw::withdraw_as_coin<T0, T1>(arg1, arg2, 0x44621169b24fb8bbb238726a47e79ddabe9669d596fcabcae1531e0aadc64256::leverage_obligation::market_obligation(arg3), arg7, 0x44621169b24fb8bbb238726a47e79ddabe9669d596fcabcae1531e0aadc64256::leverage_reduce_to_borrow_coin::enforce_ctoken_deduciton<T0, T1>(arg2, arg3, arg4), arg5, arg6, arg8);
        0x44621169b24fb8bbb238726a47e79ddabe9669d596fcabcae1531e0aadc64256::leverage_reduce_to_borrow_coin::emit_reduce_leverage_event(0x44621169b24fb8bbb238726a47e79ddabe9669d596fcabcae1531e0aadc64256::leverage_obligation::id(arg3), 0x2::coin::value<T1>(&v0), 0, 0x44621169b24fb8bbb238726a47e79ddabe9669d596fcabcae1531e0aadc64256::leverage_obligation::get_collateral_price<T1, T2>(arg5, arg6));
        v0
    }

    public fun withdraw_size<T0, T1, T2>(arg0: &0x44621169b24fb8bbb238726a47e79ddabe9669d596fcabcae1531e0aadc64256::leverage_app::LeverageApp, arg1: &0x273468dc036f1b797a1c8b04c5d6aefcdd5c2befd94160c2f1078ce9c7813420::app::ProtocolApp, arg2: &mut 0x273468dc036f1b797a1c8b04c5d6aefcdd5c2befd94160c2f1078ce9c7813420::market::Market<T0>, arg3: &0x44621169b24fb8bbb238726a47e79ddabe9669d596fcabcae1531e0aadc64256::leverage_obligation::LeverageMarketOwnerCap, arg4: u8, arg5: &0xf04916dd9886f2404e7ab846fb3e7ef6134ea06d242f86c33192a7e4877e42c4::x_oracle::XOracle, arg6: &0x2::clock::Clock, arg7: &0x273468dc036f1b797a1c8b04c5d6aefcdd5c2befd94160c2f1078ce9c7813420::coin_decimals_registry::CoinDecimalsRegistry, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x44621169b24fb8bbb238726a47e79ddabe9669d596fcabcae1531e0aadc64256::leverage_app::ensure_version_matches(arg0);
        0x44621169b24fb8bbb238726a47e79ddabe9669d596fcabcae1531e0aadc64256::leverage_obligation::ensure_same_market<T0>(arg3);
        0x44621169b24fb8bbb238726a47e79ddabe9669d596fcabcae1531e0aadc64256::leverage_obligation::ensure_coins_match<T1, T2>(arg3);
        let (v0, _) = 0x44621169b24fb8bbb238726a47e79ddabe9669d596fcabcae1531e0aadc64256::leverage_reduce_to_borrow_coin::enforce_collateral_deduciton_by_percentage<T0, T1>(arg2, arg3, arg4);
        let v2 = 0x273468dc036f1b797a1c8b04c5d6aefcdd5c2befd94160c2f1078ce9c7813420::withdraw::withdraw_as_coin<T0, T1>(arg1, arg2, 0x44621169b24fb8bbb238726a47e79ddabe9669d596fcabcae1531e0aadc64256::leverage_obligation::market_obligation(arg3), arg7, v0, arg5, arg6, arg8);
        0x44621169b24fb8bbb238726a47e79ddabe9669d596fcabcae1531e0aadc64256::leverage_reduce_to_borrow_coin::emit_reduce_size_event(0x44621169b24fb8bbb238726a47e79ddabe9669d596fcabcae1531e0aadc64256::leverage_obligation::id(arg3), 0x2::coin::value<T1>(&v2), 0, 0x44621169b24fb8bbb238726a47e79ddabe9669d596fcabcae1531e0aadc64256::leverage_obligation::get_collateral_price<T1, T2>(arg5, arg6));
        v2
    }

    // decompiled from Move bytecode v6
}

