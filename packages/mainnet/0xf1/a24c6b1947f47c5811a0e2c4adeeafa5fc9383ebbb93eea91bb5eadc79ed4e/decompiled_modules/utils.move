module 0xf1a24c6b1947f47c5811a0e2c4adeeafa5fc9383ebbb93eea91bb5eadc79ed4e::utils {
    public fun mul_div_u64(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg2 != 0, 1);
        (((arg0 as u128) * (arg1 as u128) / (arg2 as u128)) as u64)
    }

    // decompiled from Move bytecode v6
}

