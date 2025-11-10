module 0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::utils {
    public fun to_millisecond(arg0: u64) : u64 {
        arg0 * 1000
    }

    public fun to_seconds(arg0: u64) : u64 {
        arg0 / 1000
    }

    // decompiled from Move bytecode v6
}

