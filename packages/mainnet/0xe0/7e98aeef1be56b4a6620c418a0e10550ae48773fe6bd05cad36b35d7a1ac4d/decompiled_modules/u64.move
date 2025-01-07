module 0xe07e98aeef1be56b4a6620c418a0e10550ae48773fe6bd05cad36b35d7a1ac4d::u64 {
    public fun mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = 0xe07e98aeef1be56b4a6620c418a0e10550ae48773fe6bd05cad36b35d7a1ac4d::u128::mul_div((arg0 as u128), (arg1 as u128), (arg2 as u128));
        assert!(v0 <= 18446744073709551615, 1);
        (v0 as u64)
    }

    // decompiled from Move bytecode v6
}

