module 0x552179e58ae1fc8a9b6be8360bda97e1c4d6f07621d36c8bbe6ad5c179663dd8::util {
    public fun mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let (v0, v1) = if (arg0 >= arg1) {
            (arg0, arg1)
        } else {
            (arg1, arg0)
        };
        assert!(arg2 > 0, 0);
        let v2 = (v0 as u256);
        let v3 = (v1 as u256);
        let v4 = (arg2 as u256);
        ((v2 / v4 * v3 + v2 % v4 * v3 / v4) as u64)
    }

    // decompiled from Move bytecode v6
}

