module 0x40a75086cf3902b3bae80aba77f01e8aea44ef60d319a8017c7a5c081f8f8b43::assert {
    public fun assert_additional_ms(arg0: u64, arg1: &0x40a75086cf3902b3bae80aba77f01e8aea44ef60d319a8017c7a5c081f8f8b43::epoch::EpochConfig) {
        assert!(arg0 > 0, 0x40a75086cf3902b3bae80aba77f01e8aea44ef60d319a8017c7a5c081f8f8b43::error::e_invalid_additional_ms());
        assert!(0x40a75086cf3902b3bae80aba77f01e8aea44ef60d319a8017c7a5c081f8f8b43::epoch::is_epoch_start(arg1, arg0), 0x40a75086cf3902b3bae80aba77f01e8aea44ef60d319a8017c7a5c081f8f8b43::error::e_invalid_additional_ms());
    }

    public fun assert_init_reward_valid(arg0: u64, arg1: u64, arg2: &0x2::clock::Clock, arg3: &0x40a75086cf3902b3bae80aba77f01e8aea44ef60d319a8017c7a5c081f8f8b43::epoch::EpochConfig) {
        assert!(arg0 > 0x2::clock::timestamp_ms(arg2), 0x40a75086cf3902b3bae80aba77f01e8aea44ef60d319a8017c7a5c081f8f8b43::error::e_invalid_start_time());
        assert!(0x40a75086cf3902b3bae80aba77f01e8aea44ef60d319a8017c7a5c081f8f8b43::epoch::is_epoch_start(arg3, arg0 + arg1), 0x40a75086cf3902b3bae80aba77f01e8aea44ef60d319a8017c7a5c081f8f8b43::error::e_invalid_start_time());
    }

    public fun assert_valid_unbond_at(arg0: &0x40a75086cf3902b3bae80aba77f01e8aea44ef60d319a8017c7a5c081f8f8b43::ve_mmt::VeMMT, arg1: u64, arg2: &0x2::clock::Clock) {
        assert!(0x40a75086cf3902b3bae80aba77f01e8aea44ef60d319a8017c7a5c081f8f8b43::epoch::is_epoch_start(0x40a75086cf3902b3bae80aba77f01e8aea44ef60d319a8017c7a5c081f8f8b43::ve_mmt::ep_config(arg0), arg1), 0x40a75086cf3902b3bae80aba77f01e8aea44ef60d319a8017c7a5c081f8f8b43::error::e_invalid_unbond_at());
        assert!(arg1 >= 0x2::clock::timestamp_ms(arg2), 0x40a75086cf3902b3bae80aba77f01e8aea44ef60d319a8017c7a5c081f8f8b43::error::e_invalid_unbond_at());
    }

    // decompiled from Move bytecode v6
}

