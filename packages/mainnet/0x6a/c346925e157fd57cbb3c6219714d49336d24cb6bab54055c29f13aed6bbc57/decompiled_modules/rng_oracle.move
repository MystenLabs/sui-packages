module 0x6ac346925e157fd57cbb3c6219714d49336d24cb6bab54055c29f13aed6bbc57::rng_oracle {
    public fun pick(arg0: u64, arg1: u64) : u64 {
        (arg0 * 1103515245 + 12345) % arg1
    }

    // decompiled from Move bytecode v6
}

