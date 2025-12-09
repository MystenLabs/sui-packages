module 0x493b93df465b97d9d2cb3b76081716d46124d65ab7233952498ccccca6ab8cbb::utils {
    public fun to_milliseconds(arg0: u64) : u64 {
        arg0 * 1000
    }

    public fun to_seconds(arg0: u64) : u64 {
        arg0 / 1000
    }

    // decompiled from Move bytecode v6
}

