module 0x84b9bbd786a20cd5b83de880915232723853adcd609548802867a294413c381d::swap_fl_b_tw_trb_cts {
    public fun ta_ca<T0, T1, T2, T3>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: u64, arg2: u128, arg3: u64, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg5: u128, arg6: u64, arg7: &mut 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::wallet::Vault<T0>, arg8: &mut 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::wallet::Vault<T1>, arg9: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T3>, arg10: u64, arg11: &0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::datastore::Config, arg12: &0x2::clock::Clock, arg13: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg14: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg15: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::fl_dp::fl_b_checked<T0, T3>(arg9, arg10, arg15);
        let (v2, v3) = 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::trb::ta<T0, T1, T2>(v0, arg0, arg1, arg2, arg13, 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::datastore::get_sender_if_whitelisted(arg11, arg15), arg12, arg15);
        let v4 = v2;
        let (v5, v6) = 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::cts::ca_from_coins__<T1, T0>(arg4, 0x2::coin::value<T1>(&v4), arg5, arg12, arg14, arg8, v3);
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::cts::repay_f_s_x_from_coin<T1, T0>(arg4, v6, v4, arg14);
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::fl_dp::base_fl_b_from_balance<T0, T3>(arg9, v1, v5, arg10, arg7, arg15);
    }

    public fun ta_cb<T0, T1, T2, T3>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: u64, arg2: u128, arg3: u64, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg5: u128, arg6: u64, arg7: &mut 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::wallet::Vault<T0>, arg8: &mut 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::wallet::Vault<T1>, arg9: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T3>, arg10: u64, arg11: &0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::datastore::Config, arg12: &0x2::clock::Clock, arg13: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg14: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg15: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::fl_dp::fl_b_checked<T0, T3>(arg9, arg10, arg15);
        let (v2, v3) = 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::trb::ta<T0, T1, T2>(v0, arg0, arg1, arg2, arg13, 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::datastore::get_sender_if_whitelisted(arg11, arg15), arg12, arg15);
        let v4 = v2;
        let (v5, v6) = 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::cts::cb_from_coins__<T0, T1>(arg4, 0x2::coin::value<T1>(&v4), arg5, arg12, arg14, arg8, v3);
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::cts::repay_f_s_y_from_coin<T0, T1>(arg4, v6, v4, arg14);
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::fl_dp::base_fl_b_from_balance<T0, T3>(arg9, v1, v5, arg10, arg7, arg15);
    }

    public fun tb_ca<T0, T1, T2, T3>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: u64, arg2: u128, arg3: u64, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg5: u128, arg6: u64, arg7: &mut 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::wallet::Vault<T0>, arg8: &mut 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::wallet::Vault<T1>, arg9: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T3>, arg10: u64, arg11: &0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::datastore::Config, arg12: &0x2::clock::Clock, arg13: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg14: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg15: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::fl_dp::fl_b_checked<T1, T3>(arg9, arg10, arg15);
        let (v2, v3) = 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::trb::tb<T0, T1, T2>(v0, arg0, arg1, arg2, arg13, 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::datastore::get_sender_if_whitelisted(arg11, arg15), arg12, arg15);
        let v4 = v2;
        let (v5, v6) = 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::cts::ca_from_coins__<T0, T1>(arg4, 0x2::coin::value<T0>(&v4), arg5, arg12, arg14, arg7, v3);
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::cts::repay_f_s_x_from_coin<T0, T1>(arg4, v6, v4, arg14);
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::fl_dp::base_fl_b_from_balance<T1, T3>(arg9, v1, v5, arg10, arg8, arg15);
    }

    public fun tb_cb<T0, T1, T2, T3>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: u64, arg2: u128, arg3: u64, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg5: u128, arg6: u64, arg7: &mut 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::wallet::Vault<T0>, arg8: &mut 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::wallet::Vault<T1>, arg9: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T3>, arg10: u64, arg11: &0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::datastore::Config, arg12: &0x2::clock::Clock, arg13: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg14: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg15: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::fl_dp::fl_b_checked<T1, T3>(arg9, arg10, arg15);
        let (v2, v3) = 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::trb::tb<T0, T1, T2>(v0, arg0, arg1, arg2, arg13, 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::datastore::get_sender_if_whitelisted(arg11, arg15), arg12, arg15);
        let v4 = v2;
        let (v5, v6) = 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::cts::cb_from_coins__<T1, T0>(arg4, 0x2::coin::value<T0>(&v4), arg5, arg12, arg14, arg7, v3);
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::cts::repay_f_s_y_from_coin<T1, T0>(arg4, v6, v4, arg14);
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::fl_dp::base_fl_b_from_balance<T1, T3>(arg9, v1, v5, arg10, arg8, arg15);
    }

    // decompiled from Move bytecode v7
}

