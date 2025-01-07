module 0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::diff {
    public fun calculate_difference(arg0: vector<u8>, arg1: vector<u8>, arg2: u64, arg3: u64) : u64 {
        assert!(0x1::vector::length<u8>(&arg0) == 32, 1);
        assert!(0x1::vector::length<u8>(&arg1) == 32, 1);
        let v0 = if (arg3 > arg2) {
            arg3 - arg2
        } else {
            arg2 - arg3
        };
        major_defference_between_hashes(arg0, arg1) * 1000000 + ((difference_between_bytes(*0x1::vector::borrow<u8>(&arg0, 0), *0x1::vector::borrow<u8>(&arg1, 0)) as u64) + (difference_between_bytes(*0x1::vector::borrow<u8>(&arg0, 1), *0x1::vector::borrow<u8>(&arg1, 1)) as u64) + (difference_between_bytes(*0x1::vector::borrow<u8>(&arg0, 2), *0x1::vector::borrow<u8>(&arg1, 2)) as u64)) * 3000 + v0 * 3
    }

    public fun difference_between_bytes(arg0: u8, arg1: u8) : u8 {
        if (arg0 > arg1) {
            arg0 - arg1
        } else {
            arg1 - arg0
        }
    }

    public fun major_defference_between_hashes(arg0: vector<u8>, arg1: vector<u8>) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 32) {
            v0 = v0 + (0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::byte_util::count_bits(*0x1::vector::borrow<u8>(&arg0, v1) ^ *0x1::vector::borrow<u8>(&arg1, v1)) as u64);
            v1 = v1 + 1;
        };
        v0
    }

    public fun major_difference_equals(arg0: u64, arg1: u64) : bool {
        arg0 / 1000000 == arg1 / 1000000
    }

    public fun major_difference_equals_or_less_than(arg0: u64, arg1: u64) : bool {
        arg0 / 1000000 <= arg1 / 1000000
    }

    // decompiled from Move bytecode v6
}

