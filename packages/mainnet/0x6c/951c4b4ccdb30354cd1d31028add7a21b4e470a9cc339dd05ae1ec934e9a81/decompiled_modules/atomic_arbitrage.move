module 0x6c951c4b4ccdb30354cd1d31028add7a21b4e470a9cc339dd05ae1ec934e9a81::atomic_arbitrage {
    public entry fun arb_aftermath_bluefin<T0>(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut 0x6c951c4b4ccdb30354cd1d31028add7a21b4e470a9cc339dd05ae1ec934e9a81::dex_aftermath::Pool<0x2::sui::SUI, T0>, arg2: &mut 0x6c951c4b4ccdb30354cd1d31028add7a21b4e470a9cc339dd05ae1ec934e9a81::dex_bluefin::Pool<T0, 0x2::sui::SUI>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x6c951c4b4ccdb30354cd1d31028add7a21b4e470a9cc339dd05ae1ec934e9a81::dex_bluefin::swap_exact_base_for_quote<T0, 0x2::sui::SUI>(arg2, 0x6c951c4b4ccdb30354cd1d31028add7a21b4e470a9cc339dd05ae1ec934e9a81::dex_aftermath::swap_exact_base_for_quote<0x2::sui::SUI, T0>(arg1, arg0, arg3, arg5, arg6), arg4, arg5, arg6), 0x2::tx_context::sender(arg6));
    }

    public entry fun arb_bluefin_kriya<T0>(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut 0x6c951c4b4ccdb30354cd1d31028add7a21b4e470a9cc339dd05ae1ec934e9a81::dex_bluefin::Pool<0x2::sui::SUI, T0>, arg2: &mut 0x6c951c4b4ccdb30354cd1d31028add7a21b4e470a9cc339dd05ae1ec934e9a81::dex_kriya::Pool<T0, 0x2::sui::SUI>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x6c951c4b4ccdb30354cd1d31028add7a21b4e470a9cc339dd05ae1ec934e9a81::dex_kriya::swap_token_x_for_token_y<T0, 0x2::sui::SUI>(arg2, 0x6c951c4b4ccdb30354cd1d31028add7a21b4e470a9cc339dd05ae1ec934e9a81::dex_bluefin::swap_exact_base_for_quote<0x2::sui::SUI, T0>(arg1, arg0, arg3, arg5, arg6), arg4, arg5, arg6), 0x2::tx_context::sender(arg6));
    }

    public entry fun arb_kriya_aftermath<T0>(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut 0x6c951c4b4ccdb30354cd1d31028add7a21b4e470a9cc339dd05ae1ec934e9a81::dex_kriya::Pool<0x2::sui::SUI, T0>, arg2: &mut 0x6c951c4b4ccdb30354cd1d31028add7a21b4e470a9cc339dd05ae1ec934e9a81::dex_aftermath::Pool<T0, 0x2::sui::SUI>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x6c951c4b4ccdb30354cd1d31028add7a21b4e470a9cc339dd05ae1ec934e9a81::dex_aftermath::swap_exact_base_for_quote<T0, 0x2::sui::SUI>(arg2, 0x6c951c4b4ccdb30354cd1d31028add7a21b4e470a9cc339dd05ae1ec934e9a81::dex_kriya::swap_token_x_for_token_y<0x2::sui::SUI, T0>(arg1, arg0, arg3, arg5, arg6), arg4, arg5, arg6), 0x2::tx_context::sender(arg6));
    }

    fun calculate_min_profitable_output_with_gas(arg0: u64) : u64 {
        arg0 + 1000000 + arg0 * 10 / 10000
    }

    public fun verify_swap_profitability(arg0: u64, arg1: u64, arg2: u64) : bool {
        arg1 >= calculate_min_profitable_output_with_gas(arg0)
    }

    // decompiled from Move bytecode v6
}

