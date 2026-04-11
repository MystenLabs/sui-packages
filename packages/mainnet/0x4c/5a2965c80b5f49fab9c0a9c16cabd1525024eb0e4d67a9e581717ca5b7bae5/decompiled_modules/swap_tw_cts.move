module 0x4c5a2965c80b5f49fab9c0a9c16cabd1525024eb0e4d67a9e581717ca5b7bae5::swap_tw_cts {
    public fun ca_ca<T0, T1>(arg0: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: u128, arg2: u64, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg4: u128, arg5: u64, arg6: &mut 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::wallet::Vault<T0>, arg7: &mut 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::wallet::Vault<T1>, arg8: u64, arg9: &0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::datastore::Config, arg10: &0x2::clock::Clock, arg11: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg12: &mut 0x2::tx_context::TxContext) {
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::datastore::get_sender_if_whitelisted(arg9, arg12);
        let (v0, v1, v2) = 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::cts::ca<T0, T1>(arg0, arg8, arg1, arg10, arg11);
        let v3 = v0;
        let (v4, v5) = 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::cts::ca__<T1, T0>(arg3, 0x2::balance::value<T1>(&v3), arg4, arg10, arg11, arg7, v1);
        let v6 = v4;
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::asserts::must_amount_greated_than(0x2::balance::value<T0>(&v6), arg8);
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::cts::repay_f_s_x<T0, T1>(arg0, v2, 0x2::balance::split<T0>(&mut v6, arg8), arg11);
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::cts::repay_f_s_x<T1, T0>(arg3, v5, v3, arg11);
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::wallet::destroy_or_deposit_balance<T0>(arg6, v6);
    }

    public fun ca_cb<T0, T1>(arg0: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: u128, arg2: u64, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: u128, arg5: u64, arg6: &mut 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::wallet::Vault<T0>, arg7: &mut 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::wallet::Vault<T1>, arg8: u64, arg9: &0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::datastore::Config, arg10: &0x2::clock::Clock, arg11: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg12: &mut 0x2::tx_context::TxContext) {
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::datastore::get_sender_if_whitelisted(arg9, arg12);
        let (v0, v1, v2) = 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::cts::ca<T0, T1>(arg0, arg8, arg1, arg10, arg11);
        let v3 = v0;
        let (v4, v5) = 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::cts::cb__<T0, T1>(arg3, 0x2::balance::value<T1>(&v3), arg4, arg10, arg11, arg7, v1);
        let v6 = v4;
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::asserts::must_amount_greated_than(0x2::balance::value<T0>(&v6), arg8);
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::cts::repay_f_s_x<T0, T1>(arg0, v2, 0x2::balance::split<T0>(&mut v6, arg8), arg11);
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::cts::repay_f_s_y<T0, T1>(arg3, v5, v3, arg11);
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::wallet::destroy_or_deposit_balance<T0>(arg6, v6);
    }

    public fun cb_ca<T0, T1>(arg0: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: u128, arg2: u64, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: u128, arg5: u64, arg6: &mut 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::wallet::Vault<T0>, arg7: &mut 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::wallet::Vault<T1>, arg8: u64, arg9: &0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::datastore::Config, arg10: &0x2::clock::Clock, arg11: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg12: &mut 0x2::tx_context::TxContext) {
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::datastore::get_sender_if_whitelisted(arg9, arg12);
        let (v0, v1, v2) = 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::cts::cb<T0, T1>(arg0, arg8, arg1, arg10, arg11);
        let v3 = v0;
        let (v4, v5) = 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::cts::ca__<T0, T1>(arg3, 0x2::balance::value<T0>(&v3), arg4, arg10, arg11, arg6, v1);
        let v6 = v4;
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::asserts::must_amount_greated_than(0x2::balance::value<T1>(&v6), arg8);
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::cts::repay_f_s_y<T0, T1>(arg0, v2, 0x2::balance::split<T1>(&mut v6, arg8), arg11);
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::cts::repay_f_s_x<T0, T1>(arg3, v5, v3, arg11);
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::wallet::destroy_or_deposit_balance<T1>(arg7, v6);
    }

    public fun cb_cb<T0, T1>(arg0: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: u128, arg2: u64, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg4: u128, arg5: u64, arg6: &mut 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::wallet::Vault<T0>, arg7: &mut 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::wallet::Vault<T1>, arg8: u64, arg9: &0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::datastore::Config, arg10: &0x2::clock::Clock, arg11: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg12: &mut 0x2::tx_context::TxContext) {
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::datastore::get_sender_if_whitelisted(arg9, arg12);
        let (v0, v1, v2) = 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::cts::cb<T0, T1>(arg0, arg8, arg1, arg10, arg11);
        let v3 = v0;
        let (v4, v5) = 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::cts::cb__<T1, T0>(arg3, 0x2::balance::value<T0>(&v3), arg4, arg10, arg11, arg6, v1);
        let v6 = v4;
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::asserts::must_amount_greated_than(0x2::balance::value<T1>(&v6), arg8);
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::cts::repay_f_s_y<T0, T1>(arg0, v2, 0x2::balance::split<T1>(&mut v6, arg8), arg11);
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::cts::repay_f_s_y<T1, T0>(arg3, v5, v3, arg11);
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::wallet::destroy_or_deposit_balance<T1>(arg7, v6);
    }

    // decompiled from Move bytecode v7
}

