module 0x569ef712faf75807035e599d1db44b91dbfa296b91099a07d2d394e0caa7d620::mint_utils {
    public fun vec_map_from_vec<T0: copy + drop, T1: drop>(arg0: vector<T0>, arg1: vector<T1>) : 0x2::vec_map::VecMap<T0, T1> {
        let v0 = 0x1::vector::length<T0>(&arg0);
        assert!(v0 == 0x1::vector::length<T1>(&arg1), 0);
        let v1 = 0x2::vec_map::empty<T0, T1>();
        let v2 = 0;
        while (v2 < v0) {
            0x2::vec_map::insert<T0, T1>(&mut v1, 0x1::vector::pop_back<T0>(&mut arg0), 0x1::vector::pop_back<T1>(&mut arg1));
            v2 = v2 + 1;
        };
        v1
    }

    // decompiled from Move bytecode v6
}

