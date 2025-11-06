module 0xc76aed73036b12ed7e94fe70c64b9cd06a380037b3f6001feb17e389a5201b08::assert {
    public fun assert_additional_ms(arg0: u64, arg1: &0xc76aed73036b12ed7e94fe70c64b9cd06a380037b3f6001feb17e389a5201b08::epoch::EpochConfig) {
        assert!(arg0 > 0, 0xc76aed73036b12ed7e94fe70c64b9cd06a380037b3f6001feb17e389a5201b08::error::e_invalid_additional_ms());
        assert!(0xc76aed73036b12ed7e94fe70c64b9cd06a380037b3f6001feb17e389a5201b08::epoch::is_epoch_start(arg1, arg0), 0xc76aed73036b12ed7e94fe70c64b9cd06a380037b3f6001feb17e389a5201b08::error::e_invalid_additional_ms());
    }

    public fun assert_init_reward_valid(arg0: u64, arg1: u64, arg2: &0x2::clock::Clock, arg3: &0xc76aed73036b12ed7e94fe70c64b9cd06a380037b3f6001feb17e389a5201b08::epoch::EpochConfig) {
        assert!(arg0 > 0x2::clock::timestamp_ms(arg2), 0xc76aed73036b12ed7e94fe70c64b9cd06a380037b3f6001feb17e389a5201b08::error::e_invalid_start_time());
        assert!(0xc76aed73036b12ed7e94fe70c64b9cd06a380037b3f6001feb17e389a5201b08::epoch::is_epoch_start(arg3, arg0 + arg1), 0xc76aed73036b12ed7e94fe70c64b9cd06a380037b3f6001feb17e389a5201b08::error::e_invalid_additional_ms());
    }

    // decompiled from Move bytecode v6
}

