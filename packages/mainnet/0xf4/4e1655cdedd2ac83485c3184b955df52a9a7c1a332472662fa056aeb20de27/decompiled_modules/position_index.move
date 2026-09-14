module 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::position_index {
    struct Key has copy, drop, store {
        position: 0x2::object::ID,
    }

    public(friend) fun remove(arg0: &mut 0x2::object::UID, arg1: &mut vector<0x2::object::ID>, arg2: 0x2::object::ID) {
        let v0 = Key{position: arg2};
        assert!(0x2::dynamic_field::exists<Key>(arg0, v0), 1);
        let v1 = Key{position: arg2};
        let v2 = 0x2::dynamic_field::remove<Key, u64>(arg0, v1);
        assert!(v2 < 0x1::vector::length<0x2::object::ID>(arg1) && *0x1::vector::borrow<0x2::object::ID>(arg1, v2) == arg2, 2);
        let v3 = 0x1::vector::length<0x2::object::ID>(arg1) - 1;
        if (v2 != v3) {
            let v4 = *0x1::vector::borrow<0x2::object::ID>(arg1, v3);
            let v5 = Key{position: v4};
            if (0x2::dynamic_field::exists<Key>(arg0, v5)) {
                let v6 = Key{position: v4};
                let v7 = 0x2::dynamic_field::borrow_mut<Key, u64>(arg0, v6);
                assert!(*v7 == v3, 2);
                *v7 = v2;
            } else {
                let v8 = Key{position: v4};
                0x2::dynamic_field::add<Key, u64>(arg0, v8, v2);
            };
        };
        assert!(0x1::vector::swap_remove<0x2::object::ID>(arg1, v2) == arg2, 2);
    }

    public(friend) fun backfill(arg0: &mut 0x2::object::UID, arg1: &vector<0x2::object::ID>, arg2: u64, arg3: u64) : u64 {
        let v0 = if (arg3 > 0) {
            if (arg3 <= 128) {
                arg2 <= 0x1::vector::length<0x2::object::ID>(arg1)
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 3);
        let v1 = arg2 + 0x1::u64::min(arg3, 0x1::vector::length<0x2::object::ID>(arg1) - arg2);
        while (arg2 < v1) {
            let v2 = *0x1::vector::borrow<0x2::object::ID>(arg1, arg2);
            let v3 = Key{position: v2};
            if (0x2::dynamic_field::exists<Key>(arg0, v3)) {
                let v4 = Key{position: v2};
                assert!(*0x2::dynamic_field::borrow<Key, u64>(arg0, v4) == arg2, 2);
            } else {
                let v5 = Key{position: v2};
                0x2::dynamic_field::add<Key, u64>(arg0, v5, arg2);
            };
            arg2 = arg2 + 1;
        };
        v1
    }

    public(friend) fun contains(arg0: &0x2::object::UID, arg1: 0x2::object::ID) : bool {
        let v0 = Key{position: arg1};
        0x2::dynamic_field::exists<Key>(arg0, v0)
    }

    public(friend) fun insert(arg0: &mut 0x2::object::UID, arg1: &mut vector<0x2::object::ID>, arg2: 0x2::object::ID) {
        let v0 = Key{position: arg2};
        0x2::dynamic_field::add<Key, u64>(arg0, v0, 0x1::vector::length<0x2::object::ID>(arg1));
        0x1::vector::push_back<0x2::object::ID>(arg1, arg2);
    }

    // decompiled from Move bytecode v7
}

