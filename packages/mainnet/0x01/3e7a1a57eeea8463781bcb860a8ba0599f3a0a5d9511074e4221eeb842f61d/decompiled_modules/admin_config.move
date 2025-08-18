module 0x31949681f0148830ccb1cdf4dec21ba25ee91ad63fb76c2b47e0ca887afc671a::admin_config {
    public fun set_active(arg0: &mut 0x31949681f0148830ccb1cdf4dec21ba25ee91ad63fb76c2b47e0ca887afc671a::permission::AdminCap, arg1: &mut 0x31949681f0148830ccb1cdf4dec21ba25ee91ad63fb76c2b47e0ca887afc671a::global_config::GlobalConfig) {
        0x31949681f0148830ccb1cdf4dec21ba25ee91ad63fb76c2b47e0ca887afc671a::global_config::assert_version(arg1);
        0x31949681f0148830ccb1cdf4dec21ba25ee91ad63fb76c2b47e0ca887afc671a::global_config::set_active_status(arg1, true);
    }

    public fun set_inactive(arg0: &mut 0x31949681f0148830ccb1cdf4dec21ba25ee91ad63fb76c2b47e0ca887afc671a::permission::AdminCap, arg1: &mut 0x31949681f0148830ccb1cdf4dec21ba25ee91ad63fb76c2b47e0ca887afc671a::global_config::GlobalConfig) {
        0x31949681f0148830ccb1cdf4dec21ba25ee91ad63fb76c2b47e0ca887afc671a::global_config::assert_version(arg1);
        0x31949681f0148830ccb1cdf4dec21ba25ee91ad63fb76c2b47e0ca887afc671a::global_config::set_active_status(arg1, false);
    }

    public fun set_package_version(arg0: &mut 0x31949681f0148830ccb1cdf4dec21ba25ee91ad63fb76c2b47e0ca887afc671a::permission::AdminCap, arg1: &mut 0x31949681f0148830ccb1cdf4dec21ba25ee91ad63fb76c2b47e0ca887afc671a::global_config::GlobalConfig, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0x31949681f0148830ccb1cdf4dec21ba25ee91ad63fb76c2b47e0ca887afc671a::global_config::set_package_version(arg1, arg2, arg3);
    }

    public fun set_protocol_fee(arg0: &mut 0x31949681f0148830ccb1cdf4dec21ba25ee91ad63fb76c2b47e0ca887afc671a::permission::AdminCap, arg1: &mut 0x31949681f0148830ccb1cdf4dec21ba25ee91ad63fb76c2b47e0ca887afc671a::global_config::GlobalConfig, arg2: u64) {
        0x31949681f0148830ccb1cdf4dec21ba25ee91ad63fb76c2b47e0ca887afc671a::global_config::assert_version(arg1);
        0x31949681f0148830ccb1cdf4dec21ba25ee91ad63fb76c2b47e0ca887afc671a::global_config::set_protocol_fee(arg1, arg2);
    }

    public fun transfer_admin_role(arg0: &0x31949681f0148830ccb1cdf4dec21ba25ee91ad63fb76c2b47e0ca887afc671a::global_config::GlobalConfig, arg1: 0x31949681f0148830ccb1cdf4dec21ba25ee91ad63fb76c2b47e0ca887afc671a::permission::AdminCap, arg2: address, arg3: &0x2::tx_context::TxContext) {
        0x31949681f0148830ccb1cdf4dec21ba25ee91ad63fb76c2b47e0ca887afc671a::global_config::assert_version(arg0);
        0x31949681f0148830ccb1cdf4dec21ba25ee91ad63fb76c2b47e0ca887afc671a::permission::transfer_admin_role(arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

