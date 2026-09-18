module 0x5ae8e37c742de45861b43bce88f00fa9ef1f324a3946c9aee4dcf6cabb375f6e::dlmm {
    public fun fold<T0, T1>(arg0: &mut 0x5ae8e37c742de45861b43bce88f00fa9ef1f324a3946c9aee4dcf6cabb375f6e::probe::Probe, arg1: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg2: bool) {
        let v0 = (0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::effective_bin_price<T0, T1>(arg1, 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::active_id<T0, T1>(arg1)) as u256);
        if (v0 == 0) {
            0x5ae8e37c742de45861b43bce88f00fa9ef1f324a3946c9aee4dcf6cabb375f6e::probe::fold_closed(arg0);
            return
        };
        let v1 = (0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::base_fee_rate<T0, T1>(arg1) as u256) + (0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::get_variable_fee_rate<T0, T1>(arg1) as u256);
        let v2 = v1;
        if (v1 > 100000000) {
            v2 = 100000000;
        };
        if (arg2) {
            0x5ae8e37c742de45861b43bce88f00fa9ef1f324a3946c9aee4dcf6cabb375f6e::probe::fold(arg0, (1000000000 - v2) * v0, 0, 1000000000 * 18446744073709551616);
        } else {
            0x5ae8e37c742de45861b43bce88f00fa9ef1f324a3946c9aee4dcf6cabb375f6e::probe::fold(arg0, (1000000000 - v2) * 18446744073709551616, 0, 1000000000 * v0);
        };
    }

    // decompiled from Move bytecode v7
}

