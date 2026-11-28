module 0xa3a4e15175d34827bdd41b4faba10a93087a478e2f80c0ea16ce8c7969985d81::moments {
    public(friend) fun checked_len(arg0: &vector<u64>) : u256 {
        let v0 = 0x1::vector::length<u64>(arg0);
        assert!(v0 > 0, 1);
        assert!(v0 < 4294967296, 2);
        (v0 as u256)
    }

    public fun mean_down(arg0: &vector<u64>) : 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::ud18::UD18 {
        let v0 = 0x1::vector::length<u64>(arg0);
        assert!(v0 > 0, 1);
        0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::ud18::wrap(0xa3a4e15175d34827bdd41b4faba10a93087a478e2f80c0ea16ce8c7969985d81::ratio::frac_down(sum(arg0), (v0 as u256), 1000000000000000000))
    }

    public fun mean_up(arg0: &vector<u64>) : 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::ud18::UD18 {
        let v0 = 0x1::vector::length<u64>(arg0);
        assert!(v0 > 0, 1);
        0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::ud18::wrap(0xa3a4e15175d34827bdd41b4faba10a93087a478e2f80c0ea16ce8c7969985d81::ratio::frac_up(sum(arg0), (v0 as u256), 1000000000000000000))
    }

    public fun sample_variance_down(arg0: &vector<u64>) : 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::ud18::UD18 {
        let v0 = checked_len(arg0);
        assert!(v0 >= 2, 3);
        0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::ud18::wrap(0xa3a4e15175d34827bdd41b4faba10a93087a478e2f80c0ea16ce8c7969985d81::ratio::frac_down(sxx(arg0, v0), v0 * (v0 - 1), 1000000000000000000))
    }

    public fun sample_variance_up(arg0: &vector<u64>) : 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::ud18::UD18 {
        let v0 = checked_len(arg0);
        assert!(v0 >= 2, 3);
        0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::ud18::wrap(0xa3a4e15175d34827bdd41b4faba10a93087a478e2f80c0ea16ce8c7969985d81::ratio::frac_up(sxx(arg0, v0), v0 * (v0 - 1), 1000000000000000000))
    }

    public fun stddev_down(arg0: &vector<u64>) : 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::ud18::UD18 {
        let v0 = checked_len(arg0);
        0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::ud18::wrap(0x30cc7e3dc943e321fe01580cec162810e14fc92e37a518ab40c9268b823883b6::bits256::isqrt_down(0xa3a4e15175d34827bdd41b4faba10a93087a478e2f80c0ea16ce8c7969985d81::ratio::frac_down(sxx(arg0, v0), v0 * v0, 1000000000000000000000000000000000000)))
    }

    public fun stddev_up(arg0: &vector<u64>) : 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::ud18::UD18 {
        let v0 = checked_len(arg0);
        0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::ud18::wrap(0x30cc7e3dc943e321fe01580cec162810e14fc92e37a518ab40c9268b823883b6::bits256::isqrt_up(0xa3a4e15175d34827bdd41b4faba10a93087a478e2f80c0ea16ce8c7969985d81::ratio::frac_up(sxx(arg0, v0), v0 * v0, 1000000000000000000000000000000000000)))
    }

    public fun sum(arg0: &vector<u64>) : u256 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(arg0)) {
            v0 = v0 + (*0x1::vector::borrow<u64>(arg0, v1) as u256);
            v1 = v1 + 1;
        };
        v0
    }

    public fun sum_prod(arg0: &vector<u64>, arg1: &vector<u64>) : u256 {
        let v0 = 0x1::vector::length<u64>(arg0);
        assert!(v0 == 0x1::vector::length<u64>(arg1), 4);
        let v1 = 0;
        let v2 = 0;
        while (v2 < v0) {
            v1 = v1 + (*0x1::vector::borrow<u64>(arg0, v2) as u256) * (*0x1::vector::borrow<u64>(arg1, v2) as u256);
            v2 = v2 + 1;
        };
        v1
    }

    public fun sum_sq(arg0: &vector<u64>) : u256 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(arg0)) {
            let v2 = (*0x1::vector::borrow<u64>(arg0, v1) as u256);
            v0 = v0 + v2 * v2;
            v1 = v1 + 1;
        };
        v0
    }

    public(friend) fun sxx(arg0: &vector<u64>, arg1: u256) : u256 {
        let v0 = sum(arg0);
        arg1 * sum_sq(arg0) - v0 * v0
    }

    public fun variance_down(arg0: &vector<u64>) : 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::ud18::UD18 {
        let v0 = checked_len(arg0);
        0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::ud18::wrap(0xa3a4e15175d34827bdd41b4faba10a93087a478e2f80c0ea16ce8c7969985d81::ratio::frac_down(sxx(arg0, v0), v0 * v0, 1000000000000000000))
    }

    public fun variance_up(arg0: &vector<u64>) : 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::ud18::UD18 {
        let v0 = checked_len(arg0);
        0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::ud18::wrap(0xa3a4e15175d34827bdd41b4faba10a93087a478e2f80c0ea16ce8c7969985d81::ratio::frac_up(sxx(arg0, v0), v0 * v0, 1000000000000000000))
    }

    // decompiled from Move bytecode v7
}

