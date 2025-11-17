module 0xdb2f245331502370e5518886b9ef2ea52293df6d1238baa0a25de1341297feb0::u64 {
    public fun mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = 0xdb2f245331502370e5518886b9ef2ea52293df6d1238baa0a25de1341297feb0::u128::mul_div((arg0 as u128), (arg1 as u128), (arg2 as u128));
        assert!(v0 <= 18446744073709551615, 1);
        (v0 as u64)
    }

    // decompiled from Move bytecode v6
}

