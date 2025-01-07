module 0x8238e878d724f642ba188226404489058e2546e92d52496d2a5bc74c9d67ef26::u64 {
    public fun mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = 0x8238e878d724f642ba188226404489058e2546e92d52496d2a5bc74c9d67ef26::u128::mul_div((arg0 as u128), (arg1 as u128), (arg2 as u128));
        assert!(v0 <= 18446744073709551615, 1);
        (v0 as u64)
    }

    // decompiled from Move bytecode v6
}

