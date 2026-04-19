module 0x7c43e4c89f613107d5e82fa9c5f697720a65f808e30174605e6b54d6b88a2144::version {
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

