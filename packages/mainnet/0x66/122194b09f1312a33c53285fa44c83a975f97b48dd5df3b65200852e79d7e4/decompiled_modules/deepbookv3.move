module 0x66122194b09f1312a33c53285fa44c83a975f97b48dd5df3b65200852e79d7e4::deepbookv3 {
    public fun swap<T0, T1>(arg0: &mut 0x4dea343c9fe65d83b514a8520fdc619464be1debf598ad1e60f19b513cddb204::router::SwapContext, arg1: &mut 0xf26690b9d67ea6ac5bf393561f5b9860bb94a600c755e8b275b85470cc59d0b8::global_config::GlobalConfig, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: u64, arg4: bool, arg5: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        if (arg4) {
            swap_a2b<T0, T1>(arg0, arg1, arg2, arg3, arg5, arg6, arg7);
        } else {
            swap_b2a<T0, T1>(arg0, arg1, arg2, arg3, arg5, arg6, arg7);
        };
    }

    public fun add_deep_price_point<T0, T1, T2, T3>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T3>, arg2: &0x2::clock::Clock) {
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::add_deep_price_point<T0, T1, T2, T3>(arg0, arg1, arg2);
    }

    public fun swap_a2b<T0, T1>(arg0: &mut 0x4dea343c9fe65d83b514a8520fdc619464be1debf598ad1e60f19b513cddb204::router::SwapContext, arg1: &mut 0xf26690b9d67ea6ac5bf393561f5b9860bb94a600c755e8b275b85470cc59d0b8::global_config::GlobalConfig, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: u64, arg4: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x4dea343c9fe65d83b514a8520fdc619464be1debf598ad1e60f19b513cddb204::router::take_balance<T0>(arg0, arg3);
        if (0x2::balance::value<T0>(&v0) == 0) {
            0x4dea343c9fe65d83b514a8520fdc619464be1debf598ad1e60f19b513cddb204::router::transfer_or_destroy_coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg4, arg6);
            0x2::balance::destroy_zero<T0>(v0);
            return
        };
        let (v1, v2, v3) = 0xf26690b9d67ea6ac5bf393561f5b9860bb94a600c755e8b275b85470cc59d0b8::deepbook_v3::swap_a2b_<T0, T1>(arg1, arg2, 0x2::coin::from_balance<T0>(v0, arg6), arg4, arg5, arg6);
        if (arg3 == 0x4dea343c9fe65d83b514a8520fdc619464be1debf598ad1e60f19b513cddb204::router::max_amount_in()) {
            0x4dea343c9fe65d83b514a8520fdc619464be1debf598ad1e60f19b513cddb204::router::transfer_remaining_balance<T0>(arg0, 0x2::coin::into_balance<T0>(v1), arg6);
        } else {
            0x4dea343c9fe65d83b514a8520fdc619464be1debf598ad1e60f19b513cddb204::router::merge_balance<T0>(arg0, 0x2::coin::into_balance<T0>(v1));
        };
        0x4dea343c9fe65d83b514a8520fdc619464be1debf598ad1e60f19b513cddb204::router::merge_balance<T1>(arg0, 0x2::coin::into_balance<T1>(v2));
        0x4dea343c9fe65d83b514a8520fdc619464be1debf598ad1e60f19b513cddb204::router::transfer_or_destroy_coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v3, arg6);
    }

    fun swap_a2b_fee_amount_in<T0, T1>(arg0: &mut 0x4dea343c9fe65d83b514a8520fdc619464be1debf598ad1e60f19b513cddb204::router::SwapContext, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x4dea343c9fe65d83b514a8520fdc619464be1debf598ad1e60f19b513cddb204::router::take_balance<T0>(arg0, arg2);
        if (0x2::balance::value<T0>(&v0) == 0) {
            0x2::balance::destroy_zero<T0>(v0);
            return
        };
        let (v1, v2, v3) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_base_for_quote<T0, T1>(arg1, 0x2::coin::from_balance<T0>(v0, arg4), 0x2::coin::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg4), 0, arg3, arg4);
        if (arg2 == 0x4dea343c9fe65d83b514a8520fdc619464be1debf598ad1e60f19b513cddb204::router::max_amount_in()) {
            0x4dea343c9fe65d83b514a8520fdc619464be1debf598ad1e60f19b513cddb204::router::transfer_remaining_balance<T0>(arg0, 0x2::coin::into_balance<T0>(v1), arg4);
        } else {
            0x4dea343c9fe65d83b514a8520fdc619464be1debf598ad1e60f19b513cddb204::router::merge_balance<T0>(arg0, 0x2::coin::into_balance<T0>(v1));
        };
        0x4dea343c9fe65d83b514a8520fdc619464be1debf598ad1e60f19b513cddb204::router::merge_balance<T1>(arg0, 0x2::coin::into_balance<T1>(v2));
        0x4dea343c9fe65d83b514a8520fdc619464be1debf598ad1e60f19b513cddb204::router::transfer_or_destroy_coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v3, arg4);
    }

    fun swap_a2b_with_referral<T0, T1>(arg0: &mut 0x4dea343c9fe65d83b514a8520fdc619464be1debf598ad1e60f19b513cddb204::router::SwapContext, arg1: &mut 0xf26690b9d67ea6ac5bf393561f5b9860bb94a600c755e8b275b85470cc59d0b8::global_config::GlobalConfig, arg2: &0xf26690b9d67ea6ac5bf393561f5b9860bb94a600c755e8b275b85470cc59d0b8::global_config::BalanceCaps, arg3: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::DeepBookPoolReferral, arg4: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg5: u64, arg6: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x4dea343c9fe65d83b514a8520fdc619464be1debf598ad1e60f19b513cddb204::router::take_balance<T0>(arg0, arg5);
        if (0x2::balance::value<T0>(&v0) == 0) {
            0x4dea343c9fe65d83b514a8520fdc619464be1debf598ad1e60f19b513cddb204::router::transfer_or_destroy_coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg6, arg8);
            0x2::balance::destroy_zero<T0>(v0);
            return
        };
        let (v1, v2, v3) = 0xf26690b9d67ea6ac5bf393561f5b9860bb94a600c755e8b275b85470cc59d0b8::deepbook_v3::swap_a2b_with_referral<T0, T1>(arg1, arg4, arg2, arg3, 0x2::coin::from_balance<T0>(v0, arg8), arg6, arg7, arg8);
        if (arg5 == 0x4dea343c9fe65d83b514a8520fdc619464be1debf598ad1e60f19b513cddb204::router::max_amount_in()) {
            0x4dea343c9fe65d83b514a8520fdc619464be1debf598ad1e60f19b513cddb204::router::transfer_remaining_balance<T0>(arg0, 0x2::coin::into_balance<T0>(v1), arg8);
        } else {
            0x4dea343c9fe65d83b514a8520fdc619464be1debf598ad1e60f19b513cddb204::router::merge_balance<T0>(arg0, 0x2::coin::into_balance<T0>(v1));
        };
        0x4dea343c9fe65d83b514a8520fdc619464be1debf598ad1e60f19b513cddb204::router::merge_balance<T1>(arg0, 0x2::coin::into_balance<T1>(v2));
        0x4dea343c9fe65d83b514a8520fdc619464be1debf598ad1e60f19b513cddb204::router::transfer_or_destroy_coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v3, arg8);
    }

    public fun swap_b2a<T0, T1>(arg0: &mut 0x4dea343c9fe65d83b514a8520fdc619464be1debf598ad1e60f19b513cddb204::router::SwapContext, arg1: &mut 0xf26690b9d67ea6ac5bf393561f5b9860bb94a600c755e8b275b85470cc59d0b8::global_config::GlobalConfig, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: u64, arg4: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x4dea343c9fe65d83b514a8520fdc619464be1debf598ad1e60f19b513cddb204::router::take_balance<T1>(arg0, arg3);
        if (0x2::balance::value<T1>(&v0) == 0) {
            0x4dea343c9fe65d83b514a8520fdc619464be1debf598ad1e60f19b513cddb204::router::transfer_or_destroy_coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg4, arg6);
            0x2::balance::destroy_zero<T1>(v0);
            return
        };
        let (v1, v2, v3) = 0xf26690b9d67ea6ac5bf393561f5b9860bb94a600c755e8b275b85470cc59d0b8::deepbook_v3::swap_b2a_<T0, T1>(arg1, arg2, 0x2::coin::from_balance<T1>(v0, arg6), arg4, arg5, arg6);
        if (arg3 == 0x4dea343c9fe65d83b514a8520fdc619464be1debf598ad1e60f19b513cddb204::router::max_amount_in()) {
            0x4dea343c9fe65d83b514a8520fdc619464be1debf598ad1e60f19b513cddb204::router::transfer_remaining_balance<T1>(arg0, 0x2::coin::into_balance<T1>(v2), arg6);
        } else {
            0x4dea343c9fe65d83b514a8520fdc619464be1debf598ad1e60f19b513cddb204::router::merge_balance<T1>(arg0, 0x2::coin::into_balance<T1>(v2));
        };
        0x4dea343c9fe65d83b514a8520fdc619464be1debf598ad1e60f19b513cddb204::router::merge_balance<T0>(arg0, 0x2::coin::into_balance<T0>(v1));
        0x4dea343c9fe65d83b514a8520fdc619464be1debf598ad1e60f19b513cddb204::router::transfer_or_destroy_coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v3, arg6);
    }

    fun swap_b2a_fee_amount_in<T0, T1>(arg0: &mut 0x4dea343c9fe65d83b514a8520fdc619464be1debf598ad1e60f19b513cddb204::router::SwapContext, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x4dea343c9fe65d83b514a8520fdc619464be1debf598ad1e60f19b513cddb204::router::take_balance<T1>(arg0, arg2);
        if (0x2::balance::value<T1>(&v0) == 0) {
            0x2::balance::destroy_zero<T1>(v0);
            return
        };
        let (v1, v2, v3) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_quote_for_base<T0, T1>(arg1, 0x2::coin::from_balance<T1>(v0, arg4), 0x2::coin::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg4), 0, arg3, arg4);
        if (arg2 == 0x4dea343c9fe65d83b514a8520fdc619464be1debf598ad1e60f19b513cddb204::router::max_amount_in()) {
            0x4dea343c9fe65d83b514a8520fdc619464be1debf598ad1e60f19b513cddb204::router::transfer_remaining_balance<T1>(arg0, 0x2::coin::into_balance<T1>(v2), arg4);
        } else {
            0x4dea343c9fe65d83b514a8520fdc619464be1debf598ad1e60f19b513cddb204::router::merge_balance<T1>(arg0, 0x2::coin::into_balance<T1>(v2));
        };
        0x4dea343c9fe65d83b514a8520fdc619464be1debf598ad1e60f19b513cddb204::router::merge_balance<T0>(arg0, 0x2::coin::into_balance<T0>(v1));
        0x4dea343c9fe65d83b514a8520fdc619464be1debf598ad1e60f19b513cddb204::router::transfer_or_destroy_coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v3, arg4);
    }

    fun swap_b2a_with_referral<T0, T1>(arg0: &mut 0x4dea343c9fe65d83b514a8520fdc619464be1debf598ad1e60f19b513cddb204::router::SwapContext, arg1: &mut 0xf26690b9d67ea6ac5bf393561f5b9860bb94a600c755e8b275b85470cc59d0b8::global_config::GlobalConfig, arg2: &0xf26690b9d67ea6ac5bf393561f5b9860bb94a600c755e8b275b85470cc59d0b8::global_config::BalanceCaps, arg3: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::DeepBookPoolReferral, arg4: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg5: u64, arg6: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x4dea343c9fe65d83b514a8520fdc619464be1debf598ad1e60f19b513cddb204::router::take_balance<T1>(arg0, arg5);
        if (0x2::balance::value<T1>(&v0) == 0) {
            0x4dea343c9fe65d83b514a8520fdc619464be1debf598ad1e60f19b513cddb204::router::transfer_or_destroy_coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg6, arg8);
            0x2::balance::destroy_zero<T1>(v0);
            return
        };
        let (v1, v2, v3) = 0xf26690b9d67ea6ac5bf393561f5b9860bb94a600c755e8b275b85470cc59d0b8::deepbook_v3::swap_b2a_with_referral<T0, T1>(arg1, arg4, arg2, arg3, 0x2::coin::from_balance<T1>(v0, arg8), arg6, arg7, arg8);
        if (arg5 == 0x4dea343c9fe65d83b514a8520fdc619464be1debf598ad1e60f19b513cddb204::router::max_amount_in()) {
            0x4dea343c9fe65d83b514a8520fdc619464be1debf598ad1e60f19b513cddb204::router::transfer_remaining_balance<T1>(arg0, 0x2::coin::into_balance<T1>(v2), arg8);
        } else {
            0x4dea343c9fe65d83b514a8520fdc619464be1debf598ad1e60f19b513cddb204::router::merge_balance<T1>(arg0, 0x2::coin::into_balance<T1>(v2));
        };
        0x4dea343c9fe65d83b514a8520fdc619464be1debf598ad1e60f19b513cddb204::router::merge_balance<T0>(arg0, 0x2::coin::into_balance<T0>(v1));
        0x4dea343c9fe65d83b514a8520fdc619464be1debf598ad1e60f19b513cddb204::router::transfer_or_destroy_coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v3, arg8);
    }

    public fun swap_fee_amount_in<T0, T1>(arg0: &mut 0x4dea343c9fe65d83b514a8520fdc619464be1debf598ad1e60f19b513cddb204::router::SwapContext, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: u64, arg3: bool, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        if (arg3) {
            swap_a2b_fee_amount_in<T0, T1>(arg0, arg1, arg2, arg4, arg5);
        } else {
            swap_b2a_fee_amount_in<T0, T1>(arg0, arg1, arg2, arg4, arg5);
        };
    }

    public fun swap_with_referral<T0, T1>(arg0: &mut 0x4dea343c9fe65d83b514a8520fdc619464be1debf598ad1e60f19b513cddb204::router::SwapContext, arg1: &mut 0xf26690b9d67ea6ac5bf393561f5b9860bb94a600c755e8b275b85470cc59d0b8::global_config::GlobalConfig, arg2: &0xf26690b9d67ea6ac5bf393561f5b9860bb94a600c755e8b275b85470cc59d0b8::global_config::BalanceCaps, arg3: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::DeepBookPoolReferral, arg4: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg5: u64, arg6: bool, arg7: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        if (arg6) {
            swap_a2b_with_referral<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg7, arg8, arg9);
        } else {
            swap_b2a_with_referral<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg7, arg8, arg9);
        };
    }

    // decompiled from Move bytecode v7
}

