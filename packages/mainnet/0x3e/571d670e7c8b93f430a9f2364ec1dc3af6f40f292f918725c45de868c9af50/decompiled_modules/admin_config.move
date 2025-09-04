module 0x3e571d670e7c8b93f430a9f2364ec1dc3af6f40f292f918725c45de868c9af50::admin_config {
    public fun set_active(arg0: &mut 0x3e571d670e7c8b93f430a9f2364ec1dc3af6f40f292f918725c45de868c9af50::permission::AdminCap, arg1: &mut 0x3e571d670e7c8b93f430a9f2364ec1dc3af6f40f292f918725c45de868c9af50::global_config::GlobalConfig, arg2: &0x2::tx_context::TxContext) {
        0x3e571d670e7c8b93f430a9f2364ec1dc3af6f40f292f918725c45de868c9af50::global_config::assert_version(arg1);
        0x3e571d670e7c8b93f430a9f2364ec1dc3af6f40f292f918725c45de868c9af50::global_config::set_active_status(arg1, true, arg2);
    }

    public fun set_inactive(arg0: &mut 0x3e571d670e7c8b93f430a9f2364ec1dc3af6f40f292f918725c45de868c9af50::permission::AdminCap, arg1: &mut 0x3e571d670e7c8b93f430a9f2364ec1dc3af6f40f292f918725c45de868c9af50::global_config::GlobalConfig, arg2: &0x2::tx_context::TxContext) {
        0x3e571d670e7c8b93f430a9f2364ec1dc3af6f40f292f918725c45de868c9af50::global_config::assert_version(arg1);
        0x3e571d670e7c8b93f430a9f2364ec1dc3af6f40f292f918725c45de868c9af50::global_config::set_active_status(arg1, false, arg2);
    }

    public fun set_liquidation_threshold(arg0: &mut 0x3e571d670e7c8b93f430a9f2364ec1dc3af6f40f292f918725c45de868c9af50::permission::AdminCap, arg1: &mut 0x3e571d670e7c8b93f430a9f2364ec1dc3af6f40f292f918725c45de868c9af50::global_config::GlobalConfig, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0x3e571d670e7c8b93f430a9f2364ec1dc3af6f40f292f918725c45de868c9af50::global_config::assert_version(arg1);
        0x3e571d670e7c8b93f430a9f2364ec1dc3af6f40f292f918725c45de868c9af50::global_config::set_liquidation_threshold(arg1, arg2, arg3);
    }

    public fun set_package_version(arg0: &mut 0x3e571d670e7c8b93f430a9f2364ec1dc3af6f40f292f918725c45de868c9af50::permission::AdminCap, arg1: &mut 0x3e571d670e7c8b93f430a9f2364ec1dc3af6f40f292f918725c45de868c9af50::global_config::GlobalConfig, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0x3e571d670e7c8b93f430a9f2364ec1dc3af6f40f292f918725c45de868c9af50::global_config::set_package_version(arg1, arg2, arg3);
    }

    public fun set_protocol_fee_percent(arg0: &mut 0x3e571d670e7c8b93f430a9f2364ec1dc3af6f40f292f918725c45de868c9af50::permission::AdminCap, arg1: &mut 0x3e571d670e7c8b93f430a9f2364ec1dc3af6f40f292f918725c45de868c9af50::global_config::GlobalConfig, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0x3e571d670e7c8b93f430a9f2364ec1dc3af6f40f292f918725c45de868c9af50::global_config::assert_version(arg1);
        0x3e571d670e7c8b93f430a9f2364ec1dc3af6f40f292f918725c45de868c9af50::global_config::set_protocol_fee_percent(arg1, arg2, arg3);
    }

    public fun set_shortfall_fee_percent(arg0: &mut 0x3e571d670e7c8b93f430a9f2364ec1dc3af6f40f292f918725c45de868c9af50::permission::AdminCap, arg1: &mut 0x3e571d670e7c8b93f430a9f2364ec1dc3af6f40f292f918725c45de868c9af50::global_config::GlobalConfig, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0x3e571d670e7c8b93f430a9f2364ec1dc3af6f40f292f918725c45de868c9af50::global_config::assert_version(arg1);
        0x3e571d670e7c8b93f430a9f2364ec1dc3af6f40f292f918725c45de868c9af50::global_config::set_shortfall_fee_percent(arg1, arg2, arg3);
    }

    public fun transfer_admin_role(arg0: &0x3e571d670e7c8b93f430a9f2364ec1dc3af6f40f292f918725c45de868c9af50::global_config::GlobalConfig, arg1: 0x3e571d670e7c8b93f430a9f2364ec1dc3af6f40f292f918725c45de868c9af50::permission::AdminCap, arg2: address, arg3: &0x2::tx_context::TxContext) {
        0x3e571d670e7c8b93f430a9f2364ec1dc3af6f40f292f918725c45de868c9af50::global_config::assert_version(arg0);
        0x3e571d670e7c8b93f430a9f2364ec1dc3af6f40f292f918725c45de868c9af50::permission::transfer_admin_role(arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

