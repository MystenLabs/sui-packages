module 0x643fbc9d6182493e533a85a49a584a1c08471e2d28e6de842eb183c8d2ed9438::util {
    public(friend) fun bytes_start_with(arg0: &vector<u8>, arg1: &vector<u8>) : bool {
        let v0 = 0x1::vector::length<u8>(arg1);
        if (0x1::vector::length<u8>(arg0) < v0) {
            return false
        };
        let v1 = true;
        let v2 = 0;
        while (v2 < v0) {
            if (*0x1::vector::borrow<u8>(arg0, v2) != *0x1::vector::borrow<u8>(arg1, v2)) {
                v1 = false;
                break
            };
            v2 = v2 + 1;
        };
        v1
    }

    public(friend) fun id_bytes(arg0: 0x2::object::ID) : vector<u8> {
        0x2::address::to_bytes(0x2::object::id_to_address(&arg0))
    }

    public(friend) fun set_insert<T0: copy + drop>(arg0: &mut 0x2::vec_set::VecSet<T0>, arg1: T0) : bool {
        if (0x2::vec_set::contains<T0>(arg0, &arg1)) {
            false
        } else {
            0x2::vec_set::insert<T0>(arg0, arg1);
            true
        }
    }

    public(friend) fun set_remove<T0: copy + drop>(arg0: &mut 0x2::vec_set::VecSet<T0>, arg1: T0) : bool {
        if (0x2::vec_set::contains<T0>(arg0, &arg1)) {
            0x2::vec_set::remove<T0>(arg0, &arg1);
            true
        } else {
            false
        }
    }

    public(friend) fun upsert<T0: copy + drop, T1: drop>(arg0: &mut 0x2::vec_map::VecMap<T0, T1>, arg1: T0, arg2: T1) {
        if (0x2::vec_map::contains<T0, T1>(arg0, &arg1)) {
            *0x2::vec_map::get_mut<T0, T1>(arg0, &arg1) = arg2;
        } else {
            0x2::vec_map::insert<T0, T1>(arg0, arg1, arg2);
        };
    }

    // decompiled from Move bytecode v7
}

