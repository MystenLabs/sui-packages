module 0xcd78ab1ff816f4ec9d6faf369cd6eb3e68a8226269cc88b666472b2805220745::version {
    public fun next_version() : u64 {
        0xcd78ab1ff816f4ec9d6faf369cd6eb3e68a8226269cc88b666472b2805220745::constants::version() + 1
    }

    public fun pre_check_version(arg0: u64) {
        assert!(arg0 == 0xcd78ab1ff816f4ec9d6faf369cd6eb3e68a8226269cc88b666472b2805220745::constants::version(), 0xcd78ab1ff816f4ec9d6faf369cd6eb3e68a8226269cc88b666472b2805220745::error::incorrect_version());
    }

    public fun this_version() : u64 {
        0xcd78ab1ff816f4ec9d6faf369cd6eb3e68a8226269cc88b666472b2805220745::constants::version()
    }

    // decompiled from Move bytecode v6
}

