module 0x9525dec11fb79eaef17138ee0352dedf4ee817bc44893a9465e7bb217b45761::version {
    struct CurrentVersion has copy, drop {
        version: u64,
    }

    public fun get_program_version() : u64 {
        let v0 = CurrentVersion{version: 3};
        0x2::event::emit<CurrentVersion>(v0);
        3
    }

    // decompiled from Move bytecode v6
}

