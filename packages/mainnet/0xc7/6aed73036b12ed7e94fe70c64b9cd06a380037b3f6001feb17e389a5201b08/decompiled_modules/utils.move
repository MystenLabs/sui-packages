module 0xc76aed73036b12ed7e94fe70c64b9cd06a380037b3f6001feb17e389a5201b08::utils {
    public fun to_millisecond(arg0: u64) : u64 {
        arg0 * 1000
    }

    public fun to_seconds(arg0: u64) : u64 {
        arg0 / 1000
    }

    // decompiled from Move bytecode v6
}

