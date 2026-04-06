module 0x7e0da011c00eef73613ef256ec91d7293aea6e536069a0d0adffab2df08541e7::randomness {
    public fun expand_unique_indices_with_trace(arg0: u64, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : (vector<u64>, vector<u64>, u64) {
        assert!(arg1 > 0, 1);
        assert!(arg2 <= arg1, 2);
        let v0 = 0x1::vector::empty<u64>();
        let v1 = 0x1::vector::empty<u64>();
        let v2 = arg0;
        let v3 = 0;
        let v4 = 0;
        let v5 = 0x2::table::new<u64, u64>(arg3);
        while (v3 < arg2) {
            let v6 = arg1 - v3;
            v2 = lcg_next(v2, v6);
            v4 = v4 + 1;
            0x1::vector::push_back<u64>(&mut v1, v2);
            0x1::vector::push_back<u64>(&mut v0, mapped_or_identity(&v5, v2));
            let v7 = v6 - 1;
            let v8 = &mut v5;
            update_sparse_swap(v8, v2, v7, mapped_or_identity(&v5, v7));
            v3 = v3 + 1;
        };
        0x2::table::drop<u64, u64>(v5);
        (v0, v1, v4)
    }

    public fun lcg_a() : u64 {
        1664525
    }

    public fun lcg_c() : u64 {
        1013904223
    }

    public fun lcg_next(arg0: u64, arg1: u64) : u64 {
        if (arg1 == 0) {
            0
        } else {
            ((((arg0 as u128) * (1664525 as u128) + (1013904223 as u128)) % (arg1 as u128)) as u64)
        }
    }

    fun mapped_or_identity(arg0: &0x2::table::Table<u64, u64>, arg1: u64) : u64 {
        if (0x2::table::contains<u64, u64>(arg0, arg1)) {
            *0x2::table::borrow<u64, u64>(arg0, arg1)
        } else {
            arg1
        }
    }

    public fun mix_entropy(arg0: u64, arg1: u64) : u64 {
        arg0 ^ arg1
    }

    fun update_sparse_swap(arg0: &mut 0x2::table::Table<u64, u64>, arg1: u64, arg2: u64, arg3: u64) {
        if (arg1 != arg2) {
            if (0x2::table::contains<u64, u64>(arg0, arg1)) {
                0x2::table::remove<u64, u64>(arg0, arg1);
            };
            0x2::table::add<u64, u64>(arg0, arg1, arg3);
        } else if (0x2::table::contains<u64, u64>(arg0, arg1)) {
            0x2::table::remove<u64, u64>(arg0, arg1);
        };
        if (arg1 != arg2 && 0x2::table::contains<u64, u64>(arg0, arg2)) {
            0x2::table::remove<u64, u64>(arg0, arg2);
        };
    }

    // decompiled from Move bytecode v6
}

