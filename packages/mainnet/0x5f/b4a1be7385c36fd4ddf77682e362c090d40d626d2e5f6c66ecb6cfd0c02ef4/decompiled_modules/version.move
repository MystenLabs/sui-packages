module 0x5fb4a1be7385c36fd4ddf77682e362c090d40d626d2e5f6c66ecb6cfd0c02ef4::version {
    public fun next_version() : u64 {
        0x5fb4a1be7385c36fd4ddf77682e362c090d40d626d2e5f6c66ecb6cfd0c02ef4::constants::version() + 1
    }

    public fun pre_check_version(arg0: u64) {
        assert!(arg0 == 0x5fb4a1be7385c36fd4ddf77682e362c090d40d626d2e5f6c66ecb6cfd0c02ef4::constants::version(), 0x5fb4a1be7385c36fd4ddf77682e362c090d40d626d2e5f6c66ecb6cfd0c02ef4::error::incorrect_version());
    }

    public fun this_version() : u64 {
        0x5fb4a1be7385c36fd4ddf77682e362c090d40d626d2e5f6c66ecb6cfd0c02ef4::constants::version()
    }

    // decompiled from Move bytecode v6
}

