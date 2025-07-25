module 0x4dfaa01e9fcc00ab2cd4f4b4dbb46ec502dfaf882ad1d8aa26d973949df41c7c::steamm_cpmm_router {
    public entry fun buy_exact_in<T0, T1, T2, T3, T4, T5: drop>(arg0: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T3, T4, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::cpmm::CpQuoter, T5>, arg1: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T1, T3>, arg2: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T2, T4>, arg3: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg4: 0x2::coin::Coin<T1>, arg5: 0x2::coin::Coin<T2>, arg6: &0x2::clock::Clock, arg7: u64, arg8: bool, arg9: 0x1::ascii::String, arg10: &mut 0x2::tx_context::TxContext) {
        if (arg8) {
            let v0 = 0x2::coin::value<T1>(&arg4);
            0x13bfc09cfc1bd922d3aa53fcf7b2cd510727ee65068ce136e2ebd5f3b213fdd2::pool_script_v2::cpmm_swap<T0, T1, T2, T3, T4, T5>(arg0, arg1, arg2, arg3, &mut arg4, &mut arg5, true, v0, arg7, arg6, arg10);
            0x4dfaa01e9fcc00ab2cd4f4b4dbb46ec502dfaf882ad1d8aa26d973949df41c7c::events::emit_buy_event<T2, T1>(0x2::tx_context::sender(arg10), v0, 0x2::coin::value<T2>(&arg5));
        } else {
            let v1 = 0x2::coin::value<T2>(&arg5);
            0x13bfc09cfc1bd922d3aa53fcf7b2cd510727ee65068ce136e2ebd5f3b213fdd2::pool_script_v2::cpmm_swap<T0, T1, T2, T3, T4, T5>(arg0, arg1, arg2, arg3, &mut arg4, &mut arg5, false, v1, arg7, arg6, arg10);
            0x4dfaa01e9fcc00ab2cd4f4b4dbb46ec502dfaf882ad1d8aa26d973949df41c7c::events::emit_buy_event<T1, T2>(0x2::tx_context::sender(arg10), v1, 0x2::coin::value<T1>(&arg4));
        };
        0x4dfaa01e9fcc00ab2cd4f4b4dbb46ec502dfaf882ad1d8aa26d973949df41c7c::utils::send_coin<T1>(arg4, 0x2::tx_context::sender(arg10));
        0x4dfaa01e9fcc00ab2cd4f4b4dbb46ec502dfaf882ad1d8aa26d973949df41c7c::utils::send_coin<T2>(arg5, 0x2::tx_context::sender(arg10));
        0x4dfaa01e9fcc00ab2cd4f4b4dbb46ec502dfaf882ad1d8aa26d973949df41c7c::events::emit_order_completed_event(arg9);
    }

    public entry fun sell_exact_in<T0, T1, T2, T3, T4, T5: drop>(arg0: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T3, T4, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::cpmm::CpQuoter, T5>, arg1: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T1, T3>, arg2: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T2, T4>, arg3: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg4: 0x2::coin::Coin<T1>, arg5: 0x2::coin::Coin<T2>, arg6: &0x2::clock::Clock, arg7: u64, arg8: bool, arg9: 0x1::ascii::String, arg10: &mut 0x2::tx_context::TxContext) {
        if (arg8) {
            let v0 = 0x2::coin::value<T2>(&arg5);
            0x13bfc09cfc1bd922d3aa53fcf7b2cd510727ee65068ce136e2ebd5f3b213fdd2::pool_script_v2::cpmm_swap<T0, T1, T2, T3, T4, T5>(arg0, arg1, arg2, arg3, &mut arg4, &mut arg5, false, v0, arg7, arg6, arg10);
            0x4dfaa01e9fcc00ab2cd4f4b4dbb46ec502dfaf882ad1d8aa26d973949df41c7c::events::emit_sell_event<T2, T1>(0x2::tx_context::sender(arg10), v0, 0x2::coin::value<T1>(&arg4));
        } else {
            let v1 = 0x2::coin::value<T1>(&arg4);
            0x13bfc09cfc1bd922d3aa53fcf7b2cd510727ee65068ce136e2ebd5f3b213fdd2::pool_script_v2::cpmm_swap<T0, T1, T2, T3, T4, T5>(arg0, arg1, arg2, arg3, &mut arg4, &mut arg5, true, v1, arg7, arg6, arg10);
            0x4dfaa01e9fcc00ab2cd4f4b4dbb46ec502dfaf882ad1d8aa26d973949df41c7c::events::emit_sell_event<T1, T2>(0x2::tx_context::sender(arg10), v1, 0x2::coin::value<T2>(&arg5));
        };
        0x4dfaa01e9fcc00ab2cd4f4b4dbb46ec502dfaf882ad1d8aa26d973949df41c7c::utils::send_coin<T1>(arg4, 0x2::tx_context::sender(arg10));
        0x4dfaa01e9fcc00ab2cd4f4b4dbb46ec502dfaf882ad1d8aa26d973949df41c7c::utils::send_coin<T2>(arg5, 0x2::tx_context::sender(arg10));
        0x4dfaa01e9fcc00ab2cd4f4b4dbb46ec502dfaf882ad1d8aa26d973949df41c7c::events::emit_order_completed_event(arg9);
    }

    // decompiled from Move bytecode v6
}

