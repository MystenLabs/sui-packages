module 0xb53c89862a6df9a0fafb32bae4e5754080a587e42c25d13ee6e9faa6db63665c::helper {
    public fun getAmountsV1<T0, T1>(arg0: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: &vector<u64>, arg2: bool, arg3: &0x2::clock::Clock) : (vector<u64>, u64) {
        let v0 = 0;
        let v1 = vector[];
        while (v0 < 0x1::vector::length<u64>(arg1)) {
            let v2 = *0x1::vector::borrow<u64>(arg1, v0);
            v0 = v0 + 1;
            let v3 = 4295048017;
            let v4 = 79226673515401279992447579050;
            if (arg2) {
                v3 = 79226673515401279992447579050;
                v4 = 4295048017;
            };
            let v5 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::compute_swap_result<T0, T1>(arg0, !arg2, !arg2, v3, v2);
            let v6 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::compute_swap_result<T0, T1>(arg0, arg2, arg2, v4, v2);
            0x1::vector::push_back<u64>(&mut v1, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::get_state_amount_calculated(&v5));
            0x1::vector::push_back<u64>(&mut v1, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::get_state_amount_calculated(&v6));
        };
        (v1, 0x2::clock::timestamp_ms(arg3))
    }

    // decompiled from Move bytecode v6
}

