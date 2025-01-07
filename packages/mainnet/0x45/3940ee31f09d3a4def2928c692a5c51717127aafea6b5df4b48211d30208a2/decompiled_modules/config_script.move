module 0x453940ee31f09d3a4def2928c692a5c51717127aafea6b5df4b48211d30208a2::config_script {
    public entry fun add_fee_tier(arg0: &mut 0xd2d52783538f553919426ff09ec5dc6b7b323bc4045db9fe9650a6595a505658::config::GlobalConfig, arg1: u32, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0xd2d52783538f553919426ff09ec5dc6b7b323bc4045db9fe9650a6595a505658::config::add_fee_tier(arg0, arg1, arg2, arg3);
    }

    public entry fun add_role(arg0: &0xd2d52783538f553919426ff09ec5dc6b7b323bc4045db9fe9650a6595a505658::config::AdminCap, arg1: &mut 0xd2d52783538f553919426ff09ec5dc6b7b323bc4045db9fe9650a6595a505658::config::GlobalConfig, arg2: address, arg3: u8) {
        0xd2d52783538f553919426ff09ec5dc6b7b323bc4045db9fe9650a6595a505658::config::add_role(arg0, arg1, arg2, arg3);
    }

    public entry fun delete_fee_tier(arg0: &mut 0xd2d52783538f553919426ff09ec5dc6b7b323bc4045db9fe9650a6595a505658::config::GlobalConfig, arg1: u32, arg2: &0x2::tx_context::TxContext) {
        0xd2d52783538f553919426ff09ec5dc6b7b323bc4045db9fe9650a6595a505658::config::delete_fee_tier(arg0, arg1, arg2);
    }

    public entry fun remove_member(arg0: &0xd2d52783538f553919426ff09ec5dc6b7b323bc4045db9fe9650a6595a505658::config::AdminCap, arg1: &mut 0xd2d52783538f553919426ff09ec5dc6b7b323bc4045db9fe9650a6595a505658::config::GlobalConfig, arg2: address) {
        0xd2d52783538f553919426ff09ec5dc6b7b323bc4045db9fe9650a6595a505658::config::remove_member(arg0, arg1, arg2);
    }

    public entry fun remove_role(arg0: &0xd2d52783538f553919426ff09ec5dc6b7b323bc4045db9fe9650a6595a505658::config::AdminCap, arg1: &mut 0xd2d52783538f553919426ff09ec5dc6b7b323bc4045db9fe9650a6595a505658::config::GlobalConfig, arg2: address, arg3: u8) {
        0xd2d52783538f553919426ff09ec5dc6b7b323bc4045db9fe9650a6595a505658::config::remove_role(arg0, arg1, arg2, arg3);
    }

    public entry fun set_position_display(arg0: &0xd2d52783538f553919426ff09ec5dc6b7b323bc4045db9fe9650a6595a505658::config::GlobalConfig, arg1: &0x2::package::Publisher, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: &mut 0x2::tx_context::TxContext) {
        0xd2d52783538f553919426ff09ec5dc6b7b323bc4045db9fe9650a6595a505658::position::set_display(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public entry fun set_roles(arg0: &0xd2d52783538f553919426ff09ec5dc6b7b323bc4045db9fe9650a6595a505658::config::AdminCap, arg1: &mut 0xd2d52783538f553919426ff09ec5dc6b7b323bc4045db9fe9650a6595a505658::config::GlobalConfig, arg2: address, arg3: u128) {
        0xd2d52783538f553919426ff09ec5dc6b7b323bc4045db9fe9650a6595a505658::config::set_roles(arg0, arg1, arg2, arg3);
    }

    public entry fun update_fee_tier(arg0: &mut 0xd2d52783538f553919426ff09ec5dc6b7b323bc4045db9fe9650a6595a505658::config::GlobalConfig, arg1: u32, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0xd2d52783538f553919426ff09ec5dc6b7b323bc4045db9fe9650a6595a505658::config::update_fee_tier(arg0, arg1, arg2, arg3);
    }

    public entry fun update_protocol_fee_rate(arg0: &mut 0xd2d52783538f553919426ff09ec5dc6b7b323bc4045db9fe9650a6595a505658::config::GlobalConfig, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        0xd2d52783538f553919426ff09ec5dc6b7b323bc4045db9fe9650a6595a505658::config::update_protocol_fee_rate(arg0, arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

