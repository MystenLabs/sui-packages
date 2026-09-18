module 0x3a54319b9983e52db29b13bec9952713186cbb1910d223e0358f9cf58af9e199::constants {
    public(friend) fun max_duration_s() : 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::units::DurationS {
        0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::units::from_seconds(315360000)
    }

    public(friend) fun seconds_per_year() : u64 {
        31536000
    }

    public(friend) fun version() : u64 {
        1
    }

    // decompiled from Move bytecode v7
}

