module 0x2dad6396757d5c942d7ba7ad0651cabd7a41b4e4093002fe89c1f3f944fa9139::y {
    public fun ccm<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: vector<u64>, arg2: vector<u64>, arg3: &0x2::clock::Clock) : (vector<u64>, vector<u64>, u64) {
        assert!(0x1::vector::length<u64>(&arg1) == 0x1::vector::length<u64>(&arg2), 13906834320372269055);
        let v0 = 0x1::vector::empty<u64>();
        let v1 = 0x1::vector::empty<u64>();
        let v2 = 0;
        while (v2 < 0x1::vector::length<u64>(&arg1)) {
            let v3 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<T0, T1>(arg0, true, true, *0x1::vector::borrow<u64>(&arg1, v2));
            let v4 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<T0, T1>(arg0, false, true, *0x1::vector::borrow<u64>(&arg2, v2));
            0x1::vector::push_back<u64>(&mut v0, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_out(&v3));
            0x1::vector::push_back<u64>(&mut v1, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_out(&v4));
            v2 = v2 + 1;
        };
        (v0, v1, 0x2::clock::timestamp_ms(arg3))
    }

    public fun mcm<T0, T1>(arg0: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: vector<u64>, arg2: vector<u64>, arg3: &0x2::clock::Clock) : (vector<u64>, vector<u64>, u64) {
        assert!(0x1::vector::length<u64>(&arg1) == 0x1::vector::length<u64>(&arg2), 13906834221588021247);
        let v0 = 0x1::vector::empty<u64>();
        let v1 = 0x1::vector::empty<u64>();
        let v2 = 0;
        while (v2 < 0x1::vector::length<u64>(&arg1)) {
            let v3 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::compute_swap_result<T0, T1>(arg0, true, true, 4295048017, *0x1::vector::borrow<u64>(&arg1, v2));
            let v4 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::compute_swap_result<T0, T1>(arg0, false, true, 79226673515401279992447579050, *0x1::vector::borrow<u64>(&arg2, v2));
            0x1::vector::push_back<u64>(&mut v0, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::get_state_amount_calculated(&v3));
            0x1::vector::push_back<u64>(&mut v1, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::get_state_amount_calculated(&v4));
            v2 = v2 + 1;
        };
        (v0, v1, 0x2::clock::timestamp_ms(arg3))
    }

    // decompiled from Move bytecode v6
}

