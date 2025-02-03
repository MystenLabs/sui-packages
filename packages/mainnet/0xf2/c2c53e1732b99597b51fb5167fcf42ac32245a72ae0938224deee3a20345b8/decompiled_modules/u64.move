module 0xff47500d8fe452565b259d307bf21081ec13cd5f249c405e65e0f4159316b160::u64 {
    public fun mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = 0xff47500d8fe452565b259d307bf21081ec13cd5f249c405e65e0f4159316b160::u128::mul_div((arg0 as u128), (arg1 as u128), (arg2 as u128));
        assert!(v0 <= 18446744073709551615, 1);
        (v0 as u64)
    }

    // decompiled from Move bytecode v6
}

