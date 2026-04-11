module 0x9701ac378086db7d57f703559846bd567e75cfb2f0d894c515a6c359692c46a1::swap_tw_mmt {
    public fun ma_ma<T0, T1>(arg0: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: u128, arg2: u64, arg3: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T0>, arg4: u128, arg5: u64, arg6: &mut 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::wallet::Vault<T0>, arg7: &mut 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::wallet::Vault<T1>, arg8: u64, arg9: &0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::datastore::Config, arg10: &0x2::clock::Clock, arg11: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg12: &mut 0x2::tx_context::TxContext) {
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::datastore::get_sender_if_whitelisted(arg9, arg12);
        let (v0, v1, v2) = 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::mmt::ma<T0, T1>(arg0, arg8, arg1, arg10, arg11, arg12);
        let v3 = v0;
        let (v4, v5) = 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::mmt::ma__<T1, T0>(arg3, 0x2::balance::value<T1>(&v3), arg4, arg10, arg11, arg7, v1, arg12);
        let v6 = v4;
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::asserts::must_amount_greated_than(0x2::balance::value<T0>(&v6), arg8);
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::mmt::repay_f_s_x<T0, T1>(arg0, v2, 0x2::balance::split<T0>(&mut v6, arg8), arg11, arg12);
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::mmt::repay_f_s_x<T1, T0>(arg3, v5, v3, arg11, arg12);
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::wallet::destroy_or_deposit_balance<T0>(arg6, v6);
    }

    public fun ma_mb<T0, T1>(arg0: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: u128, arg2: u64, arg3: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg4: u128, arg5: u64, arg6: &mut 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::wallet::Vault<T0>, arg7: &mut 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::wallet::Vault<T1>, arg8: u64, arg9: &0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::datastore::Config, arg10: &0x2::clock::Clock, arg11: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg12: &mut 0x2::tx_context::TxContext) {
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::datastore::get_sender_if_whitelisted(arg9, arg12);
        let (v0, v1, v2) = 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::mmt::ma<T0, T1>(arg0, arg8, arg1, arg10, arg11, arg12);
        let v3 = v0;
        let (v4, v5) = 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::mmt::mb__<T0, T1>(arg3, 0x2::balance::value<T1>(&v3), arg4, arg10, arg11, arg7, v1, arg12);
        let v6 = v4;
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::asserts::must_amount_greated_than(0x2::balance::value<T0>(&v6), arg8);
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::mmt::repay_f_s_x<T0, T1>(arg0, v2, 0x2::balance::split<T0>(&mut v6, arg8), arg11, arg12);
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::mmt::repay_f_s_y<T0, T1>(arg3, v5, v3, arg11, arg12);
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::wallet::destroy_or_deposit_balance<T0>(arg6, v6);
    }

    public fun mb_ma<T0, T1>(arg0: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: u128, arg2: u64, arg3: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg4: u128, arg5: u64, arg6: &mut 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::wallet::Vault<T0>, arg7: &mut 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::wallet::Vault<T1>, arg8: u64, arg9: &0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::datastore::Config, arg10: &0x2::clock::Clock, arg11: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg12: &mut 0x2::tx_context::TxContext) {
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::datastore::get_sender_if_whitelisted(arg9, arg12);
        let (v0, v1, v2) = 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::mmt::mb<T0, T1>(arg0, arg8, arg1, arg10, arg11, arg12);
        let v3 = v0;
        let (v4, v5) = 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::mmt::ma__<T0, T1>(arg3, 0x2::balance::value<T0>(&v3), arg4, arg10, arg11, arg6, v1, arg12);
        let v6 = v4;
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::asserts::must_amount_greated_than(0x2::balance::value<T1>(&v6), arg8);
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::mmt::repay_f_s_y<T0, T1>(arg0, v2, 0x2::balance::split<T1>(&mut v6, arg8), arg11, arg12);
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::mmt::repay_f_s_x<T0, T1>(arg3, v5, v3, arg11, arg12);
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::wallet::destroy_or_deposit_balance<T1>(arg7, v6);
    }

    public fun mb_mb<T0, T1>(arg0: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: u128, arg2: u64, arg3: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T0>, arg4: u128, arg5: u64, arg6: &mut 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::wallet::Vault<T0>, arg7: &mut 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::wallet::Vault<T1>, arg8: u64, arg9: &0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::datastore::Config, arg10: &0x2::clock::Clock, arg11: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg12: &mut 0x2::tx_context::TxContext) {
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::datastore::get_sender_if_whitelisted(arg9, arg12);
        let (v0, v1, v2) = 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::mmt::mb<T0, T1>(arg0, arg8, arg1, arg10, arg11, arg12);
        let v3 = v0;
        let (v4, v5) = 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::mmt::mb__<T1, T0>(arg3, 0x2::balance::value<T0>(&v3), arg4, arg10, arg11, arg6, v1, arg12);
        let v6 = v4;
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::asserts::must_amount_greated_than(0x2::balance::value<T1>(&v6), arg8);
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::mmt::repay_f_s_y<T0, T1>(arg0, v2, 0x2::balance::split<T1>(&mut v6, arg8), arg11, arg12);
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::mmt::repay_f_s_y<T1, T0>(arg3, v5, v3, arg11, arg12);
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::wallet::destroy_or_deposit_balance<T1>(arg7, v6);
    }

    // decompiled from Move bytecode v7
}

