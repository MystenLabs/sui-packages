module 0xde56083161a6c70d46a1927cfffaaab71c1af48de15a69a804460802d63e4092::deepbook {
    public fun adjust_input_amount(arg0: u64, arg1: u64) : u64 {
        arg0 - arg0 / arg1
    }

    // decompiled from Move bytecode v6
}

