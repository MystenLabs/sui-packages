module 0x5ab64875e13246685268e57a504a5964eba3b5296b9dcd9bc3516d6e466fde99::cetus_util {
    public fun is_liquidation_profitable<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: bool, arg2: u64, arg3: u64) : bool {
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<T0, T1>(arg0, arg1, false, arg2);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_in(&v0) <= arg3
    }

    public fun is_liquidation_profitable_with_double_swap<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: u64, arg2: u64) : bool {
        let v0 = (arg1 as u128);
        arg2 > ((v0 * (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::fee_rate<T0, T1>(arg0) as u128) * 2 / (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::clmm_math::fee_rate_denominator() as u128) + v0) as u64)
    }

    // decompiled from Move bytecode v6
}

