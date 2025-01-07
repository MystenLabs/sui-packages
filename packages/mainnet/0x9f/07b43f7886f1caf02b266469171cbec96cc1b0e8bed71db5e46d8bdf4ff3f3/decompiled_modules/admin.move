module 0x9f07b43f7886f1caf02b266469171cbec96cc1b0e8bed71db5e46d8bdf4ff3f3::admin {
    public fun set_slippage<T0, T1, T2>(arg0: &0x9f07b43f7886f1caf02b266469171cbec96cc1b0e8bed71db5e46d8bdf4ff3f3::vault::AdminCap, arg1: &mut 0x9f07b43f7886f1caf02b266469171cbec96cc1b0e8bed71db5e46d8bdf4ff3f3::vault::Vault<T0, T1, T2, 0x9f07b43f7886f1caf02b266469171cbec96cc1b0e8bed71db5e46d8bdf4ff3f3::config::Uncorrelated>, arg2: u128, arg3: u128) {
        0x9f07b43f7886f1caf02b266469171cbec96cc1b0e8bed71db5e46d8bdf4ff3f3::vault::set_slippage<T0, T1, T2, 0x9f07b43f7886f1caf02b266469171cbec96cc1b0e8bed71db5e46d8bdf4ff3f3::config::Uncorrelated>(arg1, arg2, arg3);
    }

    public fun set_trigger_scalling<T0, T1, T2>(arg0: &0x9f07b43f7886f1caf02b266469171cbec96cc1b0e8bed71db5e46d8bdf4ff3f3::vault::AdminCap, arg1: &mut 0x9f07b43f7886f1caf02b266469171cbec96cc1b0e8bed71db5e46d8bdf4ff3f3::vault::Vault<T0, T1, T2, 0x9f07b43f7886f1caf02b266469171cbec96cc1b0e8bed71db5e46d8bdf4ff3f3::config::Uncorrelated>, arg2: u128, arg3: u128) {
        assert!(arg3 > arg2, 0x9f07b43f7886f1caf02b266469171cbec96cc1b0e8bed71db5e46d8bdf4ff3f3::error::upper_lower_trigger_price_incompatible());
        0x9f07b43f7886f1caf02b266469171cbec96cc1b0e8bed71db5e46d8bdf4ff3f3::config::set_trigger_price_scalling(0x9f07b43f7886f1caf02b266469171cbec96cc1b0e8bed71db5e46d8bdf4ff3f3::vault::borrow_mut_config<T0, T1, T2, 0x9f07b43f7886f1caf02b266469171cbec96cc1b0e8bed71db5e46d8bdf4ff3f3::config::Uncorrelated>(arg1), arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

