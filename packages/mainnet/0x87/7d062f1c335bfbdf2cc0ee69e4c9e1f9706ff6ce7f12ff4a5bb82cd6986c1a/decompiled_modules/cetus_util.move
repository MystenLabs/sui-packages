module 0x877d062f1c335bfbdf2cc0ee69e4c9e1f9706ff6ce7f12ff4a5bb82cd6986c1a::cetus_util {
    public fun is_liquidation_profitable<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: bool, arg2: u64, arg3: u64) : bool {
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<T0, T1>(arg0, arg1, false, arg2);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_in(&v0) <= arg3
    }

    public fun is_liquidation_profitable_with_double_swap<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: u64, arg2: u64) : bool {
        true
    }

    // decompiled from Move bytecode v6
}

