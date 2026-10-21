module 0x24a10f6278785dee08a860093a97931606f3a5c15ec36bd333a7efaa54138495::mb {
    fun own(arg0: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg0) == @0x57f118d56fe158c8bd5966fd87eb106545fd5628528af42f6a05eebdf9aa3380, 0);
    }

    fun settle(arg0: 0x2::balance::Balance<0x2::sui::SUI>, arg1: &0x2::tx_context::TxContext) {
        if (0x2::balance::value<0x2::sui::SUI>(&arg0) == 0) {
            0x2::balance::destroy_zero<0x2::sui::SUI>(arg0);
        } else {
            0x2::balance::send_funds<0x2::sui::SUI>(arg0, 0x2::tx_context::sender(arg1));
        };
    }

    public fun sx<T0>(arg0: &mut 0x8f70ad5db84e1a99b542f86ccfb1a932ca7ba010a2fa12a1504d839ff4c111c6::moonbags::Configuration, arg1: &0x8f70ad5db84e1a99b542f86ccfb1a932ca7ba010a2fa12a1504d839ff4c111c6::moonbags_token_lock::Configuration, arg2: &mut 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::BurnManager, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &0x2::coin::CoinMetadata<0x2::sui::SUI>, arg6: 0x2::balance::Balance<0x2::sui::SUI>, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        own(arg9);
        let (v0, v1) = 0x8f70ad5db84e1a99b542f86ccfb1a932ca7ba010a2fa12a1504d839ff4c111c6::moonbags::buy_exact_in_returns_with_lock<T0>(arg0, arg1, 0x2::coin::from_balance<0x2::sui::SUI>(arg6, arg9), 0x1::u64::mul_div(0x2::balance::value<0x2::sui::SUI>(&arg6), 10000, 10000 + arg7), 0, arg2, arg3, arg4, arg5, arg8, arg9);
        settle(0x2::coin::into_balance<0x2::sui::SUI>(v0), arg9);
        0x2::coin::into_balance<T0>(v1)
    }

    public fun xs<T0>(arg0: &mut 0x8f70ad5db84e1a99b542f86ccfb1a932ca7ba010a2fa12a1504d839ff4c111c6::moonbags::Configuration, arg1: 0x2::balance::Balance<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        own(arg3);
        let (v0, v1) = 0x8f70ad5db84e1a99b542f86ccfb1a932ca7ba010a2fa12a1504d839ff4c111c6::moonbags::sell_returns<T0>(arg0, 0x2::coin::from_balance<T0>(arg1, arg3), 0, arg2, arg3);
        0x2::coin::destroy_zero<T0>(v1);
        0x2::coin::into_balance<0x2::sui::SUI>(v0)
    }

    // decompiled from Move bytecode v7
}

