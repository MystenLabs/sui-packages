module 0xd11553e11fbae0b48f6190d5cfeacb02b7c8cc15f249ce31f804e45974384f3f::admin_config {
    public fun set_active(arg0: &mut 0xd11553e11fbae0b48f6190d5cfeacb02b7c8cc15f249ce31f804e45974384f3f::permission::AdminCap, arg1: &mut 0xd11553e11fbae0b48f6190d5cfeacb02b7c8cc15f249ce31f804e45974384f3f::global_config::GlobalConfig, arg2: &0x2::tx_context::TxContext) {
        0xd11553e11fbae0b48f6190d5cfeacb02b7c8cc15f249ce31f804e45974384f3f::global_config::assert_version(arg1);
        0xd11553e11fbae0b48f6190d5cfeacb02b7c8cc15f249ce31f804e45974384f3f::global_config::set_active_status(arg1, true, arg2);
    }

    public fun set_collateral_weight<T0, T1>(arg0: &mut 0xd11553e11fbae0b48f6190d5cfeacb02b7c8cc15f249ce31f804e45974384f3f::permission::AdminCap, arg1: &0xd11553e11fbae0b48f6190d5cfeacb02b7c8cc15f249ce31f804e45974384f3f::global_config::GlobalConfig, arg2: &mut 0xd11553e11fbae0b48f6190d5cfeacb02b7c8cc15f249ce31f804e45974384f3f::main::Farm<T0, T1>, arg3: u64) {
        0xd11553e11fbae0b48f6190d5cfeacb02b7c8cc15f249ce31f804e45974384f3f::global_config::assert_version(arg1);
        0xd11553e11fbae0b48f6190d5cfeacb02b7c8cc15f249ce31f804e45974384f3f::main::set_collateral_weight<T0, T1>(arg2, arg3);
    }

    public fun set_inactive(arg0: &mut 0xd11553e11fbae0b48f6190d5cfeacb02b7c8cc15f249ce31f804e45974384f3f::permission::AdminCap, arg1: &mut 0xd11553e11fbae0b48f6190d5cfeacb02b7c8cc15f249ce31f804e45974384f3f::global_config::GlobalConfig, arg2: &0x2::tx_context::TxContext) {
        0xd11553e11fbae0b48f6190d5cfeacb02b7c8cc15f249ce31f804e45974384f3f::global_config::assert_version(arg1);
        0xd11553e11fbae0b48f6190d5cfeacb02b7c8cc15f249ce31f804e45974384f3f::global_config::set_active_status(arg1, false, arg2);
    }

    public fun set_liquidation_fee_wallet(arg0: &mut 0xd11553e11fbae0b48f6190d5cfeacb02b7c8cc15f249ce31f804e45974384f3f::permission::AdminCap, arg1: &mut 0xd11553e11fbae0b48f6190d5cfeacb02b7c8cc15f249ce31f804e45974384f3f::global_config::GlobalConfig, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0xd11553e11fbae0b48f6190d5cfeacb02b7c8cc15f249ce31f804e45974384f3f::global_config::assert_version(arg1);
        0xd11553e11fbae0b48f6190d5cfeacb02b7c8cc15f249ce31f804e45974384f3f::global_config::set_liquidation_fee_wallet(arg1, arg2, arg3);
    }

    public fun set_liquidation_threshold(arg0: &mut 0xd11553e11fbae0b48f6190d5cfeacb02b7c8cc15f249ce31f804e45974384f3f::permission::AdminCap, arg1: &mut 0xd11553e11fbae0b48f6190d5cfeacb02b7c8cc15f249ce31f804e45974384f3f::global_config::GlobalConfig, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0xd11553e11fbae0b48f6190d5cfeacb02b7c8cc15f249ce31f804e45974384f3f::global_config::assert_version(arg1);
        0xd11553e11fbae0b48f6190d5cfeacb02b7c8cc15f249ce31f804e45974384f3f::global_config::set_liquidation_threshold(arg1, arg2, arg3);
    }

    public fun set_package_version(arg0: &mut 0xd11553e11fbae0b48f6190d5cfeacb02b7c8cc15f249ce31f804e45974384f3f::permission::AdminCap, arg1: &mut 0xd11553e11fbae0b48f6190d5cfeacb02b7c8cc15f249ce31f804e45974384f3f::global_config::GlobalConfig, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0xd11553e11fbae0b48f6190d5cfeacb02b7c8cc15f249ce31f804e45974384f3f::global_config::set_package_version(arg1, arg2, arg3);
    }

    public fun set_protocol_fee_percent(arg0: &mut 0xd11553e11fbae0b48f6190d5cfeacb02b7c8cc15f249ce31f804e45974384f3f::permission::AdminCap, arg1: &mut 0xd11553e11fbae0b48f6190d5cfeacb02b7c8cc15f249ce31f804e45974384f3f::global_config::GlobalConfig, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0xd11553e11fbae0b48f6190d5cfeacb02b7c8cc15f249ce31f804e45974384f3f::global_config::assert_version(arg1);
        0xd11553e11fbae0b48f6190d5cfeacb02b7c8cc15f249ce31f804e45974384f3f::global_config::set_protocol_fee_percent(arg1, arg2, arg3);
    }

    public fun set_shortfall_fee_percent(arg0: &mut 0xd11553e11fbae0b48f6190d5cfeacb02b7c8cc15f249ce31f804e45974384f3f::permission::AdminCap, arg1: &mut 0xd11553e11fbae0b48f6190d5cfeacb02b7c8cc15f249ce31f804e45974384f3f::global_config::GlobalConfig, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0xd11553e11fbae0b48f6190d5cfeacb02b7c8cc15f249ce31f804e45974384f3f::global_config::assert_version(arg1);
        0xd11553e11fbae0b48f6190d5cfeacb02b7c8cc15f249ce31f804e45974384f3f::global_config::set_shortfall_fee_percent(arg1, arg2, arg3);
    }

    public fun transfer_admin_role(arg0: &0xd11553e11fbae0b48f6190d5cfeacb02b7c8cc15f249ce31f804e45974384f3f::global_config::GlobalConfig, arg1: 0xd11553e11fbae0b48f6190d5cfeacb02b7c8cc15f249ce31f804e45974384f3f::permission::AdminCap, arg2: address, arg3: &0x2::tx_context::TxContext) {
        0xd11553e11fbae0b48f6190d5cfeacb02b7c8cc15f249ce31f804e45974384f3f::global_config::assert_version(arg0);
        0xd11553e11fbae0b48f6190d5cfeacb02b7c8cc15f249ce31f804e45974384f3f::permission::transfer_admin_role(arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

