module 0x9f41dadb335bc56697e55cd50e3d655cb57d220ab1550f9902ce815f1b4d39d6::bbb_cetus_swap {
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

    struct CetusSwapPromise {
        swap: CetusSwap,
    }

    public fun swap<T0, T1>(arg0: CetusSwapPromise, arg1: &mut 0x9f41dadb335bc56697e55cd50e3d655cb57d220ab1550f9902ce815f1b4d39d6::bbb_vault::BBBVault, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let CetusSwapPromise { swap: v0 } = arg0;
        let v1 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_info_from_price_info_object(arg2);
        let v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_identifier(&v1);
        let v3 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_info_from_price_info_object(arg3);
        let v4 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_identifier(&v3);
        let v5 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::get_bytes(&v2);
        assert!(&v5 == feed_a(&v0), 1001);
        let v6 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::get_bytes(&v4);
        assert!(&v6 == feed_b(&v0), 1002);
        let v7 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg5);
        assert!(&v7 == pool_id(&v0), 1000);
        let v8 = 0x1::type_name::get<T0>();
        let v9 = 0x1::type_name::get<T1>();
        assert!(&v8 == type_a(&v0), 1003);
        assert!(&v9 == type_b(&v0), 1004);
        if (v0.a2b) {
            let v10 = 0x2::coin::from_balance<T0>(0x9f41dadb335bc56697e55cd50e3d655cb57d220ab1550f9902ce815f1b4d39d6::bbb_vault::withdraw<T0>(arg1), arg7);
            let v11 = 0x2::coin::value<T0>(&v10);
            if (v11 == 0) {
                0x2::coin::destroy_zero<T0>(v10);
                return
            };
            let v12 = 0x9f41dadb335bc56697e55cd50e3d655cb57d220ab1550f9902ce815f1b4d39d6::bbb_pyth::calc_amount_out(arg2, arg3, v0.decimals_a, v0.decimals_b, v11, v0.max_age_secs, arg6);
            let v13 = swap_a2b<T0, T1>(arg4, arg5, v10, arg6, arg7);
            let v14 = 0x2::coin::value<T1>(&v13);
            assert!(v14 >= (((v12 as u256) * (v0.slippage as u256) / 1000000000000000000) as u64), 1005);
            0x9f41dadb335bc56697e55cd50e3d655cb57d220ab1550f9902ce815f1b4d39d6::bbb_vault::deposit<T1>(arg1, v13);
            let v15 = CetusSwapEvent{
                type_in      : 0x1::type_name::into_string(v8),
                type_out     : 0x1::type_name::into_string(v9),
                amount_in    : v11,
                amount_out   : v14,
                expected_out : v12,
            };
            0x2::event::emit<CetusSwapEvent>(v15);
        } else {
            let v16 = 0x2::coin::from_balance<T1>(0x9f41dadb335bc56697e55cd50e3d655cb57d220ab1550f9902ce815f1b4d39d6::bbb_vault::withdraw<T1>(arg1), arg7);
            let v17 = 0x2::coin::value<T1>(&v16);
            if (v17 == 0) {
                0x2::coin::destroy_zero<T1>(v16);
                return
            };
            let v18 = 0x9f41dadb335bc56697e55cd50e3d655cb57d220ab1550f9902ce815f1b4d39d6::bbb_pyth::calc_amount_out(arg3, arg2, v0.decimals_b, v0.decimals_a, v17, v0.max_age_secs, arg6);
            let v19 = swap_b2a<T0, T1>(arg4, arg5, v16, arg6, arg7);
            let v20 = 0x2::coin::value<T0>(&v19);
            assert!(v20 >= (((v18 as u256) * (v0.slippage as u256) / 1000000000000000000) as u64), 1005);
            0x9f41dadb335bc56697e55cd50e3d655cb57d220ab1550f9902ce815f1b4d39d6::bbb_vault::deposit<T0>(arg1, v19);
            let v21 = CetusSwapEvent{
                type_in      : 0x1::type_name::into_string(v9),
                type_out     : 0x1::type_name::into_string(v8),
                amount_in    : v17,
                amount_out   : v20,
                expected_out : v18,
            };
            0x2::event::emit<CetusSwapEvent>(v21);
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

    public fun input_output_types(arg0: &CetusSwap) : (&0x1::type_name::TypeName, &0x1::type_name::TypeName) {
        if (a2b(arg0)) {
            (type_a(arg0), type_b(arg0))
        } else {
            (type_b(arg0), type_a(arg0))
        }
    }

    public fun max_age_secs(arg0: &CetusSwap) : u64 {
        arg0.max_age_secs
    }

    public fun new<T0, T1>(arg0: &0x9f41dadb335bc56697e55cd50e3d655cb57d220ab1550f9902ce815f1b4d39d6::bbb_admin::BBBAdminCap, arg1: bool, arg2: u8, arg3: u8, arg4: vector<u8>, arg5: vector<u8>, arg6: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg7: u64, arg8: u64) : CetusSwap {
        assert!((arg7 as u256) <= 1000000000000000000, 1007);
        assert!((arg7 as u256) >= 500000000000000000, 1008);
        assert!(arg8 < 3600, 1009);
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

    public(friend) fun new_promise(arg0: CetusSwap) : CetusSwapPromise {
        CetusSwapPromise{swap: arg0}
    }

    public fun pool_id(arg0: &CetusSwap) : &0x2::object::ID {
        &arg0.pool_id
    }

    public fun slippage(arg0: &CetusSwap) : u64 {
        arg0.slippage
    }

    fun swap_a2b<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, true, true, 0x2::coin::value<T0>(&arg2), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::min_sqrt_price(), arg3);
        let v3 = v2;
        0x2::balance::destroy_zero<T0>(v0);
        assert!(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v3) == 0x2::coin::value<T0>(&arg2), 1006);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(arg2), 0x2::balance::zero<T1>(), v3);
        0x2::coin::from_balance<T1>(v1, arg4)
    }

    fun swap_b2a<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
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

