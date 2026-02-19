module 0x9775782a66473e9d441e5d16ef77fc36a9dd7e061d84565f3120fb2d4d9e25c::vector {
    public fun unlock_unlockable<T0: store>(arg0: &mut vector<0x9775782a66473e9d441e5d16ef77fc36a9dd7e061d84565f3120fb2d4d9e25c::locked::Locked<T0>>, arg1: &0x2::clock::Clock) : vector<T0> {
        let v0 = 0x1::vector::empty<0x9775782a66473e9d441e5d16ef77fc36a9dd7e061d84565f3120fb2d4d9e25c::locked::Locked<T0>>();
        let v1 = 0x1::vector::empty<0x9775782a66473e9d441e5d16ef77fc36a9dd7e061d84565f3120fb2d4d9e25c::locked::Locked<T0>>();
        0x1::vector::reverse<0x9775782a66473e9d441e5d16ef77fc36a9dd7e061d84565f3120fb2d4d9e25c::locked::Locked<T0>>(arg0);
        while (!0x1::vector::is_empty<0x9775782a66473e9d441e5d16ef77fc36a9dd7e061d84565f3120fb2d4d9e25c::locked::Locked<T0>>(arg0)) {
            let v2 = 0x1::vector::pop_back<0x9775782a66473e9d441e5d16ef77fc36a9dd7e061d84565f3120fb2d4d9e25c::locked::Locked<T0>>(arg0);
            if (0x9775782a66473e9d441e5d16ef77fc36a9dd7e061d84565f3120fb2d4d9e25c::locked::lock_end_timestamp_ms<T0>(&v2) <= 0x2::clock::timestamp_ms(arg1)) {
                0x1::vector::push_back<0x9775782a66473e9d441e5d16ef77fc36a9dd7e061d84565f3120fb2d4d9e25c::locked::Locked<T0>>(&mut v0, v2);
                continue
            };
            0x1::vector::push_back<0x9775782a66473e9d441e5d16ef77fc36a9dd7e061d84565f3120fb2d4d9e25c::locked::Locked<T0>>(&mut v1, v2);
        };
        0x1::vector::reverse<0x9775782a66473e9d441e5d16ef77fc36a9dd7e061d84565f3120fb2d4d9e25c::locked::Locked<T0>>(&mut v1);
        let v3 = 0;
        while (v3 < 0x1::vector::length<0x9775782a66473e9d441e5d16ef77fc36a9dd7e061d84565f3120fb2d4d9e25c::locked::Locked<T0>>(&v1)) {
            0x1::vector::push_back<0x9775782a66473e9d441e5d16ef77fc36a9dd7e061d84565f3120fb2d4d9e25c::locked::Locked<T0>>(arg0, 0x1::vector::pop_back<0x9775782a66473e9d441e5d16ef77fc36a9dd7e061d84565f3120fb2d4d9e25c::locked::Locked<T0>>(&mut v1));
            v3 = v3 + 1;
        };
        0x1::vector::destroy_empty<0x9775782a66473e9d441e5d16ef77fc36a9dd7e061d84565f3120fb2d4d9e25c::locked::Locked<T0>>(v1);
        unlock_vec<T0>(v0, arg1)
    }

    public fun unlock_vec<T0: store>(arg0: vector<0x9775782a66473e9d441e5d16ef77fc36a9dd7e061d84565f3120fb2d4d9e25c::locked::Locked<T0>>, arg1: &0x2::clock::Clock) : vector<T0> {
        let v0 = 0x1::vector::empty<T0>();
        0x1::vector::reverse<0x9775782a66473e9d441e5d16ef77fc36a9dd7e061d84565f3120fb2d4d9e25c::locked::Locked<T0>>(&mut arg0);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x9775782a66473e9d441e5d16ef77fc36a9dd7e061d84565f3120fb2d4d9e25c::locked::Locked<T0>>(&arg0)) {
            0x1::vector::push_back<T0>(&mut v0, 0x9775782a66473e9d441e5d16ef77fc36a9dd7e061d84565f3120fb2d4d9e25c::locked::unlock_<T0>(0x1::vector::pop_back<0x9775782a66473e9d441e5d16ef77fc36a9dd7e061d84565f3120fb2d4d9e25c::locked::Locked<T0>>(&mut arg0), 0x2::clock::timestamp_ms(arg1)));
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<0x9775782a66473e9d441e5d16ef77fc36a9dd7e061d84565f3120fb2d4d9e25c::locked::Locked<T0>>(arg0);
        v0
    }

    // decompiled from Move bytecode v6
}

