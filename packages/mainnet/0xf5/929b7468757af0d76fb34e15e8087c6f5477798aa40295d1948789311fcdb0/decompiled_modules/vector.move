module 0xf5929b7468757af0d76fb34e15e8087c6f5477798aa40295d1948789311fcdb0::vector {
    public fun unlock_unlockable<T0: store>(arg0: &mut vector<0xf5929b7468757af0d76fb34e15e8087c6f5477798aa40295d1948789311fcdb0::locked::Locked<T0>>, arg1: &0x2::clock::Clock) : vector<T0> {
        let v0 = 0x1::vector::empty<0xf5929b7468757af0d76fb34e15e8087c6f5477798aa40295d1948789311fcdb0::locked::Locked<T0>>();
        let v1 = 0x1::vector::empty<0xf5929b7468757af0d76fb34e15e8087c6f5477798aa40295d1948789311fcdb0::locked::Locked<T0>>();
        0x1::vector::reverse<0xf5929b7468757af0d76fb34e15e8087c6f5477798aa40295d1948789311fcdb0::locked::Locked<T0>>(arg0);
        while (!0x1::vector::is_empty<0xf5929b7468757af0d76fb34e15e8087c6f5477798aa40295d1948789311fcdb0::locked::Locked<T0>>(arg0)) {
            let v2 = 0x1::vector::pop_back<0xf5929b7468757af0d76fb34e15e8087c6f5477798aa40295d1948789311fcdb0::locked::Locked<T0>>(arg0);
            if (0xf5929b7468757af0d76fb34e15e8087c6f5477798aa40295d1948789311fcdb0::locked::lock_end_timestamp_ms<T0>(&v2) <= 0x2::clock::timestamp_ms(arg1)) {
                0x1::vector::push_back<0xf5929b7468757af0d76fb34e15e8087c6f5477798aa40295d1948789311fcdb0::locked::Locked<T0>>(&mut v0, v2);
                continue
            };
            0x1::vector::push_back<0xf5929b7468757af0d76fb34e15e8087c6f5477798aa40295d1948789311fcdb0::locked::Locked<T0>>(&mut v1, v2);
        };
        0x1::vector::reverse<0xf5929b7468757af0d76fb34e15e8087c6f5477798aa40295d1948789311fcdb0::locked::Locked<T0>>(&mut v1);
        let v3 = 0;
        while (v3 < 0x1::vector::length<0xf5929b7468757af0d76fb34e15e8087c6f5477798aa40295d1948789311fcdb0::locked::Locked<T0>>(&v1)) {
            0x1::vector::push_back<0xf5929b7468757af0d76fb34e15e8087c6f5477798aa40295d1948789311fcdb0::locked::Locked<T0>>(arg0, 0x1::vector::pop_back<0xf5929b7468757af0d76fb34e15e8087c6f5477798aa40295d1948789311fcdb0::locked::Locked<T0>>(&mut v1));
            v3 = v3 + 1;
        };
        0x1::vector::destroy_empty<0xf5929b7468757af0d76fb34e15e8087c6f5477798aa40295d1948789311fcdb0::locked::Locked<T0>>(v1);
        unlock_vec<T0>(v0, arg1)
    }

    public fun unlock_vec<T0: store>(arg0: vector<0xf5929b7468757af0d76fb34e15e8087c6f5477798aa40295d1948789311fcdb0::locked::Locked<T0>>, arg1: &0x2::clock::Clock) : vector<T0> {
        let v0 = 0x1::vector::empty<T0>();
        0x1::vector::reverse<0xf5929b7468757af0d76fb34e15e8087c6f5477798aa40295d1948789311fcdb0::locked::Locked<T0>>(&mut arg0);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0xf5929b7468757af0d76fb34e15e8087c6f5477798aa40295d1948789311fcdb0::locked::Locked<T0>>(&arg0)) {
            0x1::vector::push_back<T0>(&mut v0, 0xf5929b7468757af0d76fb34e15e8087c6f5477798aa40295d1948789311fcdb0::locked::unlock_<T0>(0x1::vector::pop_back<0xf5929b7468757af0d76fb34e15e8087c6f5477798aa40295d1948789311fcdb0::locked::Locked<T0>>(&mut arg0), 0x2::clock::timestamp_ms(arg1)));
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<0xf5929b7468757af0d76fb34e15e8087c6f5477798aa40295d1948789311fcdb0::locked::Locked<T0>>(arg0);
        v0
    }

    // decompiled from Move bytecode v6
}

