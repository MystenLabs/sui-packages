module 0xa3a4e15175d34827bdd41b4faba10a93087a478e2f80c0ea16ce8c7969985d81::select {
    public fun count_le(arg0: &vector<u64>, arg1: u64) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(arg0)) {
            let v2 = if (*0x1::vector::borrow<u64>(arg0, v1) <= arg1) {
                1
            } else {
                0
            };
            v0 = v0 + v2;
            v1 = v1 + 1;
        };
        v0
    }

    public fun kth_smallest(arg0: &vector<u64>, arg1: u64) : u64 {
        assert!(arg1 < 0x1::vector::length<u64>(arg0), 1);
        let v0 = 0;
        let v1 = 18446744073709551615;
        while (v0 < v1) {
            let v2 = v0 + (v1 - v0) / 2;
            if (count_le(arg0, v2) > arg1) {
                v1 = v2;
                continue
            };
            v0 = v2 + 1;
        };
        v0
    }

    public fun median(arg0: &vector<u64>) : 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::ud18::UD18 {
        let v0 = 0x1::vector::length<u64>(arg0);
        assert!(v0 > 0, 2);
        let v1 = kth_smallest(arg0, (v0 - 1) / 2);
        let v2 = if (v0 % 2 == 1) {
            v1
        } else {
            kth_smallest(arg0, v0 / 2)
        };
        0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::ud18::wrap(((v1 as u256) + (v2 as u256)) * 500000000000000000)
    }

    public fun quantile_lower(arg0: &vector<u64>, arg1: 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::ud18::UD18) : u64 {
        let v0 = 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::ud18::unwrap(arg1);
        assert!(v0 <= 1000000000000000000, 3);
        let v1 = 0x1::vector::length<u64>(arg0);
        assert!(v1 > 0, 2);
        kth_smallest(arg0, ((((v1 - 1) as u256) * v0 / 1000000000000000000) as u64))
    }

    public fun quantile_upper(arg0: &vector<u64>, arg1: 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::ud18::UD18) : u64 {
        let v0 = 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::ud18::unwrap(arg1);
        assert!(v0 <= 1000000000000000000, 3);
        let v1 = 0x1::vector::length<u64>(arg0);
        assert!(v1 > 0, 2);
        let v2 = ((v1 - 1) as u256) * v0;
        let v3 = if (v2 % 1000000000000000000 != 0) {
            v2 / 1000000000000000000 + 1
        } else {
            v2 / 1000000000000000000
        };
        kth_smallest(arg0, (v3 as u64))
    }

    // decompiled from Move bytecode v7
}

