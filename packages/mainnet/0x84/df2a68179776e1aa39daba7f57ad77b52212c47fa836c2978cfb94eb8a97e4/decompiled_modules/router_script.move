module 0x84df2a68179776e1aa39daba7f57ad77b52212c47fa836c2978cfb94eb8a97e4::router_script {
    public entry fun cetus<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: vector<0x2::coin::Coin<T1>>, arg3: u128, arg4: u128, arg5: u64, arg6: u32, arg7: u32, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = merge_coins<T1>(arg2, arg10);
        cetus_swap<T0, T1>(arg0, arg1, v0, arg8, arg3, arg4, arg9, arg10);
        cetus_liquidity<T0, T1>(arg0, arg1, arg6, arg7, arg5, arg9, arg10);
    }

    fun cetus_liquidity<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: u32, arg3: u32, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::open_position<T0, T1>(arg0, arg1, arg2, arg3, arg6);
        let (v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::remove_liquidity<T0, T1>(arg0, arg1, &mut v0, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(&v0), arg5);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_add_liquidity<T0, T1>(arg0, arg1, v1, v2, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_fix_coin<T0, T1>(arg0, arg1, &mut v0, arg4, false, arg5));
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::close_position<T0, T1>(arg0, arg1, v0);
    }

    fun cetus_swap<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: u128, arg5: u128, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, false, true, arg3, arg4, arg6);
        let v3 = v2;
        let v4 = v0;
        0x2::balance::destroy_zero<T1>(v1);
        let v5 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v3);
        let (v6, v7, v8) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, true, true, 0x2::balance::value<T0>(&v4), arg5, arg6);
        let v9 = v8;
        let v10 = v7;
        0x2::balance::destroy_zero<T0>(v6);
        assert!(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v9) == 0x2::balance::value<T0>(&v4), 1);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, v4, 0x2::balance::zero<T1>(), v9);
        0x2::balance::join<T1>(&mut v10, 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg2, v5 - 0x2::balance::value<T1>(&v10), arg7)));
        assert!(v5 == 0x2::balance::value<T1>(&v10), 2);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), v10, v3);
        send_coin<T1>(arg2, 0x2::tx_context::sender(arg7));
    }

    public entry fun deepbook<T0, T1>(arg0: &mut 0xdee9::clob_v2::Pool<T0, T1>, arg1: u64, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xdee9::clob_v2::create_account(arg6);
        0xdee9::clob_v2::deposit_base<T0, T1>(arg0, arg2, &v0);
        0xdee9::clob_v2::deposit_quote<T0, T1>(arg0, arg3, &v0);
        let v1 = 0xdee9::clob_v2::withdraw_quote<T0, T1>(arg0, arg4, &v0, arg6);
        let (v2, v3, _) = 0xdee9::clob_v2::swap_exact_base_for_quote<T0, T1>(arg0, arg1, &v0, arg4, 0xdee9::clob_v2::withdraw_base<T0, T1>(arg0, arg4, &v0, arg6), 0x2::coin::zero<T1>(arg6), arg5, arg6);
        let v5 = v2;
        let (v6, v7, _) = 0xdee9::clob_v2::swap_exact_quote_for_base<T0, T1>(arg0, arg1, &v0, arg4, arg5, v3, arg6);
        0x2::coin::join<T0>(&mut v5, v6);
        0x2::coin::join<T1>(&mut v1, v7);
        send_coin<T0>(v5, 0x2::tx_context::sender(arg6));
        send_coin<T1>(v1, 0x2::tx_context::sender(arg6));
        0x2::transfer::public_transfer<0xdee9::custodian_v2::AccountCap>(v0, 0x2::tx_context::sender(arg6));
    }

    fun merge_coins<T0>(arg0: vector<0x2::coin::Coin<T0>>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        if (0x1::vector::is_empty<0x2::coin::Coin<T0>>(&arg0)) {
            0x1::vector::destroy_empty<0x2::coin::Coin<T0>>(arg0);
            0x2::coin::zero<T0>(arg1)
        } else {
            let v1 = 0x1::vector::pop_back<0x2::coin::Coin<T0>>(&mut arg0);
            0x2::pay::join_vec<T0>(&mut v1, arg0);
            v1
        }
    }

    public entry fun navi<T0: copy + drop + store>(arg0: &0xcfd595a530ce4fa5e35a69a526fb0aba65b64f41ffcac94fc58bed17013eb8c9::ac_table::AcTable<T0, T0, T0>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public entry fun scallop<T0>(arg0: &0x2::clock::Clock, arg1: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg2: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg4: u8, arg5: 0x2::coin::Coin<T0>, arg6: u64, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive, arg8: &mut 0x2::tx_context::TxContext) {
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::lending::deposit<T0>(arg0, arg1, arg3, arg4, arg5, arg6, arg7, arg8);
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::lending::withdraw<T0>(arg0, arg2, arg1, arg3, arg4, arg6, 0x2::tx_context::sender(arg8), arg7, arg8);
    }

    fun send_coin<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address) {
        if (0x2::coin::value<T0>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, arg1);
        } else {
            0x2::coin::destroy_zero<T0>(arg0);
        };
    }

    // decompiled from Move bytecode v6
}

