module 0xea74470c6d6774c1e86621c46d8cc874b39a896288e66459abdee863a2bcdae3::utils {
    public fun calc_aum<T0, T1, T2>(arg0: &0xea74470c6d6774c1e86621c46d8cc874b39a896288e66459abdee863a2bcdae3::vault::Vault<T0, T1, T2>, arg1: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg2: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg3: &0xce7e9b076229e914dc87900323fa122fb6869f39fda82b85770d1aa27f61ad8e::oracle::KriyaOracle, arg4: &0xdf3da4bcc7939caf6486ecc104e1cbd69f97f2025195d270649566301d15eb96::registry::CoinDecimalsRegistry, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg6: &0x2::clock::Clock) : (u64, u64, u64) {
        let (v0, v1) = 0xea74470c6d6774c1e86621c46d8cc874b39a896288e66459abdee863a2bcdae3::vault::info<T0, T1, T2>(arg0, arg1, arg2, arg5);
        (v0 - 0xce7e9b076229e914dc87900323fa122fb6869f39fda82b85770d1aa27f61ad8e::oracle_utils::get_amount(0x1::type_name::get<T0>(), 0xce7e9b076229e914dc87900323fa122fb6869f39fda82b85770d1aa27f61ad8e::oracle_utils::get_usd_value(0x1::type_name::get<T1>(), v1, arg3, arg4, arg6), arg3, arg4, arg6), v0, v1)
    }

    public fun deposit_flow_id() : u8 {
        1
    }

    public fun get_cur_leverage<T0, T1, T2>(arg0: &0xea74470c6d6774c1e86621c46d8cc874b39a896288e66459abdee863a2bcdae3::vault::Vault<T0, T1, T2>, arg1: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg2: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg3: &0xce7e9b076229e914dc87900323fa122fb6869f39fda82b85770d1aa27f61ad8e::oracle::KriyaOracle, arg4: &0xdf3da4bcc7939caf6486ecc104e1cbd69f97f2025195d270649566301d15eb96::registry::CoinDecimalsRegistry, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg6: &0x2::clock::Clock) : u64 {
        let (v0, v1, _) = calc_aum<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
        (((v1 as u256) * (0xea74470c6d6774c1e86621c46d8cc874b39a896288e66459abdee863a2bcdae3::vault::leverage_scaling() as u256) / (v0 as u256)) as u64)
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

