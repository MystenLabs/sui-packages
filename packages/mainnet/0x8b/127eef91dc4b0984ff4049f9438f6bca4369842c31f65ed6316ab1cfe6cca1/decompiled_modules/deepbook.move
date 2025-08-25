module 0x18c815edb99030944a5812fb66a72bd5980db23134c655d1c23becd46c3cf00d::deepbook {
    public fun adjust_input_amount(arg0: u64, arg1: u64) : u64 {
        arg0 - arg0 % arg1
    }

    // decompiled from Move bytecode v6
}

