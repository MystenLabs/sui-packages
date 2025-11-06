module 0x5ffa593f329dd0222a7bc2e87ebbc2b45a6bba3c49ce2586c718f518b89673e6::utils {
    public fun to_millisecond(arg0: u64) : u64 {
        arg0 * 1000
    }

    public fun to_seconds(arg0: u64) : u64 {
        arg0 / 1000
    }

    // decompiled from Move bytecode v6
}

