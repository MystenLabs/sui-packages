module 0x4051e63dd9fe859285bd52d240118ea718347055658b5593afcdf39a9db2602b::bbb_cetus_swap {
    struct CetusSwapEvent has copy, drop {
        type_in: 0x1::ascii::String,
        type_out: 0x1::ascii::String,
        amount_in: u64,
        amount_out: u64,
        expected_out: u64,
    }

    struct CetusSwap has copy, drop, store {
        a2b: bool,
        type_a: 0x1::type_name::TypeName,
        type_b: 0x1::type_name::TypeName,
        decimals_a: u8,
        decimals_b: u8,
        feed_a: vector<u8>,
        feed_b: vector<u8>,
        pool_id: 0x2::object::ID,
        slippage: u64,
        max_age_secs: u64,
    }

    public fun swap<T0, T1>(arg0: &CetusSwap, arg1: &mut 0x4051e63dd9fe859285bd52d240118ea718347055658b5593afcdf39a9db2602b::bbb_vault::BBBVault, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_info_from_price_info_object(arg2);
        let v1 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_identifier(&v0);
        let v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_info_from_price_info_object(arg3);
        let v3 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_identifier(&v2);
        let v4 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::get_bytes(&v1);
        assert!(&v4 == feed_a(arg0), 1001);
        let v5 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::get_bytes(&v3);
        assert!(&v5 == feed_b(arg0), 1002);
        let v6 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg5);
        assert!(&v6 == pool_id(arg0), 1000);
        let v7 = 0x1::type_name::get<T0>();
        let v8 = 0x1::type_name::get<T1>();
        assert!(&v7 == type_a(arg0), 1003);
        assert!(&v8 == type_b(arg0), 1004);
        if (arg0.a2b) {
            let v9 = 0x2::coin::from_balance<T0>(0x4051e63dd9fe859285bd52d240118ea718347055658b5593afcdf39a9db2602b::bbb_vault::withdraw<T0>(arg1), arg7);
            let v10 = 0x2::coin::value<T0>(&v9);
            if (v10 == 0) {
                0x2::coin::destroy_zero<T0>(v9);
                return
            };
            let v11 = 0x4051e63dd9fe859285bd52d240118ea718347055658b5593afcdf39a9db2602b::bbb_pyth::calc_amount_out(arg2, arg3, arg0.decimals_a, arg0.decimals_b, v10, arg0.max_age_secs, arg6);
            let v12 = swap_a2b<T0, T1>(arg4, arg5, v9, arg6, arg7);
            let v13 = 0x2::coin::value<T1>(&v12);
            assert!(v13 >= (((v11 as u256) * (arg0.slippage as u256) / 1000000000000000000) as u64), 1005);
            0x4051e63dd9fe859285bd52d240118ea718347055658b5593afcdf39a9db2602b::bbb_vault::deposit<T1>(arg1, v12);
            let v14 = CetusSwapEvent{
                type_in      : 0x1::type_name::into_string(v7),
                type_out     : 0x1::type_name::into_string(v8),
                amount_in    : v10,
                amount_out   : v13,
                expected_out : v11,
            };
            0x2::event::emit<CetusSwapEvent>(v14);
        } else {
            let v15 = 0x2::coin::from_balance<T1>(0x4051e63dd9fe859285bd52d240118ea718347055658b5593afcdf39a9db2602b::bbb_vault::withdraw<T1>(arg1), arg7);
            let v16 = 0x2::coin::value<T1>(&v15);
            if (v16 == 0) {
                0x2::coin::destroy_zero<T1>(v15);
                return
            };
            let v17 = 0x4051e63dd9fe859285bd52d240118ea718347055658b5593afcdf39a9db2602b::bbb_pyth::calc_amount_out(arg3, arg2, arg0.decimals_b, arg0.decimals_a, v16, arg0.max_age_secs, arg6);
            let v18 = swap_b2a<T0, T1>(arg4, arg5, v15, arg6, arg7);
            let v19 = 0x2::coin::value<T0>(&v18);
            assert!(v19 >= (((v17 as u256) * (arg0.slippage as u256) / 1000000000000000000) as u64), 1005);
            0x4051e63dd9fe859285bd52d240118ea718347055658b5593afcdf39a9db2602b::bbb_vault::deposit<T0>(arg1, v18);
            let v20 = CetusSwapEvent{
                type_in      : 0x1::type_name::into_string(v8),
                type_out     : 0x1::type_name::into_string(v7),
                amount_in    : v16,
                amount_out   : v19,
                expected_out : v17,
            };
            0x2::event::emit<CetusSwapEvent>(v20);
        };
    }

    public fun a2b(arg0: &CetusSwap) : bool {
        arg0.a2b
    }

    public fun decimals_a(arg0: &CetusSwap) : u8 {
        arg0.decimals_a
    }

    public fun decimals_b(arg0: &CetusSwap) : u8 {
        arg0.decimals_b
    }

    public fun feed_a(arg0: &CetusSwap) : &vector<u8> {
        &arg0.feed_a
    }

    public fun feed_b(arg0: &CetusSwap) : &vector<u8> {
        &arg0.feed_b
    }

    public fun max_age_secs(arg0: &CetusSwap) : u64 {
        arg0.max_age_secs
    }

    public fun new<T0, T1>(arg0: &0x4051e63dd9fe859285bd52d240118ea718347055658b5593afcdf39a9db2602b::bbb_admin::BBBAdminCap, arg1: bool, arg2: u8, arg3: u8, arg4: vector<u8>, arg5: vector<u8>, arg6: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg7: u64, arg8: u64) : CetusSwap {
        CetusSwap{
            a2b          : arg1,
            type_a       : 0x1::type_name::get<T0>(),
            type_b       : 0x1::type_name::get<T1>(),
            decimals_a   : arg2,
            decimals_b   : arg3,
            feed_a       : arg4,
            feed_b       : arg5,
            pool_id      : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg6),
            slippage     : arg7,
            max_age_secs : arg8,
        }
    }

    public fun pool_id(arg0: &CetusSwap) : &0x2::object::ID {
        &arg0.pool_id
    }

    public fun slippage(arg0: &CetusSwap) : u64 {
        arg0.slippage
    }

    public fun swap_a2b<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, true, true, 0x2::coin::value<T0>(&arg2), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::min_sqrt_price(), arg3);
        let v3 = v2;
        0x2::balance::destroy_zero<T0>(v0);
        assert!(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v3) == 0x2::coin::value<T0>(&arg2), 1006);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(arg2), 0x2::balance::zero<T1>(), v3);
        0x2::coin::from_balance<T1>(v1, arg4)
    }

    public fun swap_b2a<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, false, true, 0x2::coin::value<T1>(&arg2), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::max_sqrt_price(), arg3);
        let v3 = v2;
        0x2::balance::destroy_zero<T1>(v1);
        assert!(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v3) == 0x2::coin::value<T1>(&arg2), 1006);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(arg2), v3);
        0x2::coin::from_balance<T0>(v0, arg4)
    }

    public fun type_a(arg0: &CetusSwap) : &0x1::type_name::TypeName {
        &arg0.type_a
    }

    public fun type_b(arg0: &CetusSwap) : &0x1::type_name::TypeName {
        &arg0.type_b
    }

    // decompiled from Move bytecode v6
}

