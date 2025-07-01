module 0xe96f73400fcf04dea660a33ed66b57742e3d936e15b551f7c2f27f2ab5a9dbf1::admin {
    public fun add_force_rebalance_df<T0, T1, T2, T3: copy + drop + store>(arg0: &0xe96f73400fcf04dea660a33ed66b57742e3d936e15b551f7c2f27f2ab5a9dbf1::vault::AdminCap, arg1: &mut 0xe96f73400fcf04dea660a33ed66b57742e3d936e15b551f7c2f27f2ab5a9dbf1::vault::Vault<T0, T1, T2, T3>) {
        0xe96f73400fcf04dea660a33ed66b57742e3d936e15b551f7c2f27f2ab5a9dbf1::vault::add_force_rebalance_df<T0, T1, T2, T3>(arg1);
    }

    public fun set_position_price_scaling_fo_vault<T0, T1, T2, T3: copy + drop + store>(arg0: &0xe96f73400fcf04dea660a33ed66b57742e3d936e15b551f7c2f27f2ab5a9dbf1::vault::AdminCap, arg1: &mut 0xe96f73400fcf04dea660a33ed66b57742e3d936e15b551f7c2f27f2ab5a9dbf1::vault::Vault<T0, T1, T2, T3>, arg2: u128, arg3: u128) {
        assert!(arg3 > arg2, 0xe96f73400fcf04dea660a33ed66b57742e3d936e15b551f7c2f27f2ab5a9dbf1::error::upper_lower_trigger_price_incompatible());
        0xe96f73400fcf04dea660a33ed66b57742e3d936e15b551f7c2f27f2ab5a9dbf1::vault::set_price_scalling<T0, T1, T2, T3>(arg1, arg2, arg3);
    }

    public fun set_rebalance_price_source<T0, T1, T2, T3: copy + drop + store>(arg0: &0xe96f73400fcf04dea660a33ed66b57742e3d936e15b551f7c2f27f2ab5a9dbf1::vault::AdminCap, arg1: &mut 0xe96f73400fcf04dea660a33ed66b57742e3d936e15b551f7c2f27f2ab5a9dbf1::vault::Vault<T0, T1, T2, T3>, arg2: u8) {
        0xe96f73400fcf04dea660a33ed66b57742e3d936e15b551f7c2f27f2ab5a9dbf1::vault::set_rebalance_price_source<T0, T1, T2, T3>(arg1, arg2);
    }

    public fun set_slippage<T0, T1, T2>(arg0: &0xe96f73400fcf04dea660a33ed66b57742e3d936e15b551f7c2f27f2ab5a9dbf1::vault::AdminCap, arg1: &mut 0xe96f73400fcf04dea660a33ed66b57742e3d936e15b551f7c2f27f2ab5a9dbf1::vault::Vault<T0, T1, T2, 0xe96f73400fcf04dea660a33ed66b57742e3d936e15b551f7c2f27f2ab5a9dbf1::config::Uncorrelated>, arg2: u128, arg3: u128) {
        0xe96f73400fcf04dea660a33ed66b57742e3d936e15b551f7c2f27f2ab5a9dbf1::vault::set_slippage<T0, T1, T2, 0xe96f73400fcf04dea660a33ed66b57742e3d936e15b551f7c2f27f2ab5a9dbf1::config::Uncorrelated>(arg1, arg2, arg3);
    }

    public fun set_trigger_scalling<T0, T1, T2>(arg0: &0xe96f73400fcf04dea660a33ed66b57742e3d936e15b551f7c2f27f2ab5a9dbf1::vault::AdminCap, arg1: &mut 0xe96f73400fcf04dea660a33ed66b57742e3d936e15b551f7c2f27f2ab5a9dbf1::vault::Vault<T0, T1, T2, 0xe96f73400fcf04dea660a33ed66b57742e3d936e15b551f7c2f27f2ab5a9dbf1::config::Uncorrelated>, arg2: u128, arg3: u128) {
        assert!(arg3 > arg2, 0xe96f73400fcf04dea660a33ed66b57742e3d936e15b551f7c2f27f2ab5a9dbf1::error::upper_lower_trigger_price_incompatible());
        0xe96f73400fcf04dea660a33ed66b57742e3d936e15b551f7c2f27f2ab5a9dbf1::config::set_trigger_price_scalling(0xe96f73400fcf04dea660a33ed66b57742e3d936e15b551f7c2f27f2ab5a9dbf1::vault::borrow_mut_config<T0, T1, T2, 0xe96f73400fcf04dea660a33ed66b57742e3d936e15b551f7c2f27f2ab5a9dbf1::config::Uncorrelated>(arg1), arg2, arg3);
    }

    public fun set_upgeer_trigger_price_factor_drift<T0, T1, T2>(arg0: &0xe96f73400fcf04dea660a33ed66b57742e3d936e15b551f7c2f27f2ab5a9dbf1::vault::AdminCap, arg1: &mut 0xe96f73400fcf04dea660a33ed66b57742e3d936e15b551f7c2f27f2ab5a9dbf1::vault::Vault<T0, T1, T2, 0xe96f73400fcf04dea660a33ed66b57742e3d936e15b551f7c2f27f2ab5a9dbf1::config::Drift>, arg2: u128) {
        0xe96f73400fcf04dea660a33ed66b57742e3d936e15b551f7c2f27f2ab5a9dbf1::config::set_drift_upper_trigger_price_scalling(0xe96f73400fcf04dea660a33ed66b57742e3d936e15b551f7c2f27f2ab5a9dbf1::vault::borrow_mut_config<T0, T1, T2, 0xe96f73400fcf04dea660a33ed66b57742e3d936e15b551f7c2f27f2ab5a9dbf1::config::Drift>(arg1), arg2);
    }

    // decompiled from Move bytecode v6
}

