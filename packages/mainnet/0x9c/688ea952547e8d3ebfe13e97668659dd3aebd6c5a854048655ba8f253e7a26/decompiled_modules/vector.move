module 0x9c688ea952547e8d3ebfe13e97668659dd3aebd6c5a854048655ba8f253e7a26::vector {
    public fun unlock_unlockable<T0: store>(arg0: &mut vector<0x9c688ea952547e8d3ebfe13e97668659dd3aebd6c5a854048655ba8f253e7a26::locked::Locked<T0>>, arg1: bool, arg2: &0x2::clock::Clock) : vector<T0> {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let v1 = 0x1::vector::empty<0x9c688ea952547e8d3ebfe13e97668659dd3aebd6c5a854048655ba8f253e7a26::locked::Locked<T0>>();
        let v1 = if (0x1::vector::is_empty<0x9c688ea952547e8d3ebfe13e97668659dd3aebd6c5a854048655ba8f253e7a26::locked::Locked<T0>>(arg0) || v0 < 0x9c688ea952547e8d3ebfe13e97668659dd3aebd6c5a854048655ba8f253e7a26::locked::lock_end_timestamp_ms<T0>(0x1::vector::borrow<0x9c688ea952547e8d3ebfe13e97668659dd3aebd6c5a854048655ba8f253e7a26::locked::Locked<T0>>(arg0, 0)) && arg1) {
            v1
        } else {
            0x1::vector::reverse<0x9c688ea952547e8d3ebfe13e97668659dd3aebd6c5a854048655ba8f253e7a26::locked::Locked<T0>>(arg0);
            let v2 = 0x1::vector::length<0x9c688ea952547e8d3ebfe13e97668659dd3aebd6c5a854048655ba8f253e7a26::locked::Locked<T0>>(arg0);
            while (v2 > 0) {
                v2 = v2 - 1;
                if (0x9c688ea952547e8d3ebfe13e97668659dd3aebd6c5a854048655ba8f253e7a26::locked::lock_end_timestamp_ms<T0>(0x1::vector::borrow<0x9c688ea952547e8d3ebfe13e97668659dd3aebd6c5a854048655ba8f253e7a26::locked::Locked<T0>>(arg0, v2)) <= v0) {
                    0x1::vector::push_back<0x9c688ea952547e8d3ebfe13e97668659dd3aebd6c5a854048655ba8f253e7a26::locked::Locked<T0>>(&mut v1, 0x1::vector::pop_back<0x9c688ea952547e8d3ebfe13e97668659dd3aebd6c5a854048655ba8f253e7a26::locked::Locked<T0>>(arg0));
                    continue
                };
                if (arg1) {
                    break
                };
            };
            0x1::vector::reverse<0x9c688ea952547e8d3ebfe13e97668659dd3aebd6c5a854048655ba8f253e7a26::locked::Locked<T0>>(arg0);
            v1
        };
        unlock_vec<T0>(v1, arg2)
    }

    public fun unlock_vec<T0: store>(arg0: vector<0x9c688ea952547e8d3ebfe13e97668659dd3aebd6c5a854048655ba8f253e7a26::locked::Locked<T0>>, arg1: &0x2::clock::Clock) : vector<T0> {
        let v0 = 0x1::vector::empty<T0>();
        0x1::vector::reverse<0x9c688ea952547e8d3ebfe13e97668659dd3aebd6c5a854048655ba8f253e7a26::locked::Locked<T0>>(&mut arg0);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x9c688ea952547e8d3ebfe13e97668659dd3aebd6c5a854048655ba8f253e7a26::locked::Locked<T0>>(&arg0)) {
            0x1::vector::push_back<T0>(&mut v0, 0x9c688ea952547e8d3ebfe13e97668659dd3aebd6c5a854048655ba8f253e7a26::locked::unlock_<T0>(0x1::vector::pop_back<0x9c688ea952547e8d3ebfe13e97668659dd3aebd6c5a854048655ba8f253e7a26::locked::Locked<T0>>(&mut arg0), 0x2::clock::timestamp_ms(arg1)));
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<0x9c688ea952547e8d3ebfe13e97668659dd3aebd6c5a854048655ba8f253e7a26::locked::Locked<T0>>(arg0);
        v0
    }

    // decompiled from Move bytecode v6
}

