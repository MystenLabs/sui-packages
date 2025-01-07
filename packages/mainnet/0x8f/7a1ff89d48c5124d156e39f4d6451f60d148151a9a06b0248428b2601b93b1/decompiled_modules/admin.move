module 0x8f7a1ff89d48c5124d156e39f4d6451f60d148151a9a06b0248428b2601b93b1::admin {
    public fun set_slippage<T0, T1, T2>(arg0: &0x8f7a1ff89d48c5124d156e39f4d6451f60d148151a9a06b0248428b2601b93b1::vault::AdminCap, arg1: &mut 0x8f7a1ff89d48c5124d156e39f4d6451f60d148151a9a06b0248428b2601b93b1::vault::Vault<T0, T1, T2, 0x8f7a1ff89d48c5124d156e39f4d6451f60d148151a9a06b0248428b2601b93b1::config::Uncorrelated>, arg2: u128, arg3: u128) {
        0x8f7a1ff89d48c5124d156e39f4d6451f60d148151a9a06b0248428b2601b93b1::vault::set_slippage<T0, T1, T2, 0x8f7a1ff89d48c5124d156e39f4d6451f60d148151a9a06b0248428b2601b93b1::config::Uncorrelated>(arg1, arg2, arg3);
    }

    public fun set_trigger_scalling<T0, T1, T2>(arg0: &0x8f7a1ff89d48c5124d156e39f4d6451f60d148151a9a06b0248428b2601b93b1::vault::AdminCap, arg1: &mut 0x8f7a1ff89d48c5124d156e39f4d6451f60d148151a9a06b0248428b2601b93b1::vault::Vault<T0, T1, T2, 0x8f7a1ff89d48c5124d156e39f4d6451f60d148151a9a06b0248428b2601b93b1::config::Uncorrelated>, arg2: u128, arg3: u128) {
        assert!(arg3 > arg2, 0x8f7a1ff89d48c5124d156e39f4d6451f60d148151a9a06b0248428b2601b93b1::error::upper_lower_trigger_price_incompatible());
        0x8f7a1ff89d48c5124d156e39f4d6451f60d148151a9a06b0248428b2601b93b1::config::set_trigger_price_scalling(0x8f7a1ff89d48c5124d156e39f4d6451f60d148151a9a06b0248428b2601b93b1::vault::borrow_mut_config<T0, T1, T2, 0x8f7a1ff89d48c5124d156e39f4d6451f60d148151a9a06b0248428b2601b93b1::config::Uncorrelated>(arg1), arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

