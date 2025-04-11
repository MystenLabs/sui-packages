module 0xc7f5568dbd69488437ee95f2d9a028724e1de12432965ff8acca7c67310ba46::util {
    public fun mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = (arg0 as u256) * (arg1 as u256) / (arg2 as u256);
        assert!(v0 <= 18446744073709551615, 0xc7f5568dbd69488437ee95f2d9a028724e1de12432965ff8acca7c67310ba46::error_code::mul_div_overflow());
        (v0 as u64)
    }

    // decompiled from Move bytecode v6
}

