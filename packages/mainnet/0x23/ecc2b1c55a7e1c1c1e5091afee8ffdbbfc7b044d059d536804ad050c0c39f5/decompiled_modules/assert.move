module 0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::assert {
    public fun assert_additional_ms(arg0: u64, arg1: &0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::epoch::EpochConfig) {
        assert!(0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::epoch::is_epoch_start(arg1, arg0), 0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::error::e_invalid_additional_ms());
    }

    public fun assert_init_reward_valid(arg0: u64, arg1: u64, arg2: &0x2::clock::Clock, arg3: &0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::epoch::EpochConfig) {
        assert!(arg0 > 0x2::clock::timestamp_ms(arg2), 0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::error::e_invalid_start_time());
        assert!(0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::epoch::is_epoch_start(arg3, arg0 + arg1), 0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::error::e_invalid_additional_ms());
    }

    // decompiled from Move bytecode v6
}

