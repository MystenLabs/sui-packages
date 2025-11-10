module 0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::keeper {
    public fun sync_staking_pool(arg0: &mut 0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::staking_pool::StakingPool, arg1: &0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::ve_mmt::VeMMT, arg2: &0x2::clock::Clock) {
        0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::version::assert_supported_version(0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::ve_mmt::version(arg1));
        assert!(!0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::ve_mmt::is_paused(arg1), 0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::error::e_paused());
        0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::staking_pool::sync_or_advance_epoch(arg0, arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

