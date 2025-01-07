module 0x3d69bc993cc6b167ac18986b541f8be7a9ac040a5d41ff53538dde271595d70c::aurora {
    struct ContractData has store, key {
        id: 0x2::object::UID,
    }

    struct AccessList has store, key {
        id: 0x2::object::UID,
        list: vector<address>,
    }

    public fun a0<T0, T1, T2>(arg0: &mut 0xe016516cae4c27eb871870e3b1dd63d45ae180c412677784915b437a7ec930f0::safeV2::AccessList, arg1: &mut 0xe016516cae4c27eb871870e3b1dd63d45ae180c412677784915b437a7ec930f0::safeV2::Pool<T1>, arg2: &mut 0xe016516cae4c27eb871870e3b1dd63d45ae180c412677784915b437a7ec930f0::safeV2::Pool<T2>, arg3: u64, arg4: u64, arg5: &mut 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::Pool<T0>, arg6: &0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool_registry::PoolRegistry, arg7: &0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::ProtocolFeeVault, arg8: &mut 0x64213b0e4a52bac468d4ac3f140242f70714381653a1919a6d57cd49c628207a::treasury::Treasury, arg9: &mut 0xa6baab1e668c7868991c1c3c11e144100f5734c407d020f72a01b9d1a8bcb97f::insurance_fund::InsuranceFund, arg10: &0xc66fabf1a9253e43c70f1cc02d40a1d18db183140ecaae2a3f58fa6b66c55acf::referral_vault::ReferralVault, arg11: &mut 0x2::tx_context::TxContext) {
        0xe016516cae4c27eb871870e3b1dd63d45ae180c412677784915b437a7ec930f0::safeV2::deposit<T2>(arg2, 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::swap::swap_exact_in<T0, T1, T2>(arg5, arg6, arg7, arg8, arg9, arg10, 0xe016516cae4c27eb871870e3b1dd63d45ae180c412677784915b437a7ec930f0::safeV2::withdraw<T1>(arg0, arg1, arg3, arg11), 10000, 0, arg11), arg4, arg11);
    }

    public fun a1_to<T0, T1, T2>(arg0: &mut 0xe016516cae4c27eb871870e3b1dd63d45ae180c412677784915b437a7ec930f0::safeV2::AccessList, arg1: &mut 0xe016516cae4c27eb871870e3b1dd63d45ae180c412677784915b437a7ec930f0::safeV2::Pool<T1>, arg2: &mut 0xe016516cae4c27eb871870e3b1dd63d45ae180c412677784915b437a7ec930f0::safeV2::Pool<T2>, arg3: u64, arg4: u64, arg5: &mut 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::Pool<T0>, arg6: &0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool_registry::PoolRegistry, arg7: &0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::ProtocolFeeVault, arg8: &mut 0x64213b0e4a52bac468d4ac3f140242f70714381653a1919a6d57cd49c628207a::treasury::Treasury, arg9: &mut 0xa6baab1e668c7868991c1c3c11e144100f5734c407d020f72a01b9d1a8bcb97f::insurance_fund::InsuranceFund, arg10: &0xc66fabf1a9253e43c70f1cc02d40a1d18db183140ecaae2a3f58fa6b66c55acf::referral_vault::ReferralVault, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xe016516cae4c27eb871870e3b1dd63d45ae180c412677784915b437a7ec930f0::safeV2::withdraw<T1>(arg0, arg1, arg3, arg11);
        0xe016516cae4c27eb871870e3b1dd63d45ae180c412677784915b437a7ec930f0::safeV2::deposit<T2>(arg2, 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::swap::swap_exact_out<T0, T1, T2>(arg5, arg6, arg7, arg8, arg9, arg10, arg4, &mut v0, arg3, 0, arg11), arg4, arg11);
        if (0x2::coin::value<T1>(&v0) > 0) {
            0xe016516cae4c27eb871870e3b1dd63d45ae180c412677784915b437a7ec930f0::safeV2::deposit<T1>(arg1, v0, 0, arg11);
        } else {
            0x2::coin::destroy_zero<T1>(v0);
        };
    }

    public fun access_list_add(arg0: &mut AccessList, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == @0x87c9e076815e78ee63b7dc225704c428b8c51072ccead4304ae07f6c68fe1b92, 1);
        0x1::vector::push_back<address>(&mut arg0.list, arg1);
    }

    public fun c0<T0, T1>(arg0: &mut 0xe016516cae4c27eb871870e3b1dd63d45ae180c412677784915b437a7ec930f0::safeV2::AccessList, arg1: &mut 0xe016516cae4c27eb871870e3b1dd63d45ae180c412677784915b437a7ec930f0::safeV2::Pool<T0>, arg2: &mut 0xe016516cae4c27eb871870e3b1dd63d45ae180c412677784915b437a7ec930f0::safeV2::Pool<T1>, arg3: u64, arg4: u64, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg7: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::partner::Partner, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap_with_partner<T1, T0>(arg5, arg6, arg7, false, true, arg3, 79226673515401279992447579055, arg8);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap_with_partner<T1, T0>(arg5, arg6, arg7, 0x2::balance::zero<T1>(), 0x2::coin::into_balance<T0>(0xe016516cae4c27eb871870e3b1dd63d45ae180c412677784915b437a7ec930f0::safeV2::withdraw<T0>(arg0, arg1, arg3, arg9)), v2);
        0x2::balance::destroy_zero<T0>(v1);
        0xe016516cae4c27eb871870e3b1dd63d45ae180c412677784915b437a7ec930f0::safeV2::deposit<T1>(arg2, 0x2::coin::from_balance<T1>(v0, arg9), arg4, arg9);
    }

    public fun c1_to<T0, T1>(arg0: &mut 0xe016516cae4c27eb871870e3b1dd63d45ae180c412677784915b437a7ec930f0::safeV2::AccessList, arg1: &mut 0xe016516cae4c27eb871870e3b1dd63d45ae180c412677784915b437a7ec930f0::safeV2::Pool<T0>, arg2: &mut 0xe016516cae4c27eb871870e3b1dd63d45ae180c412677784915b437a7ec930f0::safeV2::Pool<T1>, arg3: u64, arg4: u64, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg7: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::partner::Partner, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xe016516cae4c27eb871870e3b1dd63d45ae180c412677784915b437a7ec930f0::safeV2::withdraw<T0>(arg0, arg1, arg3, arg9);
        let (v1, v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap_with_partner<T0, T1>(arg5, arg6, arg7, true, false, arg4, 4295048016, arg8);
        let v4 = v3;
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap_with_partner<T0, T1>(arg5, arg6, arg7, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v0, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v4), arg9)), 0x2::balance::zero<T1>(), v4);
        let v5 = 0x2::coin::from_balance<T0>(v1, arg9);
        if (0x2::coin::value<T0>(&v5) > 0) {
            0xe016516cae4c27eb871870e3b1dd63d45ae180c412677784915b437a7ec930f0::safeV2::deposit<T0>(arg1, v5, 0, arg9);
        } else {
            0x2::coin::destroy_zero<T0>(v5);
        };
        if (0x2::coin::value<T0>(&v0) > 0) {
            0xe016516cae4c27eb871870e3b1dd63d45ae180c412677784915b437a7ec930f0::safeV2::deposit<T0>(arg1, v0, 0, arg9);
        } else {
            0x2::coin::destroy_zero<T0>(v0);
        };
        0xe016516cae4c27eb871870e3b1dd63d45ae180c412677784915b437a7ec930f0::safeV2::deposit<T1>(arg2, 0x2::coin::from_balance<T1>(v2, arg9), arg4, arg9);
    }

    public fun d0<T0, T1>(arg0: &mut 0xe016516cae4c27eb871870e3b1dd63d45ae180c412677784915b437a7ec930f0::safeV2::AccessList, arg1: &mut 0xe016516cae4c27eb871870e3b1dd63d45ae180c412677784915b437a7ec930f0::safeV2::Pool<T0>, arg2: &mut 0xe016516cae4c27eb871870e3b1dd63d45ae180c412677784915b437a7ec930f0::safeV2::Pool<T1>, arg3: u64, arg4: u64, arg5: &mut 0xdee9::clob_v2::Pool<T0, T1>, arg6: &0xdee9::custodian_v2::AccountCap, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xdee9::clob_v2::place_market_order<T0, T1>(arg5, arg6, 33333, arg3, false, 0xe016516cae4c27eb871870e3b1dd63d45ae180c412677784915b437a7ec930f0::safeV2::withdraw<T0>(arg0, arg1, arg3, arg8), 0x2::coin::zero<T1>(arg8), arg7, arg8);
        let v2 = v0;
        if (0x2::coin::value<T0>(&v2) > 0) {
            0xe016516cae4c27eb871870e3b1dd63d45ae180c412677784915b437a7ec930f0::safeV2::deposit<T0>(arg1, v2, 0, arg8);
        } else {
            0x2::coin::destroy_zero<T0>(v2);
        };
        0xe016516cae4c27eb871870e3b1dd63d45ae180c412677784915b437a7ec930f0::safeV2::deposit<T1>(arg2, v1, arg4, arg8);
    }

    public fun d1_to<T0, T1>(arg0: &mut 0xe016516cae4c27eb871870e3b1dd63d45ae180c412677784915b437a7ec930f0::safeV2::AccessList, arg1: &mut 0xe016516cae4c27eb871870e3b1dd63d45ae180c412677784915b437a7ec930f0::safeV2::Pool<T0>, arg2: &mut 0xe016516cae4c27eb871870e3b1dd63d45ae180c412677784915b437a7ec930f0::safeV2::Pool<T1>, arg3: u64, arg4: u64, arg5: &mut 0xdee9::clob_v2::Pool<T1, T0>, arg6: &0xdee9::custodian_v2::AccountCap, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xdee9::clob_v2::place_market_order<T1, T0>(arg5, arg6, 33333, arg4, true, 0x2::coin::zero<T1>(arg8), 0xe016516cae4c27eb871870e3b1dd63d45ae180c412677784915b437a7ec930f0::safeV2::withdraw<T0>(arg0, arg1, arg3, arg8), arg7, arg8);
        let v2 = v1;
        if (0x2::coin::value<T0>(&v2) > 0) {
            0xe016516cae4c27eb871870e3b1dd63d45ae180c412677784915b437a7ec930f0::safeV2::deposit<T0>(arg1, v2, 0, arg8);
        } else {
            0x2::coin::destroy_zero<T0>(v2);
        };
        0xe016516cae4c27eb871870e3b1dd63d45ae180c412677784915b437a7ec930f0::safeV2::deposit<T1>(arg2, v0, arg4, arg8);
    }

    public fun f0<T0, T1>(arg0: &mut 0xe016516cae4c27eb871870e3b1dd63d45ae180c412677784915b437a7ec930f0::safeV2::AccessList, arg1: &mut 0xe016516cae4c27eb871870e3b1dd63d45ae180c412677784915b437a7ec930f0::safeV2::Pool<T0>, arg2: &mut 0xe016516cae4c27eb871870e3b1dd63d45ae180c412677784915b437a7ec930f0::safeV2::Pool<T1>, arg3: u64, arg4: u64, arg5: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg6: &mut 0x2::tx_context::TxContext) {
        0xe016516cae4c27eb871870e3b1dd63d45ae180c412677784915b437a7ec930f0::safeV2::deposit<T1>(arg2, 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::router::swap_exact_input_direct<T0, T1>(arg5, 0xe016516cae4c27eb871870e3b1dd63d45ae180c412677784915b437a7ec930f0::safeV2::withdraw<T0>(arg0, arg1, arg3, arg6), arg6), arg4, arg6);
    }

    public fun f1_to<T0, T1>(arg0: &mut 0xe016516cae4c27eb871870e3b1dd63d45ae180c412677784915b437a7ec930f0::safeV2::AccessList, arg1: &mut 0xe016516cae4c27eb871870e3b1dd63d45ae180c412677784915b437a7ec930f0::safeV2::Pool<T0>, arg2: &mut 0xe016516cae4c27eb871870e3b1dd63d45ae180c412677784915b437a7ec930f0::safeV2::Pool<T1>, arg3: u64, arg4: u64, arg5: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg6: &mut 0x2::tx_context::TxContext) {
        0xe016516cae4c27eb871870e3b1dd63d45ae180c412677784915b437a7ec930f0::safeV2::deposit<T1>(arg2, 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::router::swap_exact_output_direct<T0, T1>(arg5, 0xe016516cae4c27eb871870e3b1dd63d45ae180c412677784915b437a7ec930f0::safeV2::withdraw<T0>(arg0, arg1, arg3, arg6), arg4, arg6), arg4, arg6);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        new_access_list(arg0);
    }

    fun is_valid(arg0: &AccessList, arg1: &0x2::tx_context::TxContext) : bool {
        let v0 = arg0.list;
        let v1 = 0x2::tx_context::sender(arg1);
        0x1::vector::contains<address>(&v0, &v1)
    }

    public fun k0<T0, T1>(arg0: &mut 0xe016516cae4c27eb871870e3b1dd63d45ae180c412677784915b437a7ec930f0::safeV2::AccessList, arg1: &mut 0xe016516cae4c27eb871870e3b1dd63d45ae180c412677784915b437a7ec930f0::safeV2::Pool<T0>, arg2: &mut 0xe016516cae4c27eb871870e3b1dd63d45ae180c412677784915b437a7ec930f0::safeV2::Pool<T1>, arg3: u64, arg4: u64, arg5: &mut 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::Pool<T1, T0>, arg6: &mut 0x2::tx_context::TxContext) {
        0xe016516cae4c27eb871870e3b1dd63d45ae180c412677784915b437a7ec930f0::safeV2::deposit<T1>(arg2, 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::swap_token_y<T1, T0>(arg5, 0xe016516cae4c27eb871870e3b1dd63d45ae180c412677784915b437a7ec930f0::safeV2::withdraw<T0>(arg0, arg1, arg3, arg6), arg3, 0, arg6), arg4, arg6);
    }

    public fun k1<T0, T1>(arg0: &mut 0xe016516cae4c27eb871870e3b1dd63d45ae180c412677784915b437a7ec930f0::safeV2::AccessList, arg1: &mut 0xe016516cae4c27eb871870e3b1dd63d45ae180c412677784915b437a7ec930f0::safeV2::Pool<T0>, arg2: &mut 0xe016516cae4c27eb871870e3b1dd63d45ae180c412677784915b437a7ec930f0::safeV2::Pool<T1>, arg3: u64, arg4: u64, arg5: &mut 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::Pool<T0, T1>, arg6: &mut 0x2::tx_context::TxContext) {
        0xe016516cae4c27eb871870e3b1dd63d45ae180c412677784915b437a7ec930f0::safeV2::deposit<T1>(arg2, 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::swap_token_x<T0, T1>(arg5, 0xe016516cae4c27eb871870e3b1dd63d45ae180c412677784915b437a7ec930f0::safeV2::withdraw<T0>(arg0, arg1, arg3, arg6), arg3, 0, arg6), arg4, arg6);
    }

    fun new_access_list(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AccessList{
            id   : 0x2::object::new(arg0),
            list : 0x1::vector::singleton<address>(@0x87c9e076815e78ee63b7dc225704c428b8c51072ccead4304ae07f6c68fe1b92),
        };
        0x2::transfer::share_object<AccessList>(v0);
    }

    public fun t0<T0, T1, T2>(arg0: &mut 0xe016516cae4c27eb871870e3b1dd63d45ae180c412677784915b437a7ec930f0::safeV2::AccessList, arg1: &mut 0xe016516cae4c27eb871870e3b1dd63d45ae180c412677784915b437a7ec930f0::safeV2::Pool<T0>, arg2: &mut 0xe016516cae4c27eb871870e3b1dd63d45ae180c412677784915b437a7ec930f0::safeV2::Pool<T1>, arg3: u64, arg4: u64, arg5: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg6: &0x2::clock::Clock, arg7: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg8: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_a_b_with_return_<T0, T1, T2>(arg5, 0x1::vector::singleton<0x2::coin::Coin<T0>>(0xe016516cae4c27eb871870e3b1dd63d45ae180c412677784915b437a7ec930f0::safeV2::withdraw<T0>(arg0, arg1, arg3, arg8)), arg3, 0, 4295048016, true, 0x2::tx_context::sender(arg8), 9999999999999999999, arg6, arg7, arg8);
        let v2 = v1;
        if (0x2::coin::value<T0>(&v2) > 0) {
            0xe016516cae4c27eb871870e3b1dd63d45ae180c412677784915b437a7ec930f0::safeV2::deposit<T0>(arg1, v2, 0, arg8);
        } else {
            0x2::coin::destroy_zero<T0>(v2);
        };
        0xe016516cae4c27eb871870e3b1dd63d45ae180c412677784915b437a7ec930f0::safeV2::deposit<T1>(arg2, v0, arg4, arg8);
    }

    public fun t1_to<T0, T1, T2>(arg0: &mut 0xe016516cae4c27eb871870e3b1dd63d45ae180c412677784915b437a7ec930f0::safeV2::AccessList, arg1: &mut 0xe016516cae4c27eb871870e3b1dd63d45ae180c412677784915b437a7ec930f0::safeV2::Pool<T0>, arg2: &mut 0xe016516cae4c27eb871870e3b1dd63d45ae180c412677784915b437a7ec930f0::safeV2::Pool<T1>, arg3: u64, arg4: u64, arg5: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T1, T0, T2>, arg6: &0x2::clock::Clock, arg7: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg8: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_b_a_with_return_<T1, T0, T2>(arg5, 0x1::vector::singleton<0x2::coin::Coin<T0>>(0xe016516cae4c27eb871870e3b1dd63d45ae180c412677784915b437a7ec930f0::safeV2::withdraw<T0>(arg0, arg1, arg3, arg8)), arg4, 0, 79226673515401279992447579055, false, 0x2::tx_context::sender(arg8), 9999999999999999999, arg6, arg7, arg8);
        let v2 = v1;
        if (0x2::coin::value<T0>(&v2) > 0) {
            0xe016516cae4c27eb871870e3b1dd63d45ae180c412677784915b437a7ec930f0::safeV2::deposit<T0>(arg1, v2, 0, arg8);
        } else {
            0x2::coin::destroy_zero<T0>(v2);
        };
        0xe016516cae4c27eb871870e3b1dd63d45ae180c412677784915b437a7ec930f0::safeV2::deposit<T1>(arg2, v0, arg4, arg8);
    }

    // decompiled from Move bytecode v6
}

