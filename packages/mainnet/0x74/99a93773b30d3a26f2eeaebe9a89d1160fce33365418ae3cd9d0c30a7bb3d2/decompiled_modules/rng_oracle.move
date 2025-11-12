module 0x7499a93773b30d3a26f2eeaebe9a89d1160fce33365418ae3cd9d0c30a7bb3d2::rng_oracle {
    public fun pick(arg0: u64, arg1: u64) : u64 {
        (arg0 * 1103515245 + 12345) % arg1
    }

    // decompiled from Move bytecode v6
}

