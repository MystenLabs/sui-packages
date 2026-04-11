module 0x9701ac378086db7d57f703559846bd567e75cfb2f0d894c515a6c359692c46a1::swap_tw_mmt_trb {
    public fun ma_ta<T0, T1, T2>(arg0: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: u128, arg2: u64, arg3: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T1, T0, T2>, arg4: u64, arg5: u128, arg6: u64, arg7: &mut 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::wallet::Vault<T0>, arg8: &mut 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::wallet::Vault<T1>, arg9: u64, arg10: &0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::datastore::Config, arg11: &0x2::clock::Clock, arg12: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg13: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg14: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::mmt::ma<T0, T1>(arg0, arg9, arg1, arg11, arg12, arg14);
        let v3 = 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::trb::ta_balance__<T1, T0, T2>(v0, arg3, arg4, arg5, arg13, 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::datastore::get_sender_if_whitelisted(arg10, arg14), arg11, arg8, v1, arg14);
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::asserts::must_amount_greated_than(0x2::balance::value<T0>(&v3), arg9);
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::mmt::repay_f_s_x<T0, T1>(arg0, v2, 0x2::balance::split<T0>(&mut v3, arg9), arg12, arg14);
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::wallet::destroy_or_deposit_balance<T0>(arg7, v3);
    }

    public fun ma_tb<T0, T1, T2>(arg0: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: u128, arg2: u64, arg3: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg4: u64, arg5: u128, arg6: u64, arg7: &mut 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::wallet::Vault<T0>, arg8: &mut 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::wallet::Vault<T1>, arg9: u64, arg10: &0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::datastore::Config, arg11: &0x2::clock::Clock, arg12: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg13: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg14: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::mmt::ma<T0, T1>(arg0, arg9, arg1, arg11, arg12, arg14);
        let v3 = 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::trb::tb_balance__<T0, T1, T2>(v0, arg3, arg4, arg5, arg13, 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::datastore::get_sender_if_whitelisted(arg10, arg14), arg11, arg8, v1, arg14);
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::asserts::must_amount_greated_than(0x2::balance::value<T0>(&v3), arg9);
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::mmt::repay_f_s_x<T0, T1>(arg0, v2, 0x2::balance::split<T0>(&mut v3, arg9), arg12, arg14);
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::wallet::destroy_or_deposit_balance<T0>(arg7, v3);
    }

    public fun mb_ta<T0, T1, T2>(arg0: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: u128, arg2: u64, arg3: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg4: u64, arg5: u128, arg6: u64, arg7: &mut 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::wallet::Vault<T0>, arg8: &mut 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::wallet::Vault<T1>, arg9: u64, arg10: &0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::datastore::Config, arg11: &0x2::clock::Clock, arg12: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg13: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg14: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::mmt::mb<T0, T1>(arg0, arg9, arg1, arg11, arg12, arg14);
        let v3 = 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::trb::ta_balance__<T0, T1, T2>(v0, arg3, arg4, arg5, arg13, 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::datastore::get_sender_if_whitelisted(arg10, arg14), arg11, arg7, v1, arg14);
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::asserts::must_amount_greated_than(0x2::balance::value<T1>(&v3), arg9);
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::mmt::repay_f_s_y<T0, T1>(arg0, v2, 0x2::balance::split<T1>(&mut v3, arg9), arg12, arg14);
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::wallet::destroy_or_deposit_balance<T1>(arg8, v3);
    }

    public fun mb_tb<T0, T1, T2>(arg0: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: u128, arg2: u64, arg3: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T1, T0, T2>, arg4: u64, arg5: u128, arg6: u64, arg7: &mut 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::wallet::Vault<T0>, arg8: &mut 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::wallet::Vault<T1>, arg9: u64, arg10: &0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::datastore::Config, arg11: &0x2::clock::Clock, arg12: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg13: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg14: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::mmt::mb<T0, T1>(arg0, arg9, arg1, arg11, arg12, arg14);
        let v3 = 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::trb::tb_balance__<T1, T0, T2>(v0, arg3, arg4, arg5, arg13, 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::datastore::get_sender_if_whitelisted(arg10, arg14), arg11, arg7, v1, arg14);
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::asserts::must_amount_greated_than(0x2::balance::value<T1>(&v3), arg9);
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::mmt::repay_f_s_y<T0, T1>(arg0, v2, 0x2::balance::split<T1>(&mut v3, arg9), arg12, arg14);
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::wallet::destroy_or_deposit_balance<T1>(arg8, v3);
    }

    // decompiled from Move bytecode v7
}

