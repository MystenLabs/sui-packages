module 0x2c90dc0ebeb90628a2a9915cdd809f6509d1b8a1bde69a25cfb783802c1101f4::utils {
    public fun calculate_reward_in_duration(arg0: u64, arg1: u64) : u64 {
        arg0 * to_seconds(arg1)
    }

    public fun calculate_reward_per_seconds(arg0: u64, arg1: u64) : u64 {
        assert!(to_seconds(arg1) > 0, 0);
        arg0 / to_seconds(arg1)
    }

    public fun to_milliseconds(arg0: u64) : u64 {
        arg0 * 1000
    }

    public fun to_seconds(arg0: u64) : u64 {
        arg0 / 1000
    }

    public fun transfer_or_destroy_zero<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address) {
        if (0x2::coin::value<T0>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, arg1);
        } else {
            0x2::coin::destroy_zero<T0>(arg0);
        };
    }

    // decompiled from Move bytecode v6
}

