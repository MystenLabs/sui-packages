module 0xb62bbdb7bfe17327c03882b13ec0b3a29a455f737b60c3b583745349117e9104::assert {
    public fun assert_additional_ms(arg0: u64, arg1: &0xb62bbdb7bfe17327c03882b13ec0b3a29a455f737b60c3b583745349117e9104::epoch::EpochConfig) {
        assert!(arg0 > 0, 0xb62bbdb7bfe17327c03882b13ec0b3a29a455f737b60c3b583745349117e9104::error::e_invalid_additional_ms());
        assert!(0xb62bbdb7bfe17327c03882b13ec0b3a29a455f737b60c3b583745349117e9104::epoch::is_epoch_start(arg1, arg0), 0xb62bbdb7bfe17327c03882b13ec0b3a29a455f737b60c3b583745349117e9104::error::e_invalid_additional_ms());
    }

    public fun assert_init_reward_valid(arg0: u64, arg1: u64, arg2: &0x2::clock::Clock, arg3: &0xb62bbdb7bfe17327c03882b13ec0b3a29a455f737b60c3b583745349117e9104::epoch::EpochConfig) {
        assert!(arg0 > 0x2::clock::timestamp_ms(arg2), 0xb62bbdb7bfe17327c03882b13ec0b3a29a455f737b60c3b583745349117e9104::error::e_invalid_start_time());
        assert!(0xb62bbdb7bfe17327c03882b13ec0b3a29a455f737b60c3b583745349117e9104::epoch::is_epoch_start(arg3, arg0 + arg1), 0xb62bbdb7bfe17327c03882b13ec0b3a29a455f737b60c3b583745349117e9104::error::e_invalid_additional_ms());
    }

    // decompiled from Move bytecode v6
}

