module 0x8faf0700ef072abd55848992a6bcf1d14bfc14ff526d197bfd9de9a25939cd5d::cetus {
    public fun flash_a2b<T0, T1>(arg0: &mut 0x6c088e567321dbcf28a9d24d6c75d3dc66e13b3d371fdc6a66a12ec444a99842::session::Session<T0>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &0x2::clock::Clock) : (0x2::balance::Balance<T1>, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<T0, T1>) {
        0x6c088e567321dbcf28a9d24d6c75d3dc66e13b3d371fdc6a66a12ec444a99842::session::record_leg<T0>(arg0, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg2), true, 0);
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg1, arg2, true, true, 0x6c088e567321dbcf28a9d24d6c75d3dc66e13b3d371fdc6a66a12ec444a99842::session::open_loan<T0>(arg0), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::min_sqrt_price(), arg3);
        0x2::balance::destroy_zero<T0>(v0);
        (v1, v2)
    }

    public fun flash_b2a<T0, T1>(arg0: &mut 0x6c088e567321dbcf28a9d24d6c75d3dc66e13b3d371fdc6a66a12ec444a99842::session::Session<T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &0x2::clock::Clock) : (0x2::balance::Balance<T0>, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<T0, T1>) {
        0x6c088e567321dbcf28a9d24d6c75d3dc66e13b3d371fdc6a66a12ec444a99842::session::record_leg<T1>(arg0, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg2), false, 0);
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg1, arg2, false, true, 0x6c088e567321dbcf28a9d24d6c75d3dc66e13b3d371fdc6a66a12ec444a99842::session::open_loan<T1>(arg0), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::max_sqrt_price(), arg3);
        0x2::balance::destroy_zero<T1>(v1);
        (v0, v2)
    }

    public fun quote<T0, T1, T2>(arg0: &mut 0x6c088e567321dbcf28a9d24d6c75d3dc66e13b3d371fdc6a66a12ec444a99842::session::Session<T2>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: bool) {
        let v0 = vector[];
        let v1 = 0x6c088e567321dbcf28a9d24d6c75d3dc66e13b3d371fdc6a66a12ec444a99842::session::amounts<T2>(arg0);
        0x1::vector::reverse<u64>(&mut v1);
        let v2 = 0;
        while (v2 < 0x1::vector::length<u64>(&v1)) {
            let v3 = 0x1::vector::pop_back<u64>(&mut v1);
            let v4 = if (v3 == 0) {
                0
            } else {
                let v5 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<T0, T1>(arg1, arg2, true, v3);
                if (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_is_exceed(&v5)) {
                    0
                } else {
                    0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_out(&v5)
                }
            };
            0x1::vector::push_back<u64>(&mut v0, v4);
            v2 = v2 + 1;
        };
        0x1::vector::destroy_empty<u64>(v1);
        let v6 = &v0;
        let v7 = vector[];
        let v8 = 0;
        while (v8 < 0x1::vector::length<u64>(v6)) {
            0x1::vector::push_back<u64>(&mut v7, 0);
            v8 = v8 + 1;
        };
        0x6c088e567321dbcf28a9d24d6c75d3dc66e13b3d371fdc6a66a12ec444a99842::session::record_quote<T2>(arg0, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1), arg2, v0, v7);
    }

    fun refund<T0>(arg0: 0x2::balance::Balance<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        if (0x2::balance::value<T0>(&arg0) == 0) {
            0x2::balance::destroy_zero<T0>(arg0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg0, arg1), 0x2::tx_context::sender(arg1));
        };
    }

    public fun repay_a2b<T0, T1>(arg0: &mut 0x6c088e567321dbcf28a9d24d6c75d3dc66e13b3d371fdc6a66a12ec444a99842::session::Session<T0>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<T0, T1>) {
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg1, arg2, 0x6c088e567321dbcf28a9d24d6c75d3dc66e13b3d371fdc6a66a12ec444a99842::session::close_loan<T0>(arg0, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&arg3)), 0x2::balance::zero<T1>(), arg3);
    }

    public fun repay_b2a<T0, T1>(arg0: &mut 0x6c088e567321dbcf28a9d24d6c75d3dc66e13b3d371fdc6a66a12ec444a99842::session::Session<T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<T0, T1>) {
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg1, arg2, 0x2::balance::zero<T0>(), 0x6c088e567321dbcf28a9d24d6c75d3dc66e13b3d371fdc6a66a12ec444a99842::session::close_loan<T1>(arg0, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&arg3)), arg3);
    }

    public fun swap_a2b<T0, T1, T2>(arg0: &mut 0x6c088e567321dbcf28a9d24d6c75d3dc66e13b3d371fdc6a66a12ec444a99842::session::Session<T2>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: 0x2::balance::Balance<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        0x6c088e567321dbcf28a9d24d6c75d3dc66e13b3d371fdc6a66a12ec444a99842::session::record_leg<T2>(arg0, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg2), true, 0);
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg1, arg2, true, true, 0x2::balance::value<T0>(&arg3), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::min_sqrt_price(), arg4);
        let v3 = v2;
        0x2::balance::destroy_zero<T0>(v0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg1, arg2, 0x2::balance::split<T0>(&mut arg3, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v3)), 0x2::balance::zero<T1>(), v3);
        refund<T0>(arg3, arg5);
        v1
    }

    public fun swap_b2a<T0, T1, T2>(arg0: &mut 0x6c088e567321dbcf28a9d24d6c75d3dc66e13b3d371fdc6a66a12ec444a99842::session::Session<T2>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: 0x2::balance::Balance<T1>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        0x6c088e567321dbcf28a9d24d6c75d3dc66e13b3d371fdc6a66a12ec444a99842::session::record_leg<T2>(arg0, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg2), false, 0);
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg1, arg2, false, true, 0x2::balance::value<T1>(&arg3), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::max_sqrt_price(), arg4);
        let v3 = v2;
        0x2::balance::destroy_zero<T1>(v1);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg1, arg2, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut arg3, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v3)), v3);
        refund<T1>(arg3, arg5);
        v0
    }

    // decompiled from Move bytecode v7
}

