module 0x2c11fdd0054a57de9339af40966ffacfb763d4fff9527e5f4ffea92b8ecfa7ce::orderbook_v2 {
    public fun swap<T0, T1>(arg0: &mut 0x422e3239f174320760dd675ba3835cf4b1c511be4a36e819cb61fab7d5d404a::router::SwapContext, arg1: &0x3257f7f5bdbc239f102a39375bfd10691067fbe74e01d97297725c0ea51b2133::versioned::Versioned, arg2: &0x3257f7f5bdbc239f102a39375bfd10691067fbe74e01d97297725c0ea51b2133::config::GlobalConfig, arg3: &0x3257f7f5bdbc239f102a39375bfd10691067fbe74e01d97297725c0ea51b2133::market_maker::MarketMaker, arg4: &mut 0x3257f7f5bdbc239f102a39375bfd10691067fbe74e01d97297725c0ea51b2133::orderbook_v2::Pool<T0, T1>, arg5: vector<u8>, arg6: vector<vector<u8>>, arg7: u64, arg8: bool, arg9: vector<u8>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        if (arg8) {
            swap_a2b<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg9, arg10, arg11);
        } else {
            swap_b2a<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg9, arg10, arg11);
        };
    }

    public fun swap_a2b<T0, T1>(arg0: &mut 0x422e3239f174320760dd675ba3835cf4b1c511be4a36e819cb61fab7d5d404a::router::SwapContext, arg1: &0x3257f7f5bdbc239f102a39375bfd10691067fbe74e01d97297725c0ea51b2133::versioned::Versioned, arg2: &0x3257f7f5bdbc239f102a39375bfd10691067fbe74e01d97297725c0ea51b2133::config::GlobalConfig, arg3: &0x3257f7f5bdbc239f102a39375bfd10691067fbe74e01d97297725c0ea51b2133::market_maker::MarketMaker, arg4: &mut 0x3257f7f5bdbc239f102a39375bfd10691067fbe74e01d97297725c0ea51b2133::orderbook_v2::Pool<T0, T1>, arg5: vector<u8>, arg6: vector<vector<u8>>, arg7: u64, arg8: vector<u8>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x422e3239f174320760dd675ba3835cf4b1c511be4a36e819cb61fab7d5d404a::router::take_balance<T0>(arg0, arg7);
        let v1 = 0x2::balance::value<T0>(&v0);
        if (v1 == 0) {
            0x2::balance::destroy_zero<T0>(v0);
            return
        };
        0x3257f7f5bdbc239f102a39375bfd10691067fbe74e01d97297725c0ea51b2133::orderbook_v2::update_quote_envelope_v2<T0, T1>(arg1, arg2, arg3, arg4, arg5, arg6, arg9, arg10);
        let (v2, v3) = 0x3257f7f5bdbc239f102a39375bfd10691067fbe74e01d97297725c0ea51b2133::orderbook_v2::swap_exact_base_for_quote<T0, T1>(arg1, arg2, arg3, arg4, 0x3257f7f5bdbc239f102a39375bfd10691067fbe74e01d97297725c0ea51b2133::orderbook_v2::new_quote_fill(arg8, v1), v0, arg9, arg10);
        let v4 = v3;
        let v5 = v2;
        let v6 = 0x2::balance::value<T0>(&v4);
        0x422e3239f174320760dd675ba3835cf4b1c511be4a36e819cb61fab7d5d404a::router::merge_balance<T0>(arg0, v4);
        0x422e3239f174320760dd675ba3835cf4b1c511be4a36e819cb61fab7d5d404a::router::merge_balance<T1>(arg0, v5);
        0x422e3239f174320760dd675ba3835cf4b1c511be4a36e819cb61fab7d5d404a::router::emit_swap_event<T0, T1>(arg0, b"PQF_ORDERBOOK_V2", 0x2::object::id<0x3257f7f5bdbc239f102a39375bfd10691067fbe74e01d97297725c0ea51b2133::orderbook_v2::Pool<T0, T1>>(arg4), v1 - v6, 0x2::balance::value<T1>(&v5), v6);
    }

    public fun swap_b2a<T0, T1>(arg0: &mut 0x422e3239f174320760dd675ba3835cf4b1c511be4a36e819cb61fab7d5d404a::router::SwapContext, arg1: &0x3257f7f5bdbc239f102a39375bfd10691067fbe74e01d97297725c0ea51b2133::versioned::Versioned, arg2: &0x3257f7f5bdbc239f102a39375bfd10691067fbe74e01d97297725c0ea51b2133::config::GlobalConfig, arg3: &0x3257f7f5bdbc239f102a39375bfd10691067fbe74e01d97297725c0ea51b2133::market_maker::MarketMaker, arg4: &mut 0x3257f7f5bdbc239f102a39375bfd10691067fbe74e01d97297725c0ea51b2133::orderbook_v2::Pool<T0, T1>, arg5: vector<u8>, arg6: vector<vector<u8>>, arg7: u64, arg8: vector<u8>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x422e3239f174320760dd675ba3835cf4b1c511be4a36e819cb61fab7d5d404a::router::take_balance<T1>(arg0, arg7);
        let v1 = 0x2::balance::value<T1>(&v0);
        if (v1 == 0) {
            0x2::balance::destroy_zero<T1>(v0);
            return
        };
        0x3257f7f5bdbc239f102a39375bfd10691067fbe74e01d97297725c0ea51b2133::orderbook_v2::update_quote_envelope_v2<T0, T1>(arg1, arg2, arg3, arg4, arg5, arg6, arg9, arg10);
        let (v2, v3) = 0x3257f7f5bdbc239f102a39375bfd10691067fbe74e01d97297725c0ea51b2133::orderbook_v2::swap_exact_quote_for_base<T0, T1>(arg1, arg2, arg3, arg4, 0x3257f7f5bdbc239f102a39375bfd10691067fbe74e01d97297725c0ea51b2133::orderbook_v2::new_quote_fill(arg8, v1), v0, arg9, arg10);
        let v4 = v3;
        let v5 = v2;
        let v6 = 0x2::balance::value<T1>(&v4);
        0x422e3239f174320760dd675ba3835cf4b1c511be4a36e819cb61fab7d5d404a::router::merge_balance<T1>(arg0, v4);
        0x422e3239f174320760dd675ba3835cf4b1c511be4a36e819cb61fab7d5d404a::router::merge_balance<T0>(arg0, v5);
        0x422e3239f174320760dd675ba3835cf4b1c511be4a36e819cb61fab7d5d404a::router::emit_swap_event<T1, T0>(arg0, b"PQF_ORDERBOOK_V2", 0x2::object::id<0x3257f7f5bdbc239f102a39375bfd10691067fbe74e01d97297725c0ea51b2133::orderbook_v2::Pool<T0, T1>>(arg4), v1 - v6, 0x2::balance::value<T0>(&v5), v6);
    }

    // decompiled from Move bytecode v7
}

