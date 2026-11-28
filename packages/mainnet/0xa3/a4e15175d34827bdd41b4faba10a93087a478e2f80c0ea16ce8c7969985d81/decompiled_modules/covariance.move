module 0xa3a4e15175d34827bdd41b4faba10a93087a478e2f80c0ea16ce8c7969985d81::covariance {
    fun cov_r(arg0: &vector<u64>, arg1: &vector<u64>, arg2: bool) : 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18 {
        let v0 = pair_len(arg0, arg1);
        let v1 = v0 * 0xa3a4e15175d34827bdd41b4faba10a93087a478e2f80c0ea16ce8c7969985d81::moments::sum_prod(arg0, arg1);
        let v2 = 0xa3a4e15175d34827bdd41b4faba10a93087a478e2f80c0ea16ce8c7969985d81::moments::sum(arg0) * 0xa3a4e15175d34827bdd41b4faba10a93087a478e2f80c0ea16ce8c7969985d81::moments::sum(arg1);
        let v3 = v1 < v2;
        let v4 = if (v3) {
            v2 - v1
        } else {
            v1 - v2
        };
        0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::wrap(0xa3a4e15175d34827bdd41b4faba10a93087a478e2f80c0ea16ce8c7969985d81::ratio::signed_ratio(v3, v4, v0 * v0, arg2))
    }

    public fun covariance_down(arg0: &vector<u64>, arg1: &vector<u64>) : 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18 {
        cov_r(arg0, arg1, false)
    }

    public fun covariance_up(arg0: &vector<u64>, arg1: &vector<u64>) : 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18 {
        cov_r(arg0, arg1, true)
    }

    public fun intercept_down(arg0: &vector<u64>, arg1: &vector<u64>) : 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18 {
        intercept_r(arg0, arg1, false)
    }

    fun intercept_r(arg0: &vector<u64>, arg1: &vector<u64>, arg2: bool) : 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18 {
        let v0 = 0xa3a4e15175d34827bdd41b4faba10a93087a478e2f80c0ea16ce8c7969985d81::moments::sum(arg0);
        let v1 = 0xa3a4e15175d34827bdd41b4faba10a93087a478e2f80c0ea16ce8c7969985d81::moments::sum_sq(arg0);
        let v2 = pair_len(arg0, arg1) * v1 - v0 * v0;
        assert!(v2 > 0, 4);
        let v3 = v1 * 0xa3a4e15175d34827bdd41b4faba10a93087a478e2f80c0ea16ce8c7969985d81::moments::sum(arg1);
        let v4 = v0 * 0xa3a4e15175d34827bdd41b4faba10a93087a478e2f80c0ea16ce8c7969985d81::moments::sum_prod(arg0, arg1);
        let v5 = v3 < v4;
        let v6 = if (v5) {
            v4 - v3
        } else {
            v3 - v4
        };
        0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::wrap(0xa3a4e15175d34827bdd41b4faba10a93087a478e2f80c0ea16ce8c7969985d81::ratio::signed_ratio(v5, v6, v2, arg2))
    }

    public fun intercept_up(arg0: &vector<u64>, arg1: &vector<u64>) : 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18 {
        intercept_r(arg0, arg1, true)
    }

    fun pair_len(arg0: &vector<u64>, arg1: &vector<u64>) : u256 {
        let v0 = 0x1::vector::length<u64>(arg0);
        assert!(v0 == 0x1::vector::length<u64>(arg1), 1);
        assert!(v0 > 0, 2);
        assert!(v0 < 4294967296, 3);
        (v0 as u256)
    }

    public fun slope_down(arg0: &vector<u64>, arg1: &vector<u64>) : 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18 {
        slope_r(arg0, arg1, false)
    }

    fun slope_r(arg0: &vector<u64>, arg1: &vector<u64>, arg2: bool) : 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18 {
        let v0 = pair_len(arg0, arg1);
        let v1 = 0xa3a4e15175d34827bdd41b4faba10a93087a478e2f80c0ea16ce8c7969985d81::moments::sum(arg0);
        let v2 = v0 * 0xa3a4e15175d34827bdd41b4faba10a93087a478e2f80c0ea16ce8c7969985d81::moments::sum_sq(arg0) - v1 * v1;
        assert!(v2 > 0, 4);
        let v3 = v0 * 0xa3a4e15175d34827bdd41b4faba10a93087a478e2f80c0ea16ce8c7969985d81::moments::sum_prod(arg0, arg1);
        let v4 = v1 * 0xa3a4e15175d34827bdd41b4faba10a93087a478e2f80c0ea16ce8c7969985d81::moments::sum(arg1);
        let v5 = v3 < v4;
        let v6 = if (v5) {
            v4 - v3
        } else {
            v3 - v4
        };
        0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::wrap(0xa3a4e15175d34827bdd41b4faba10a93087a478e2f80c0ea16ce8c7969985d81::ratio::signed_ratio(v5, v6, v2, arg2))
    }

    public fun slope_up(arg0: &vector<u64>, arg1: &vector<u64>) : 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18 {
        slope_r(arg0, arg1, true)
    }

    // decompiled from Move bytecode v7
}

