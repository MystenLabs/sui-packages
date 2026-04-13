module 0xfd6098ae62cbfc3803d8a6fc560e05c412840bf2a2afffa41c0acf2db4434bbd::version {
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

