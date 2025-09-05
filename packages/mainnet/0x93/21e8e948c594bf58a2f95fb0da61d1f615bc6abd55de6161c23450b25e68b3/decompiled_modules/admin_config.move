module 0x9321e8e948c594bf58a2f95fb0da61d1f615bc6abd55de6161c23450b25e68b3::admin_config {
    public fun set_active(arg0: &mut 0x9321e8e948c594bf58a2f95fb0da61d1f615bc6abd55de6161c23450b25e68b3::permission::AdminCap, arg1: &mut 0x9321e8e948c594bf58a2f95fb0da61d1f615bc6abd55de6161c23450b25e68b3::global_config::GlobalConfig, arg2: &0x2::tx_context::TxContext) {
        0x9321e8e948c594bf58a2f95fb0da61d1f615bc6abd55de6161c23450b25e68b3::global_config::assert_version(arg1);
        0x9321e8e948c594bf58a2f95fb0da61d1f615bc6abd55de6161c23450b25e68b3::global_config::set_active_status(arg1, true, arg2);
    }

    public fun set_collateral_weight<T0, T1>(arg0: &mut 0x9321e8e948c594bf58a2f95fb0da61d1f615bc6abd55de6161c23450b25e68b3::permission::AdminCap, arg1: &0x9321e8e948c594bf58a2f95fb0da61d1f615bc6abd55de6161c23450b25e68b3::global_config::GlobalConfig, arg2: &mut 0x9321e8e948c594bf58a2f95fb0da61d1f615bc6abd55de6161c23450b25e68b3::main::Farm<T0, T1>, arg3: u64) {
        0x9321e8e948c594bf58a2f95fb0da61d1f615bc6abd55de6161c23450b25e68b3::global_config::assert_version(arg1);
        0x9321e8e948c594bf58a2f95fb0da61d1f615bc6abd55de6161c23450b25e68b3::main::set_collateral_weight<T0, T1>(arg2, arg3);
    }

    public fun set_inactive(arg0: &mut 0x9321e8e948c594bf58a2f95fb0da61d1f615bc6abd55de6161c23450b25e68b3::permission::AdminCap, arg1: &mut 0x9321e8e948c594bf58a2f95fb0da61d1f615bc6abd55de6161c23450b25e68b3::global_config::GlobalConfig, arg2: &0x2::tx_context::TxContext) {
        0x9321e8e948c594bf58a2f95fb0da61d1f615bc6abd55de6161c23450b25e68b3::global_config::assert_version(arg1);
        0x9321e8e948c594bf58a2f95fb0da61d1f615bc6abd55de6161c23450b25e68b3::global_config::set_active_status(arg1, false, arg2);
    }

    public fun set_liquidation_fee_wallet(arg0: &mut 0x9321e8e948c594bf58a2f95fb0da61d1f615bc6abd55de6161c23450b25e68b3::permission::AdminCap, arg1: &mut 0x9321e8e948c594bf58a2f95fb0da61d1f615bc6abd55de6161c23450b25e68b3::global_config::GlobalConfig, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x9321e8e948c594bf58a2f95fb0da61d1f615bc6abd55de6161c23450b25e68b3::global_config::assert_version(arg1);
        0x9321e8e948c594bf58a2f95fb0da61d1f615bc6abd55de6161c23450b25e68b3::global_config::set_liquidation_fee_wallet(arg1, arg2, arg3);
    }

    public fun set_liquidation_threshold(arg0: &mut 0x9321e8e948c594bf58a2f95fb0da61d1f615bc6abd55de6161c23450b25e68b3::permission::AdminCap, arg1: &mut 0x9321e8e948c594bf58a2f95fb0da61d1f615bc6abd55de6161c23450b25e68b3::global_config::GlobalConfig, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0x9321e8e948c594bf58a2f95fb0da61d1f615bc6abd55de6161c23450b25e68b3::global_config::assert_version(arg1);
        0x9321e8e948c594bf58a2f95fb0da61d1f615bc6abd55de6161c23450b25e68b3::global_config::set_liquidation_threshold(arg1, arg2, arg3);
    }

    public fun set_package_version(arg0: &mut 0x9321e8e948c594bf58a2f95fb0da61d1f615bc6abd55de6161c23450b25e68b3::permission::AdminCap, arg1: &mut 0x9321e8e948c594bf58a2f95fb0da61d1f615bc6abd55de6161c23450b25e68b3::global_config::GlobalConfig, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0x9321e8e948c594bf58a2f95fb0da61d1f615bc6abd55de6161c23450b25e68b3::global_config::set_package_version(arg1, arg2, arg3);
    }

    public fun set_protocol_fee_percent(arg0: &mut 0x9321e8e948c594bf58a2f95fb0da61d1f615bc6abd55de6161c23450b25e68b3::permission::AdminCap, arg1: &mut 0x9321e8e948c594bf58a2f95fb0da61d1f615bc6abd55de6161c23450b25e68b3::global_config::GlobalConfig, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0x9321e8e948c594bf58a2f95fb0da61d1f615bc6abd55de6161c23450b25e68b3::global_config::assert_version(arg1);
        0x9321e8e948c594bf58a2f95fb0da61d1f615bc6abd55de6161c23450b25e68b3::global_config::set_protocol_fee_percent(arg1, arg2, arg3);
    }

    public fun set_shortfall_fee_percent(arg0: &mut 0x9321e8e948c594bf58a2f95fb0da61d1f615bc6abd55de6161c23450b25e68b3::permission::AdminCap, arg1: &mut 0x9321e8e948c594bf58a2f95fb0da61d1f615bc6abd55de6161c23450b25e68b3::global_config::GlobalConfig, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0x9321e8e948c594bf58a2f95fb0da61d1f615bc6abd55de6161c23450b25e68b3::global_config::assert_version(arg1);
        0x9321e8e948c594bf58a2f95fb0da61d1f615bc6abd55de6161c23450b25e68b3::global_config::set_shortfall_fee_percent(arg1, arg2, arg3);
    }

    public fun transfer_admin_role(arg0: &0x9321e8e948c594bf58a2f95fb0da61d1f615bc6abd55de6161c23450b25e68b3::global_config::GlobalConfig, arg1: 0x9321e8e948c594bf58a2f95fb0da61d1f615bc6abd55de6161c23450b25e68b3::permission::AdminCap, arg2: address, arg3: &0x2::tx_context::TxContext) {
        0x9321e8e948c594bf58a2f95fb0da61d1f615bc6abd55de6161c23450b25e68b3::global_config::assert_version(arg0);
        0x9321e8e948c594bf58a2f95fb0da61d1f615bc6abd55de6161c23450b25e68b3::permission::transfer_admin_role(arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

