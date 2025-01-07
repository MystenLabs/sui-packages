module 0x959565be8f8272726967c5a37a8b5394b590cc2bb488e07ba02f7e809df6cfa8::util {
    public fun mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = (arg0 as u256) * (arg1 as u256) / (arg2 as u256);
        assert!(v0 <= 18446744073709551615, 0x959565be8f8272726967c5a37a8b5394b590cc2bb488e07ba02f7e809df6cfa8::error_code::mul_div_overflow());
        (v0 as u64)
    }

    // decompiled from Move bytecode v6
}

