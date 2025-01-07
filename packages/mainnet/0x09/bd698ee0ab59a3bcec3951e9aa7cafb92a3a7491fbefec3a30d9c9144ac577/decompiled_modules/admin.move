module 0x9bd698ee0ab59a3bcec3951e9aa7cafb92a3a7491fbefec3a30d9c9144ac577::admin {
    public fun set_slippage<T0, T1, T2>(arg0: &0x9bd698ee0ab59a3bcec3951e9aa7cafb92a3a7491fbefec3a30d9c9144ac577::vault::AdminCap, arg1: &mut 0x9bd698ee0ab59a3bcec3951e9aa7cafb92a3a7491fbefec3a30d9c9144ac577::vault::Vault<T0, T1, T2, 0x9bd698ee0ab59a3bcec3951e9aa7cafb92a3a7491fbefec3a30d9c9144ac577::config::Uncorrelated>, arg2: u128, arg3: u128) {
        0x9bd698ee0ab59a3bcec3951e9aa7cafb92a3a7491fbefec3a30d9c9144ac577::vault::set_slippage<T0, T1, T2, 0x9bd698ee0ab59a3bcec3951e9aa7cafb92a3a7491fbefec3a30d9c9144ac577::config::Uncorrelated>(arg1, arg2, arg3);
    }

    public fun set_trigger_scalling<T0, T1, T2>(arg0: &0x9bd698ee0ab59a3bcec3951e9aa7cafb92a3a7491fbefec3a30d9c9144ac577::vault::AdminCap, arg1: &mut 0x9bd698ee0ab59a3bcec3951e9aa7cafb92a3a7491fbefec3a30d9c9144ac577::vault::Vault<T0, T1, T2, 0x9bd698ee0ab59a3bcec3951e9aa7cafb92a3a7491fbefec3a30d9c9144ac577::config::Uncorrelated>, arg2: u128, arg3: u128) {
        assert!(arg3 > arg2, 0x9bd698ee0ab59a3bcec3951e9aa7cafb92a3a7491fbefec3a30d9c9144ac577::error::upper_lower_trigger_price_incompatible());
        0x9bd698ee0ab59a3bcec3951e9aa7cafb92a3a7491fbefec3a30d9c9144ac577::config::set_trigger_price_scalling(0x9bd698ee0ab59a3bcec3951e9aa7cafb92a3a7491fbefec3a30d9c9144ac577::vault::borrow_mut_config<T0, T1, T2, 0x9bd698ee0ab59a3bcec3951e9aa7cafb92a3a7491fbefec3a30d9c9144ac577::config::Uncorrelated>(arg1), arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

