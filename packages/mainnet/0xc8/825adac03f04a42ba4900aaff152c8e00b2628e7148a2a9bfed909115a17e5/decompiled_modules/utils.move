module 0xc8825adac03f04a42ba4900aaff152c8e00b2628e7148a2a9bfed909115a17e5::utils {
    public fun partition_amount(arg0: u64, arg1: u64) : u64 {
        arg0 * arg1 / 100
    }

    // decompiled from Move bytecode v6
}

