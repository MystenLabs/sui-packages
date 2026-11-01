module 0x8269897ee68730b4bde175c883719f1fa108509113c2c177ad1b456bb3782ba2::constants {
    public(friend) fun max_duration_s() : 0xdb1caa95193a0bda87e56a9aaf9878672ca8bea7039447e5c789a572a0621969::units::DurationS {
        0xdb1caa95193a0bda87e56a9aaf9878672ca8bea7039447e5c789a572a0621969::units::from_seconds(315360000)
    }

    public(friend) fun seconds_per_year() : u64 {
        31536000
    }

    public(friend) fun version() : u64 {
        1
    }

    // decompiled from Move bytecode v7
}

