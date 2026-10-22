module 0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::constants {
    public(friend) fun exchange_prices_precision() : u128 {
        1000000000000
    }

    public(friend) fun max_duration_s() : 0x8dd99ecce2f05548858a39694aa5bbdd1c61adc260f9b90dc3889a9c7930ad01::units::DurationS {
        0x8dd99ecce2f05548858a39694aa5bbdd1c61adc260f9b90dc3889a9c7930ad01::units::from_seconds(315360000)
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

