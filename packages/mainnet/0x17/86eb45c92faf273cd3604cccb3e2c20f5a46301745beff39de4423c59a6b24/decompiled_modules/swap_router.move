module 0x1786eb45c92faf273cd3604cccb3e2c20f5a46301745beff39de4423c59a6b24::swap_router {
    public fun swap_exact_x_to_y<T0>(arg0: &mut 0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::universal_router::Route, arg1: &0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::meme::MemeConfig, arg2: &mut 0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::meme::BondingCurve<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::universal_router::borrow_mut_current_path<T0, 0x2::sui::SUI>(arg0);
        0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::universal_router::fill_coin_out<T0, 0x2::sui::SUI>(v0, 0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::meme::sell_returns<T0>(arg2, arg1, 0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::universal_router::take_coin_in<T0, 0x2::sui::SUI>(v0), 0, arg3));
    }

    public fun swap_exact_y_to_x<T0>(arg0: &mut 0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::universal_router::Route, arg1: &0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::meme::MemeConfig, arg2: &mut 0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::meme::BondingCurve<T0>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::universal_router::borrow_mut_current_path<0x2::sui::SUI, T0>(arg0);
        let (v1, v2) = 0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::meme::buy_returns<T0>(arg2, arg1, 0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::universal_router::take_coin_in<0x2::sui::SUI, T0>(v0), arg3, 0, 0x2::tx_context::sender(arg4), arg4);
        0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::utils::refund_if_necessary<0x2::sui::SUI>(v1, 0x2::tx_context::sender(arg4));
        0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::universal_router::fill_coin_out<0x2::sui::SUI, T0>(v0, v2);
    }

    // decompiled from Move bytecode v6
}

