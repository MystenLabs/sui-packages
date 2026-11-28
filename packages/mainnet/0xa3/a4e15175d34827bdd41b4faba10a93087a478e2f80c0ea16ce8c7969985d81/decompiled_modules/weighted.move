module 0xa3a4e15175d34827bdd41b4faba10a93087a478e2f80c0ea16ce8c7969985d81::weighted {
    public fun weighted_mean_down(arg0: &vector<u64>, arg1: &vector<u64>) : 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::ud18::UD18 {
        let v0 = 0xa3a4e15175d34827bdd41b4faba10a93087a478e2f80c0ea16ce8c7969985d81::moments::sum(arg1);
        assert!(v0 > 0, 1);
        0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::ud18::wrap(0xa3a4e15175d34827bdd41b4faba10a93087a478e2f80c0ea16ce8c7969985d81::ratio::frac_down(0xa3a4e15175d34827bdd41b4faba10a93087a478e2f80c0ea16ce8c7969985d81::moments::sum_prod(arg1, arg0), v0, 1000000000000000000))
    }

    public fun weighted_mean_up(arg0: &vector<u64>, arg1: &vector<u64>) : 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::ud18::UD18 {
        let v0 = 0xa3a4e15175d34827bdd41b4faba10a93087a478e2f80c0ea16ce8c7969985d81::moments::sum(arg1);
        assert!(v0 > 0, 1);
        0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::ud18::wrap(0xa3a4e15175d34827bdd41b4faba10a93087a478e2f80c0ea16ce8c7969985d81::ratio::frac_up(0xa3a4e15175d34827bdd41b4faba10a93087a478e2f80c0ea16ce8c7969985d81::moments::sum_prod(arg1, arg0), v0, 1000000000000000000))
    }

    // decompiled from Move bytecode v7
}

