module 0x40a75086cf3902b3bae80aba77f01e8aea44ef60d319a8017c7a5c081f8f8b43::keeper {
    public fun sync_staking_pool(arg0: &mut 0x40a75086cf3902b3bae80aba77f01e8aea44ef60d319a8017c7a5c081f8f8b43::staking_pool::StakingPool, arg1: &0x40a75086cf3902b3bae80aba77f01e8aea44ef60d319a8017c7a5c081f8f8b43::ve_mmt::VeMMT, arg2: &0x2::clock::Clock) {
        let (_, v1) = 0x40a75086cf3902b3bae80aba77f01e8aea44ef60d319a8017c7a5c081f8f8b43::ve_mmt::config_fields(arg1);
        if (0x40a75086cf3902b3bae80aba77f01e8aea44ef60d319a8017c7a5c081f8f8b43::staking_pool::current_epoch(arg0) != 0x40a75086cf3902b3bae80aba77f01e8aea44ef60d319a8017c7a5c081f8f8b43::epoch::epoch_id(v1, 0x2::clock::timestamp_ms(arg2))) {
            0x40a75086cf3902b3bae80aba77f01e8aea44ef60d319a8017c7a5c081f8f8b43::staking_pool::sync_or_advance_epoch(arg0, arg1, arg2);
        };
    }

    // decompiled from Move bytecode v6
}

