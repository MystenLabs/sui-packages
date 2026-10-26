module 0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::paper {
    public(friend) fun mint(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: &0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::params::Params) : (u64, u64) {
        let v0 = (0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::params::paper_threshold(arg4) as u128);
        let v1 = if (arg1 >= arg2) {
            let v2 = ((arg1 - arg2) as u128);
            if (v2 >= v0) {
                0
            } else {
                v0 - v2
            }
        } else {
            v0 + ((arg2 - arg1) as u128)
        };
        let v3 = (arg0 as u128);
        let v4 = if (v3 < v1) {
            v3
        } else {
            v1
        };
        let v5 = (arg3 as u128) + v3 - v4;
        let v6 = v4 * (0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::params::paper_rate(arg4) as u128) + tail_total(v5, arg4) - tail_total((arg3 as u128), arg4);
        assert!(v6 <= 18446744073709551615, 0);
        assert!(v5 <= 18446744073709551615, 0);
        ((v6 as u64), (v5 as u64))
    }

    public fun tail_total(arg0: u128, arg1: &0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::params::Params) : u128 {
        let v0 = (0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::params::paper_decay_s(arg1) as u128);
        0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::fixed::mul_div((0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::params::paper_rate(arg1) as u128) * v0, arg0, v0 + arg0, false)
    }

    // decompiled from Move bytecode v7
}

