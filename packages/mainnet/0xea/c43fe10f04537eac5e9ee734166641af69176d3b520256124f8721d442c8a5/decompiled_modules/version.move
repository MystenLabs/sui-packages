module 0xeac43fe10f04537eac5e9ee734166641af69176d3b520256124f8721d442c8a5::version {
    public fun next_version() : u64 {
        0xeac43fe10f04537eac5e9ee734166641af69176d3b520256124f8721d442c8a5::constants::version() + 1
    }

    public fun pre_check_version(arg0: u64) {
        assert!(arg0 == 0xeac43fe10f04537eac5e9ee734166641af69176d3b520256124f8721d442c8a5::constants::version(), 0xeac43fe10f04537eac5e9ee734166641af69176d3b520256124f8721d442c8a5::error::incorrect_version());
    }

    public fun this_version() : u64 {
        0xeac43fe10f04537eac5e9ee734166641af69176d3b520256124f8721d442c8a5::constants::version()
    }

    // decompiled from Move bytecode v6
}

