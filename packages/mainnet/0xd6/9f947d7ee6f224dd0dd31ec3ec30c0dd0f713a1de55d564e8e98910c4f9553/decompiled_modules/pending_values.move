module 0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::pending_values {
    struct PendingValues has copy, drop, store {
        pos0: 0x2::vec_map::VecMap<u64, u64>,
    }

    public(friend) fun empty() : PendingValues {
        PendingValues{pos0: 0x2::vec_map::empty<u64, u64>()}
    }

    public(friend) fun is_empty(arg0: &PendingValues) : bool {
        0x2::vec_map::is_empty<u64, u64>(&arg0.pos0)
    }

    public(friend) fun flush(arg0: &mut PendingValues, arg1: u64) : u64 {
        let v0 = 0;
        let v1 = 0x2::vec_map::keys<u64, u64>(&arg0.pos0);
        0x1::vector::reverse<u64>(&mut v1);
        let v2 = 0;
        while (v2 < 0x1::vector::length<u64>(&v1)) {
            let v3 = 0x1::vector::pop_back<u64>(&mut v1);
            if (v3 <= arg1) {
                let (_, v5) = 0x2::vec_map::remove<u64, u64>(&mut arg0.pos0, &v3);
                v0 = v0 + v5;
            };
            v2 = v2 + 1;
        };
        0x1::vector::destroy_empty<u64>(v1);
        v0
    }

    public(friend) fun inner(arg0: &PendingValues) : &0x2::vec_map::VecMap<u64, u64> {
        &arg0.pos0
    }

    public(friend) fun inner_mut(arg0: &mut PendingValues) : &mut 0x2::vec_map::VecMap<u64, u64> {
        &mut arg0.pos0
    }

    public(friend) fun insert_or_add(arg0: &mut PendingValues, arg1: u64, arg2: u64) {
        let v0 = &mut arg0.pos0;
        if (!0x2::vec_map::contains<u64, u64>(v0, &arg1)) {
            0x2::vec_map::insert<u64, u64>(v0, arg1, arg2);
        } else {
            *0x2::vec_map::get_mut<u64, u64>(v0, &arg1) = *0x2::vec_map::get<u64, u64>(v0, &arg1) + arg2;
        };
    }

    public(friend) fun insert_or_replace(arg0: &mut PendingValues, arg1: u64, arg2: u64) {
        let v0 = &mut arg0.pos0;
        if (!0x2::vec_map::contains<u64, u64>(v0, &arg1)) {
            0x2::vec_map::insert<u64, u64>(v0, arg1, arg2);
        } else {
            *0x2::vec_map::get_mut<u64, u64>(v0, &arg1) = arg2;
        };
    }

    public(friend) fun reduce(arg0: &mut PendingValues, arg1: u64, arg2: u64) {
        let v0 = &mut arg0.pos0;
        if (!0x2::vec_map::contains<u64, u64>(v0, &arg1)) {
            abort 0
        };
        let v1 = *0x2::vec_map::get<u64, u64>(v0, &arg1);
        assert!(v1 >= arg2, 1);
        *0x2::vec_map::get_mut<u64, u64>(v0, &arg1) = v1 - arg2;
    }

    public(friend) fun unwrap(arg0: PendingValues) : 0x2::vec_map::VecMap<u64, u64> {
        let PendingValues { pos0: v0 } = arg0;
        v0
    }

    public(friend) fun value_at(arg0: &PendingValues, arg1: u64) : u64 {
        let v0 = 0;
        let v1 = v0;
        let v2 = 0x2::vec_map::keys<u64, u64>(&arg0.pos0);
        0x1::vector::reverse<u64>(&mut v2);
        let v3 = 0;
        while (v3 < 0x1::vector::length<u64>(&v2)) {
            let v4 = v1;
            let v5 = 0x1::vector::pop_back<u64>(&mut v2);
            if (v5 <= arg1) {
                v4 = v0 + *0x2::vec_map::get<u64, u64>(&arg0.pos0, &v5);
            };
            v1 = v4;
            v3 = v3 + 1;
        };
        0x1::vector::destroy_empty<u64>(v2);
        v1
    }

    // decompiled from Move bytecode v6
}

