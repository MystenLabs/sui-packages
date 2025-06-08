module 0xf7de0d6b442728b570f7ddd420b13e8ebb6568d69e114c4602d4e0a4ab2b9d90::utils {
    public fun bytes(arg0: u64, arg1: u8) : vector<u8> {
        let v0 = b"";
        let v1 = 0;
        while (v1 < arg0) {
            0x1::vector::push_back<u8>(&mut v0, arg1);
            v1 = v1 + 1;
        };
        v0
    }

    public fun compare_sizes<T0, T1>(arg0: &T0, arg1: &T1) : u8 {
        let v0 = measure_bcs_size<T0>(arg0);
        let v1 = measure_bcs_size<T1>(arg1);
        if (v0 == v1) {
            0
        } else if (v0 > v1) {
            1
        } else {
            2
        }
    }

    public fun incremental_bytes(arg0: u64, arg1: u8) : vector<u8> {
        let v0 = b"";
        let v1 = 0;
        while (v1 < arg0) {
            0x1::vector::push_back<u8>(&mut v0, ((((arg1 as u64) + v1) % 256) as u8));
            v1 = v1 + 1;
        };
        v0
    }

    public fun measure_bcs_size<T0>(arg0: &T0) : u64 {
        let v0 = 0x2::bcs::to_bytes<T0>(arg0);
        0x1::vector::length<u8>(&v0)
    }

    public fun pattern_bytes(arg0: u64, arg1: u64) : vector<u8> {
        let v0 = b"";
        let v1 = 0;
        while (v1 < arg0) {
            0x1::vector::push_back<u8>(&mut v0, (((arg1 * 7 + v1 * 13) % 256) as u8));
            v1 = v1 + 1;
        };
        v0
    }

    // decompiled from Move bytecode v6
}

