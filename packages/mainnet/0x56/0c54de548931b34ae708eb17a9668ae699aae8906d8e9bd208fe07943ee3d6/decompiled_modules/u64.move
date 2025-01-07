module 0x560c54de548931b34ae708eb17a9668ae699aae8906d8e9bd208fe07943ee3d6::u64 {
    public fun mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = 0x560c54de548931b34ae708eb17a9668ae699aae8906d8e9bd208fe07943ee3d6::u128::mul_div((arg0 as u128), (arg1 as u128), (arg2 as u128));
        assert!(v0 <= 18446744073709551615, 1);
        (v0 as u64)
    }

    // decompiled from Move bytecode v6
}

