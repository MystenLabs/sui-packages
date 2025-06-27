module 0x7701ae515703598d6f2451f4bfec857d3cba994fd3e1968b11110d674e3126c4::config_script {
    public entry fun add_fee_tier(arg0: &mut 0x771249e154f5d1c8dc70738df3ce452afc979046bc89bd8d7d32c54254d1940c::config::GlobalConfig, arg1: u32, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x771249e154f5d1c8dc70738df3ce452afc979046bc89bd8d7d32c54254d1940c::config::add_fee_tier(arg0, arg1, arg2, arg3);
    }

    public entry fun add_role(arg0: &0x771249e154f5d1c8dc70738df3ce452afc979046bc89bd8d7d32c54254d1940c::config::AdminCap, arg1: &mut 0x771249e154f5d1c8dc70738df3ce452afc979046bc89bd8d7d32c54254d1940c::config::GlobalConfig, arg2: address, arg3: u8) {
        0x771249e154f5d1c8dc70738df3ce452afc979046bc89bd8d7d32c54254d1940c::config::add_role(arg0, arg1, arg2, arg3);
    }

    public entry fun delete_fee_tier(arg0: &mut 0x771249e154f5d1c8dc70738df3ce452afc979046bc89bd8d7d32c54254d1940c::config::GlobalConfig, arg1: u32, arg2: &mut 0x2::tx_context::TxContext) {
        0x771249e154f5d1c8dc70738df3ce452afc979046bc89bd8d7d32c54254d1940c::config::delete_fee_tier(arg0, arg1, arg2);
    }

    public entry fun init_fee_tiers(arg0: &mut 0x771249e154f5d1c8dc70738df3ce452afc979046bc89bd8d7d32c54254d1940c::config::GlobalConfig, arg1: &0x771249e154f5d1c8dc70738df3ce452afc979046bc89bd8d7d32c54254d1940c::config::AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        0x771249e154f5d1c8dc70738df3ce452afc979046bc89bd8d7d32c54254d1940c::config::add_fee_tier(arg0, 2, 100, arg2);
        0x771249e154f5d1c8dc70738df3ce452afc979046bc89bd8d7d32c54254d1940c::config::add_fee_tier(arg0, 10, 500, arg2);
        0x771249e154f5d1c8dc70738df3ce452afc979046bc89bd8d7d32c54254d1940c::config::add_fee_tier(arg0, 60, 2500, arg2);
        0x771249e154f5d1c8dc70738df3ce452afc979046bc89bd8d7d32c54254d1940c::config::add_fee_tier(arg0, 200, 10000, arg2);
    }

    public entry fun remove_member(arg0: &0x771249e154f5d1c8dc70738df3ce452afc979046bc89bd8d7d32c54254d1940c::config::AdminCap, arg1: &mut 0x771249e154f5d1c8dc70738df3ce452afc979046bc89bd8d7d32c54254d1940c::config::GlobalConfig, arg2: address) {
        0x771249e154f5d1c8dc70738df3ce452afc979046bc89bd8d7d32c54254d1940c::config::remove_member(arg0, arg1, arg2);
    }

    public entry fun remove_role(arg0: &0x771249e154f5d1c8dc70738df3ce452afc979046bc89bd8d7d32c54254d1940c::config::AdminCap, arg1: &mut 0x771249e154f5d1c8dc70738df3ce452afc979046bc89bd8d7d32c54254d1940c::config::GlobalConfig, arg2: address, arg3: u8) {
        0x771249e154f5d1c8dc70738df3ce452afc979046bc89bd8d7d32c54254d1940c::config::remove_role(arg0, arg1, arg2, arg3);
    }

    public entry fun set_position_display(arg0: &0x771249e154f5d1c8dc70738df3ce452afc979046bc89bd8d7d32c54254d1940c::config::GlobalConfig, arg1: &0x2::package::Publisher, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: &mut 0x2::tx_context::TxContext) {
        0x771249e154f5d1c8dc70738df3ce452afc979046bc89bd8d7d32c54254d1940c::position::set_display(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public entry fun set_roles(arg0: &0x771249e154f5d1c8dc70738df3ce452afc979046bc89bd8d7d32c54254d1940c::config::AdminCap, arg1: &mut 0x771249e154f5d1c8dc70738df3ce452afc979046bc89bd8d7d32c54254d1940c::config::GlobalConfig, arg2: address, arg3: u128) {
        0x771249e154f5d1c8dc70738df3ce452afc979046bc89bd8d7d32c54254d1940c::config::set_roles(arg0, arg1, arg2, arg3);
    }

    public entry fun setup(arg0: &0x771249e154f5d1c8dc70738df3ce452afc979046bc89bd8d7d32c54254d1940c::config::AdminCap, arg1: &mut 0x771249e154f5d1c8dc70738df3ce452afc979046bc89bd8d7d32c54254d1940c::config::GlobalConfig, arg2: &mut 0x771249e154f5d1c8dc70738df3ce452afc979046bc89bd8d7d32c54254d1940c::partner::Partners, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        init_fee_tiers(arg1, arg0, arg4);
        0x771249e154f5d1c8dc70738df3ce452afc979046bc89bd8d7d32c54254d1940c::partner::create_partner(arg1, arg2, 0x1::string::utf8(b"dead for aggregator"), 0, 0x2::clock::timestamp_ms(arg3) / 1000 + 1, 0x2::clock::timestamp_ms(arg3) / 1000 + 10, 0x2::tx_context::sender(arg4), arg3, arg4);
    }

    public entry fun update_fee_tier(arg0: &mut 0x771249e154f5d1c8dc70738df3ce452afc979046bc89bd8d7d32c54254d1940c::config::GlobalConfig, arg1: u32, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x771249e154f5d1c8dc70738df3ce452afc979046bc89bd8d7d32c54254d1940c::config::update_fee_tier(arg0, arg1, arg2, arg3);
    }

    public entry fun update_protocol_fee_rate(arg0: &mut 0x771249e154f5d1c8dc70738df3ce452afc979046bc89bd8d7d32c54254d1940c::config::GlobalConfig, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x771249e154f5d1c8dc70738df3ce452afc979046bc89bd8d7d32c54254d1940c::config::update_protocol_fee_rate(arg0, arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

