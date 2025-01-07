module 0xe597e13d410a4f14272eb8bd3c232f10006f9c3e35375dfdf8984e4ec250d2a3::util {
    public fun mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = (arg0 as u256) * (arg1 as u256) / (arg2 as u256);
        assert!(v0 <= 18446744073709551615, 0xe597e13d410a4f14272eb8bd3c232f10006f9c3e35375dfdf8984e4ec250d2a3::error_code::mul_div_overflow());
        (v0 as u64)
    }

    // decompiled from Move bytecode v6
}

