module 0xfba5d0a4d3fd7de52dd91e9d0a391592dba646c5487612b436b09956be135274::utils {
    public fun calc_aum<T0, T1, T2>(arg0: &0xfba5d0a4d3fd7de52dd91e9d0a391592dba646c5487612b436b09956be135274::vault::Vault<T0, T1, T2>, arg1: &0xce7e9b076229e914dc87900323fa122fb6869f39fda82b85770d1aa27f61ad8e::oracle::KriyaOracle, arg2: &0xdf3da4bcc7939caf6486ecc104e1cbd69f97f2025195d270649566301d15eb96::registry::CoinDecimalsRegistry, arg3: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg4: &0x2::clock::Clock) : (u64, u64, u64) {
        let (v0, v1) = 0xfba5d0a4d3fd7de52dd91e9d0a391592dba646c5487612b436b09956be135274::vault::info<T0, T1, T2>(arg0, arg3);
        (v0 - 0xce7e9b076229e914dc87900323fa122fb6869f39fda82b85770d1aa27f61ad8e::oracle_utils::get_amount(0x1::type_name::get<T0>(), 0xce7e9b076229e914dc87900323fa122fb6869f39fda82b85770d1aa27f61ad8e::oracle_utils::get_usd_value(0x1::type_name::get<T1>(), v1, arg1, arg2, arg4), arg1, arg2, arg4), v0, v1)
    }

    public fun get_cur_leverage<T0, T1, T2>(arg0: &0xfba5d0a4d3fd7de52dd91e9d0a391592dba646c5487612b436b09956be135274::vault::Vault<T0, T1, T2>, arg1: &0xce7e9b076229e914dc87900323fa122fb6869f39fda82b85770d1aa27f61ad8e::oracle::KriyaOracle, arg2: &0xdf3da4bcc7939caf6486ecc104e1cbd69f97f2025195d270649566301d15eb96::registry::CoinDecimalsRegistry, arg3: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg4: &0x2::clock::Clock) : u64 {
        let (v0, v1, _) = calc_aum<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4);
        (((v1 as u256) * (0xfba5d0a4d3fd7de52dd91e9d0a391592dba646c5487612b436b09956be135274::vault::leverage_scaling() as u256) / (v0 as u256)) as u64)
    }

    public fun get_slippage_adjusted_sqrt_price(arg0: bool, arg1: u128, arg2: u128, arg3: u128) : u128 {
        if (arg1 == 0 && arg2 == 0) {
            if (arg0) {
                4295048016
            } else {
                79226673515401279992447579055
            }
        } else if (arg0) {
            scale(arg3, arg2)
        } else {
            scale(arg3, arg1)
        }
    }

    fun scale(arg0: u128, arg1: u128) : u128 {
        (((arg0 as u256) * (arg1 as u256) / (0xfba5d0a4d3fd7de52dd91e9d0a391592dba646c5487612b436b09956be135274::vault::slippage_scaling() as u256)) as u128)
    }

    // decompiled from Move bytecode v6
}

