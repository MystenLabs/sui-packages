module 0x5ffa593f329dd0222a7bc2e87ebbc2b45a6bba3c49ce2586c718f518b89673e6::assert {
    public fun assert_additional_ms(arg0: u64, arg1: &0x5ffa593f329dd0222a7bc2e87ebbc2b45a6bba3c49ce2586c718f518b89673e6::epoch::EpochConfig) {
        assert!(arg0 > 0, 0x5ffa593f329dd0222a7bc2e87ebbc2b45a6bba3c49ce2586c718f518b89673e6::error::e_invalid_additional_ms());
        assert!(0x5ffa593f329dd0222a7bc2e87ebbc2b45a6bba3c49ce2586c718f518b89673e6::epoch::is_epoch_start(arg1, arg0), 0x5ffa593f329dd0222a7bc2e87ebbc2b45a6bba3c49ce2586c718f518b89673e6::error::e_invalid_additional_ms());
    }

    public fun assert_init_reward_valid(arg0: u64, arg1: u64, arg2: &0x2::clock::Clock, arg3: &0x5ffa593f329dd0222a7bc2e87ebbc2b45a6bba3c49ce2586c718f518b89673e6::epoch::EpochConfig) {
        assert!(arg0 > 0x2::clock::timestamp_ms(arg2), 0x5ffa593f329dd0222a7bc2e87ebbc2b45a6bba3c49ce2586c718f518b89673e6::error::e_invalid_start_time());
        assert!(0x5ffa593f329dd0222a7bc2e87ebbc2b45a6bba3c49ce2586c718f518b89673e6::epoch::is_epoch_start(arg3, arg0 + arg1), 0x5ffa593f329dd0222a7bc2e87ebbc2b45a6bba3c49ce2586c718f518b89673e6::error::e_invalid_additional_ms());
    }

    // decompiled from Move bytecode v6
}

