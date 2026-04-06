module 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::utils {
    public fun abs_diff(arg0: u64, arg1: u64) : u64 {
        if (arg0 > arg1) {
            arg0 - arg1
        } else {
            arg1 - arg0
        }
    }

    public fun build_metadata<T0: copy + drop, T1: copy + drop>(arg0: vector<T0>, arg1: vector<T1>) : 0x2::vec_map::VecMap<T0, T1> {
        assert!(0x1::vector::length<T0>(&arg0) == 0x1::vector::length<T1>(&arg1), 13835339637633056769);
        let v0 = 0x2::vec_map::empty<T0, T1>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<T0>(&arg0)) {
            0x2::vec_map::insert<T0, T1>(&mut v0, *0x1::vector::borrow<T0>(&arg0, v1), *0x1::vector::borrow<T1>(&arg1, v1));
            v1 = v1 + 1;
        };
        v0
    }

    public fun sub_and_positive(arg0: u64, arg1: u64) : u64 {
        if (arg0 > arg1) {
            arg0 - arg1
        } else {
            0
        }
    }

    public fun sum(arg0: &vector<u64>) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v0 < 0x1::vector::length<u64>(arg0)) {
            v1 = v1 + *0x1::vector::borrow<u64>(arg0, v0);
            v0 = v0 + 1;
        };
        v1
    }

    // decompiled from Move bytecode v6
}

