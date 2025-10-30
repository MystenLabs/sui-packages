module 0x353ee6e39e854c2fba0f3085fa613d0a055d754daea67ad799eeb042f48721e5::coin_price {
    struct RouteInfo has copy, drop, store {
        usdc_input: u64,
        sui_intermediate: u64,
        yy_output: u64,
        effective_price: u64,
    }

    public fun calculate_swap_result<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: u64, arg2: bool) : (u64, u64) {
        assert!(arg1 > 0, 1002);
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<T0, T1>(arg0, arg2, true, arg1);
        (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_in(&v0), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_out(&v0))
    }

    public fun calculate_price_impact(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u64 {
        let v0 = (((arg0 as u128) * (arg3 as u128) / (arg2 as u128)) as u64);
        if (v0 == 0) {
            return 0
        };
        let v1 = if (v0 > arg1) {
            v0 - arg1
        } else {
            0
        };
        (((v1 as u128) * 10000 / (v0 as u128)) as u64)
    }

    public fun calculate_swap_result_by_amount_out<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: u64, arg2: bool) : (u64, u64) {
        assert!(arg1 > 0, 1002);
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<T0, T1>(arg0, arg2, false, arg1);
        (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_in(&v0), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_out(&v0))
    }

    public fun calculate_usdc_needed_for_yy<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: &mut 0x68114ffc0a0d7c4a582b4494d2370205a23d93e96b9ef6a750d0ba5f8f52b7db::implements::Global, arg2: u64) : (u64, u64) {
        assert!(arg2 > 0, 1002);
        let (v0, v1, _) = 0x68114ffc0a0d7c4a582b4494d2370205a23d93e96b9ef6a750d0ba5f8f52b7db::interface::getLpliquidity<T1, T2>(arg1);
        assert!(v0 > 0 && v1 > 0, 1001);
        assert!(arg2 < v1, 1003);
        let v3 = (((v0 as u128) * (arg2 as u128) / ((v1 as u128) - (arg2 as u128))) as u64) + 1;
        let (v4, _) = calculate_swap_result_by_amount_out<T0, T1>(arg0, v3, true);
        (v4, v3)
    }

    public fun calculate_usdc_to_yy_route<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: &mut 0x68114ffc0a0d7c4a582b4494d2370205a23d93e96b9ef6a750d0ba5f8f52b7db::implements::Global, arg2: u64) : (u64, u64) {
        assert!(arg2 > 0, 1002);
        let (_, v1) = calculate_swap_result<T0, T1>(arg0, arg2, true);
        (v1, calculate_yswap_amount_out<T1, T2>(arg1, v1))
    }

    public fun calculate_yswap_amount_out<T0, T1>(arg0: &mut 0x68114ffc0a0d7c4a582b4494d2370205a23d93e96b9ef6a750d0ba5f8f52b7db::implements::Global, arg1: u64) : u64 {
        if (arg1 == 0) {
            return 0
        };
        let (v0, v1, _) = 0x68114ffc0a0d7c4a582b4494d2370205a23d93e96b9ef6a750d0ba5f8f52b7db::interface::getLpliquidity<T0, T1>(arg0);
        if (v0 == 0 || v1 == 0) {
            return 0
        };
        (((arg1 as u128) * (v1 as u128) / (v0 as u128)) as u64)
    }

    public fun calculate_yswap_amount_outV1<T0, T1>(arg0: &mut 0x68114ffc0a0d7c4a582b4494d2370205a23d93e96b9ef6a750d0ba5f8f52b7db::implements::Global, arg1: u64) : u128 {
        if (arg1 == 0) {
            return 0
        };
        let (v0, v1, _) = 0x68114ffc0a0d7c4a582b4494d2370205a23d93e96b9ef6a750d0ba5f8f52b7db::interface::getLpliquidity<T0, T1>(arg0);
        if (v0 == 0 || v1 == 0) {
            return 0
        };
        calculate_yswap_amount_out_pure(v0, v1, arg1)
    }

    public fun calculate_yswap_amount_out_pure(arg0: u64, arg1: u64, arg2: u64) : u128 {
        let v0 = if (arg2 == 0) {
            true
        } else if (arg0 == 0) {
            true
        } else {
            arg1 == 0
        };
        if (v0) {
            return 0
        };
        (arg2 as u128) * (arg1 as u128) / (arg0 as u128)
    }

    public fun format_amount(arg0: u64, arg1: u8) : (u64, u64) {
        let v0 = pow_10(arg1);
        (arg0 / v0, arg0 % v0)
    }

    public fun get_cetus_pool_info<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>) : (u128, u128, u64) {
        (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::liquidity<T0, T1>(arg0), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg0), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::fee_rate<T0, T1>(arg0))
    }

    public fun get_detailed_route_info<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: &mut 0x68114ffc0a0d7c4a582b4494d2370205a23d93e96b9ef6a750d0ba5f8f52b7db::implements::Global, arg2: u64) : RouteInfo {
        let (v0, v1) = calculate_usdc_to_yy_route<T0, T1, T2>(arg0, arg1, arg2);
        let v2 = if (arg2 > 0) {
            (((v1 as u128) * 10000 / (arg2 as u128)) as u64)
        } else {
            0
        };
        RouteInfo{
            usdc_input       : arg2,
            sui_intermediate : v0,
            yy_output        : v1,
            effective_price  : v2,
        }
    }

    public fun get_yswap_reserves<T0, T1>(arg0: &mut 0x68114ffc0a0d7c4a582b4494d2370205a23d93e96b9ef6a750d0ba5f8f52b7db::implements::Global) : (u64, u64) {
        let (v0, v1, _) = 0x68114ffc0a0d7c4a582b4494d2370205a23d93e96b9ef6a750d0ba5f8f52b7db::interface::getLpliquidity<T0, T1>(arg0);
        (v0, v1)
    }

    fun pow_10(arg0: u8) : u64 {
        let v0 = 1;
        let v1 = 0;
        while (v1 < arg0) {
            v0 = v0 * 10;
            v1 = v1 + 1;
        };
        v0
    }

    public fun quick_quote_100_usdc_to_yy<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: &mut 0x68114ffc0a0d7c4a582b4494d2370205a23d93e96b9ef6a750d0ba5f8f52b7db::implements::Global) : u64 {
        let (_, v1) = calculate_usdc_to_yy_route<T0, T1, T2>(arg0, arg1, 100000000);
        v1
    }

    public fun quote_usdc_to_yy<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: &mut 0x68114ffc0a0d7c4a582b4494d2370205a23d93e96b9ef6a750d0ba5f8f52b7db::implements::Global, arg2: u64) : u64 {
        let (_, v1) = calculate_usdc_to_yy_route<T0, T1, T2>(arg0, arg1, arg2);
        v1
    }

    public fun route_info_effective_price(arg0: &RouteInfo) : u64 {
        arg0.effective_price
    }

    public fun route_info_sui_intermediate(arg0: &RouteInfo) : u64 {
        arg0.sui_intermediate
    }

    public fun route_info_usdc_input(arg0: &RouteInfo) : u64 {
        arg0.usdc_input
    }

    public fun route_info_yy_output(arg0: &RouteInfo) : u64 {
        arg0.yy_output
    }

    // decompiled from Move bytecode v6
}

