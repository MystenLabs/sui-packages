module 0xce8377ed30706cc6ac8ee35f0309f2c57c40c9166748c9ec935aac22629b89eb::cetus_clmm {
    struct PRESWAPRESULTEVENT has copy, drop {
        amount_in: u64,
        amount_out: u64,
        fee_amount: u64,
        after_sqrt_price: u128,
        is_exceed: bool,
    }

    entry fun pre_swap<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: bool, arg2: bool, arg3: u64) {
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<T0, T1>(arg0, arg1, arg2, arg3);
        let v1 = PRESWAPRESULTEVENT{
            amount_in        : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_in(&v0),
            amount_out       : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_out(&v0),
            fee_amount       : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_fee_amount(&v0),
            after_sqrt_price : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_after_sqrt_price(&v0),
            is_exceed        : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_is_exceed(&v0),
        };
        0x2::event::emit<PRESWAPRESULTEVENT>(v1);
    }

    // decompiled from Move bytecode v6
}

