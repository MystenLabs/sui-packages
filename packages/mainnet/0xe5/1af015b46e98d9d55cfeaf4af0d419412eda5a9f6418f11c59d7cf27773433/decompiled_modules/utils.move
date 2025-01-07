module 0x90332a76b3fdcd84edeb229315b3d623be7d5888aa733d3030b8cee9c53bb4ed::utils {
    public fun calc_aum<T0, T1, T2>(arg0: &0x90332a76b3fdcd84edeb229315b3d623be7d5888aa733d3030b8cee9c53bb4ed::vault::Vault<T0, T1, T2>, arg1: &0x7903ed759a2e2749ecdb64a8f100b0a547185f2ef7ea286048aa1f174c8a8b9a::oracle::KriyaOracle, arg2: &0xa0f0687f5122e80366716e6594d9a5aae2015b24003d9bcb6b4576af357635b2::registry::CoinDecimalsRegistry, arg3: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg4: &0x2::clock::Clock) : (u64, u64, u64) {
        let (v0, v1) = 0x90332a76b3fdcd84edeb229315b3d623be7d5888aa733d3030b8cee9c53bb4ed::vault::info<T0, T1, T2>(arg0, arg3);
        (v0 - 0x7903ed759a2e2749ecdb64a8f100b0a547185f2ef7ea286048aa1f174c8a8b9a::oracle_utils::get_amount(0x1::type_name::get<T0>(), 0x7903ed759a2e2749ecdb64a8f100b0a547185f2ef7ea286048aa1f174c8a8b9a::oracle_utils::get_usd_value(0x1::type_name::get<T1>(), v1, arg1, arg2, arg4), arg1, arg2, arg4), v0, v1)
    }

    public fun deposit_flow_id() : u8 {
        1
    }

    public fun get_cur_leverage<T0, T1, T2>(arg0: &0x90332a76b3fdcd84edeb229315b3d623be7d5888aa733d3030b8cee9c53bb4ed::vault::Vault<T0, T1, T2>, arg1: &0x7903ed759a2e2749ecdb64a8f100b0a547185f2ef7ea286048aa1f174c8a8b9a::oracle::KriyaOracle, arg2: &0xa0f0687f5122e80366716e6594d9a5aae2015b24003d9bcb6b4576af357635b2::registry::CoinDecimalsRegistry, arg3: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg4: &0x2::clock::Clock) : u64 {
        let (v0, v1, _) = calc_aum<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4);
        (((v1 as u256) * (0x90332a76b3fdcd84edeb229315b3d623be7d5888aa733d3030b8cee9c53bb4ed::vault::leverage_scaling() as u256) / (v0 as u256)) as u64)
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

