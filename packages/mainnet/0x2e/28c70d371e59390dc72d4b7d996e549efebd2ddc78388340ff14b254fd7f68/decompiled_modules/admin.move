module 0x2e28c70d371e59390dc72d4b7d996e549efebd2ddc78388340ff14b254fd7f68::admin {
    public fun set_slippage<T0, T1, T2>(arg0: &0x2e28c70d371e59390dc72d4b7d996e549efebd2ddc78388340ff14b254fd7f68::vault::AdminCap, arg1: &mut 0x2e28c70d371e59390dc72d4b7d996e549efebd2ddc78388340ff14b254fd7f68::vault::Vault<T0, T1, T2, 0x2e28c70d371e59390dc72d4b7d996e549efebd2ddc78388340ff14b254fd7f68::config::Uncorrelated>, arg2: u128, arg3: u128) {
        0x2e28c70d371e59390dc72d4b7d996e549efebd2ddc78388340ff14b254fd7f68::vault::set_slippage<T0, T1, T2, 0x2e28c70d371e59390dc72d4b7d996e549efebd2ddc78388340ff14b254fd7f68::config::Uncorrelated>(arg1, arg2, arg3);
    }

    public fun set_trigger_scalling<T0, T1, T2>(arg0: &0x2e28c70d371e59390dc72d4b7d996e549efebd2ddc78388340ff14b254fd7f68::vault::AdminCap, arg1: &mut 0x2e28c70d371e59390dc72d4b7d996e549efebd2ddc78388340ff14b254fd7f68::vault::Vault<T0, T1, T2, 0x2e28c70d371e59390dc72d4b7d996e549efebd2ddc78388340ff14b254fd7f68::config::Uncorrelated>, arg2: u128, arg3: u128) {
        assert!(arg3 > arg2, 9);
        0x2e28c70d371e59390dc72d4b7d996e549efebd2ddc78388340ff14b254fd7f68::config::set_trigger_price_scalling(0x2e28c70d371e59390dc72d4b7d996e549efebd2ddc78388340ff14b254fd7f68::vault::borrow_mut_config<T0, T1, T2, 0x2e28c70d371e59390dc72d4b7d996e549efebd2ddc78388340ff14b254fd7f68::config::Uncorrelated>(arg1), arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

