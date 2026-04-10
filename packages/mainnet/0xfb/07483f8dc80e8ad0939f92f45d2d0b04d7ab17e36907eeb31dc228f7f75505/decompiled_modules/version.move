module 0xae9d731d014c9c8ddee00be64097a55dfb47e6d3d1cbb1b0385aaf08eec17a03::version {
    struct CurrentVersion has copy, drop {
        version: u64,
    }

    public fun get_program_version() : u64 {
        let v0 = CurrentVersion{version: 7};
        0x2::event::emit<CurrentVersion>(v0);
        7
    }

    // decompiled from Move bytecode v7
}

