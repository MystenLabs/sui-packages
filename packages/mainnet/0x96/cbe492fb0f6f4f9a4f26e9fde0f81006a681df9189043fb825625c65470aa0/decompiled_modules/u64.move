module 0x96cbe492fb0f6f4f9a4f26e9fde0f81006a681df9189043fb825625c65470aa0::u64 {
    public fun mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = 0x96cbe492fb0f6f4f9a4f26e9fde0f81006a681df9189043fb825625c65470aa0::u128::mul_div((arg0 as u128), (arg1 as u128), (arg2 as u128));
        assert!(v0 <= 18446744073709551615, 1);
        (v0 as u64)
    }

    // decompiled from Move bytecode v6
}

