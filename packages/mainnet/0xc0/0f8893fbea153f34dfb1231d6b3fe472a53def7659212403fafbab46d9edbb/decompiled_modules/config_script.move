module 0xc00f8893fbea153f34dfb1231d6b3fe472a53def7659212403fafbab46d9edbb::config_script {
    public entry fun add_fee_tier(arg0: &mut 0x2999984d9f3b6d4d36a310cddad758936e69e4d58dc234f9bf59c0da50ad7cd8::config::GlobalConfig, arg1: u32, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0x2999984d9f3b6d4d36a310cddad758936e69e4d58dc234f9bf59c0da50ad7cd8::config::add_fee_tier(arg0, arg1, arg2, arg3);
    }

    public entry fun add_role(arg0: &0x2999984d9f3b6d4d36a310cddad758936e69e4d58dc234f9bf59c0da50ad7cd8::config::AdminCap, arg1: &mut 0x2999984d9f3b6d4d36a310cddad758936e69e4d58dc234f9bf59c0da50ad7cd8::config::GlobalConfig, arg2: address, arg3: u8) {
        0x2999984d9f3b6d4d36a310cddad758936e69e4d58dc234f9bf59c0da50ad7cd8::config::add_role(arg0, arg1, arg2, arg3);
    }

    public entry fun delete_fee_tier(arg0: &mut 0x2999984d9f3b6d4d36a310cddad758936e69e4d58dc234f9bf59c0da50ad7cd8::config::GlobalConfig, arg1: u32, arg2: &0x2::tx_context::TxContext) {
        0x2999984d9f3b6d4d36a310cddad758936e69e4d58dc234f9bf59c0da50ad7cd8::config::delete_fee_tier(arg0, arg1, arg2);
    }

    public entry fun remove_member(arg0: &0x2999984d9f3b6d4d36a310cddad758936e69e4d58dc234f9bf59c0da50ad7cd8::config::AdminCap, arg1: &mut 0x2999984d9f3b6d4d36a310cddad758936e69e4d58dc234f9bf59c0da50ad7cd8::config::GlobalConfig, arg2: address) {
        0x2999984d9f3b6d4d36a310cddad758936e69e4d58dc234f9bf59c0da50ad7cd8::config::remove_member(arg0, arg1, arg2);
    }

    public entry fun remove_role(arg0: &0x2999984d9f3b6d4d36a310cddad758936e69e4d58dc234f9bf59c0da50ad7cd8::config::AdminCap, arg1: &mut 0x2999984d9f3b6d4d36a310cddad758936e69e4d58dc234f9bf59c0da50ad7cd8::config::GlobalConfig, arg2: address, arg3: u8) {
        0x2999984d9f3b6d4d36a310cddad758936e69e4d58dc234f9bf59c0da50ad7cd8::config::remove_role(arg0, arg1, arg2, arg3);
    }

    public entry fun set_roles(arg0: &0x2999984d9f3b6d4d36a310cddad758936e69e4d58dc234f9bf59c0da50ad7cd8::config::AdminCap, arg1: &mut 0x2999984d9f3b6d4d36a310cddad758936e69e4d58dc234f9bf59c0da50ad7cd8::config::GlobalConfig, arg2: address, arg3: u128) {
        0x2999984d9f3b6d4d36a310cddad758936e69e4d58dc234f9bf59c0da50ad7cd8::config::set_roles(arg0, arg1, arg2, arg3);
    }

    public entry fun update_fee_tier(arg0: &mut 0x2999984d9f3b6d4d36a310cddad758936e69e4d58dc234f9bf59c0da50ad7cd8::config::GlobalConfig, arg1: u32, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0x2999984d9f3b6d4d36a310cddad758936e69e4d58dc234f9bf59c0da50ad7cd8::config::update_fee_tier(arg0, arg1, arg2, arg3);
    }

    public entry fun update_protocol_fee_rate(arg0: &mut 0x2999984d9f3b6d4d36a310cddad758936e69e4d58dc234f9bf59c0da50ad7cd8::config::GlobalConfig, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        0x2999984d9f3b6d4d36a310cddad758936e69e4d58dc234f9bf59c0da50ad7cd8::config::update_protocol_fee_rate(arg0, arg1, arg2);
    }

    public entry fun set_position_display(arg0: &0x2999984d9f3b6d4d36a310cddad758936e69e4d58dc234f9bf59c0da50ad7cd8::config::GlobalConfig, arg1: &0x2::package::Publisher, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: &mut 0x2::tx_context::TxContext) {
        0x2999984d9f3b6d4d36a310cddad758936e69e4d58dc234f9bf59c0da50ad7cd8::position::set_display(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    // decompiled from Move bytecode v6
}

