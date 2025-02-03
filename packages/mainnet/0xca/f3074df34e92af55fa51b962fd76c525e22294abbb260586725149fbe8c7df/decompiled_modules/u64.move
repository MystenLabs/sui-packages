module 0xcaf3074df34e92af55fa51b962fd76c525e22294abbb260586725149fbe8c7df::u64 {
    public fun mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = 0xcaf3074df34e92af55fa51b962fd76c525e22294abbb260586725149fbe8c7df::u128::mul_div((arg0 as u128), (arg1 as u128), (arg2 as u128));
        assert!(v0 <= 18446744073709551615, 1);
        (v0 as u64)
    }

    // decompiled from Move bytecode v6
}

