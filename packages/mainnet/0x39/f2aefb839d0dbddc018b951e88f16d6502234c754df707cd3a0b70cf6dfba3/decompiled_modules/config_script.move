module 0x39f2aefb839d0dbddc018b951e88f16d6502234c754df707cd3a0b70cf6dfba3::config_script {
    public fun add_role(arg0: &0xc7d71347aa2bafbdf09b594b3153ff8b5b74078dba8d6d0e2b4bf39ca6f5716c::config::AdminCap, arg1: &mut 0xc7d71347aa2bafbdf09b594b3153ff8b5b74078dba8d6d0e2b4bf39ca6f5716c::config::GlobalConfig, arg2: address, arg3: u8) {
        0xc7d71347aa2bafbdf09b594b3153ff8b5b74078dba8d6d0e2b4bf39ca6f5716c::config::add_role(arg0, arg1, arg2, arg3);
    }

    public fun add_update_fee_tier(arg0: &mut 0xc7d71347aa2bafbdf09b594b3153ff8b5b74078dba8d6d0e2b4bf39ca6f5716c::config::GlobalConfig, arg1: u32, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0xc7d71347aa2bafbdf09b594b3153ff8b5b74078dba8d6d0e2b4bf39ca6f5716c::config::add_update_fee_tier(arg0, arg1, arg2, arg3);
    }

    public fun add_whitelist_token<T0>(arg0: &mut 0xc7d71347aa2bafbdf09b594b3153ff8b5b74078dba8d6d0e2b4bf39ca6f5716c::config::GlobalConfig, arg1: &0x2::tx_context::TxContext) {
        0xc7d71347aa2bafbdf09b594b3153ff8b5b74078dba8d6d0e2b4bf39ca6f5716c::config::add_whitelist_token<T0>(arg0, arg1);
    }

    public fun delete_fee_tier(arg0: &mut 0xc7d71347aa2bafbdf09b594b3153ff8b5b74078dba8d6d0e2b4bf39ca6f5716c::config::GlobalConfig, arg1: u32, arg2: &0x2::tx_context::TxContext) {
        0xc7d71347aa2bafbdf09b594b3153ff8b5b74078dba8d6d0e2b4bf39ca6f5716c::config::delete_fee_tier(arg0, arg1, arg2);
    }

    public fun remove_member(arg0: &0xc7d71347aa2bafbdf09b594b3153ff8b5b74078dba8d6d0e2b4bf39ca6f5716c::config::AdminCap, arg1: &mut 0xc7d71347aa2bafbdf09b594b3153ff8b5b74078dba8d6d0e2b4bf39ca6f5716c::config::GlobalConfig, arg2: address) {
        0xc7d71347aa2bafbdf09b594b3153ff8b5b74078dba8d6d0e2b4bf39ca6f5716c::config::remove_member(arg0, arg1, arg2);
    }

    public fun remove_role(arg0: &0xc7d71347aa2bafbdf09b594b3153ff8b5b74078dba8d6d0e2b4bf39ca6f5716c::config::AdminCap, arg1: &mut 0xc7d71347aa2bafbdf09b594b3153ff8b5b74078dba8d6d0e2b4bf39ca6f5716c::config::GlobalConfig, arg2: address, arg3: u8) {
        0xc7d71347aa2bafbdf09b594b3153ff8b5b74078dba8d6d0e2b4bf39ca6f5716c::config::remove_role(arg0, arg1, arg2, arg3);
    }

    public fun remove_whitelist_token<T0>(arg0: &mut 0xc7d71347aa2bafbdf09b594b3153ff8b5b74078dba8d6d0e2b4bf39ca6f5716c::config::GlobalConfig, arg1: &0x2::tx_context::TxContext) {
        0xc7d71347aa2bafbdf09b594b3153ff8b5b74078dba8d6d0e2b4bf39ca6f5716c::config::delete_whitelist_token<T0>(arg0, arg1);
    }

    public fun set_position_display(arg0: &0xc7d71347aa2bafbdf09b594b3153ff8b5b74078dba8d6d0e2b4bf39ca6f5716c::config::GlobalConfig, arg1: &0x2::package::Publisher, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: &mut 0x2::tx_context::TxContext) {
        0xc7d71347aa2bafbdf09b594b3153ff8b5b74078dba8d6d0e2b4bf39ca6f5716c::position::set_display(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public fun set_roles(arg0: &0xc7d71347aa2bafbdf09b594b3153ff8b5b74078dba8d6d0e2b4bf39ca6f5716c::config::AdminCap, arg1: &mut 0xc7d71347aa2bafbdf09b594b3153ff8b5b74078dba8d6d0e2b4bf39ca6f5716c::config::GlobalConfig, arg2: address, arg3: u128) {
        0xc7d71347aa2bafbdf09b594b3153ff8b5b74078dba8d6d0e2b4bf39ca6f5716c::config::set_roles(arg1, arg0, arg2, arg3);
    }

    public fun update_protocol_fee_rate(arg0: &mut 0xc7d71347aa2bafbdf09b594b3153ff8b5b74078dba8d6d0e2b4bf39ca6f5716c::config::GlobalConfig, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        0xc7d71347aa2bafbdf09b594b3153ff8b5b74078dba8d6d0e2b4bf39ca6f5716c::config::update_protocol_fee_rate(arg0, arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

