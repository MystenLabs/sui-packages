module 0x7543ae0745cfbf6129a16b08f3909b21a1d2318859543be6454f7b87845f91cc::market_gen {
    public entry fun createMarket<T0: store + key, T1>(arg0: &0x7543ae0745cfbf6129a16b08f3909b21a1d2318859543be6454f7b87845f91cc::market::MarketAdminCap, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: bool, arg8: 0x1::option::Option<u16>, arg9: 0x1::option::Option<u16>, arg10: &0x7543ae0745cfbf6129a16b08f3909b21a1d2318859543be6454f7b87845f91cc::version::Version, arg11: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_share_object<0x7543ae0745cfbf6129a16b08f3909b21a1d2318859543be6454f7b87845f91cc::market::Market>(0x7543ae0745cfbf6129a16b08f3909b21a1d2318859543be6454f7b87845f91cc::market::createMarket<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11));
    }

    public entry fun sweep<T0: store + key, T1>(arg0: &mut 0x7543ae0745cfbf6129a16b08f3909b21a1d2318859543be6454f7b87845f91cc::market::Market, arg1: vector<u128>, arg2: &mut 0x2::coin::Coin<T1>, arg3: &0x2::clock::Clock, arg4: &0x7543ae0745cfbf6129a16b08f3909b21a1d2318859543be6454f7b87845f91cc::version::Version, arg5: &mut 0x2::tx_context::TxContext) {
        0x7543ae0745cfbf6129a16b08f3909b21a1d2318859543be6454f7b87845f91cc::market::sweep<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun buyCross<T0: store + key, T1>(arg0: &mut 0x7543ae0745cfbf6129a16b08f3909b21a1d2318859543be6454f7b87845f91cc::market::Market, arg1: 0x2::coin::Coin<T1>, arg2: u128, arg3: &0x2::clock::Clock, arg4: &0x7543ae0745cfbf6129a16b08f3909b21a1d2318859543be6454f7b87845f91cc::version::Version, arg5: &mut 0x2::tx_context::TxContext) {
        0x7543ae0745cfbf6129a16b08f3909b21a1d2318859543be6454f7b87845f91cc::market::buy_cross<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun buyLimit<T0: store + key, T1>(arg0: &mut 0x7543ae0745cfbf6129a16b08f3909b21a1d2318859543be6454f7b87845f91cc::market::Market, arg1: 0x2::coin::Coin<T1>, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0x7543ae0745cfbf6129a16b08f3909b21a1d2318859543be6454f7b87845f91cc::version::Version, arg6: &mut 0x2::tx_context::TxContext) {
        0x7543ae0745cfbf6129a16b08f3909b21a1d2318859543be6454f7b87845f91cc::market::buy_limit<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public entry fun buyMarket<T0: store + key, T1>(arg0: &mut 0x7543ae0745cfbf6129a16b08f3909b21a1d2318859543be6454f7b87845f91cc::market::Market, arg1: 0x2::coin::Coin<T1>, arg2: &0x2::clock::Clock, arg3: &0x7543ae0745cfbf6129a16b08f3909b21a1d2318859543be6454f7b87845f91cc::version::Version, arg4: &mut 0x2::tx_context::TxContext) {
        0x7543ae0745cfbf6129a16b08f3909b21a1d2318859543be6454f7b87845f91cc::market::buy_flash<T0, T1>(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun cancelBuy<T0: store + key, T1>(arg0: &mut 0x7543ae0745cfbf6129a16b08f3909b21a1d2318859543be6454f7b87845f91cc::market::Market, arg1: vector<u128>, arg2: &0x7543ae0745cfbf6129a16b08f3909b21a1d2318859543be6454f7b87845f91cc::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0x7543ae0745cfbf6129a16b08f3909b21a1d2318859543be6454f7b87845f91cc::market::cancel_buy<T0, T1>(arg0, arg1, arg2, arg3);
    }

    public entry fun cancelSell<T0: store + key, T1>(arg0: &mut 0x7543ae0745cfbf6129a16b08f3909b21a1d2318859543be6454f7b87845f91cc::market::Market, arg1: vector<u128>, arg2: &0x7543ae0745cfbf6129a16b08f3909b21a1d2318859543be6454f7b87845f91cc::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0x7543ae0745cfbf6129a16b08f3909b21a1d2318859543be6454f7b87845f91cc::market::cancel_sell<T0, T1>(arg0, arg1, arg2, arg3);
    }

    public entry fun sellLimit<T0: store + key, T1>(arg0: &mut 0x7543ae0745cfbf6129a16b08f3909b21a1d2318859543be6454f7b87845f91cc::market::Market, arg1: T0, arg2: u64, arg3: &0x2::clock::Clock, arg4: u64, arg5: &0x7543ae0745cfbf6129a16b08f3909b21a1d2318859543be6454f7b87845f91cc::version::Version, arg6: &mut 0x2::tx_context::TxContext) {
        0x7543ae0745cfbf6129a16b08f3909b21a1d2318859543be6454f7b87845f91cc::market::sell_limit<T0, T1>(arg0, arg1, arg2, arg4, arg3, arg5, arg6);
    }

    public entry fun sellMarket<T0: store + key, T1>(arg0: &mut 0x7543ae0745cfbf6129a16b08f3909b21a1d2318859543be6454f7b87845f91cc::market::Market, arg1: T0, arg2: &0x2::clock::Clock, arg3: &0x7543ae0745cfbf6129a16b08f3909b21a1d2318859543be6454f7b87845f91cc::version::Version, arg4: &mut 0x2::tx_context::TxContext) {
        0x7543ae0745cfbf6129a16b08f3909b21a1d2318859543be6454f7b87845f91cc::market::sell_flash<T0, T1>(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun withdrawFeeMarket<T0: store + key, T1>(arg0: &0x7543ae0745cfbf6129a16b08f3909b21a1d2318859543be6454f7b87845f91cc::market::MarketTreasureCap, arg1: &mut 0x7543ae0745cfbf6129a16b08f3909b21a1d2318859543be6454f7b87845f91cc::market::Market, arg2: &0x7543ae0745cfbf6129a16b08f3909b21a1d2318859543be6454f7b87845f91cc::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x7543ae0745cfbf6129a16b08f3909b21a1d2318859543be6454f7b87845f91cc::market::withdraw_fee<T0, T1>(arg0, arg1, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun withdrawRoyalFeeMarket<T0: store + key, T1>(arg0: &0x2::package::Publisher, arg1: &mut 0x7543ae0745cfbf6129a16b08f3909b21a1d2318859543be6454f7b87845f91cc::market::Market, arg2: &0x7543ae0745cfbf6129a16b08f3909b21a1d2318859543be6454f7b87845f91cc::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x7543ae0745cfbf6129a16b08f3909b21a1d2318859543be6454f7b87845f91cc::market::withdraw_royal_fee<T0, T1>(arg0, arg1, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

