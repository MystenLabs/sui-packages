module 0xff3bdba674e8e9683a19774185f1138a104f23df1a978caec30f4eda9daa6560::scallop_math_u64 {
    public fun mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = 0xff3bdba674e8e9683a19774185f1138a104f23df1a978caec30f4eda9daa6560::scallop_math_u128::mul_div((arg0 as u128), (arg1 as u128), (arg2 as u128));
        assert!(v0 <= 18446744073709551615, 9223372101279285249);
        (v0 as u64)
    }

    // decompiled from Move bytecode v6
}

