module 0x1649a79b08c19dd5bac65cc559caa3132380f9f8b580aea4441cdb20d9d3382b::deposit {
    struct DepositEvent has copy, drop, store {
        vault_id: 0x2::object::ID,
        user: address,
        deposit_amount: u64,
        lp_shares_minted: u64,
        total_deposited_a: u64,
        total_borrowed_b: u64,
        aum_in_a: u64,
        total_lp_supply: u64,
    }

    fun calc_vt_shares<T0, T1, T2>(arg0: &0x1649a79b08c19dd5bac65cc559caa3132380f9f8b580aea4441cdb20d9d3382b::vault::Vault<T0, T1, T2>, arg1: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg2: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg3: &0x659b624dfd09c631f9925e21dd6144a483b0530fc0fd8a5b620e5d7b88d1bccf::oracle::KriyaOracle, arg4: &0x31f55a770ae4b852c36992dec0e794ed846e3160b1993b023328d815b0bc16f6::registry::CoinDecimalsRegistry, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg6: u64, arg7: &0x2::clock::Clock) : u64 {
        let v0 = 0x1649a79b08c19dd5bac65cc559caa3132380f9f8b580aea4441cdb20d9d3382b::vault::total_vt_supply<T0, T1, T2>(arg0);
        if (v0 == 0) {
            return arg6
        };
        let (v1, _, _) = 0x1649a79b08c19dd5bac65cc559caa3132380f9f8b580aea4441cdb20d9d3382b::utils::calc_aum<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg7);
        (((arg6 as u256) * (v0 as u256) / (v1 as u256)) as u64)
    }

    public fun deposit_a<T0, T1, T2>(arg0: &mut 0x1649a79b08c19dd5bac65cc559caa3132380f9f8b580aea4441cdb20d9d3382b::vault::Vault<T0, T1, T2>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg8: &0x659b624dfd09c631f9925e21dd6144a483b0530fc0fd8a5b620e5d7b88d1bccf::oracle::KriyaOracle, arg9: &0x31f55a770ae4b852c36992dec0e794ed846e3160b1993b023328d815b0bc16f6::registry::CoinDecimalsRegistry, arg10: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg11: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg12: &0x2::clock::Clock, arg13: &0x1649a79b08c19dd5bac65cc559caa3132380f9f8b580aea4441cdb20d9d3382b::version::Version, arg14: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        0x1649a79b08c19dd5bac65cc559caa3132380f9f8b580aea4441cdb20d9d3382b::version::assert_current_version(arg13);
        let v0 = 0x2::coin::value<T0>(&arg1);
        let v1 = calc_vt_shares<T0, T1, T2>(arg0, arg4, arg5, arg8, arg9, arg3, v0, arg12);
        let (v2, v3, v4) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg11, arg2, false, false, get_deposit_flash_swap_amount(0x1649a79b08c19dd5bac65cc559caa3132380f9f8b580aea4441cdb20d9d3382b::vault::leverage<T0, T1, T2>(arg0), v0), 79226673515401279992447579055, arg12);
        let v5 = v4;
        0x2::balance::destroy_zero<T1>(v3);
        0x2::coin::join<T0>(&mut arg1, 0x2::coin::from_balance<T0>(v2, arg14));
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg11, arg2, 0x2::balance::zero<T0>(), 0x1649a79b08c19dd5bac65cc559caa3132380f9f8b580aea4441cdb20d9d3382b::vault::deposit<T0, T1, T2>(arg0, arg1, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v5), arg3, arg4, arg5, arg6, arg7, arg10, arg12), v5);
        let v6 = 0x1649a79b08c19dd5bac65cc559caa3132380f9f8b580aea4441cdb20d9d3382b::vault::mint_vt<T0, T1, T2>(arg0, v1, arg14);
        let (v7, v8, v9) = 0x1649a79b08c19dd5bac65cc559caa3132380f9f8b580aea4441cdb20d9d3382b::utils::calc_aum<T0, T1, T2>(arg0, arg4, arg5, arg8, arg9, arg3, arg12);
        let v10 = DepositEvent{
            vault_id          : 0x2::object::id<0x1649a79b08c19dd5bac65cc559caa3132380f9f8b580aea4441cdb20d9d3382b::vault::Vault<T0, T1, T2>>(arg0),
            user              : 0x2::tx_context::sender(arg14),
            deposit_amount    : v0,
            lp_shares_minted  : 0x2::coin::value<T2>(&v6),
            total_deposited_a : v8,
            total_borrowed_b  : v9,
            aum_in_a          : v7,
            total_lp_supply   : 0x1649a79b08c19dd5bac65cc559caa3132380f9f8b580aea4441cdb20d9d3382b::vault::total_vt_supply<T0, T1, T2>(arg0),
        };
        0x2::event::emit<DepositEvent>(v10);
        v6
    }

    public fun deposit_b<T0, T1, T2>(arg0: &mut 0x1649a79b08c19dd5bac65cc559caa3132380f9f8b580aea4441cdb20d9d3382b::vault::Vault<T0, T1, T2>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg8: &0x659b624dfd09c631f9925e21dd6144a483b0530fc0fd8a5b620e5d7b88d1bccf::oracle::KriyaOracle, arg9: &0x31f55a770ae4b852c36992dec0e794ed846e3160b1993b023328d815b0bc16f6::registry::CoinDecimalsRegistry, arg10: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg11: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg12: &0x2::clock::Clock, arg13: &0x1649a79b08c19dd5bac65cc559caa3132380f9f8b580aea4441cdb20d9d3382b::version::Version, arg14: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        0x1649a79b08c19dd5bac65cc559caa3132380f9f8b580aea4441cdb20d9d3382b::version::assert_current_version(arg13);
        let v0 = 0x2::coin::value<T0>(&arg1);
        let v1 = calc_vt_shares<T0, T1, T2>(arg0, arg4, arg5, arg8, arg9, arg3, v0, arg12);
        let (v2, v3, v4) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T1, T0>(arg11, arg2, true, false, get_deposit_flash_swap_amount(0x1649a79b08c19dd5bac65cc559caa3132380f9f8b580aea4441cdb20d9d3382b::vault::leverage<T0, T1, T2>(arg0), v0), 4295048016, arg12);
        let v5 = v4;
        0x2::balance::destroy_zero<T1>(v2);
        0x2::coin::join<T0>(&mut arg1, 0x2::coin::from_balance<T0>(v3, arg14));
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T1, T0>(arg11, arg2, 0x1649a79b08c19dd5bac65cc559caa3132380f9f8b580aea4441cdb20d9d3382b::vault::deposit<T0, T1, T2>(arg0, arg1, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T1, T0>(&v5), arg3, arg4, arg5, arg6, arg7, arg10, arg12), 0x2::balance::zero<T0>(), v5);
        let v6 = 0x1649a79b08c19dd5bac65cc559caa3132380f9f8b580aea4441cdb20d9d3382b::vault::mint_vt<T0, T1, T2>(arg0, v1, arg14);
        let (v7, v8, v9) = 0x1649a79b08c19dd5bac65cc559caa3132380f9f8b580aea4441cdb20d9d3382b::utils::calc_aum<T0, T1, T2>(arg0, arg4, arg5, arg8, arg9, arg3, arg12);
        let v10 = DepositEvent{
            vault_id          : 0x2::object::id<0x1649a79b08c19dd5bac65cc559caa3132380f9f8b580aea4441cdb20d9d3382b::vault::Vault<T0, T1, T2>>(arg0),
            user              : 0x2::tx_context::sender(arg14),
            deposit_amount    : v0,
            lp_shares_minted  : 0x2::coin::value<T2>(&v6),
            total_deposited_a : v8,
            total_borrowed_b  : v9,
            aum_in_a          : v7,
            total_lp_supply   : 0x1649a79b08c19dd5bac65cc559caa3132380f9f8b580aea4441cdb20d9d3382b::vault::total_vt_supply<T0, T1, T2>(arg0),
        };
        0x2::event::emit<DepositEvent>(v10);
        v6
    }

    fun get_deposit_flash_swap_amount(arg0: u8, arg1: u64) : u64 {
        arg1 * ((arg0 as u64) - 1)
    }

    // decompiled from Move bytecode v6
}

