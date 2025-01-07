module 0xec00703df008c19f9a32fd2ac99327757a3578bad53c026273248d0b2830eeb::admin {
    public fun set_slippage<T0, T1, T2>(arg0: &0xec00703df008c19f9a32fd2ac99327757a3578bad53c026273248d0b2830eeb::vault::AdminCap, arg1: &mut 0xec00703df008c19f9a32fd2ac99327757a3578bad53c026273248d0b2830eeb::vault::Vault<T0, T1, T2, 0xec00703df008c19f9a32fd2ac99327757a3578bad53c026273248d0b2830eeb::config::Uncorrelated>, arg2: u128, arg3: u128) {
        0xec00703df008c19f9a32fd2ac99327757a3578bad53c026273248d0b2830eeb::vault::set_slippage<T0, T1, T2, 0xec00703df008c19f9a32fd2ac99327757a3578bad53c026273248d0b2830eeb::config::Uncorrelated>(arg1, arg2, arg3);
    }

    public fun set_trigger_scalling<T0, T1, T2>(arg0: &0xec00703df008c19f9a32fd2ac99327757a3578bad53c026273248d0b2830eeb::vault::AdminCap, arg1: &mut 0xec00703df008c19f9a32fd2ac99327757a3578bad53c026273248d0b2830eeb::vault::Vault<T0, T1, T2, 0xec00703df008c19f9a32fd2ac99327757a3578bad53c026273248d0b2830eeb::config::Uncorrelated>, arg2: u128, arg3: u128) {
        assert!(arg3 > arg2, 0xec00703df008c19f9a32fd2ac99327757a3578bad53c026273248d0b2830eeb::error::upper_lower_trigger_price_incompatible());
        0xec00703df008c19f9a32fd2ac99327757a3578bad53c026273248d0b2830eeb::config::set_trigger_price_scalling(0xec00703df008c19f9a32fd2ac99327757a3578bad53c026273248d0b2830eeb::vault::borrow_mut_config<T0, T1, T2, 0xec00703df008c19f9a32fd2ac99327757a3578bad53c026273248d0b2830eeb::config::Uncorrelated>(arg1), arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

