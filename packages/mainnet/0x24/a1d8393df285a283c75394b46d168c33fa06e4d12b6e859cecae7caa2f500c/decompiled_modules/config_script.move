module 0x24a1d8393df285a283c75394b46d168c33fa06e4d12b6e859cecae7caa2f500c::config_script {
    public entry fun add_fee_tier(arg0: &mut 0xad456c8224c3c529fe341dcc14426532f57537e59b8f0672f1f5506d0eeeae67::config::GlobalConfig, arg1: u32, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0xad456c8224c3c529fe341dcc14426532f57537e59b8f0672f1f5506d0eeeae67::config::add_fee_tier(arg0, arg1, arg2, arg3);
    }

    public entry fun add_role(arg0: &0xad456c8224c3c529fe341dcc14426532f57537e59b8f0672f1f5506d0eeeae67::config::AdminCap, arg1: &mut 0xad456c8224c3c529fe341dcc14426532f57537e59b8f0672f1f5506d0eeeae67::config::GlobalConfig, arg2: address, arg3: u8) {
        0xad456c8224c3c529fe341dcc14426532f57537e59b8f0672f1f5506d0eeeae67::config::add_role(arg0, arg1, arg2, arg3);
    }

    public entry fun delete_fee_tier(arg0: &mut 0xad456c8224c3c529fe341dcc14426532f57537e59b8f0672f1f5506d0eeeae67::config::GlobalConfig, arg1: u32, arg2: &0x2::tx_context::TxContext) {
        0xad456c8224c3c529fe341dcc14426532f57537e59b8f0672f1f5506d0eeeae67::config::delete_fee_tier(arg0, arg1, arg2);
    }

    public entry fun remove_member(arg0: &0xad456c8224c3c529fe341dcc14426532f57537e59b8f0672f1f5506d0eeeae67::config::AdminCap, arg1: &mut 0xad456c8224c3c529fe341dcc14426532f57537e59b8f0672f1f5506d0eeeae67::config::GlobalConfig, arg2: address) {
        0xad456c8224c3c529fe341dcc14426532f57537e59b8f0672f1f5506d0eeeae67::config::remove_member(arg0, arg1, arg2);
    }

    public entry fun remove_role(arg0: &0xad456c8224c3c529fe341dcc14426532f57537e59b8f0672f1f5506d0eeeae67::config::AdminCap, arg1: &mut 0xad456c8224c3c529fe341dcc14426532f57537e59b8f0672f1f5506d0eeeae67::config::GlobalConfig, arg2: address, arg3: u8) {
        0xad456c8224c3c529fe341dcc14426532f57537e59b8f0672f1f5506d0eeeae67::config::remove_role(arg0, arg1, arg2, arg3);
    }

    public entry fun set_position_display(arg0: &0xad456c8224c3c529fe341dcc14426532f57537e59b8f0672f1f5506d0eeeae67::config::GlobalConfig, arg1: &0x2::package::Publisher, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: &mut 0x2::tx_context::TxContext) {
        0xad456c8224c3c529fe341dcc14426532f57537e59b8f0672f1f5506d0eeeae67::position::set_display(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public entry fun set_roles(arg0: &0xad456c8224c3c529fe341dcc14426532f57537e59b8f0672f1f5506d0eeeae67::config::AdminCap, arg1: &mut 0xad456c8224c3c529fe341dcc14426532f57537e59b8f0672f1f5506d0eeeae67::config::GlobalConfig, arg2: address, arg3: u128) {
        0xad456c8224c3c529fe341dcc14426532f57537e59b8f0672f1f5506d0eeeae67::config::set_roles(arg0, arg1, arg2, arg3);
    }

    public entry fun update_fee_tier(arg0: &mut 0xad456c8224c3c529fe341dcc14426532f57537e59b8f0672f1f5506d0eeeae67::config::GlobalConfig, arg1: u32, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0xad456c8224c3c529fe341dcc14426532f57537e59b8f0672f1f5506d0eeeae67::config::update_fee_tier(arg0, arg1, arg2, arg3);
    }

    public entry fun update_protocol_fee_rate(arg0: &mut 0xad456c8224c3c529fe341dcc14426532f57537e59b8f0672f1f5506d0eeeae67::config::GlobalConfig, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        0xad456c8224c3c529fe341dcc14426532f57537e59b8f0672f1f5506d0eeeae67::config::update_protocol_fee_rate(arg0, arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

