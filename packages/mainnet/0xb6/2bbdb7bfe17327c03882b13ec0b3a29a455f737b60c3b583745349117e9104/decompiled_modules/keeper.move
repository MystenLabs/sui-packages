module 0xb62bbdb7bfe17327c03882b13ec0b3a29a455f737b60c3b583745349117e9104::keeper {
    public fun sync_staking_pool(arg0: &mut 0xb62bbdb7bfe17327c03882b13ec0b3a29a455f737b60c3b583745349117e9104::staking_pool::StakingPool, arg1: &0xb62bbdb7bfe17327c03882b13ec0b3a29a455f737b60c3b583745349117e9104::ve_mmt::VeMMT, arg2: &0x2::clock::Clock) {
        0xb62bbdb7bfe17327c03882b13ec0b3a29a455f737b60c3b583745349117e9104::staking_pool::sync_or_advance_epoch(arg0, arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

