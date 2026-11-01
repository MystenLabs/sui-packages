module 0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::constants {
    public(friend) fun exchange_prices_precision() : u128 {
        1000000000000
    }

    public(friend) fun max_duration_s() : 0xdb1caa95193a0bda87e56a9aaf9878672ca8bea7039447e5c789a572a0621969::units::DurationS {
        0xdb1caa95193a0bda87e56a9aaf9878672ca8bea7039447e5c789a572a0621969::units::from_seconds(315360000)
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

