module 0x77b5ff90a988beab0864e468bf3b006f2df0ad29b17fc590b139e4443396dd06::version {
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

