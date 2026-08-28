module 0x5647f4d694be025ff8465b2f98794b45ca4734b6f7b6c09972bbe9a6ac8e719c::vc {
    struct L<phantom T0, phantom T1> {
        a: 0x2::balance::Balance<T0>,
        b: 0x2::balance::Balance<T1>,
        owed: u64,
        receipt: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<T0, T1>,
    }

    public fun e_short_repay() : u64 {
        30
    }

    public fun op<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: bool, arg3: u64, arg4: &0x2::clock::Clock) : L<T0, T1> {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, arg2, true, arg3, 0x5647f4d694be025ff8465b2f98794b45ca4734b6f7b6c09972bbe9a6ac8e719c::n::lm(arg2), arg4);
        let v3 = v2;
        L<T0, T1>{
            a       : v0,
            b       : v1,
            owed    : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v3),
            receipt : v3,
        }
    }

    public fun qo<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: bool, arg2: u64) : u64 {
        if (arg2 == 0) {
            return 0
        };
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<T0, T1>(arg0, arg1, true, arg2);
        if (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_is_exceed(&v0)) {
            return 0
        };
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_out(&v0)
    }

    public fun qs<T0, T1>(arg0: &mut 0x5647f4d694be025ff8465b2f98794b45ca4734b6f7b6c09972bbe9a6ac8e719c::p::P, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: bool) {
        0x5647f4d694be025ff8465b2f98794b45ca4734b6f7b6c09972bbe9a6ac8e719c::p::fd(arg0, qo<T0, T1>(arg1, arg2, 0x5647f4d694be025ff8465b2f98794b45ca4734b6f7b6c09972bbe9a6ac8e719c::p::cy(arg0)));
    }

    public fun ra<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: L<T0, T1>, arg3: 0x2::balance::Balance<T0>) : 0x2::balance::Balance<T0> {
        let L {
            a       : v0,
            b       : v1,
            owed    : v2,
            receipt : v3,
        } = arg2;
        0x2::balance::destroy_zero<T0>(v0);
        0x2::balance::destroy_zero<T1>(v1);
        assert!(0x2::balance::value<T0>(&arg3) >= v2, 30);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::split<T0>(&mut arg3, v2), 0x2::balance::zero<T1>(), v3);
        arg3
    }

    public fun rb<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: L<T0, T1>, arg3: 0x2::balance::Balance<T1>) : 0x2::balance::Balance<T1> {
        let L {
            a       : v0,
            b       : v1,
            owed    : v2,
            receipt : v3,
        } = arg2;
        0x2::balance::destroy_zero<T0>(v0);
        0x2::balance::destroy_zero<T1>(v1);
        assert!(0x2::balance::value<T1>(&arg3) >= v2, 30);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut arg3, v2), v3);
        arg3
    }

    public fun sa<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T0>, arg3: &0x2::clock::Clock) : 0x2::balance::Balance<T1> {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, true, true, 0x2::balance::value<T0>(&arg2), 0x5647f4d694be025ff8465b2f98794b45ca4734b6f7b6c09972bbe9a6ac8e719c::n::lm(true), arg3);
        0x2::balance::destroy_zero<T0>(v0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, arg2, 0x2::balance::zero<T1>(), v2);
        v1
    }

    public fun sb<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T1>, arg3: &0x2::clock::Clock) : 0x2::balance::Balance<T0> {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, false, true, 0x2::balance::value<T1>(&arg2), 0x5647f4d694be025ff8465b2f98794b45ca4734b6f7b6c09972bbe9a6ac8e719c::n::lm(false), arg3);
        0x2::balance::destroy_zero<T1>(v1);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), arg2, v2);
        v0
    }

    public fun ta<T0, T1>(arg0: L<T0, T1>) : (L<T0, T1>, 0x2::balance::Balance<T0>) {
        let L {
            a       : v0,
            b       : v1,
            owed    : v2,
            receipt : v3,
        } = arg0;
        let v4 = L<T0, T1>{
            a       : 0x2::balance::zero<T0>(),
            b       : v1,
            owed    : v2,
            receipt : v3,
        };
        (v4, v0)
    }

    public fun tb<T0, T1>(arg0: L<T0, T1>) : (L<T0, T1>, 0x2::balance::Balance<T1>) {
        let L {
            a       : v0,
            b       : v1,
            owed    : v2,
            receipt : v3,
        } = arg0;
        let v4 = L<T0, T1>{
            a       : v0,
            b       : 0x2::balance::zero<T1>(),
            owed    : v2,
            receipt : v3,
        };
        (v4, v1)
    }

    // decompiled from Move bytecode v7
}

