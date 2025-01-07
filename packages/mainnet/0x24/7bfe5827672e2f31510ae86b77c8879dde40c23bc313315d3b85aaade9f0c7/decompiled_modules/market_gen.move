module 0x247bfe5827672e2f31510ae86b77c8879dde40c23bc313315d3b85aaade9f0c7::market_gen {
    public entry fun sweep<T0: store + key, T1>(arg0: &mut 0x247bfe5827672e2f31510ae86b77c8879dde40c23bc313315d3b85aaade9f0c7::market::Market, arg1: &mut 0x247bfe5827672e2f31510ae86b77c8879dde40c23bc313315d3b85aaade9f0c7::payment_policy::PolicyVault<T0>, arg2: vector<u128>, arg3: &mut 0x2::coin::Coin<T1>, arg4: &0x2::clock::Clock, arg5: &0x247bfe5827672e2f31510ae86b77c8879dde40c23bc313315d3b85aaade9f0c7::version::Version, arg6: &mut 0x2::tx_context::TxContext) {
        0x247bfe5827672e2f31510ae86b77c8879dde40c23bc313315d3b85aaade9f0c7::market::sweep<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public entry fun buyCross<T0: store + key, T1>(arg0: &mut 0x247bfe5827672e2f31510ae86b77c8879dde40c23bc313315d3b85aaade9f0c7::market::Market, arg1: &mut 0x247bfe5827672e2f31510ae86b77c8879dde40c23bc313315d3b85aaade9f0c7::payment_policy::PolicyVault<T0>, arg2: 0x2::coin::Coin<T1>, arg3: u128, arg4: &0x2::clock::Clock, arg5: &0x247bfe5827672e2f31510ae86b77c8879dde40c23bc313315d3b85aaade9f0c7::version::Version, arg6: &mut 0x2::tx_context::TxContext) {
        0x247bfe5827672e2f31510ae86b77c8879dde40c23bc313315d3b85aaade9f0c7::market::buy_cross<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public entry fun buyLimit<T0: store + key, T1>(arg0: &mut 0x247bfe5827672e2f31510ae86b77c8879dde40c23bc313315d3b85aaade9f0c7::market::Market, arg1: &mut 0x247bfe5827672e2f31510ae86b77c8879dde40c23bc313315d3b85aaade9f0c7::payment_policy::PolicyVault<T0>, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &0x247bfe5827672e2f31510ae86b77c8879dde40c23bc313315d3b85aaade9f0c7::version::Version, arg7: &mut 0x2::tx_context::TxContext) {
        0x247bfe5827672e2f31510ae86b77c8879dde40c23bc313315d3b85aaade9f0c7::market::buy_limit<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    public entry fun buyMarket<T0: store + key, T1>(arg0: &mut 0x247bfe5827672e2f31510ae86b77c8879dde40c23bc313315d3b85aaade9f0c7::market::Market, arg1: &mut 0x247bfe5827672e2f31510ae86b77c8879dde40c23bc313315d3b85aaade9f0c7::payment_policy::PolicyVault<T0>, arg2: 0x2::coin::Coin<T1>, arg3: &0x2::clock::Clock, arg4: &0x247bfe5827672e2f31510ae86b77c8879dde40c23bc313315d3b85aaade9f0c7::version::Version, arg5: &mut 0x2::tx_context::TxContext) {
        0x247bfe5827672e2f31510ae86b77c8879dde40c23bc313315d3b85aaade9f0c7::market::buy_flash<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun cancelBuy<T0: store + key, T1>(arg0: &mut 0x247bfe5827672e2f31510ae86b77c8879dde40c23bc313315d3b85aaade9f0c7::market::Market, arg1: vector<u128>, arg2: &0x247bfe5827672e2f31510ae86b77c8879dde40c23bc313315d3b85aaade9f0c7::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0x247bfe5827672e2f31510ae86b77c8879dde40c23bc313315d3b85aaade9f0c7::market::cancel_buy<T0, T1>(arg0, arg1, arg2, arg3);
    }

    public entry fun cancelSell<T0: store + key, T1>(arg0: &mut 0x247bfe5827672e2f31510ae86b77c8879dde40c23bc313315d3b85aaade9f0c7::market::Market, arg1: vector<u128>, arg2: &0x247bfe5827672e2f31510ae86b77c8879dde40c23bc313315d3b85aaade9f0c7::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0x247bfe5827672e2f31510ae86b77c8879dde40c23bc313315d3b85aaade9f0c7::market::cancel_sell<T0, T1>(arg0, arg1, arg2, arg3);
    }

    public entry fun sellLimit<T0: store + key, T1>(arg0: &mut 0x247bfe5827672e2f31510ae86b77c8879dde40c23bc313315d3b85aaade9f0c7::market::Market, arg1: &mut 0x247bfe5827672e2f31510ae86b77c8879dde40c23bc313315d3b85aaade9f0c7::payment_policy::PolicyVault<T0>, arg2: T0, arg3: u64, arg4: &0x2::clock::Clock, arg5: u64, arg6: &0x247bfe5827672e2f31510ae86b77c8879dde40c23bc313315d3b85aaade9f0c7::version::Version, arg7: &mut 0x2::tx_context::TxContext) {
        0x247bfe5827672e2f31510ae86b77c8879dde40c23bc313315d3b85aaade9f0c7::market::sell_limit<T0, T1>(arg0, arg1, arg2, arg3, arg5, arg4, arg6, arg7);
    }

    public entry fun sellMarket<T0: store + key, T1>(arg0: &mut 0x247bfe5827672e2f31510ae86b77c8879dde40c23bc313315d3b85aaade9f0c7::market::Market, arg1: &mut 0x247bfe5827672e2f31510ae86b77c8879dde40c23bc313315d3b85aaade9f0c7::payment_policy::PolicyVault<T0>, arg2: T0, arg3: &0x2::clock::Clock, arg4: &0x247bfe5827672e2f31510ae86b77c8879dde40c23bc313315d3b85aaade9f0c7::version::Version, arg5: &mut 0x2::tx_context::TxContext) {
        0x247bfe5827672e2f31510ae86b77c8879dde40c23bc313315d3b85aaade9f0c7::market::sell_flash<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun withdrawFeeMarket<T0: store + key, T1>(arg0: &0x247bfe5827672e2f31510ae86b77c8879dde40c23bc313315d3b85aaade9f0c7::market::MarketTreasureCap, arg1: &mut 0x247bfe5827672e2f31510ae86b77c8879dde40c23bc313315d3b85aaade9f0c7::market::Market, arg2: &0x247bfe5827672e2f31510ae86b77c8879dde40c23bc313315d3b85aaade9f0c7::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x247bfe5827672e2f31510ae86b77c8879dde40c23bc313315d3b85aaade9f0c7::market::withdraw_fee<T0, T1>(arg0, arg1, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun withdrawFeeRoyal<T0: store + key, T1>(arg0: &0x247bfe5827672e2f31510ae86b77c8879dde40c23bc313315d3b85aaade9f0c7::payment_policy::PolicyVaultCap, arg1: &mut 0x247bfe5827672e2f31510ae86b77c8879dde40c23bc313315d3b85aaade9f0c7::payment_policy::PolicyVault<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x247bfe5827672e2f31510ae86b77c8879dde40c23bc313315d3b85aaade9f0c7::payment_policy::withdrawRoyalFeeCoin<T0, T1>(arg0, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

