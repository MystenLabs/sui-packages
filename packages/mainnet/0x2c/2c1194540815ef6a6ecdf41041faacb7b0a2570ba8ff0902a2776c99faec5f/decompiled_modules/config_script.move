module 0x2c2c1194540815ef6a6ecdf41041faacb7b0a2570ba8ff0902a2776c99faec5f::config_script {
    public fun add_fee_tier(arg0: &mut 0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::config::GlobalConfig, arg1: u32, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::config::add_fee_tier(arg0, arg1, arg2, arg3);
    }

    public fun add_role(arg0: &0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::config::AdminCap, arg1: &mut 0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::config::GlobalConfig, arg2: address, arg3: u8) {
        0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::config::add_role(arg0, arg1, arg2, arg3);
    }

    public fun add_whitelist_token<T0>(arg0: &mut 0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::config::GlobalConfig, arg1: &0x2::tx_context::TxContext) {
        0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::config::add_whitelist_token<T0>(arg0, arg1);
    }

    public fun delete_fee_tier(arg0: &mut 0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::config::GlobalConfig, arg1: u32, arg2: &0x2::tx_context::TxContext) {
        0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::config::delete_fee_tier(arg0, arg1, arg2);
    }

    public fun remove_member(arg0: &0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::config::AdminCap, arg1: &mut 0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::config::GlobalConfig, arg2: address) {
        0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::config::remove_member(arg0, arg1, arg2);
    }

    public fun remove_role(arg0: &0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::config::AdminCap, arg1: &mut 0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::config::GlobalConfig, arg2: address, arg3: u8) {
        0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::config::remove_role(arg0, arg1, arg2, arg3);
    }

    public fun remove_whitelist_token<T0>(arg0: &mut 0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::config::GlobalConfig, arg1: &0x2::tx_context::TxContext) {
        0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::config::delete_whitelist_token<T0>(arg0, arg1);
    }

    public fun set_position_display(arg0: &0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::config::GlobalConfig, arg1: &0x2::package::Publisher, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: &mut 0x2::tx_context::TxContext) {
        0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::position::set_display(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public fun set_roles(arg0: &0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::config::AdminCap, arg1: &mut 0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::config::GlobalConfig, arg2: address, arg3: u128) {
        0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::config::set_roles(arg0, arg1, arg2, arg3);
    }

    public fun update_fee_tier(arg0: &mut 0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::config::GlobalConfig, arg1: u32, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::config::update_fee_tier(arg0, arg1, arg2, arg3);
    }

    public fun update_protocol_fee_rate(arg0: &mut 0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::config::GlobalConfig, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::config::update_protocol_fee_rate(arg0, arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

