module 0xecdf55bcd998892afa20c65d6f0aaaebd963f29c237442a62889872b10605020::admin {
    public fun add_force_rebalance_df<T0, T1, T2, T3: copy + drop + store>(arg0: &0xecdf55bcd998892afa20c65d6f0aaaebd963f29c237442a62889872b10605020::vault::AdminCap, arg1: &mut 0xecdf55bcd998892afa20c65d6f0aaaebd963f29c237442a62889872b10605020::vault::Vault<T0, T1, T2, T3>) {
        0xecdf55bcd998892afa20c65d6f0aaaebd963f29c237442a62889872b10605020::vault::add_force_rebalance_df<T0, T1, T2, T3>(arg1);
    }

    public fun set_position_price_scaling_fo_vault<T0, T1, T2, T3: copy + drop + store>(arg0: &0xecdf55bcd998892afa20c65d6f0aaaebd963f29c237442a62889872b10605020::vault::AdminCap, arg1: &mut 0xecdf55bcd998892afa20c65d6f0aaaebd963f29c237442a62889872b10605020::vault::Vault<T0, T1, T2, T3>, arg2: u128, arg3: u128) {
        assert!(arg3 > arg2, 0xecdf55bcd998892afa20c65d6f0aaaebd963f29c237442a62889872b10605020::error::upper_lower_trigger_price_incompatible());
        0xecdf55bcd998892afa20c65d6f0aaaebd963f29c237442a62889872b10605020::vault::set_price_scalling<T0, T1, T2, T3>(arg1, arg2, arg3);
    }

    public fun set_slippage<T0, T1, T2>(arg0: &0xecdf55bcd998892afa20c65d6f0aaaebd963f29c237442a62889872b10605020::vault::AdminCap, arg1: &mut 0xecdf55bcd998892afa20c65d6f0aaaebd963f29c237442a62889872b10605020::vault::Vault<T0, T1, T2, 0xecdf55bcd998892afa20c65d6f0aaaebd963f29c237442a62889872b10605020::config::Uncorrelated>, arg2: u128, arg3: u128) {
        0xecdf55bcd998892afa20c65d6f0aaaebd963f29c237442a62889872b10605020::vault::set_slippage<T0, T1, T2, 0xecdf55bcd998892afa20c65d6f0aaaebd963f29c237442a62889872b10605020::config::Uncorrelated>(arg1, arg2, arg3);
    }

    public fun set_trigger_scalling<T0, T1, T2>(arg0: &0xecdf55bcd998892afa20c65d6f0aaaebd963f29c237442a62889872b10605020::vault::AdminCap, arg1: &mut 0xecdf55bcd998892afa20c65d6f0aaaebd963f29c237442a62889872b10605020::vault::Vault<T0, T1, T2, 0xecdf55bcd998892afa20c65d6f0aaaebd963f29c237442a62889872b10605020::config::Uncorrelated>, arg2: u128, arg3: u128) {
        assert!(arg3 > arg2, 0xecdf55bcd998892afa20c65d6f0aaaebd963f29c237442a62889872b10605020::error::upper_lower_trigger_price_incompatible());
        0xecdf55bcd998892afa20c65d6f0aaaebd963f29c237442a62889872b10605020::config::set_trigger_price_scalling(0xecdf55bcd998892afa20c65d6f0aaaebd963f29c237442a62889872b10605020::vault::borrow_mut_config<T0, T1, T2, 0xecdf55bcd998892afa20c65d6f0aaaebd963f29c237442a62889872b10605020::config::Uncorrelated>(arg1), arg2, arg3);
    }

    public fun set_upgeer_trigger_price_factor_drift<T0, T1, T2>(arg0: &0xecdf55bcd998892afa20c65d6f0aaaebd963f29c237442a62889872b10605020::vault::AdminCap, arg1: &mut 0xecdf55bcd998892afa20c65d6f0aaaebd963f29c237442a62889872b10605020::vault::Vault<T0, T1, T2, 0xecdf55bcd998892afa20c65d6f0aaaebd963f29c237442a62889872b10605020::config::Drift>, arg2: u128) {
        0xecdf55bcd998892afa20c65d6f0aaaebd963f29c237442a62889872b10605020::config::set_drift_upper_trigger_price_scalling(0xecdf55bcd998892afa20c65d6f0aaaebd963f29c237442a62889872b10605020::vault::borrow_mut_config<T0, T1, T2, 0xecdf55bcd998892afa20c65d6f0aaaebd963f29c237442a62889872b10605020::config::Drift>(arg1), arg2);
    }

    // decompiled from Move bytecode v6
}

