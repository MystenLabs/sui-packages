module 0x97084e44e7778be7414a8fa00623a6274f0161ab0735390a6f2a569e1bdaef7f::config_script {
    public fun add_fee_tier(arg0: &mut 0x677a8ee8489097070f95ffdac5c385ee1ee84e1056ea3d29ede5e09f3e612420::config::GlobalConfig, arg1: u32, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0x677a8ee8489097070f95ffdac5c385ee1ee84e1056ea3d29ede5e09f3e612420::config::add_fee_tier(arg0, arg1, arg2, arg3);
    }

    public fun add_role(arg0: &0x677a8ee8489097070f95ffdac5c385ee1ee84e1056ea3d29ede5e09f3e612420::config::AdminCap, arg1: &mut 0x677a8ee8489097070f95ffdac5c385ee1ee84e1056ea3d29ede5e09f3e612420::config::GlobalConfig, arg2: address, arg3: u8) {
        0x677a8ee8489097070f95ffdac5c385ee1ee84e1056ea3d29ede5e09f3e612420::config::add_role(arg0, arg1, arg2, arg3);
    }

    public fun add_whitelist_token<T0>(arg0: &mut 0x677a8ee8489097070f95ffdac5c385ee1ee84e1056ea3d29ede5e09f3e612420::config::GlobalConfig, arg1: &0x2::tx_context::TxContext) {
        0x677a8ee8489097070f95ffdac5c385ee1ee84e1056ea3d29ede5e09f3e612420::config::add_whitelist_token<T0>(arg0, arg1);
    }

    public fun delete_fee_tier(arg0: &mut 0x677a8ee8489097070f95ffdac5c385ee1ee84e1056ea3d29ede5e09f3e612420::config::GlobalConfig, arg1: u32, arg2: &0x2::tx_context::TxContext) {
        0x677a8ee8489097070f95ffdac5c385ee1ee84e1056ea3d29ede5e09f3e612420::config::delete_fee_tier(arg0, arg1, arg2);
    }

    public fun remove_member(arg0: &0x677a8ee8489097070f95ffdac5c385ee1ee84e1056ea3d29ede5e09f3e612420::config::AdminCap, arg1: &mut 0x677a8ee8489097070f95ffdac5c385ee1ee84e1056ea3d29ede5e09f3e612420::config::GlobalConfig, arg2: address) {
        0x677a8ee8489097070f95ffdac5c385ee1ee84e1056ea3d29ede5e09f3e612420::config::remove_member(arg0, arg1, arg2);
    }

    public fun remove_role(arg0: &0x677a8ee8489097070f95ffdac5c385ee1ee84e1056ea3d29ede5e09f3e612420::config::AdminCap, arg1: &mut 0x677a8ee8489097070f95ffdac5c385ee1ee84e1056ea3d29ede5e09f3e612420::config::GlobalConfig, arg2: address, arg3: u8) {
        0x677a8ee8489097070f95ffdac5c385ee1ee84e1056ea3d29ede5e09f3e612420::config::remove_role(arg0, arg1, arg2, arg3);
    }

    public fun set_roles(arg0: &0x677a8ee8489097070f95ffdac5c385ee1ee84e1056ea3d29ede5e09f3e612420::config::AdminCap, arg1: &mut 0x677a8ee8489097070f95ffdac5c385ee1ee84e1056ea3d29ede5e09f3e612420::config::GlobalConfig, arg2: address, arg3: u128) {
        0x677a8ee8489097070f95ffdac5c385ee1ee84e1056ea3d29ede5e09f3e612420::config::set_roles(arg0, arg1, arg2, arg3);
    }

    public fun update_fee_tier(arg0: &mut 0x677a8ee8489097070f95ffdac5c385ee1ee84e1056ea3d29ede5e09f3e612420::config::GlobalConfig, arg1: u32, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0x677a8ee8489097070f95ffdac5c385ee1ee84e1056ea3d29ede5e09f3e612420::config::update_fee_tier(arg0, arg1, arg2, arg3);
    }

    public fun update_protocol_fee_rate(arg0: &mut 0x677a8ee8489097070f95ffdac5c385ee1ee84e1056ea3d29ede5e09f3e612420::config::GlobalConfig, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        0x677a8ee8489097070f95ffdac5c385ee1ee84e1056ea3d29ede5e09f3e612420::config::update_protocol_fee_rate(arg0, arg1, arg2);
    }

    public fun remove_whitelist_token<T0>(arg0: &mut 0x677a8ee8489097070f95ffdac5c385ee1ee84e1056ea3d29ede5e09f3e612420::config::GlobalConfig, arg1: &0x2::tx_context::TxContext) {
        0x677a8ee8489097070f95ffdac5c385ee1ee84e1056ea3d29ede5e09f3e612420::config::delete_whitelist_token<T0>(arg0, arg1);
    }

    public fun set_position_display(arg0: &0x677a8ee8489097070f95ffdac5c385ee1ee84e1056ea3d29ede5e09f3e612420::config::GlobalConfig, arg1: &0x2::package::Publisher, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: &mut 0x2::tx_context::TxContext) {
        0x677a8ee8489097070f95ffdac5c385ee1ee84e1056ea3d29ede5e09f3e612420::position::set_display(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    // decompiled from Move bytecode v6
}

