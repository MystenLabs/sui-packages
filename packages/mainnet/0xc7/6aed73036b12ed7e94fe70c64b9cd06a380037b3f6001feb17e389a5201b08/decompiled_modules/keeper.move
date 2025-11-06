module 0xc76aed73036b12ed7e94fe70c64b9cd06a380037b3f6001feb17e389a5201b08::keeper {
    public fun sync_staking_pool(arg0: &mut 0xc76aed73036b12ed7e94fe70c64b9cd06a380037b3f6001feb17e389a5201b08::staking_pool::StakingPool, arg1: &0xc76aed73036b12ed7e94fe70c64b9cd06a380037b3f6001feb17e389a5201b08::ve_mmt::VeMMT, arg2: &0x2::clock::Clock) {
        0xc76aed73036b12ed7e94fe70c64b9cd06a380037b3f6001feb17e389a5201b08::version::assert_supported_version(0xc76aed73036b12ed7e94fe70c64b9cd06a380037b3f6001feb17e389a5201b08::ve_mmt::version(arg1));
        assert!(!0xc76aed73036b12ed7e94fe70c64b9cd06a380037b3f6001feb17e389a5201b08::ve_mmt::is_paused(arg1), 0xc76aed73036b12ed7e94fe70c64b9cd06a380037b3f6001feb17e389a5201b08::error::e_paused());
        0xc76aed73036b12ed7e94fe70c64b9cd06a380037b3f6001feb17e389a5201b08::staking_pool::sync_or_advance_epoch(arg0, arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

