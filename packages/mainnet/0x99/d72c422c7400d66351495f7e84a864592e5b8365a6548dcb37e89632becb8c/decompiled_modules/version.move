module 0x99d72c422c7400d66351495f7e84a864592e5b8365a6548dcb37e89632becb8c::version {
    public fun next_version() : u64 {
        0x99d72c422c7400d66351495f7e84a864592e5b8365a6548dcb37e89632becb8c::constants::version() + 1
    }

    public fun pre_check_version(arg0: u64) {
        assert!(arg0 == 0x99d72c422c7400d66351495f7e84a864592e5b8365a6548dcb37e89632becb8c::constants::version(), 0x99d72c422c7400d66351495f7e84a864592e5b8365a6548dcb37e89632becb8c::error::incorrect_version());
    }

    public fun this_version() : u64 {
        0x99d72c422c7400d66351495f7e84a864592e5b8365a6548dcb37e89632becb8c::constants::version()
    }

    // decompiled from Move bytecode v6
}

