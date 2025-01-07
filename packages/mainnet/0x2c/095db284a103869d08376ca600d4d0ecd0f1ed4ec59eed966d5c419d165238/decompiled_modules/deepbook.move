module 0x2c095db284a103869d08376ca600d4d0ecd0f1ed4ec59eed966d5c419d165238::deepbook {
    public fun adjust_input_amount(arg0: u64, arg1: u64) : u64 {
        arg0 - arg0 % arg1
    }

    // decompiled from Move bytecode v6
}

