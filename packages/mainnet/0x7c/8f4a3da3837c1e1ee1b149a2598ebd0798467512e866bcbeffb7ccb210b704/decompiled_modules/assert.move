module 0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::assert {
    public fun assert_additional_ms(arg0: u64, arg1: &0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::epoch::EpochConfig) {
        assert!(arg0 > 0, 0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::error::e_invalid_additional_ms());
        assert!(0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::epoch::is_epoch_start(arg1, arg0), 0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::error::e_invalid_additional_ms());
    }

    public fun assert_init_reward_valid(arg0: u64, arg1: u64, arg2: &0x2::clock::Clock, arg3: &0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::epoch::EpochConfig) {
        assert!(arg0 > 0x2::clock::timestamp_ms(arg2), 0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::error::e_invalid_start_time());
        assert!(0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::epoch::is_epoch_start(arg3, arg0 + arg1), 0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::error::e_invalid_additional_ms());
    }

    // decompiled from Move bytecode v6
}

