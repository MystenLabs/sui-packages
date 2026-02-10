module 0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::committee {
    struct Committee has copy, drop, store {
        pos0: 0x2::vec_map::VecMap<0x2::object::ID, vector<u16>>,
    }

    public(friend) fun empty() : Committee {
        Committee{pos0: 0x2::vec_map::empty<0x2::object::ID, vector<u16>>()}
    }

    public(friend) fun diff(arg0: &Committee, arg1: &Committee) : (vector<0x2::object::ID>, vector<0x2::object::ID>) {
        let v0 = 0;
        let v1 = 0;
        let v2 = 0x1::vector::empty<0x2::object::ID>();
        let v3 = 0x1::vector::empty<0x2::object::ID>();
        let v4 = size(arg0);
        let v5 = size(arg1);
        while (v0 < v4 && v1 < v5) {
            let (v6, _) = 0x2::vec_map::get_entry_by_idx<0x2::object::ID, vector<u16>>(&arg0.pos0, v0);
            let (v8, _) = 0x2::vec_map::get_entry_by_idx<0x2::object::ID, vector<u16>>(&arg1.pos0, v1);
            if (v6 == v8) {
                v0 = v0 + 1;
                v1 = v1 + 1;
                continue
            };
            if (0x2::address::to_u256(0x2::object::id_to_address(v6)) < 0x2::address::to_u256(0x2::object::id_to_address(v8))) {
                v0 = v0 + 1;
                0x1::vector::push_back<0x2::object::ID>(&mut v2, *v6);
                continue
            };
            0x1::vector::push_back<0x2::object::ID>(&mut v3, *v8);
            v1 = v1 + 1;
        };
        while (v0 < v4) {
            let (v10, _) = 0x2::vec_map::get_entry_by_idx<0x2::object::ID, vector<u16>>(&arg0.pos0, v0);
            0x1::vector::push_back<0x2::object::ID>(&mut v2, *v10);
            v0 = v0 + 1;
        };
        while (v1 < v5) {
            let (v12, _) = 0x2::vec_map::get_entry_by_idx<0x2::object::ID, vector<u16>>(&arg1.pos0, v1);
            0x1::vector::push_back<0x2::object::ID>(&mut v3, *v12);
            v1 = v1 + 1;
        };
        (v2, v3)
    }

    public(friend) fun contains(arg0: &Committee, arg1: &0x2::object::ID) : bool {
        0x2::vec_map::contains<0x2::object::ID, vector<u16>>(&arg0.pos0, arg1)
    }

    public fun size(arg0: &Committee) : u64 {
        0x2::vec_map::size<0x2::object::ID, vector<u16>>(&arg0.pos0)
    }

    public(friend) fun initialize(arg0: 0x2::vec_map::VecMap<0x2::object::ID, u16>) : Committee {
        let v0 = 0;
        let v1 = if (0x2::vec_map::size<0x2::object::ID, u16>(&arg0) <= 1) {
            arg0
        } else {
            let (v2, v3) = 0x2::vec_map::into_keys_values<0x2::object::ID, u16>(arg0);
            let v4 = v3;
            let v5 = v2;
            let v6 = 1;
            while (v6 < 0x1::vector::length<0x2::object::ID>(&v5)) {
                while (v6 > 0 && 0x2::address::to_u256(0x2::object::id_to_address(0x1::vector::borrow<0x2::object::ID>(&v5, v6 - 1))) > 0x2::address::to_u256(0x2::object::id_to_address(0x1::vector::borrow<0x2::object::ID>(&v5, v6)))) {
                    0x1::vector::swap<0x2::object::ID>(&mut v5, v6 - 1, v6);
                    0x1::vector::swap<u16>(&mut v4, v6 - 1, v6);
                    v6 = v6 - 1;
                };
                v6 = v6 + 1;
            };
            0x2::vec_map::from_keys_values<0x2::object::ID, u16>(v5, v4)
        };
        let (v7, v8) = 0x2::vec_map::into_keys_values<0x2::object::ID, u16>(v1);
        let v9 = vector[];
        let v10 = v8;
        0x1::vector::reverse<u16>(&mut v10);
        let v11 = 0;
        while (v11 < 0x1::vector::length<u16>(&v10)) {
            let v12 = vector[];
            let v13 = 0;
            while (v13 < (0x1::vector::pop_back<u16>(&mut v10) as u64)) {
                let v14 = v0;
                v0 = v0 + 1;
                0x1::vector::push_back<u16>(&mut v12, v14);
                v13 = v13 + 1;
            };
            0x1::vector::push_back<vector<u16>>(&mut v9, v12);
            v11 = v11 + 1;
        };
        0x1::vector::destroy_empty<u16>(v10);
        Committee{pos0: 0x2::vec_map::from_keys_values<0x2::object::ID, vector<u16>>(v7, v9)}
    }

    public fun inner(arg0: &Committee) : &0x2::vec_map::VecMap<0x2::object::ID, vector<u16>> {
        &arg0.pos0
    }

    public fun shards(arg0: &Committee, arg1: &0x2::object::ID) : &vector<u16> {
        0x2::vec_map::get<0x2::object::ID, vector<u16>>(&arg0.pos0, arg1)
    }

    public fun to_inner(arg0: &Committee) : 0x2::vec_map::VecMap<0x2::object::ID, vector<u16>> {
        arg0.pos0
    }

    public(friend) fun transition(arg0: &Committee, arg1: 0x2::vec_map::VecMap<0x2::object::ID, u16>) : Committee {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x2::vec_map::size<0x2::object::ID, u16>(&arg1)) {
            let (_, v3) = 0x2::vec_map::get_entry_by_idx<0x2::object::ID, u16>(&arg1, v1);
            v0 = v0 + *v3;
            v1 = v1 + 1;
        };
        let v4 = 0x2::vec_map::empty<0x2::object::ID, vector<u16>>();
        let v5 = vector[];
        let v6 = 0;
        let v7 = 0;
        while (v7 < 0x2::vec_map::size<0x2::object::ID, vector<u16>>(&arg0.pos0)) {
            let (v8, v9) = 0x2::vec_map::get_entry_by_idx<0x2::object::ID, vector<u16>>(&arg0.pos0, v7);
            v6 = v6 + 0x1::vector::length<u16>(v9);
            let v10 = *v8;
            let v11 = 0x2::vec_map::get_idx_opt<0x2::object::ID, u16>(&arg1, &v10);
            let v12 = if (0x1::option::is_some<u64>(&v11)) {
                let (_, v14) = 0x2::vec_map::remove_entry_by_idx<0x2::object::ID, u16>(&mut arg1, 0x1::option::destroy_some<u64>(v11));
                0x1::option::some<u64>((v14 as u64))
            } else {
                0x1::option::destroy_none<u64>(v11);
                0x1::option::none<u64>()
            };
            let v15 = v12;
            let v16 = if (0x1::option::is_none<u64>(&v15)) {
                true
            } else {
                let v17 = 0;
                0x1::option::borrow<u64>(&v15) == &v17
            };
            if (v16) {
                0x1::vector::append<u16>(&mut v5, *v9);
            } else {
                let v18 = 0x1::vector::length<u16>(v9);
                let v19 = 0x1::option::destroy_some<u64>(v15);
                if (v18 == v19) {
                    0x2::vec_map::insert<0x2::object::ID, vector<u16>>(&mut v4, v10, *v9);
                };
                if (v18 > v19) {
                    let v20 = *v9;
                    let v21 = 0;
                    while (v21 < v18 - v19) {
                        0x1::vector::push_back<u16>(&mut v5, 0x1::vector::pop_back<u16>(&mut v20));
                        v21 = v21 + 1;
                    };
                    0x2::vec_map::insert<0x2::object::ID, vector<u16>>(&mut v4, v10, v20);
                };
                if (v18 < v19) {
                    0x2::vec_map::insert<0x2::object::ID, u16>(&mut arg1, v10, (v19 as u16));
                };
            };
            v7 = v7 + 1;
        };
        assert!((v0 as u64) == v6, 0);
        let (v22, v23) = 0x2::vec_map::into_keys_values<0x2::object::ID, u16>(arg1);
        let v24 = v22;
        let v25 = v23;
        0x1::vector::reverse<u16>(&mut v25);
        assert!(0x1::vector::length<0x2::object::ID>(&v24) == 0x1::vector::length<u16>(&v25), 13906834685444489215);
        0x1::vector::reverse<0x2::object::ID>(&mut v24);
        let v26 = 0;
        while (v26 < 0x1::vector::length<0x2::object::ID>(&v24)) {
            let v27 = 0x1::vector::pop_back<0x2::object::ID>(&mut v24);
            let v28 = 0x1::vector::pop_back<u16>(&mut v25);
            if (v28 == 0) {
            } else {
                let v29 = 0x2::vec_map::try_get<0x2::object::ID, vector<u16>>(&arg0.pos0, &v27);
                let v30 = if (0x1::option::is_some<vector<u16>>(&v29)) {
                    0x1::option::destroy_some<vector<u16>>(v29)
                } else {
                    0x1::option::destroy_none<vector<u16>>(v29);
                    vector[]
                };
                let v31 = v30;
                let v32 = 0;
                while (v32 < 0x1::u64::diff(0x1::vector::length<u16>(&v31), (v28 as u64))) {
                    0x1::vector::push_back<u16>(&mut v31, 0x1::vector::pop_back<u16>(&mut v5));
                    v32 = v32 + 1;
                };
                0x2::vec_map::insert<0x2::object::ID, vector<u16>>(&mut v4, v27, v31);
            };
            v26 = v26 + 1;
        };
        0x1::vector::destroy_empty<0x2::object::ID>(v24);
        0x1::vector::destroy_empty<u16>(v25);
        let v33 = if (0x2::vec_map::size<0x2::object::ID, vector<u16>>(&v4) <= 1) {
            v4
        } else {
            let (v34, v35) = 0x2::vec_map::into_keys_values<0x2::object::ID, vector<u16>>(v4);
            let v36 = v35;
            let v37 = v34;
            let v38 = 1;
            while (v38 < 0x1::vector::length<0x2::object::ID>(&v37)) {
                while (v38 > 0 && 0x2::address::to_u256(0x2::object::id_to_address(0x1::vector::borrow<0x2::object::ID>(&v37, v38 - 1))) > 0x2::address::to_u256(0x2::object::id_to_address(0x1::vector::borrow<0x2::object::ID>(&v37, v38)))) {
                    0x1::vector::swap<0x2::object::ID>(&mut v37, v38 - 1, v38);
                    0x1::vector::swap<vector<u16>>(&mut v36, v38 - 1, v38);
                    v38 = v38 - 1;
                };
                v38 = v38 + 1;
            };
            0x2::vec_map::from_keys_values<0x2::object::ID, vector<u16>>(v37, v36)
        };
        Committee{pos0: v33}
    }

    // decompiled from Move bytecode v6
}

