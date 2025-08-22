module 0x62e8d653b0617e106c90a0298f37c87fa5a8d7f3da79acc2454c9b3b553bcc3d::admin_config {
    public fun set_active(arg0: &mut 0x62e8d653b0617e106c90a0298f37c87fa5a8d7f3da79acc2454c9b3b553bcc3d::permission::AdminCap, arg1: &mut 0x62e8d653b0617e106c90a0298f37c87fa5a8d7f3da79acc2454c9b3b553bcc3d::global_config::GlobalConfig) {
        0x62e8d653b0617e106c90a0298f37c87fa5a8d7f3da79acc2454c9b3b553bcc3d::global_config::assert_version(arg1);
        0x62e8d653b0617e106c90a0298f37c87fa5a8d7f3da79acc2454c9b3b553bcc3d::global_config::set_active_status(arg1, true);
    }

    public fun set_inactive(arg0: &mut 0x62e8d653b0617e106c90a0298f37c87fa5a8d7f3da79acc2454c9b3b553bcc3d::permission::AdminCap, arg1: &mut 0x62e8d653b0617e106c90a0298f37c87fa5a8d7f3da79acc2454c9b3b553bcc3d::global_config::GlobalConfig) {
        0x62e8d653b0617e106c90a0298f37c87fa5a8d7f3da79acc2454c9b3b553bcc3d::global_config::assert_version(arg1);
        0x62e8d653b0617e106c90a0298f37c87fa5a8d7f3da79acc2454c9b3b553bcc3d::global_config::set_active_status(arg1, false);
    }

    public fun set_package_version(arg0: &mut 0x62e8d653b0617e106c90a0298f37c87fa5a8d7f3da79acc2454c9b3b553bcc3d::permission::AdminCap, arg1: &mut 0x62e8d653b0617e106c90a0298f37c87fa5a8d7f3da79acc2454c9b3b553bcc3d::global_config::GlobalConfig, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0x62e8d653b0617e106c90a0298f37c87fa5a8d7f3da79acc2454c9b3b553bcc3d::global_config::set_package_version(arg1, arg2, arg3);
    }

    public fun set_protocol_fee_percent(arg0: &mut 0x62e8d653b0617e106c90a0298f37c87fa5a8d7f3da79acc2454c9b3b553bcc3d::permission::AdminCap, arg1: &mut 0x62e8d653b0617e106c90a0298f37c87fa5a8d7f3da79acc2454c9b3b553bcc3d::global_config::GlobalConfig, arg2: u64) {
        0x62e8d653b0617e106c90a0298f37c87fa5a8d7f3da79acc2454c9b3b553bcc3d::global_config::assert_version(arg1);
        0x62e8d653b0617e106c90a0298f37c87fa5a8d7f3da79acc2454c9b3b553bcc3d::global_config::set_protocol_fee_percent(arg1, arg2);
    }

    public fun set_shortfall_fee_percent(arg0: &mut 0x62e8d653b0617e106c90a0298f37c87fa5a8d7f3da79acc2454c9b3b553bcc3d::permission::AdminCap, arg1: &mut 0x62e8d653b0617e106c90a0298f37c87fa5a8d7f3da79acc2454c9b3b553bcc3d::global_config::GlobalConfig, arg2: u64) {
        0x62e8d653b0617e106c90a0298f37c87fa5a8d7f3da79acc2454c9b3b553bcc3d::global_config::assert_version(arg1);
        0x62e8d653b0617e106c90a0298f37c87fa5a8d7f3da79acc2454c9b3b553bcc3d::global_config::set_shortfall_fee_percent(arg1, arg2);
    }

    public fun transfer_admin_role(arg0: &0x62e8d653b0617e106c90a0298f37c87fa5a8d7f3da79acc2454c9b3b553bcc3d::global_config::GlobalConfig, arg1: 0x62e8d653b0617e106c90a0298f37c87fa5a8d7f3da79acc2454c9b3b553bcc3d::permission::AdminCap, arg2: address, arg3: &0x2::tx_context::TxContext) {
        0x62e8d653b0617e106c90a0298f37c87fa5a8d7f3da79acc2454c9b3b553bcc3d::global_config::assert_version(arg0);
        0x62e8d653b0617e106c90a0298f37c87fa5a8d7f3da79acc2454c9b3b553bcc3d::permission::transfer_admin_role(arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

