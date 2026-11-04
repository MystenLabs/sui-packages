module 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::group_pair {
    struct GroupPair has copy, drop, store {
        from: u64,
        to: u64,
    }

    public fun from(arg0: &GroupPair) : u64 {
        arg0.from
    }

    public fun group_pair_vec_map<T0>(arg0: vector<u64>, arg1: vector<u64>, arg2: vector<T0>) : 0x2::vec_map::VecMap<GroupPair, T0> {
        let v0 = 0x2::vec_map::empty<GroupPair, T0>();
        assert!(0x1::vector::length<u64>(&arg0) == 0x1::vector::length<u64>(&arg1), 0);
        assert!(0x1::vector::length<u64>(&arg0) == 0x1::vector::length<T0>(&arg2), 0);
        let v1 = 0;
        while (v1 < 0x1::vector::length<T0>(&arg2)) {
            let v2 = GroupPair{
                from : 0x1::vector::pop_back<u64>(&mut arg0),
                to   : 0x1::vector::pop_back<u64>(&mut arg1),
            };
            0x2::vec_map::insert<GroupPair, T0>(&mut v0, v2, 0x1::vector::pop_back<T0>(&mut arg2));
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<T0>(arg2);
        v0
    }

    public fun group_pair_vec_set(arg0: vector<u64>, arg1: vector<u64>) : 0x2::vec_set::VecSet<GroupPair> {
        let v0 = 0x2::vec_set::empty<GroupPair>();
        assert!(0x1::vector::length<u64>(&arg0) == 0x1::vector::length<u64>(&arg1), 0);
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(&arg0)) {
            let v2 = GroupPair{
                from : 0x1::vector::pop_back<u64>(&mut arg0),
                to   : 0x1::vector::pop_back<u64>(&mut arg1),
            };
            0x2::vec_set::insert<GroupPair>(&mut v0, v2);
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<u64>(arg0);
        v0
    }

    public fun new(arg0: u64, arg1: u64) : GroupPair {
        GroupPair{
            from : arg0,
            to   : arg1,
        }
    }

    public fun to(arg0: &GroupPair) : u64 {
        arg0.to
    }

    public fun to_vectors(arg0: vector<GroupPair>) : (vector<u64>, vector<u64>) {
        let v0 = vector[];
        let v1 = vector[];
        let v2 = 0;
        while (v2 < 0x1::vector::length<GroupPair>(&arg0)) {
            let v3 = 0x1::vector::pop_back<GroupPair>(&mut arg0);
            0x1::vector::push_back<u64>(&mut v0, v3.from);
            0x1::vector::push_back<u64>(&mut v1, v3.to);
            v2 = v2 + 1;
        };
        0x1::vector::destroy_empty<GroupPair>(arg0);
        (v0, v1)
    }

    // decompiled from Move bytecode v7
}

