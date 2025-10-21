module 0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::keeper {
    public fun sync_staking_pool(arg0: &mut 0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::staking_pool::StakingPool, arg1: &0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::ve_mmt::VeMMT, arg2: &0x2::clock::Clock) {
        let (_, v1) = 0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::ve_mmt::config_fields(arg1);
        if (0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::staking_pool::current_epoch(arg0) != 0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::epoch::epoch_id(v1, 0x2::clock::timestamp_ms(arg2))) {
            0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::staking_pool::sync_or_advance_epoch(arg0, arg1, arg2);
        };
    }

    // decompiled from Move bytecode v6
}

