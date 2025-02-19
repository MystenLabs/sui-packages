module 0xde76b5100c777b0ef6154eb7485f2270ec390b2f7cd3786469e5772a9eb90b5a::config_script {
    public entry fun add_fee_tier(arg0: &mut 0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::config::GlobalConfig, arg1: u32, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::config::add_fee_tier(arg0, arg1, arg2, arg3);
    }

    public entry fun add_role(arg0: &0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::config::AdminCap, arg1: &mut 0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::config::GlobalConfig, arg2: address, arg3: u8) {
        0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::config::add_role(arg0, arg1, arg2, arg3);
    }

    public entry fun delete_fee_tier(arg0: &mut 0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::config::GlobalConfig, arg1: u32, arg2: &mut 0x2::tx_context::TxContext) {
        0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::config::delete_fee_tier(arg0, arg1, arg2);
    }

    public entry fun remove_member(arg0: &0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::config::AdminCap, arg1: &mut 0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::config::GlobalConfig, arg2: address) {
        0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::config::remove_member(arg0, arg1, arg2);
    }

    public entry fun remove_role(arg0: &0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::config::AdminCap, arg1: &mut 0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::config::GlobalConfig, arg2: address, arg3: u8) {
        0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::config::remove_role(arg0, arg1, arg2, arg3);
    }

    public entry fun set_roles(arg0: &0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::config::AdminCap, arg1: &mut 0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::config::GlobalConfig, arg2: address, arg3: u128) {
        0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::config::set_roles(arg0, arg1, arg2, arg3);
    }

    public entry fun update_fee_tier(arg0: &mut 0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::config::GlobalConfig, arg1: u32, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::config::update_fee_tier(arg0, arg1, arg2, arg3);
    }

    public entry fun update_protocol_fee_rate(arg0: &mut 0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::config::GlobalConfig, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::config::update_protocol_fee_rate(arg0, arg1, arg2);
    }

    public entry fun init_fee_tiers(arg0: &mut 0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::config::GlobalConfig, arg1: &0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::config::AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::config::add_fee_tier(arg0, 2, 100, arg2);
        0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::config::add_fee_tier(arg0, 10, 500, arg2);
        0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::config::add_fee_tier(arg0, 60, 2500, arg2);
        0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::config::add_fee_tier(arg0, 200, 10000, arg2);
    }

    public entry fun set_position_display(arg0: &0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::config::GlobalConfig, arg1: &0x2::package::Publisher, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: &mut 0x2::tx_context::TxContext) {
        0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::position::set_display(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    // decompiled from Move bytecode v6
}

