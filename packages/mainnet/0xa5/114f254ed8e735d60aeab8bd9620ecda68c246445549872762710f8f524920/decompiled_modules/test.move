module 0xa5114f254ed8e735d60aeab8bd9620ecda68c246445549872762710f8f524920::test {
    public fun mul_add_u64(arg0: u64, arg1: u64, arg2: u64) : u64 {
        if (arg0 == 0 || arg1 == 0) {
            return 0
        };
        assert!(arg0 <= 18446744073709551615 / arg1, 8001);
        let v0 = arg0 * arg1;
        assert!(v0 <= 18446744073709551615 - arg2, 8001);
        v0 + arg2
    }

    // decompiled from Move bytecode v6
}

