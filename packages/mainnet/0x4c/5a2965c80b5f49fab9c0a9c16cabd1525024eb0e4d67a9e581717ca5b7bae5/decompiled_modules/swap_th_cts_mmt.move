module 0x4c5a2965c80b5f49fab9c0a9c16cabd1525024eb0e4d67a9e581717ca5b7bae5::swap_th_cts_mmt {
    public fun ca_ca_ma<T0, T1, T2>(arg0: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: u128, arg2: u64, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg4: u128, arg5: u64, arg6: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T0>, arg7: u128, arg8: u64, arg9: &mut 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::wallet::Vault<T0>, arg10: &mut 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::wallet::Vault<T1>, arg11: &mut 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::wallet::Vault<T2>, arg12: u64, arg13: &0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::datastore::Config, arg14: &0x2::clock::Clock, arg15: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg16: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg17: &mut 0x2::tx_context::TxContext) {
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::datastore::get_sender_if_whitelisted(arg13, arg17);
        let (v0, v1, v2) = 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::cts::ca<T0, T1>(arg0, arg12, arg1, arg14, arg15);
        let v3 = v0;
        let (v4, v5) = 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::cts::ca_<T1, T2>(arg3, 0x2::balance::value<T1>(&v3), arg4, arg14, arg15, arg10);
        let v6 = v4;
        let (v7, v8) = 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::mmt::ma__<T2, T0>(arg6, 0x2::balance::value<T2>(&v6), arg7, arg14, arg16, arg11, v1, arg17);
        let v9 = v7;
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::asserts::must_amount_greated_than(0x2::balance::value<T0>(&v9), arg12);
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::cts::repay_f_s_x<T0, T1>(arg0, v2, 0x2::balance::split<T0>(&mut v9, arg12), arg15);
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::cts::repay_f_s_x<T1, T2>(arg3, v5, v3, arg15);
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::mmt::repay_f_s_x<T2, T0>(arg6, v8, v6, arg16, arg17);
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::wallet::destroy_or_deposit_balance<T0>(arg9, v9);
    }

    public fun ca_ca_mb<T0, T1, T2>(arg0: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: u128, arg2: u64, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg4: u128, arg5: u64, arg6: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T2>, arg7: u128, arg8: u64, arg9: &mut 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::wallet::Vault<T0>, arg10: &mut 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::wallet::Vault<T1>, arg11: &mut 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::wallet::Vault<T2>, arg12: u64, arg13: &0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::datastore::Config, arg14: &0x2::clock::Clock, arg15: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg16: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg17: &mut 0x2::tx_context::TxContext) {
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::datastore::get_sender_if_whitelisted(arg13, arg17);
        let (v0, v1, v2) = 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::cts::ca<T0, T1>(arg0, arg12, arg1, arg14, arg15);
        let v3 = v0;
        let (v4, v5) = 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::cts::ca_<T1, T2>(arg3, 0x2::balance::value<T1>(&v3), arg4, arg14, arg15, arg10);
        let v6 = v4;
        let (v7, v8) = 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::mmt::mb__<T0, T2>(arg6, 0x2::balance::value<T2>(&v6), arg7, arg14, arg16, arg11, v1, arg17);
        let v9 = v7;
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::asserts::must_amount_greated_than(0x2::balance::value<T0>(&v9), arg12);
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::cts::repay_f_s_x<T0, T1>(arg0, v2, 0x2::balance::split<T0>(&mut v9, arg12), arg15);
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::cts::repay_f_s_x<T1, T2>(arg3, v5, v3, arg15);
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::mmt::repay_f_s_y<T0, T2>(arg6, v8, v6, arg16, arg17);
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::wallet::destroy_or_deposit_balance<T0>(arg9, v9);
    }

    public fun ca_cb_ma<T0, T1, T2>(arg0: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: u128, arg2: u64, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>, arg4: u128, arg5: u64, arg6: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T0>, arg7: u128, arg8: u64, arg9: &mut 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::wallet::Vault<T0>, arg10: &mut 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::wallet::Vault<T1>, arg11: &mut 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::wallet::Vault<T2>, arg12: u64, arg13: &0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::datastore::Config, arg14: &0x2::clock::Clock, arg15: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg16: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg17: &mut 0x2::tx_context::TxContext) {
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::datastore::get_sender_if_whitelisted(arg13, arg17);
        let (v0, v1, v2) = 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::cts::ca<T0, T1>(arg0, arg12, arg1, arg14, arg15);
        let v3 = v0;
        let (v4, v5) = 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::cts::cb_<T2, T1>(arg3, 0x2::balance::value<T1>(&v3), arg4, arg14, arg15, arg10);
        let v6 = v4;
        let (v7, v8) = 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::mmt::ma__<T2, T0>(arg6, 0x2::balance::value<T2>(&v6), arg7, arg14, arg16, arg11, v1, arg17);
        let v9 = v7;
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::asserts::must_amount_greated_than(0x2::balance::value<T0>(&v9), arg12);
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::cts::repay_f_s_x<T0, T1>(arg0, v2, 0x2::balance::split<T0>(&mut v9, arg12), arg15);
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::cts::repay_f_s_y<T2, T1>(arg3, v5, v3, arg15);
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::mmt::repay_f_s_x<T2, T0>(arg6, v8, v6, arg16, arg17);
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::wallet::destroy_or_deposit_balance<T0>(arg9, v9);
    }

    public fun ca_cb_mb<T0, T1, T2>(arg0: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: u128, arg2: u64, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>, arg4: u128, arg5: u64, arg6: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T2>, arg7: u128, arg8: u64, arg9: &mut 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::wallet::Vault<T0>, arg10: &mut 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::wallet::Vault<T1>, arg11: &mut 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::wallet::Vault<T2>, arg12: u64, arg13: &0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::datastore::Config, arg14: &0x2::clock::Clock, arg15: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg16: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg17: &mut 0x2::tx_context::TxContext) {
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::datastore::get_sender_if_whitelisted(arg13, arg17);
        let (v0, v1, v2) = 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::cts::ca<T0, T1>(arg0, arg12, arg1, arg14, arg15);
        let v3 = v0;
        let (v4, v5) = 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::cts::cb_<T2, T1>(arg3, 0x2::balance::value<T1>(&v3), arg4, arg14, arg15, arg10);
        let v6 = v4;
        let (v7, v8) = 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::mmt::mb__<T0, T2>(arg6, 0x2::balance::value<T2>(&v6), arg7, arg14, arg16, arg11, v1, arg17);
        let v9 = v7;
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::asserts::must_amount_greated_than(0x2::balance::value<T0>(&v9), arg12);
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::cts::repay_f_s_x<T0, T1>(arg0, v2, 0x2::balance::split<T0>(&mut v9, arg12), arg15);
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::cts::repay_f_s_y<T2, T1>(arg3, v5, v3, arg15);
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::mmt::repay_f_s_y<T0, T2>(arg6, v8, v6, arg16, arg17);
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::wallet::destroy_or_deposit_balance<T0>(arg9, v9);
    }

    public fun ca_ma_ca<T0, T1, T2>(arg0: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: u128, arg2: u64, arg3: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T2>, arg4: u128, arg5: u64, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T0>, arg7: u128, arg8: u64, arg9: &mut 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::wallet::Vault<T0>, arg10: &mut 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::wallet::Vault<T1>, arg11: &mut 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::wallet::Vault<T2>, arg12: u64, arg13: &0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::datastore::Config, arg14: &0x2::clock::Clock, arg15: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg16: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg17: &mut 0x2::tx_context::TxContext) {
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::datastore::get_sender_if_whitelisted(arg13, arg17);
        let (v0, v1, v2) = 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::cts::ca<T0, T1>(arg0, arg12, arg1, arg14, arg15);
        let v3 = v0;
        let (v4, v5) = 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::mmt::ma_<T1, T2>(arg3, 0x2::balance::value<T1>(&v3), arg4, arg14, arg16, arg10, arg17);
        let v6 = v4;
        let (v7, v8) = 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::cts::ca__<T2, T0>(arg6, 0x2::balance::value<T2>(&v6), arg7, arg14, arg15, arg11, v1);
        let v9 = v7;
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::asserts::must_amount_greated_than(0x2::balance::value<T0>(&v9), arg12);
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::cts::repay_f_s_x<T0, T1>(arg0, v2, 0x2::balance::split<T0>(&mut v9, arg12), arg15);
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::mmt::repay_f_s_x<T1, T2>(arg3, v5, v3, arg16, arg17);
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::cts::repay_f_s_x<T2, T0>(arg6, v8, v6, arg15);
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::wallet::destroy_or_deposit_balance<T0>(arg9, v9);
    }

    public fun ca_ma_cb<T0, T1, T2>(arg0: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: u128, arg2: u64, arg3: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T2>, arg4: u128, arg5: u64, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T2>, arg7: u128, arg8: u64, arg9: &mut 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::wallet::Vault<T0>, arg10: &mut 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::wallet::Vault<T1>, arg11: &mut 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::wallet::Vault<T2>, arg12: u64, arg13: &0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::datastore::Config, arg14: &0x2::clock::Clock, arg15: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg16: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg17: &mut 0x2::tx_context::TxContext) {
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::datastore::get_sender_if_whitelisted(arg13, arg17);
        let (v0, v1, v2) = 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::cts::ca<T0, T1>(arg0, arg12, arg1, arg14, arg15);
        let v3 = v0;
        let (v4, v5) = 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::mmt::ma_<T1, T2>(arg3, 0x2::balance::value<T1>(&v3), arg4, arg14, arg16, arg10, arg17);
        let v6 = v4;
        let (v7, v8) = 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::cts::cb__<T0, T2>(arg6, 0x2::balance::value<T2>(&v6), arg7, arg14, arg15, arg11, v1);
        let v9 = v7;
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::asserts::must_amount_greated_than(0x2::balance::value<T0>(&v9), arg12);
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::cts::repay_f_s_x<T0, T1>(arg0, v2, 0x2::balance::split<T0>(&mut v9, arg12), arg15);
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::mmt::repay_f_s_x<T1, T2>(arg3, v5, v3, arg16, arg17);
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::cts::repay_f_s_y<T0, T2>(arg6, v8, v6, arg15);
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::wallet::destroy_or_deposit_balance<T0>(arg9, v9);
    }

    public fun ca_ma_ma<T0, T1, T2>(arg0: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: u128, arg2: u64, arg3: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T2>, arg4: u128, arg5: u64, arg6: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T0>, arg7: u128, arg8: u64, arg9: &mut 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::wallet::Vault<T0>, arg10: &mut 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::wallet::Vault<T1>, arg11: &mut 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::wallet::Vault<T2>, arg12: u64, arg13: &0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::datastore::Config, arg14: &0x2::clock::Clock, arg15: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg16: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg17: &mut 0x2::tx_context::TxContext) {
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::datastore::get_sender_if_whitelisted(arg13, arg17);
        let (v0, v1, v2) = 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::cts::ca<T0, T1>(arg0, arg12, arg1, arg14, arg15);
        let v3 = v0;
        let (v4, v5) = 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::mmt::ma_<T1, T2>(arg3, 0x2::balance::value<T1>(&v3), arg4, arg14, arg16, arg10, arg17);
        let v6 = v4;
        let (v7, v8) = 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::mmt::ma__<T2, T0>(arg6, 0x2::balance::value<T2>(&v6), arg7, arg14, arg16, arg11, v1, arg17);
        let v9 = v7;
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::asserts::must_amount_greated_than(0x2::balance::value<T0>(&v9), arg12);
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::cts::repay_f_s_x<T0, T1>(arg0, v2, 0x2::balance::split<T0>(&mut v9, arg12), arg15);
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::mmt::repay_f_s_x<T1, T2>(arg3, v5, v3, arg16, arg17);
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::mmt::repay_f_s_x<T2, T0>(arg6, v8, v6, arg16, arg17);
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::wallet::destroy_or_deposit_balance<T0>(arg9, v9);
    }

    public fun ca_ma_mb<T0, T1, T2>(arg0: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: u128, arg2: u64, arg3: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T2>, arg4: u128, arg5: u64, arg6: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T2>, arg7: u128, arg8: u64, arg9: &mut 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::wallet::Vault<T0>, arg10: &mut 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::wallet::Vault<T1>, arg11: &mut 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::wallet::Vault<T2>, arg12: u64, arg13: &0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::datastore::Config, arg14: &0x2::clock::Clock, arg15: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg16: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg17: &mut 0x2::tx_context::TxContext) {
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::datastore::get_sender_if_whitelisted(arg13, arg17);
        let (v0, v1, v2) = 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::cts::ca<T0, T1>(arg0, arg12, arg1, arg14, arg15);
        let v3 = v0;
        let (v4, v5) = 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::mmt::ma_<T1, T2>(arg3, 0x2::balance::value<T1>(&v3), arg4, arg14, arg16, arg10, arg17);
        let v6 = v4;
        let (v7, v8) = 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::mmt::mb__<T0, T2>(arg6, 0x2::balance::value<T2>(&v6), arg7, arg14, arg16, arg11, v1, arg17);
        let v9 = v7;
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::asserts::must_amount_greated_than(0x2::balance::value<T0>(&v9), arg12);
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::cts::repay_f_s_x<T0, T1>(arg0, v2, 0x2::balance::split<T0>(&mut v9, arg12), arg15);
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::mmt::repay_f_s_x<T1, T2>(arg3, v5, v3, arg16, arg17);
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::mmt::repay_f_s_y<T0, T2>(arg6, v8, v6, arg16, arg17);
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::wallet::destroy_or_deposit_balance<T0>(arg9, v9);
    }

    public fun ca_mb_ca<T0, T1, T2>(arg0: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: u128, arg2: u64, arg3: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T1>, arg4: u128, arg5: u64, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T0>, arg7: u128, arg8: u64, arg9: &mut 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::wallet::Vault<T0>, arg10: &mut 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::wallet::Vault<T1>, arg11: &mut 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::wallet::Vault<T2>, arg12: u64, arg13: &0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::datastore::Config, arg14: &0x2::clock::Clock, arg15: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg16: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg17: &mut 0x2::tx_context::TxContext) {
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::datastore::get_sender_if_whitelisted(arg13, arg17);
        let (v0, v1, v2) = 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::cts::ca<T0, T1>(arg0, arg12, arg1, arg14, arg15);
        let v3 = v0;
        let (v4, v5) = 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::mmt::mb_<T2, T1>(arg3, 0x2::balance::value<T1>(&v3), arg4, arg14, arg16, arg10, arg17);
        let v6 = v4;
        let (v7, v8) = 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::cts::ca__<T2, T0>(arg6, 0x2::balance::value<T2>(&v6), arg7, arg14, arg15, arg11, v1);
        let v9 = v7;
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::asserts::must_amount_greated_than(0x2::balance::value<T0>(&v9), arg12);
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::cts::repay_f_s_x<T0, T1>(arg0, v2, 0x2::balance::split<T0>(&mut v9, arg12), arg15);
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::mmt::repay_f_s_y<T2, T1>(arg3, v5, v3, arg16, arg17);
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::cts::repay_f_s_x<T2, T0>(arg6, v8, v6, arg15);
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::wallet::destroy_or_deposit_balance<T0>(arg9, v9);
    }

    public fun ca_mb_cb<T0, T1, T2>(arg0: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: u128, arg2: u64, arg3: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T1>, arg4: u128, arg5: u64, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T2>, arg7: u128, arg8: u64, arg9: &mut 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::wallet::Vault<T0>, arg10: &mut 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::wallet::Vault<T1>, arg11: &mut 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::wallet::Vault<T2>, arg12: u64, arg13: &0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::datastore::Config, arg14: &0x2::clock::Clock, arg15: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg16: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg17: &mut 0x2::tx_context::TxContext) {
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::datastore::get_sender_if_whitelisted(arg13, arg17);
        let (v0, v1, v2) = 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::cts::ca<T0, T1>(arg0, arg12, arg1, arg14, arg15);
        let v3 = v0;
        let (v4, v5) = 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::mmt::mb_<T2, T1>(arg3, 0x2::balance::value<T1>(&v3), arg4, arg14, arg16, arg10, arg17);
        let v6 = v4;
        let (v7, v8) = 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::cts::cb__<T0, T2>(arg6, 0x2::balance::value<T2>(&v6), arg7, arg14, arg15, arg11, v1);
        let v9 = v7;
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::asserts::must_amount_greated_than(0x2::balance::value<T0>(&v9), arg12);
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::cts::repay_f_s_x<T0, T1>(arg0, v2, 0x2::balance::split<T0>(&mut v9, arg12), arg15);
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::mmt::repay_f_s_y<T2, T1>(arg3, v5, v3, arg16, arg17);
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::cts::repay_f_s_y<T0, T2>(arg6, v8, v6, arg15);
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::wallet::destroy_or_deposit_balance<T0>(arg9, v9);
    }

    public fun ca_mb_ma<T0, T1, T2>(arg0: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: u128, arg2: u64, arg3: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T1>, arg4: u128, arg5: u64, arg6: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T0>, arg7: u128, arg8: u64, arg9: &mut 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::wallet::Vault<T0>, arg10: &mut 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::wallet::Vault<T1>, arg11: &mut 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::wallet::Vault<T2>, arg12: u64, arg13: &0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::datastore::Config, arg14: &0x2::clock::Clock, arg15: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg16: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg17: &mut 0x2::tx_context::TxContext) {
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::datastore::get_sender_if_whitelisted(arg13, arg17);
        let (v0, v1, v2) = 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::cts::ca<T0, T1>(arg0, arg12, arg1, arg14, arg15);
        let v3 = v0;
        let (v4, v5) = 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::mmt::mb_<T2, T1>(arg3, 0x2::balance::value<T1>(&v3), arg4, arg14, arg16, arg10, arg17);
        let v6 = v4;
        let (v7, v8) = 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::mmt::ma__<T2, T0>(arg6, 0x2::balance::value<T2>(&v6), arg7, arg14, arg16, arg11, v1, arg17);
        let v9 = v7;
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::asserts::must_amount_greated_than(0x2::balance::value<T0>(&v9), arg12);
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::cts::repay_f_s_x<T0, T1>(arg0, v2, 0x2::balance::split<T0>(&mut v9, arg12), arg15);
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::mmt::repay_f_s_y<T2, T1>(arg3, v5, v3, arg16, arg17);
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::mmt::repay_f_s_x<T2, T0>(arg6, v8, v6, arg16, arg17);
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::wallet::destroy_or_deposit_balance<T0>(arg9, v9);
    }

    public fun ca_mb_mb<T0, T1, T2>(arg0: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: u128, arg2: u64, arg3: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T1>, arg4: u128, arg5: u64, arg6: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T2>, arg7: u128, arg8: u64, arg9: &mut 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::wallet::Vault<T0>, arg10: &mut 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::wallet::Vault<T1>, arg11: &mut 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::wallet::Vault<T2>, arg12: u64, arg13: &0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::datastore::Config, arg14: &0x2::clock::Clock, arg15: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg16: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg17: &mut 0x2::tx_context::TxContext) {
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::datastore::get_sender_if_whitelisted(arg13, arg17);
        let (v0, v1, v2) = 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::cts::ca<T0, T1>(arg0, arg12, arg1, arg14, arg15);
        let v3 = v0;
        let (v4, v5) = 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::mmt::mb_<T2, T1>(arg3, 0x2::balance::value<T1>(&v3), arg4, arg14, arg16, arg10, arg17);
        let v6 = v4;
        let (v7, v8) = 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::mmt::mb__<T0, T2>(arg6, 0x2::balance::value<T2>(&v6), arg7, arg14, arg16, arg11, v1, arg17);
        let v9 = v7;
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::asserts::must_amount_greated_than(0x2::balance::value<T0>(&v9), arg12);
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::cts::repay_f_s_x<T0, T1>(arg0, v2, 0x2::balance::split<T0>(&mut v9, arg12), arg15);
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::mmt::repay_f_s_y<T2, T1>(arg3, v5, v3, arg16, arg17);
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::mmt::repay_f_s_y<T0, T2>(arg6, v8, v6, arg16, arg17);
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::wallet::destroy_or_deposit_balance<T0>(arg9, v9);
    }

    public fun cb_ca_ma<T0, T1, T2>(arg0: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: u128, arg2: u64, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T2>, arg4: u128, arg5: u64, arg6: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T1>, arg7: u128, arg8: u64, arg9: &mut 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::wallet::Vault<T0>, arg10: &mut 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::wallet::Vault<T1>, arg11: &mut 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::wallet::Vault<T2>, arg12: u64, arg13: &0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::datastore::Config, arg14: &0x2::clock::Clock, arg15: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg16: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg17: &mut 0x2::tx_context::TxContext) {
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::datastore::get_sender_if_whitelisted(arg13, arg17);
        let (v0, v1, v2) = 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::cts::cb<T0, T1>(arg0, arg12, arg1, arg14, arg15);
        let v3 = v0;
        let (v4, v5) = 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::cts::ca_<T0, T2>(arg3, 0x2::balance::value<T0>(&v3), arg4, arg14, arg15, arg9);
        let v6 = v4;
        let (v7, v8) = 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::mmt::ma__<T2, T1>(arg6, 0x2::balance::value<T2>(&v6), arg7, arg14, arg16, arg11, v1, arg17);
        let v9 = v7;
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::asserts::must_amount_greated_than(0x2::balance::value<T1>(&v9), arg12);
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::cts::repay_f_s_y<T0, T1>(arg0, v2, 0x2::balance::split<T1>(&mut v9, arg12), arg15);
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::cts::repay_f_s_x<T0, T2>(arg3, v5, v3, arg15);
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::mmt::repay_f_s_x<T2, T1>(arg6, v8, v6, arg16, arg17);
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::wallet::destroy_or_deposit_balance<T1>(arg10, v9);
    }

    public fun cb_ca_mb<T0, T1, T2>(arg0: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: u128, arg2: u64, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T2>, arg4: u128, arg5: u64, arg6: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T2>, arg7: u128, arg8: u64, arg9: &mut 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::wallet::Vault<T0>, arg10: &mut 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::wallet::Vault<T1>, arg11: &mut 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::wallet::Vault<T2>, arg12: u64, arg13: &0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::datastore::Config, arg14: &0x2::clock::Clock, arg15: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg16: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg17: &mut 0x2::tx_context::TxContext) {
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::datastore::get_sender_if_whitelisted(arg13, arg17);
        let (v0, v1, v2) = 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::cts::cb<T0, T1>(arg0, arg12, arg1, arg14, arg15);
        let v3 = v0;
        let (v4, v5) = 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::cts::ca_<T0, T2>(arg3, 0x2::balance::value<T0>(&v3), arg4, arg14, arg15, arg9);
        let v6 = v4;
        let (v7, v8) = 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::mmt::mb__<T1, T2>(arg6, 0x2::balance::value<T2>(&v6), arg7, arg14, arg16, arg11, v1, arg17);
        let v9 = v7;
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::asserts::must_amount_greated_than(0x2::balance::value<T1>(&v9), arg12);
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::cts::repay_f_s_y<T0, T1>(arg0, v2, 0x2::balance::split<T1>(&mut v9, arg12), arg15);
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::cts::repay_f_s_x<T0, T2>(arg3, v5, v3, arg15);
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::mmt::repay_f_s_y<T1, T2>(arg6, v8, v6, arg16, arg17);
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::wallet::destroy_or_deposit_balance<T1>(arg10, v9);
    }

    public fun cb_cb_ma<T0, T1, T2>(arg0: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: u128, arg2: u64, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T0>, arg4: u128, arg5: u64, arg6: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T1>, arg7: u128, arg8: u64, arg9: &mut 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::wallet::Vault<T0>, arg10: &mut 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::wallet::Vault<T1>, arg11: &mut 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::wallet::Vault<T2>, arg12: u64, arg13: &0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::datastore::Config, arg14: &0x2::clock::Clock, arg15: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg16: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg17: &mut 0x2::tx_context::TxContext) {
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::datastore::get_sender_if_whitelisted(arg13, arg17);
        let (v0, v1, v2) = 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::cts::cb<T0, T1>(arg0, arg12, arg1, arg14, arg15);
        let v3 = v0;
        let (v4, v5) = 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::cts::cb_<T2, T0>(arg3, 0x2::balance::value<T0>(&v3), arg4, arg14, arg15, arg9);
        let v6 = v4;
        let (v7, v8) = 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::mmt::ma__<T2, T1>(arg6, 0x2::balance::value<T2>(&v6), arg7, arg14, arg16, arg11, v1, arg17);
        let v9 = v7;
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::asserts::must_amount_greated_than(0x2::balance::value<T1>(&v9), arg12);
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::cts::repay_f_s_y<T0, T1>(arg0, v2, 0x2::balance::split<T1>(&mut v9, arg12), arg15);
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::cts::repay_f_s_y<T2, T0>(arg3, v5, v3, arg15);
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::mmt::repay_f_s_x<T2, T1>(arg6, v8, v6, arg16, arg17);
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::wallet::destroy_or_deposit_balance<T1>(arg10, v9);
    }

    public fun cb_cb_mb<T0, T1, T2>(arg0: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: u128, arg2: u64, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T0>, arg4: u128, arg5: u64, arg6: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T2>, arg7: u128, arg8: u64, arg9: &mut 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::wallet::Vault<T0>, arg10: &mut 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::wallet::Vault<T1>, arg11: &mut 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::wallet::Vault<T2>, arg12: u64, arg13: &0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::datastore::Config, arg14: &0x2::clock::Clock, arg15: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg16: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg17: &mut 0x2::tx_context::TxContext) {
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::datastore::get_sender_if_whitelisted(arg13, arg17);
        let (v0, v1, v2) = 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::cts::cb<T0, T1>(arg0, arg12, arg1, arg14, arg15);
        let v3 = v0;
        let (v4, v5) = 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::cts::cb_<T2, T0>(arg3, 0x2::balance::value<T0>(&v3), arg4, arg14, arg15, arg9);
        let v6 = v4;
        let (v7, v8) = 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::mmt::mb__<T1, T2>(arg6, 0x2::balance::value<T2>(&v6), arg7, arg14, arg16, arg11, v1, arg17);
        let v9 = v7;
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::asserts::must_amount_greated_than(0x2::balance::value<T1>(&v9), arg12);
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::cts::repay_f_s_y<T0, T1>(arg0, v2, 0x2::balance::split<T1>(&mut v9, arg12), arg15);
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::cts::repay_f_s_y<T2, T0>(arg3, v5, v3, arg15);
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::mmt::repay_f_s_y<T1, T2>(arg6, v8, v6, arg16, arg17);
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::wallet::destroy_or_deposit_balance<T1>(arg10, v9);
    }

    public fun cb_ma_ca<T0, T1, T2>(arg0: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: u128, arg2: u64, arg3: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T2>, arg4: u128, arg5: u64, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>, arg7: u128, arg8: u64, arg9: &mut 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::wallet::Vault<T0>, arg10: &mut 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::wallet::Vault<T1>, arg11: &mut 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::wallet::Vault<T2>, arg12: u64, arg13: &0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::datastore::Config, arg14: &0x2::clock::Clock, arg15: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg16: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg17: &mut 0x2::tx_context::TxContext) {
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::datastore::get_sender_if_whitelisted(arg13, arg17);
        let (v0, v1, v2) = 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::cts::cb<T0, T1>(arg0, arg12, arg1, arg14, arg15);
        let v3 = v0;
        let (v4, v5) = 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::mmt::ma_<T0, T2>(arg3, 0x2::balance::value<T0>(&v3), arg4, arg14, arg16, arg9, arg17);
        let v6 = v4;
        let (v7, v8) = 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::cts::ca__<T2, T1>(arg6, 0x2::balance::value<T2>(&v6), arg7, arg14, arg15, arg11, v1);
        let v9 = v7;
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::asserts::must_amount_greated_than(0x2::balance::value<T1>(&v9), arg12);
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::cts::repay_f_s_y<T0, T1>(arg0, v2, 0x2::balance::split<T1>(&mut v9, arg12), arg15);
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::mmt::repay_f_s_x<T0, T2>(arg3, v5, v3, arg16, arg17);
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::cts::repay_f_s_x<T2, T1>(arg6, v8, v6, arg15);
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::wallet::destroy_or_deposit_balance<T1>(arg10, v9);
    }

    public fun cb_ma_cb<T0, T1, T2>(arg0: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: u128, arg2: u64, arg3: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T2>, arg4: u128, arg5: u64, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg7: u128, arg8: u64, arg9: &mut 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::wallet::Vault<T0>, arg10: &mut 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::wallet::Vault<T1>, arg11: &mut 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::wallet::Vault<T2>, arg12: u64, arg13: &0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::datastore::Config, arg14: &0x2::clock::Clock, arg15: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg16: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg17: &mut 0x2::tx_context::TxContext) {
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::datastore::get_sender_if_whitelisted(arg13, arg17);
        let (v0, v1, v2) = 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::cts::cb<T0, T1>(arg0, arg12, arg1, arg14, arg15);
        let v3 = v0;
        let (v4, v5) = 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::mmt::ma_<T0, T2>(arg3, 0x2::balance::value<T0>(&v3), arg4, arg14, arg16, arg9, arg17);
        let v6 = v4;
        let (v7, v8) = 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::cts::cb__<T1, T2>(arg6, 0x2::balance::value<T2>(&v6), arg7, arg14, arg15, arg11, v1);
        let v9 = v7;
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::asserts::must_amount_greated_than(0x2::balance::value<T1>(&v9), arg12);
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::cts::repay_f_s_y<T0, T1>(arg0, v2, 0x2::balance::split<T1>(&mut v9, arg12), arg15);
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::mmt::repay_f_s_x<T0, T2>(arg3, v5, v3, arg16, arg17);
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::cts::repay_f_s_y<T1, T2>(arg6, v8, v6, arg15);
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::wallet::destroy_or_deposit_balance<T1>(arg10, v9);
    }

    public fun cb_ma_ma<T0, T1, T2>(arg0: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: u128, arg2: u64, arg3: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T2>, arg4: u128, arg5: u64, arg6: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T1>, arg7: u128, arg8: u64, arg9: &mut 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::wallet::Vault<T0>, arg10: &mut 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::wallet::Vault<T1>, arg11: &mut 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::wallet::Vault<T2>, arg12: u64, arg13: &0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::datastore::Config, arg14: &0x2::clock::Clock, arg15: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg16: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg17: &mut 0x2::tx_context::TxContext) {
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::datastore::get_sender_if_whitelisted(arg13, arg17);
        let (v0, v1, v2) = 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::cts::cb<T0, T1>(arg0, arg12, arg1, arg14, arg15);
        let v3 = v0;
        let (v4, v5) = 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::mmt::ma_<T0, T2>(arg3, 0x2::balance::value<T0>(&v3), arg4, arg14, arg16, arg9, arg17);
        let v6 = v4;
        let (v7, v8) = 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::mmt::ma__<T2, T1>(arg6, 0x2::balance::value<T2>(&v6), arg7, arg14, arg16, arg11, v1, arg17);
        let v9 = v7;
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::asserts::must_amount_greated_than(0x2::balance::value<T1>(&v9), arg12);
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::cts::repay_f_s_y<T0, T1>(arg0, v2, 0x2::balance::split<T1>(&mut v9, arg12), arg15);
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::mmt::repay_f_s_x<T0, T2>(arg3, v5, v3, arg16, arg17);
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::mmt::repay_f_s_x<T2, T1>(arg6, v8, v6, arg16, arg17);
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::wallet::destroy_or_deposit_balance<T1>(arg10, v9);
    }

    public fun cb_ma_mb<T0, T1, T2>(arg0: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: u128, arg2: u64, arg3: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T2>, arg4: u128, arg5: u64, arg6: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T2>, arg7: u128, arg8: u64, arg9: &mut 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::wallet::Vault<T0>, arg10: &mut 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::wallet::Vault<T1>, arg11: &mut 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::wallet::Vault<T2>, arg12: u64, arg13: &0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::datastore::Config, arg14: &0x2::clock::Clock, arg15: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg16: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg17: &mut 0x2::tx_context::TxContext) {
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::datastore::get_sender_if_whitelisted(arg13, arg17);
        let (v0, v1, v2) = 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::cts::cb<T0, T1>(arg0, arg12, arg1, arg14, arg15);
        let v3 = v0;
        let (v4, v5) = 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::mmt::ma_<T0, T2>(arg3, 0x2::balance::value<T0>(&v3), arg4, arg14, arg16, arg9, arg17);
        let v6 = v4;
        let (v7, v8) = 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::mmt::mb__<T1, T2>(arg6, 0x2::balance::value<T2>(&v6), arg7, arg14, arg16, arg11, v1, arg17);
        let v9 = v7;
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::asserts::must_amount_greated_than(0x2::balance::value<T1>(&v9), arg12);
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::cts::repay_f_s_y<T0, T1>(arg0, v2, 0x2::balance::split<T1>(&mut v9, arg12), arg15);
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::mmt::repay_f_s_x<T0, T2>(arg3, v5, v3, arg16, arg17);
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::mmt::repay_f_s_y<T1, T2>(arg6, v8, v6, arg16, arg17);
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::wallet::destroy_or_deposit_balance<T1>(arg10, v9);
    }

    public fun cb_mb_ca<T0, T1, T2>(arg0: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: u128, arg2: u64, arg3: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T0>, arg4: u128, arg5: u64, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>, arg7: u128, arg8: u64, arg9: &mut 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::wallet::Vault<T0>, arg10: &mut 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::wallet::Vault<T1>, arg11: &mut 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::wallet::Vault<T2>, arg12: u64, arg13: &0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::datastore::Config, arg14: &0x2::clock::Clock, arg15: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg16: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg17: &mut 0x2::tx_context::TxContext) {
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::datastore::get_sender_if_whitelisted(arg13, arg17);
        let (v0, v1, v2) = 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::cts::cb<T0, T1>(arg0, arg12, arg1, arg14, arg15);
        let v3 = v0;
        let (v4, v5) = 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::mmt::mb_<T2, T0>(arg3, 0x2::balance::value<T0>(&v3), arg4, arg14, arg16, arg9, arg17);
        let v6 = v4;
        let (v7, v8) = 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::cts::ca__<T2, T1>(arg6, 0x2::balance::value<T2>(&v6), arg7, arg14, arg15, arg11, v1);
        let v9 = v7;
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::asserts::must_amount_greated_than(0x2::balance::value<T1>(&v9), arg12);
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::cts::repay_f_s_y<T0, T1>(arg0, v2, 0x2::balance::split<T1>(&mut v9, arg12), arg15);
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::mmt::repay_f_s_y<T2, T0>(arg3, v5, v3, arg16, arg17);
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::cts::repay_f_s_x<T2, T1>(arg6, v8, v6, arg15);
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::wallet::destroy_or_deposit_balance<T1>(arg10, v9);
    }

    public fun cb_mb_cb<T0, T1, T2>(arg0: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: u128, arg2: u64, arg3: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T0>, arg4: u128, arg5: u64, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg7: u128, arg8: u64, arg9: &mut 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::wallet::Vault<T0>, arg10: &mut 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::wallet::Vault<T1>, arg11: &mut 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::wallet::Vault<T2>, arg12: u64, arg13: &0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::datastore::Config, arg14: &0x2::clock::Clock, arg15: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg16: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg17: &mut 0x2::tx_context::TxContext) {
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::datastore::get_sender_if_whitelisted(arg13, arg17);
        let (v0, v1, v2) = 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::cts::cb<T0, T1>(arg0, arg12, arg1, arg14, arg15);
        let v3 = v0;
        let (v4, v5) = 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::mmt::mb_<T2, T0>(arg3, 0x2::balance::value<T0>(&v3), arg4, arg14, arg16, arg9, arg17);
        let v6 = v4;
        let (v7, v8) = 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::cts::cb__<T1, T2>(arg6, 0x2::balance::value<T2>(&v6), arg7, arg14, arg15, arg11, v1);
        let v9 = v7;
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::asserts::must_amount_greated_than(0x2::balance::value<T1>(&v9), arg12);
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::cts::repay_f_s_y<T0, T1>(arg0, v2, 0x2::balance::split<T1>(&mut v9, arg12), arg15);
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::mmt::repay_f_s_y<T2, T0>(arg3, v5, v3, arg16, arg17);
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::cts::repay_f_s_y<T1, T2>(arg6, v8, v6, arg15);
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::wallet::destroy_or_deposit_balance<T1>(arg10, v9);
    }

    public fun cb_mb_ma<T0, T1, T2>(arg0: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: u128, arg2: u64, arg3: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T0>, arg4: u128, arg5: u64, arg6: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T1>, arg7: u128, arg8: u64, arg9: &mut 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::wallet::Vault<T0>, arg10: &mut 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::wallet::Vault<T1>, arg11: &mut 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::wallet::Vault<T2>, arg12: u64, arg13: &0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::datastore::Config, arg14: &0x2::clock::Clock, arg15: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg16: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg17: &mut 0x2::tx_context::TxContext) {
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::datastore::get_sender_if_whitelisted(arg13, arg17);
        let (v0, v1, v2) = 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::cts::cb<T0, T1>(arg0, arg12, arg1, arg14, arg15);
        let v3 = v0;
        let (v4, v5) = 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::mmt::mb_<T2, T0>(arg3, 0x2::balance::value<T0>(&v3), arg4, arg14, arg16, arg9, arg17);
        let v6 = v4;
        let (v7, v8) = 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::mmt::ma__<T2, T1>(arg6, 0x2::balance::value<T2>(&v6), arg7, arg14, arg16, arg11, v1, arg17);
        let v9 = v7;
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::asserts::must_amount_greated_than(0x2::balance::value<T1>(&v9), arg12);
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::cts::repay_f_s_y<T0, T1>(arg0, v2, 0x2::balance::split<T1>(&mut v9, arg12), arg15);
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::mmt::repay_f_s_y<T2, T0>(arg3, v5, v3, arg16, arg17);
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::mmt::repay_f_s_x<T2, T1>(arg6, v8, v6, arg16, arg17);
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::wallet::destroy_or_deposit_balance<T1>(arg10, v9);
    }

    public fun cb_mb_mb<T0, T1, T2>(arg0: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: u128, arg2: u64, arg3: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T0>, arg4: u128, arg5: u64, arg6: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T2>, arg7: u128, arg8: u64, arg9: &mut 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::wallet::Vault<T0>, arg10: &mut 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::wallet::Vault<T1>, arg11: &mut 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::wallet::Vault<T2>, arg12: u64, arg13: &0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::datastore::Config, arg14: &0x2::clock::Clock, arg15: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg16: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg17: &mut 0x2::tx_context::TxContext) {
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::datastore::get_sender_if_whitelisted(arg13, arg17);
        let (v0, v1, v2) = 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::cts::cb<T0, T1>(arg0, arg12, arg1, arg14, arg15);
        let v3 = v0;
        let (v4, v5) = 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::mmt::mb_<T2, T0>(arg3, 0x2::balance::value<T0>(&v3), arg4, arg14, arg16, arg9, arg17);
        let v6 = v4;
        let (v7, v8) = 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::mmt::mb__<T1, T2>(arg6, 0x2::balance::value<T2>(&v6), arg7, arg14, arg16, arg11, v1, arg17);
        let v9 = v7;
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::asserts::must_amount_greated_than(0x2::balance::value<T1>(&v9), arg12);
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::cts::repay_f_s_y<T0, T1>(arg0, v2, 0x2::balance::split<T1>(&mut v9, arg12), arg15);
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::mmt::repay_f_s_y<T2, T0>(arg3, v5, v3, arg16, arg17);
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::mmt::repay_f_s_y<T1, T2>(arg6, v8, v6, arg16, arg17);
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::wallet::destroy_or_deposit_balance<T1>(arg10, v9);
    }

    // decompiled from Move bytecode v7
}

