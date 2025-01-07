module 0xa4ceb3319e8790520c53aef2e1197a41c18c4bfedaf05bcef490bee7fd436f59::config_script {
    public entry fun add_fee_tier(arg0: &mut 0xb37c47b69844e80738e95dbbdb26b6eda77c3eab0396618e96be581389c0cbcd::config::GlobalConfig, arg1: u32, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0xb37c47b69844e80738e95dbbdb26b6eda77c3eab0396618e96be581389c0cbcd::config::add_fee_tier(arg0, arg1, arg2, arg3);
    }

    public entry fun add_role(arg0: &0xb37c47b69844e80738e95dbbdb26b6eda77c3eab0396618e96be581389c0cbcd::config::AdminCap, arg1: &mut 0xb37c47b69844e80738e95dbbdb26b6eda77c3eab0396618e96be581389c0cbcd::config::GlobalConfig, arg2: address, arg3: u8) {
        0xb37c47b69844e80738e95dbbdb26b6eda77c3eab0396618e96be581389c0cbcd::config::add_role(arg0, arg1, arg2, arg3);
    }

    public entry fun delete_fee_tier(arg0: &mut 0xb37c47b69844e80738e95dbbdb26b6eda77c3eab0396618e96be581389c0cbcd::config::GlobalConfig, arg1: u32, arg2: &mut 0x2::tx_context::TxContext) {
        0xb37c47b69844e80738e95dbbdb26b6eda77c3eab0396618e96be581389c0cbcd::config::delete_fee_tier(arg0, arg1, arg2);
    }

    public entry fun remove_member(arg0: &0xb37c47b69844e80738e95dbbdb26b6eda77c3eab0396618e96be581389c0cbcd::config::AdminCap, arg1: &mut 0xb37c47b69844e80738e95dbbdb26b6eda77c3eab0396618e96be581389c0cbcd::config::GlobalConfig, arg2: address) {
        0xb37c47b69844e80738e95dbbdb26b6eda77c3eab0396618e96be581389c0cbcd::config::remove_member(arg0, arg1, arg2);
    }

    public entry fun remove_role(arg0: &0xb37c47b69844e80738e95dbbdb26b6eda77c3eab0396618e96be581389c0cbcd::config::AdminCap, arg1: &mut 0xb37c47b69844e80738e95dbbdb26b6eda77c3eab0396618e96be581389c0cbcd::config::GlobalConfig, arg2: address, arg3: u8) {
        0xb37c47b69844e80738e95dbbdb26b6eda77c3eab0396618e96be581389c0cbcd::config::remove_role(arg0, arg1, arg2, arg3);
    }

    public entry fun set_position_display(arg0: &0xb37c47b69844e80738e95dbbdb26b6eda77c3eab0396618e96be581389c0cbcd::config::GlobalConfig, arg1: &0x2::package::Publisher, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: &mut 0x2::tx_context::TxContext) {
        0xb37c47b69844e80738e95dbbdb26b6eda77c3eab0396618e96be581389c0cbcd::position::set_display(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public entry fun set_roles(arg0: &0xb37c47b69844e80738e95dbbdb26b6eda77c3eab0396618e96be581389c0cbcd::config::AdminCap, arg1: &mut 0xb37c47b69844e80738e95dbbdb26b6eda77c3eab0396618e96be581389c0cbcd::config::GlobalConfig, arg2: address, arg3: u128) {
        0xb37c47b69844e80738e95dbbdb26b6eda77c3eab0396618e96be581389c0cbcd::config::set_roles(arg0, arg1, arg2, arg3);
    }

    public entry fun update_fee_tier(arg0: &mut 0xb37c47b69844e80738e95dbbdb26b6eda77c3eab0396618e96be581389c0cbcd::config::GlobalConfig, arg1: u32, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0xb37c47b69844e80738e95dbbdb26b6eda77c3eab0396618e96be581389c0cbcd::config::update_fee_tier(arg0, arg1, arg2, arg3);
    }

    public entry fun update_protocol_fee_rate(arg0: &mut 0xb37c47b69844e80738e95dbbdb26b6eda77c3eab0396618e96be581389c0cbcd::config::GlobalConfig, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0xb37c47b69844e80738e95dbbdb26b6eda77c3eab0396618e96be581389c0cbcd::config::update_protocol_fee_rate(arg0, arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

