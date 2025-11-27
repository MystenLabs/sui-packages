module 0x65b7b808b75dbbe391abe0188e973975192f678cfdb97056ed3d33b033a8a342::u64 {
    public fun mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = 0x65b7b808b75dbbe391abe0188e973975192f678cfdb97056ed3d33b033a8a342::u128::mul_div((arg0 as u128), (arg1 as u128), (arg2 as u128));
        assert!(v0 <= 18446744073709551615, 1);
        (v0 as u64)
    }

    // decompiled from Move bytecode v6
}

