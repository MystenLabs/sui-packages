module 0xa4c1810170440726d967dfc1b6ac94290004d5fdf46c1195ef60b03cd10cccb1::rng_oracle {
    public fun pick(arg0: u64, arg1: u64) : u64 {
        (arg0 * 1103515245 + 12345) % arg1
    }

    // decompiled from Move bytecode v6
}

