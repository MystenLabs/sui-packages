module 0x943535499ac300765aa930072470e0b515cfd7eebcaa5c43762665eaad9cc6f2::utils {
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

