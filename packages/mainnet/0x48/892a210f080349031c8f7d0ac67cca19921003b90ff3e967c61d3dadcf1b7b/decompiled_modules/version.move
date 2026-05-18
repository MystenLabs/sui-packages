module 0x48892a210f080349031c8f7d0ac67cca19921003b90ff3e967c61d3dadcf1b7b::version {
    public fun next_version() : u64 {
        0x48892a210f080349031c8f7d0ac67cca19921003b90ff3e967c61d3dadcf1b7b::constants::version() + 1
    }

    public fun pre_check_version(arg0: u64) {
        assert!(arg0 == 0x48892a210f080349031c8f7d0ac67cca19921003b90ff3e967c61d3dadcf1b7b::constants::version(), 0x48892a210f080349031c8f7d0ac67cca19921003b90ff3e967c61d3dadcf1b7b::error::incorrect_version());
    }

    public fun this_version() : u64 {
        0x48892a210f080349031c8f7d0ac67cca19921003b90ff3e967c61d3dadcf1b7b::constants::version()
    }

    // decompiled from Move bytecode v7
}

