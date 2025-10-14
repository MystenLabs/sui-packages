module 0x40a75086cf3902b3bae80aba77f01e8aea44ef60d319a8017c7a5c081f8f8b43::utils {
    public fun to_millisecond(arg0: u64) : u64 {
        arg0 * 1000
    }

    public fun to_seconds(arg0: u64) : u64 {
        arg0 / 1000
    }

    // decompiled from Move bytecode v6
}

