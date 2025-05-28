module 0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::util {
    public fun mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = (arg0 as u256) * (arg1 as u256) / (arg2 as u256);
        assert!(v0 <= 18446744073709551615, 0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::error_code::mul_div_overflow());
        (v0 as u64)
    }

    // decompiled from Move bytecode v6
}

