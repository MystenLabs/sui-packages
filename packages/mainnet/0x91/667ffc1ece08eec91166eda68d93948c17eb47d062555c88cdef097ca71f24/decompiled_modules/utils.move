module 0x91667ffc1ece08eec91166eda68d93948c17eb47d062555c88cdef097ca71f24::utils {
    public fun calc_aum<T0, T1, T2>(arg0: &0x91667ffc1ece08eec91166eda68d93948c17eb47d062555c88cdef097ca71f24::vault::Vault<T0, T1, T2>, arg1: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg2: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg3: &0x66c89d60620182f7e3084095dcf75f5ded8f328ffc148c825f2e4f38346a9ffd::oracle::KriyaOracle, arg4: &0xab1dc9e395f2be7ea69ffba49c451da8e841911fe532a6ed5bd4cf0af1dbd680::registry::CoinDecimalsRegistry, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg6: &0x2::clock::Clock) : (u64, u64, u64) {
        let (v0, v1) = 0x91667ffc1ece08eec91166eda68d93948c17eb47d062555c88cdef097ca71f24::vault::info<T0, T1, T2>(arg0, arg1, arg2, arg5);
        (v0 - 0x66c89d60620182f7e3084095dcf75f5ded8f328ffc148c825f2e4f38346a9ffd::oracle_utils::get_amount(0x1::type_name::get<T0>(), 0x66c89d60620182f7e3084095dcf75f5ded8f328ffc148c825f2e4f38346a9ffd::oracle_utils::get_usd_value(0x1::type_name::get<T1>(), v1, arg3, arg4, arg6), arg3, arg4, arg6), v0, v1)
    }

    // decompiled from Move bytecode v6
}

