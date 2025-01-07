module 0xe9dce8eb5bb6a721415f04337cb6cbf2302b11e16e10c51c989379933e6b32e6::withdraw {
    struct WithdrawEvent has copy, drop, store {
        vault_id: 0x2::object::ID,
        user: address,
        lp_shares_burned: u64,
        amount_out: u64,
        total_deposited_a: u64,
        total_borrowed_b: u64,
        aum_in_a: u64,
        total_lp_supply: u64,
    }

    fun get_withdraw_flash_swap_amount(arg0: u8, arg1: u64) : u64 {
        arg1 * ((arg0 as u64) - 1)
    }

    fun vt_shares_to_underlying_a<T0, T1, T2>(arg0: &0xe9dce8eb5bb6a721415f04337cb6cbf2302b11e16e10c51c989379933e6b32e6::vault::Vault<T0, T1, T2>, arg1: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg2: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg3: &0x659b624dfd09c631f9925e21dd6144a483b0530fc0fd8a5b620e5d7b88d1bccf::oracle::KriyaOracle, arg4: &0x31f55a770ae4b852c36992dec0e794ed846e3160b1993b023328d815b0bc16f6::registry::CoinDecimalsRegistry, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg6: u64, arg7: &0x2::clock::Clock) : u64 {
        let (v0, _, _) = 0xe9dce8eb5bb6a721415f04337cb6cbf2302b11e16e10c51c989379933e6b32e6::utils::calc_aum<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg7);
        (((arg6 as u256) * (v0 as u256) / (0xe9dce8eb5bb6a721415f04337cb6cbf2302b11e16e10c51c989379933e6b32e6::vault::total_vt_supply<T0, T1, T2>(arg0) as u256)) as u64)
    }

    public fun withdraw_a<T0, T1, T2>(arg0: &mut 0xe9dce8eb5bb6a721415f04337cb6cbf2302b11e16e10c51c989379933e6b32e6::vault::Vault<T0, T1, T2>, arg1: 0x2::coin::Coin<T2>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg8: &0x659b624dfd09c631f9925e21dd6144a483b0530fc0fd8a5b620e5d7b88d1bccf::oracle::KriyaOracle, arg9: &0x31f55a770ae4b852c36992dec0e794ed846e3160b1993b023328d815b0bc16f6::registry::CoinDecimalsRegistry, arg10: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg11: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg12: &0x2::clock::Clock, arg13: &0xe9dce8eb5bb6a721415f04337cb6cbf2302b11e16e10c51c989379933e6b32e6::version::Version, arg14: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xe9dce8eb5bb6a721415f04337cb6cbf2302b11e16e10c51c989379933e6b32e6::version::assert_current_version(arg13);
        assert!(0xe9dce8eb5bb6a721415f04337cb6cbf2302b11e16e10c51c989379933e6b32e6::vault::pool_id<T0, T1, T2>(arg0) == 0x2::object::id<0xe9dce8eb5bb6a721415f04337cb6cbf2302b11e16e10c51c989379933e6b32e6::vault::Vault<T0, T1, T2>>(arg0), 9223372290257846271);
        let v0 = 0x2::coin::value<T2>(&arg1);
        let v1 = vt_shares_to_underlying_a<T0, T1, T2>(arg0, arg4, arg5, arg8, arg9, arg3, v0, arg12);
        let (v2, v3, v4) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg11, arg2, true, true, get_withdraw_flash_swap_amount(0xe9dce8eb5bb6a721415f04337cb6cbf2302b11e16e10c51c989379933e6b32e6::vault::leverage<T0, T1, T2>(arg0), v1), 4295048016, arg12);
        let v5 = v4;
        0x2::balance::destroy_zero<T0>(v2);
        let v6 = 0xe9dce8eb5bb6a721415f04337cb6cbf2302b11e16e10c51c989379933e6b32e6::vault::withdraw<T0, T1, T2>(arg0, 0x2::coin::from_balance<T1>(v3, arg14), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v5) + v1, arg3, arg4, arg5, arg6, arg7, arg10, arg12, arg14);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg11, arg2, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v6, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v5), arg14)), 0x2::balance::zero<T1>(), v5);
        0xe9dce8eb5bb6a721415f04337cb6cbf2302b11e16e10c51c989379933e6b32e6::vault::burn_vt<T0, T1, T2>(arg0, arg1);
        let (v7, v8) = 0xe9dce8eb5bb6a721415f04337cb6cbf2302b11e16e10c51c989379933e6b32e6::vault::withdrawal_fees<T0, T1, T2>(arg0);
        0xe9dce8eb5bb6a721415f04337cb6cbf2302b11e16e10c51c989379933e6b32e6::vault::collect_fees<T0, T1, T2>(arg0, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v6, (((0x2::coin::value<T0>(&v6) as u256) * (v7 as u256) / (v8 as u256)) as u64), arg14)));
        let (v9, v10, v11) = 0xe9dce8eb5bb6a721415f04337cb6cbf2302b11e16e10c51c989379933e6b32e6::utils::calc_aum<T0, T1, T2>(arg0, arg4, arg5, arg8, arg9, arg3, arg12);
        let v12 = WithdrawEvent{
            vault_id          : 0x2::object::id<0xe9dce8eb5bb6a721415f04337cb6cbf2302b11e16e10c51c989379933e6b32e6::vault::Vault<T0, T1, T2>>(arg0),
            user              : 0x2::tx_context::sender(arg14),
            lp_shares_burned  : v0,
            amount_out        : 0x2::coin::value<T0>(&v6),
            total_deposited_a : v10,
            total_borrowed_b  : v11,
            aum_in_a          : v9,
            total_lp_supply   : 0xe9dce8eb5bb6a721415f04337cb6cbf2302b11e16e10c51c989379933e6b32e6::vault::total_vt_supply<T0, T1, T2>(arg0),
        };
        0x2::event::emit<WithdrawEvent>(v12);
        v6
    }

    public fun withdraw_b<T0, T1, T2>(arg0: &mut 0xe9dce8eb5bb6a721415f04337cb6cbf2302b11e16e10c51c989379933e6b32e6::vault::Vault<T0, T1, T2>, arg1: 0x2::coin::Coin<T2>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg8: &0x659b624dfd09c631f9925e21dd6144a483b0530fc0fd8a5b620e5d7b88d1bccf::oracle::KriyaOracle, arg9: &0x31f55a770ae4b852c36992dec0e794ed846e3160b1993b023328d815b0bc16f6::registry::CoinDecimalsRegistry, arg10: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg11: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg12: &0x2::clock::Clock, arg13: &0xe9dce8eb5bb6a721415f04337cb6cbf2302b11e16e10c51c989379933e6b32e6::version::Version, arg14: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xe9dce8eb5bb6a721415f04337cb6cbf2302b11e16e10c51c989379933e6b32e6::version::assert_current_version(arg13);
        assert!(0xe9dce8eb5bb6a721415f04337cb6cbf2302b11e16e10c51c989379933e6b32e6::vault::pool_id<T0, T1, T2>(arg0) == 0x2::object::id<0xe9dce8eb5bb6a721415f04337cb6cbf2302b11e16e10c51c989379933e6b32e6::vault::Vault<T0, T1, T2>>(arg0), 9223372556545818623);
        let v0 = 0x2::coin::value<T2>(&arg1);
        let v1 = vt_shares_to_underlying_a<T0, T1, T2>(arg0, arg4, arg5, arg8, arg9, arg3, v0, arg12);
        let (v2, v3, v4) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T1, T0>(arg11, arg2, true, true, get_withdraw_flash_swap_amount(0xe9dce8eb5bb6a721415f04337cb6cbf2302b11e16e10c51c989379933e6b32e6::vault::leverage<T0, T1, T2>(arg0), v1), 79226673515401279992447579055, arg12);
        let v5 = v4;
        0x2::balance::destroy_zero<T0>(v3);
        let v6 = 0xe9dce8eb5bb6a721415f04337cb6cbf2302b11e16e10c51c989379933e6b32e6::vault::withdraw<T0, T1, T2>(arg0, 0x2::coin::from_balance<T1>(v2, arg14), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T1, T0>(&v5) + v1, arg3, arg4, arg5, arg6, arg7, arg10, arg12, arg14);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T1, T0>(arg11, arg2, 0x2::balance::zero<T1>(), 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v6, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T1, T0>(&v5), arg14)), v5);
        0xe9dce8eb5bb6a721415f04337cb6cbf2302b11e16e10c51c989379933e6b32e6::vault::burn_vt<T0, T1, T2>(arg0, arg1);
        let (v7, v8) = 0xe9dce8eb5bb6a721415f04337cb6cbf2302b11e16e10c51c989379933e6b32e6::vault::withdrawal_fees<T0, T1, T2>(arg0);
        0xe9dce8eb5bb6a721415f04337cb6cbf2302b11e16e10c51c989379933e6b32e6::vault::collect_fees<T0, T1, T2>(arg0, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v6, (((0x2::coin::value<T0>(&v6) as u256) * (v7 as u256) / (v8 as u256)) as u64), arg14)));
        let (v9, v10, v11) = 0xe9dce8eb5bb6a721415f04337cb6cbf2302b11e16e10c51c989379933e6b32e6::utils::calc_aum<T0, T1, T2>(arg0, arg4, arg5, arg8, arg9, arg3, arg12);
        let v12 = WithdrawEvent{
            vault_id          : 0x2::object::id<0xe9dce8eb5bb6a721415f04337cb6cbf2302b11e16e10c51c989379933e6b32e6::vault::Vault<T0, T1, T2>>(arg0),
            user              : 0x2::tx_context::sender(arg14),
            lp_shares_burned  : v0,
            amount_out        : 0x2::coin::value<T0>(&v6),
            total_deposited_a : v10,
            total_borrowed_b  : v11,
            aum_in_a          : v9,
            total_lp_supply   : 0xe9dce8eb5bb6a721415f04337cb6cbf2302b11e16e10c51c989379933e6b32e6::vault::total_vt_supply<T0, T1, T2>(arg0),
        };
        0x2::event::emit<WithdrawEvent>(v12);
        v6
    }

    // decompiled from Move bytecode v6
}

