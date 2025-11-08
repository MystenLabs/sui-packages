module 0xdb4f99394cb32de5f48e0be6435c1a6b01552bd10607a7a249f14a3a1faf09f5::assert {
    public fun assert_additional_ms(arg0: u64, arg1: &0xdb4f99394cb32de5f48e0be6435c1a6b01552bd10607a7a249f14a3a1faf09f5::epoch::EpochConfig) {
        assert!(0xdb4f99394cb32de5f48e0be6435c1a6b01552bd10607a7a249f14a3a1faf09f5::epoch::is_epoch_start(arg1, arg0), 0xdb4f99394cb32de5f48e0be6435c1a6b01552bd10607a7a249f14a3a1faf09f5::error::e_invalid_additional_ms());
    }

    public fun assert_init_reward_valid(arg0: u64, arg1: u64, arg2: &0x2::clock::Clock, arg3: &0xdb4f99394cb32de5f48e0be6435c1a6b01552bd10607a7a249f14a3a1faf09f5::epoch::EpochConfig) {
        assert!(arg0 > 0x2::clock::timestamp_ms(arg2), 0xdb4f99394cb32de5f48e0be6435c1a6b01552bd10607a7a249f14a3a1faf09f5::error::e_invalid_start_time());
        assert!(0xdb4f99394cb32de5f48e0be6435c1a6b01552bd10607a7a249f14a3a1faf09f5::epoch::is_epoch_start(arg3, arg0 + arg1), 0xdb4f99394cb32de5f48e0be6435c1a6b01552bd10607a7a249f14a3a1faf09f5::error::e_invalid_additional_ms());
    }

    // decompiled from Move bytecode v6
}

