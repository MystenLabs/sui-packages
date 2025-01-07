module 0x41b5d64b0662be085120834b56c299f19cc93482222a3b2f0339c99108fd1051::utils {
    public fun calc_aum<T0, T1, T2>(arg0: &0x41b5d64b0662be085120834b56c299f19cc93482222a3b2f0339c99108fd1051::vault::Vault<T0, T1, T2>, arg1: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg2: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg3: &0xda2cae21810dbf8b4e80ccbd535cf6980755c7a8945811a277b037f0a723d0f2::oracle::KriyaOracle, arg4: &0xdf3da4bcc7939caf6486ecc104e1cbd69f97f2025195d270649566301d15eb96::registry::CoinDecimalsRegistry, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg6: &0xda2cae21810dbf8b4e80ccbd535cf6980755c7a8945811a277b037f0a723d0f2::version::Version, arg7: &0x2::clock::Clock) : (u64, u64, u64) {
        let (v0, v1) = 0x41b5d64b0662be085120834b56c299f19cc93482222a3b2f0339c99108fd1051::vault::info<T0, T1, T2>(arg0, arg1, arg2, arg5);
        (v0 - 0xda2cae21810dbf8b4e80ccbd535cf6980755c7a8945811a277b037f0a723d0f2::oracle_utils::get_amount(arg6, 0x1::type_name::get<T0>(), 0xda2cae21810dbf8b4e80ccbd535cf6980755c7a8945811a277b037f0a723d0f2::oracle_utils::get_usd_value(arg6, 0x1::type_name::get<T1>(), v1, arg3, arg4, arg7), arg3, arg4, arg7), v0, v1)
    }

    public fun get_cur_leverage<T0, T1, T2>(arg0: &0x41b5d64b0662be085120834b56c299f19cc93482222a3b2f0339c99108fd1051::vault::Vault<T0, T1, T2>, arg1: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg2: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg3: &0xda2cae21810dbf8b4e80ccbd535cf6980755c7a8945811a277b037f0a723d0f2::oracle::KriyaOracle, arg4: &0xdf3da4bcc7939caf6486ecc104e1cbd69f97f2025195d270649566301d15eb96::registry::CoinDecimalsRegistry, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg6: &0xda2cae21810dbf8b4e80ccbd535cf6980755c7a8945811a277b037f0a723d0f2::version::Version, arg7: &0x2::clock::Clock) : u64 {
        let (v0, v1, _) = calc_aum<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        (((v1 as u256) * (0x41b5d64b0662be085120834b56c299f19cc93482222a3b2f0339c99108fd1051::vault::leverage_scaling() as u256) / (v0 as u256)) as u64)
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
        (((arg0 as u256) * (arg1 as u256) / (0x41b5d64b0662be085120834b56c299f19cc93482222a3b2f0339c99108fd1051::vault::slippage_scaling() as u256)) as u128)
    }

    // decompiled from Move bytecode v6
}

