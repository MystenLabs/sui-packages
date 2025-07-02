module 0x3b02aef2731193a6ff70efb6aa0765ed6aca4ad778d95087b855d86485db7a0d::helper {
    public fun getAmount<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: &vector<u64>) : vector<u64> {
        let v0 = 0;
        let v1 = vector[];
        while (v0 < 0x1::vector::length<u64>(arg1)) {
            let v2 = *0x1::vector::borrow<u64>(arg1, v0);
            v0 = v0 + 1;
            let v3 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<T0, T1>(arg0, true, true, v2);
            let v4 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<T0, T1>(arg0, false, false, v2);
            0x1::vector::push_back<u64>(&mut v1, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_in(&v4));
            0x1::vector::push_back<u64>(&mut v1, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_out(&v3));
        };
        v1
    }

    public fun getAmounts<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: &vector<u64>, arg2: bool, arg3: &0x2::clock::Clock) : (vector<u64>, u64) {
        let v0 = 0;
        let v1 = vector[];
        while (v0 < 0x1::vector::length<u64>(arg1)) {
            let v2 = *0x1::vector::borrow<u64>(arg1, v0);
            v0 = v0 + 1;
            let v3 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<T0, T1>(arg0, !arg2, arg2, v2);
            let v4 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<T0, T1>(arg0, arg2, !arg2, v2);
            0x1::vector::push_back<u64>(&mut v1, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_in(&v3));
            0x1::vector::push_back<u64>(&mut v1, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_out(&v4));
        };
        (v1, 0x2::clock::timestamp_ms(arg3))
    }

    // decompiled from Move bytecode v6
}

