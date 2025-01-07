module 0x4d2a6cf777e0e8080f5c69734c17863a6a4a3450187784df56120271c6783e23::utils {
    public fun calc_aum<T0, T1, T2>(arg0: &0x4d2a6cf777e0e8080f5c69734c17863a6a4a3450187784df56120271c6783e23::vault::Vault<T0, T1, T2>, arg1: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg2: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg3: &0x7903ed759a2e2749ecdb64a8f100b0a547185f2ef7ea286048aa1f174c8a8b9a::oracle::KriyaOracle, arg4: &0xa0f0687f5122e80366716e6594d9a5aae2015b24003d9bcb6b4576af357635b2::registry::CoinDecimalsRegistry, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg6: &0x2::clock::Clock) : (u64, u64, u64) {
        let (v0, v1) = 0x4d2a6cf777e0e8080f5c69734c17863a6a4a3450187784df56120271c6783e23::vault::info<T0, T1, T2>(arg0, arg1, arg2, arg5);
        (v0 - 0x7903ed759a2e2749ecdb64a8f100b0a547185f2ef7ea286048aa1f174c8a8b9a::oracle_utils::get_amount(0x1::type_name::get<T0>(), 0x7903ed759a2e2749ecdb64a8f100b0a547185f2ef7ea286048aa1f174c8a8b9a::oracle_utils::get_usd_value(0x1::type_name::get<T1>(), v1, arg3, arg4, arg6), arg3, arg4, arg6), v0, v1)
    }

    public fun deposit_flow_id() : u8 {
        1
    }

    public fun get_cur_leverage<T0, T1, T2>(arg0: &0x4d2a6cf777e0e8080f5c69734c17863a6a4a3450187784df56120271c6783e23::vault::Vault<T0, T1, T2>, arg1: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg2: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg3: &0x7903ed759a2e2749ecdb64a8f100b0a547185f2ef7ea286048aa1f174c8a8b9a::oracle::KriyaOracle, arg4: &0xa0f0687f5122e80366716e6594d9a5aae2015b24003d9bcb6b4576af357635b2::registry::CoinDecimalsRegistry, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg6: &0x2::clock::Clock) : u64 {
        let (v0, v1, _) = calc_aum<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
        (((v1 as u256) * (0x4d2a6cf777e0e8080f5c69734c17863a6a4a3450187784df56120271c6783e23::vault::leverage_scaling() as u256) / (v0 as u256)) as u64)
    }

    public fun harvest_flow_id() : u8 {
        3
    }

    public fun update_leverage_flow_id() : u8 {
        4
    }

    public fun withdraw_flow_id() : u8 {
        2
    }

    // decompiled from Move bytecode v6
}

