module 0x2451f28ad4bf46f8cbf75a4195560d592379d0f59f940257037d9e1442840a43::math {
    public fun mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg2 != 0, 500);
        let v0 = (arg0 as u128) * (arg1 as u128) / (arg2 as u128);
        assert!(v0 <= 18446744073709551615, 501);
        (v0 as u64)
    }

    // decompiled from Move bytecode v6
}

