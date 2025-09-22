module 0xfda02f84ccbe621eb0149ac6eb339dc48eba7685296a8556d07f7a8fe28b3274::leverage_reduce_to_collateral_coin {
    public fun withdraw_leverage<T0, T1, T2>(arg0: &mut 0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::market::Market<T0>, arg1: &mut 0xfda02f84ccbe621eb0149ac6eb339dc48eba7685296a8556d07f7a8fe28b3274::leverage_obligation::LeverageMarketOwnerCap, arg2: u64, arg3: &0xab8e9e4b2dd1bbcd4ed7115625b45e580ea871551a95a15d344e674d5410acea::x_oracle::XOracle, arg4: &0x2::clock::Clock, arg5: &0xcfa25712c883ea080ae7cbd067998a134eee2e39cfbcbc4b6b29674117a021ee::coin_decimals_registry::CoinDecimalsRegistry, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0xfda02f84ccbe621eb0149ac6eb339dc48eba7685296a8556d07f7a8fe28b3274::leverage_obligation::ensure_coins_match<T1, T2>(arg1);
        0xfda02f84ccbe621eb0149ac6eb339dc48eba7685296a8556d07f7a8fe28b3274::leverage_reduce_to_borrow_coin::emit_reduce_leverage_event(0xfda02f84ccbe621eb0149ac6eb339dc48eba7685296a8556d07f7a8fe28b3274::leverage_obligation::id(arg1), arg2, 0);
        0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::withdraw::withdraw_as_coin<T0, T1>(arg0, 0xfda02f84ccbe621eb0149ac6eb339dc48eba7685296a8556d07f7a8fe28b3274::leverage_obligation::market_obligation(arg1), arg5, 0xfda02f84ccbe621eb0149ac6eb339dc48eba7685296a8556d07f7a8fe28b3274::leverage_reduce_to_borrow_coin::enforce_ctoken_deduciton<T0, T1>(arg0, arg1, arg2), arg3, arg4, arg6)
    }

    public fun withdraw_size<T0, T1, T2>(arg0: &mut 0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::market::Market<T0>, arg1: &mut 0xfda02f84ccbe621eb0149ac6eb339dc48eba7685296a8556d07f7a8fe28b3274::leverage_obligation::LeverageMarketOwnerCap, arg2: u8, arg3: &0xab8e9e4b2dd1bbcd4ed7115625b45e580ea871551a95a15d344e674d5410acea::x_oracle::XOracle, arg4: &0x2::clock::Clock, arg5: &0xcfa25712c883ea080ae7cbd067998a134eee2e39cfbcbc4b6b29674117a021ee::coin_decimals_registry::CoinDecimalsRegistry, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0xfda02f84ccbe621eb0149ac6eb339dc48eba7685296a8556d07f7a8fe28b3274::leverage_obligation::ensure_coins_match<T1, T2>(arg1);
        let (v0, v1, v2) = 0xfda02f84ccbe621eb0149ac6eb339dc48eba7685296a8556d07f7a8fe28b3274::leverage_reduce_to_borrow_coin::enforce_collateral_deduciton_by_percentage<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4);
        0xfda02f84ccbe621eb0149ac6eb339dc48eba7685296a8556d07f7a8fe28b3274::leverage_reduce_to_borrow_coin::emit_reduce_size_event(0xfda02f84ccbe621eb0149ac6eb339dc48eba7685296a8556d07f7a8fe28b3274::leverage_obligation::id(arg1), v1, v2, 0);
        0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::withdraw::withdraw_as_coin<T0, T1>(arg0, 0xfda02f84ccbe621eb0149ac6eb339dc48eba7685296a8556d07f7a8fe28b3274::leverage_obligation::market_obligation(arg1), arg5, v0, arg3, arg4, arg6)
    }

    // decompiled from Move bytecode v6
}

