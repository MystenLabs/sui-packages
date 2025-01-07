module 0xefaaeb2f19cd1adab369f230c6e821b6b272c378bb346af80a1dfd680b0be0f3::u64 {
    public fun mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = 0xefaaeb2f19cd1adab369f230c6e821b6b272c378bb346af80a1dfd680b0be0f3::u128::mul_div((arg0 as u128), (arg1 as u128), (arg2 as u128));
        assert!(v0 <= 18446744073709551615, 1);
        (v0 as u64)
    }

    // decompiled from Move bytecode v6
}

