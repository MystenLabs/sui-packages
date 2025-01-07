module 0x27321bc52766f3ed3f809524ca0149bdbbf01f7f18bdccc261eab2dc5fa14589::utils {
    public(friend) fun from_vec_to_map<T0: copy + drop, T1: drop>(arg0: vector<T0>, arg1: vector<T1>) : 0x2::vec_map::VecMap<T0, T1> {
        assert!(0x1::vector::length<T0>(&arg0) == 0x1::vector::length<T1>(&arg1), 0);
        let v0 = 0;
        let v1 = 0x2::vec_map::empty<T0, T1>();
        while (v0 < 0x1::vector::length<T0>(&arg0)) {
            0x2::vec_map::insert<T0, T1>(&mut v1, 0x1::vector::pop_back<T0>(&mut arg0), 0x1::vector::pop_back<T1>(&mut arg1));
            v0 = v0 + 1;
        };
        v1
    }

    // decompiled from Move bytecode v6
}

