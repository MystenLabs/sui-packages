module 0x1649a79b08c19dd5bac65cc559caa3132380f9f8b580aea4441cdb20d9d3382b::utils {
    public fun calc_aum<T0, T1, T2>(arg0: &0x1649a79b08c19dd5bac65cc559caa3132380f9f8b580aea4441cdb20d9d3382b::vault::Vault<T0, T1, T2>, arg1: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg2: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg3: &0x659b624dfd09c631f9925e21dd6144a483b0530fc0fd8a5b620e5d7b88d1bccf::oracle::KriyaOracle, arg4: &0x31f55a770ae4b852c36992dec0e794ed846e3160b1993b023328d815b0bc16f6::registry::CoinDecimalsRegistry, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg6: &0x2::clock::Clock) : (u64, u64, u64) {
        let (v0, v1) = 0x1649a79b08c19dd5bac65cc559caa3132380f9f8b580aea4441cdb20d9d3382b::vault::info<T0, T1, T2>(arg0, arg1, arg2, arg5);
        (v0 - 0x659b624dfd09c631f9925e21dd6144a483b0530fc0fd8a5b620e5d7b88d1bccf::oracle_utils::get_amount(0x1::type_name::get<T0>(), 0x659b624dfd09c631f9925e21dd6144a483b0530fc0fd8a5b620e5d7b88d1bccf::oracle_utils::get_usd_value(0x1::type_name::get<T1>(), v1, arg3, arg4, arg6), arg3, arg4, arg6), v0, v1)
    }

    // decompiled from Move bytecode v6
}

