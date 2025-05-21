module 0x26943cac71f5cfee07a263b3f6bf4b54b8389482fa34916e5957fa96cd06c2ce::config_script {
    public entry fun add_fee_tier(arg0: &mut 0x272968a6c4e9f404ca6f07547cf4b49435afa906c27ce49b4c8f6fa881b8e80d::config::GlobalConfig, arg1: u32, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0x272968a6c4e9f404ca6f07547cf4b49435afa906c27ce49b4c8f6fa881b8e80d::config::add_fee_tier(arg0, arg1, arg2, arg3);
    }

    public entry fun add_role(arg0: &0x272968a6c4e9f404ca6f07547cf4b49435afa906c27ce49b4c8f6fa881b8e80d::config::AdminCap, arg1: &mut 0x272968a6c4e9f404ca6f07547cf4b49435afa906c27ce49b4c8f6fa881b8e80d::config::GlobalConfig, arg2: address, arg3: u8) {
        0x272968a6c4e9f404ca6f07547cf4b49435afa906c27ce49b4c8f6fa881b8e80d::config::add_role(arg0, arg1, arg2, arg3);
    }

    public entry fun delete_fee_tier(arg0: &mut 0x272968a6c4e9f404ca6f07547cf4b49435afa906c27ce49b4c8f6fa881b8e80d::config::GlobalConfig, arg1: u32, arg2: &0x2::tx_context::TxContext) {
        0x272968a6c4e9f404ca6f07547cf4b49435afa906c27ce49b4c8f6fa881b8e80d::config::delete_fee_tier(arg0, arg1, arg2);
    }

    public entry fun remove_member(arg0: &0x272968a6c4e9f404ca6f07547cf4b49435afa906c27ce49b4c8f6fa881b8e80d::config::AdminCap, arg1: &mut 0x272968a6c4e9f404ca6f07547cf4b49435afa906c27ce49b4c8f6fa881b8e80d::config::GlobalConfig, arg2: address) {
        0x272968a6c4e9f404ca6f07547cf4b49435afa906c27ce49b4c8f6fa881b8e80d::config::remove_member(arg0, arg1, arg2);
    }

    public entry fun remove_role(arg0: &0x272968a6c4e9f404ca6f07547cf4b49435afa906c27ce49b4c8f6fa881b8e80d::config::AdminCap, arg1: &mut 0x272968a6c4e9f404ca6f07547cf4b49435afa906c27ce49b4c8f6fa881b8e80d::config::GlobalConfig, arg2: address, arg3: u8) {
        0x272968a6c4e9f404ca6f07547cf4b49435afa906c27ce49b4c8f6fa881b8e80d::config::remove_role(arg0, arg1, arg2, arg3);
    }

    public entry fun set_position_display(arg0: &0x272968a6c4e9f404ca6f07547cf4b49435afa906c27ce49b4c8f6fa881b8e80d::config::GlobalConfig, arg1: &0x2::package::Publisher, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: &mut 0x2::tx_context::TxContext) {
        0x272968a6c4e9f404ca6f07547cf4b49435afa906c27ce49b4c8f6fa881b8e80d::position::set_display(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public entry fun set_roles(arg0: &0x272968a6c4e9f404ca6f07547cf4b49435afa906c27ce49b4c8f6fa881b8e80d::config::AdminCap, arg1: &mut 0x272968a6c4e9f404ca6f07547cf4b49435afa906c27ce49b4c8f6fa881b8e80d::config::GlobalConfig, arg2: address, arg3: u128) {
        0x272968a6c4e9f404ca6f07547cf4b49435afa906c27ce49b4c8f6fa881b8e80d::config::set_roles(arg0, arg1, arg2, arg3);
    }

    public entry fun update_fee_tier(arg0: &mut 0x272968a6c4e9f404ca6f07547cf4b49435afa906c27ce49b4c8f6fa881b8e80d::config::GlobalConfig, arg1: u32, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0x272968a6c4e9f404ca6f07547cf4b49435afa906c27ce49b4c8f6fa881b8e80d::config::update_fee_tier(arg0, arg1, arg2, arg3);
    }

    public entry fun update_protocol_fee_rate(arg0: &mut 0x272968a6c4e9f404ca6f07547cf4b49435afa906c27ce49b4c8f6fa881b8e80d::config::GlobalConfig, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        0x272968a6c4e9f404ca6f07547cf4b49435afa906c27ce49b4c8f6fa881b8e80d::config::update_protocol_fee_rate(arg0, arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

