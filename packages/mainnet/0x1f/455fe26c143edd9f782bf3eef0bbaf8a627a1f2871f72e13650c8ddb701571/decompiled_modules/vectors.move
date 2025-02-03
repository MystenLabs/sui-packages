module 0x1f455fe26c143edd9f782bf3eef0bbaf8a627a1f2871f72e13650c8ddb701571::vectors {
    public fun ascending_insertion_sort(arg0: vector<u256>) : vector<u256> {
        let v0 = 0x1::vector::length<u256>(&arg0);
        let v1 = 1;
        while (v0 > v1) {
            let v2 = *0x1::vector::borrow<u256>(&arg0, v1);
            let v3 = v1;
            while (v0 > 0) {
                let v4 = *0x1::vector::borrow<u256>(&arg0, v3 - 1);
                if (v4 < v2) {
                    break
                };
                *0x1::vector::borrow_mut<u256>(&mut arg0, v3) = v4;
                let v5 = v3 - 1;
                v3 = v5;
                if (v5 == 0) {
                    break
                };
            };
            *0x1::vector::borrow_mut<u256>(&mut arg0, v3) = v2;
            v1 = v1 + 1;
        };
        arg0
    }

    public fun descending_insertion_sort(arg0: vector<u256>) : vector<u256> {
        let v0 = 0x1::vector::length<u256>(&arg0);
        let v1 = 1;
        while (v0 > v1) {
            let v2 = *0x1::vector::borrow<u256>(&arg0, v1);
            let v3 = v1;
            while (v0 > 0) {
                let v4 = *0x1::vector::borrow<u256>(&arg0, v3 - 1);
                if (v4 > v2) {
                    break
                };
                *0x1::vector::borrow_mut<u256>(&mut arg0, v3) = v4;
                let v5 = v3 - 1;
                v3 = v5;
                if (v5 == 0) {
                    break
                };
            };
            *0x1::vector::borrow_mut<u256>(&mut arg0, v3) = v2;
            v1 = v1 + 1;
        };
        arg0
    }

    public fun find_upper_bound(arg0: vector<u64>, arg1: u64) : u64 {
        if (0x1::vector::length<u64>(&arg0) == 0) {
            return 0
        };
        let v0 = 0;
        let v1 = 0x1::vector::length<u64>(&arg0);
        while (v0 < v1) {
            v1 = 0x1f455fe26c143edd9f782bf3eef0bbaf8a627a1f2871f72e13650c8ddb701571::math64::average(v0, v1);
            if (*0x1::vector::borrow<u64>(&arg0, v1) > arg1) {
                continue
            };
            v0 = v1 + 1;
        };
        if (v0 > 0 && *0x1::vector::borrow<u64>(&arg0, v0 - 1) == arg1) {
            v0 - 1
        } else {
            v0
        }
    }

    public fun gt(arg0: vector<u8>, arg1: vector<u8>) : bool {
        let v0 = 0;
        let v1 = 0x1::vector::length<u8>(&arg0);
        assert!(v1 == 0x1::vector::length<u8>(&arg1), 0);
        while (v0 < v1) {
            let v2 = *0x1::vector::borrow<u8>(&arg0, v0);
            let v3 = *0x1::vector::borrow<u8>(&arg1, v0);
            if (v2 > v3) {
                return true
            };
            if (v2 < v3) {
                return false
            };
            v0 = v0 + 1;
        };
        false
    }

    public fun gte(arg0: vector<u8>, arg1: vector<u8>) : bool {
        let v0 = 0;
        let v1 = 0x1::vector::length<u8>(&arg0);
        assert!(v1 == 0x1::vector::length<u8>(&arg1), 0);
        while (v0 < v1) {
            let v2 = *0x1::vector::borrow<u8>(&arg0, v0);
            let v3 = *0x1::vector::borrow<u8>(&arg1, v0);
            if (v2 > v3) {
                return true
            };
            if (v2 < v3) {
                return false
            };
            v0 = v0 + 1;
        };
        true
    }

    public fun lt(arg0: vector<u8>, arg1: vector<u8>) : bool {
        let v0 = 0;
        let v1 = 0x1::vector::length<u8>(&arg0);
        assert!(v1 == 0x1::vector::length<u8>(&arg1), 0);
        while (v0 < v1) {
            let v2 = *0x1::vector::borrow<u8>(&arg0, v0);
            let v3 = *0x1::vector::borrow<u8>(&arg1, v0);
            if (v2 < v3) {
                return true
            };
            if (v2 > v3) {
                return false
            };
            v0 = v0 + 1;
        };
        false
    }

    public fun lte(arg0: vector<u8>, arg1: vector<u8>) : bool {
        let v0 = 0;
        let v1 = 0x1::vector::length<u8>(&arg0);
        assert!(v1 == 0x1::vector::length<u8>(&arg1), 0);
        while (v0 < v1) {
            let v2 = *0x1::vector::borrow<u8>(&arg0, v0);
            let v3 = *0x1::vector::borrow<u8>(&arg1, v0);
            if (v2 < v3) {
                return true
            };
            if (v2 > v3) {
                return false
            };
            v0 = v0 + 1;
        };
        true
    }

    fun partion(arg0: &mut vector<u256>, arg1: u64, arg2: u64) : u64 {
        let v0 = arg1 + 1;
        let v1 = v0;
        while (v0 <= arg2) {
            if (*0x1::vector::borrow<u256>(arg0, v0) < *0x1::vector::borrow<u256>(arg0, arg1)) {
                0x1::vector::swap<u256>(arg0, v0, v1);
                v1 = v1 + 1;
            };
            v0 = v0 + 1;
        };
        0x1::vector::swap<u256>(arg0, arg1, v1 - 1);
        v1 - 1
    }

    public fun quick_sort(arg0: &mut vector<u256>, arg1: u64, arg2: u64) {
        if (arg1 < arg2) {
            let v0 = partion(arg0, arg1, arg2);
            if (v0 > 1) {
                quick_sort(arg0, arg1, v0 - 1);
            };
            quick_sort(arg0, v0 + 1, arg2);
        };
    }

    public fun to_vec_set<T0: copy + drop>(arg0: vector<T0>) : 0x2::vec_set::VecSet<T0> {
        let v0 = 0;
        let v1 = 0x2::vec_set::empty<T0>();
        while (0x1::vector::length<T0>(&arg0) > v0) {
            0x2::vec_set::insert<T0>(&mut v1, *0x1::vector::borrow<T0>(&arg0, v0));
            v0 = v0 + 1;
        };
        v1
    }

    // decompiled from Move bytecode v6
}

