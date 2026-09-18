module 0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::constants {
    public(friend) fun exchange_prices_precision() : u128 {
        1000000000000
    }

    public(friend) fun max_duration_s() : 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::units::DurationS {
        0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::units::from_seconds(315360000)
    }

    public(friend) fun max_rewards_rate() : u64 {
        50000000000000
    }

    public(friend) fun return_percent_precision() : u128 {
        100000000000000
    }

    public(friend) fun seconds_per_year() : u64 {
        31536000
    }

    public(friend) fun version() : u64 {
        1
    }

    // decompiled from Move bytecode v7
}

