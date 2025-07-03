module 0x850410002b9f31b254398b9f31104f62ab8f7f60619c897ef9f85244bdae6137::atomic_arbitrage {
    public entry fun arb_aftermath_bluefin<T0>(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut 0x850410002b9f31b254398b9f31104f62ab8f7f60619c897ef9f85244bdae6137::dex_aftermath::Pool<0x2::sui::SUI, T0>, arg2: &mut 0x850410002b9f31b254398b9f31104f62ab8f7f60619c897ef9f85244bdae6137::dex_bluefin::Pool<T0, 0x2::sui::SUI>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x850410002b9f31b254398b9f31104f62ab8f7f60619c897ef9f85244bdae6137::dex_bluefin::swap_exact_base_for_quote<T0, 0x2::sui::SUI>(arg2, 0x850410002b9f31b254398b9f31104f62ab8f7f60619c897ef9f85244bdae6137::dex_aftermath::swap_exact_base_for_quote<0x2::sui::SUI, T0>(arg1, arg0, arg3, arg5, arg6), arg4, arg5, arg6), 0x2::tx_context::sender(arg6));
    }

    public entry fun arb_bluefin_kriya<T0>(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut 0x850410002b9f31b254398b9f31104f62ab8f7f60619c897ef9f85244bdae6137::dex_bluefin::Pool<0x2::sui::SUI, T0>, arg2: &mut 0x850410002b9f31b254398b9f31104f62ab8f7f60619c897ef9f85244bdae6137::dex_kriya::Pool<T0, 0x2::sui::SUI>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x850410002b9f31b254398b9f31104f62ab8f7f60619c897ef9f85244bdae6137::dex_kriya::swap_token_x_for_token_y<T0, 0x2::sui::SUI>(arg2, 0x850410002b9f31b254398b9f31104f62ab8f7f60619c897ef9f85244bdae6137::dex_bluefin::swap_exact_base_for_quote<0x2::sui::SUI, T0>(arg1, arg0, arg3, arg5, arg6), arg4, arg5, arg6), 0x2::tx_context::sender(arg6));
    }

    public entry fun arb_kriya_aftermath<T0>(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut 0x850410002b9f31b254398b9f31104f62ab8f7f60619c897ef9f85244bdae6137::dex_kriya::Pool<0x2::sui::SUI, T0>, arg2: &mut 0x850410002b9f31b254398b9f31104f62ab8f7f60619c897ef9f85244bdae6137::dex_aftermath::Pool<T0, 0x2::sui::SUI>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x850410002b9f31b254398b9f31104f62ab8f7f60619c897ef9f85244bdae6137::dex_aftermath::swap_exact_base_for_quote<T0, 0x2::sui::SUI>(arg2, 0x850410002b9f31b254398b9f31104f62ab8f7f60619c897ef9f85244bdae6137::dex_kriya::swap_token_x_for_token_y<0x2::sui::SUI, T0>(arg1, arg0, arg3, arg5, arg6), arg4, arg5, arg6), 0x2::tx_context::sender(arg6));
    }

    public entry fun arb_turbos_deepbook<T0>(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut 0x850410002b9f31b254398b9f31104f62ab8f7f60619c897ef9f85244bdae6137::dex_turbos::Pool<0x2::sui::SUI, T0>, arg2: &mut 0x850410002b9f31b254398b9f31104f62ab8f7f60619c897ef9f85244bdae6137::dex_deepbook::Pool<T0, 0x2::sui::SUI>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x850410002b9f31b254398b9f31104f62ab8f7f60619c897ef9f85244bdae6137::dex_deepbook::swap_exact_base_for_quote<T0, 0x2::sui::SUI>(arg2, 0x850410002b9f31b254398b9f31104f62ab8f7f60619c897ef9f85244bdae6137::dex_turbos::swap_a_b<0x2::sui::SUI, T0>(arg1, arg0, arg3, arg5, arg6), arg4, arg5, arg6), 0x2::tx_context::sender(arg6));
    }

    fun calculate_min_profitable_output_with_gas(arg0: u64) : u64 {
        arg0 + 1000000 + arg0 * 10 / 10000
    }

    public fun verify_swap_profitability(arg0: u64, arg1: u64, arg2: u64) : bool {
        arg1 >= calculate_min_profitable_output_with_gas(arg0)
    }

    // decompiled from Move bytecode v6
}

