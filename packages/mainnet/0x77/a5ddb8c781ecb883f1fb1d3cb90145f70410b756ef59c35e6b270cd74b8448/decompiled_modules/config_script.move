module 0x6e3ae31a16362c563c0fef5293348d262646882a10c307f20f6be8577960f1ef::config_script {
    public entry fun add_fee_tier(arg0: &mut 0xb739751c5704a3e0262c63f058b1a9e9ea894988ff57e3caec1e73e097388035::config::GlobalConfig, arg1: u32, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0xb739751c5704a3e0262c63f058b1a9e9ea894988ff57e3caec1e73e097388035::config::add_fee_tier(arg0, arg1, arg2, arg3);
    }

    public entry fun add_role(arg0: &0xb739751c5704a3e0262c63f058b1a9e9ea894988ff57e3caec1e73e097388035::config::AdminCap, arg1: &mut 0xb739751c5704a3e0262c63f058b1a9e9ea894988ff57e3caec1e73e097388035::config::GlobalConfig, arg2: address, arg3: u8) {
        0xb739751c5704a3e0262c63f058b1a9e9ea894988ff57e3caec1e73e097388035::config::add_role(arg0, arg1, arg2, arg3);
    }

    public entry fun delete_fee_tier(arg0: &mut 0xb739751c5704a3e0262c63f058b1a9e9ea894988ff57e3caec1e73e097388035::config::GlobalConfig, arg1: u32, arg2: &mut 0x2::tx_context::TxContext) {
        0xb739751c5704a3e0262c63f058b1a9e9ea894988ff57e3caec1e73e097388035::config::delete_fee_tier(arg0, arg1, arg2);
    }

    public entry fun init_fee_tiers(arg0: &mut 0xb739751c5704a3e0262c63f058b1a9e9ea894988ff57e3caec1e73e097388035::config::GlobalConfig, arg1: &0xb739751c5704a3e0262c63f058b1a9e9ea894988ff57e3caec1e73e097388035::config::AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        0xb739751c5704a3e0262c63f058b1a9e9ea894988ff57e3caec1e73e097388035::config::add_fee_tier(arg0, 2, 100, arg2);
        0xb739751c5704a3e0262c63f058b1a9e9ea894988ff57e3caec1e73e097388035::config::add_fee_tier(arg0, 10, 500, arg2);
        0xb739751c5704a3e0262c63f058b1a9e9ea894988ff57e3caec1e73e097388035::config::add_fee_tier(arg0, 60, 2500, arg2);
        0xb739751c5704a3e0262c63f058b1a9e9ea894988ff57e3caec1e73e097388035::config::add_fee_tier(arg0, 200, 10000, arg2);
    }

    public entry fun remove_member(arg0: &0xb739751c5704a3e0262c63f058b1a9e9ea894988ff57e3caec1e73e097388035::config::AdminCap, arg1: &mut 0xb739751c5704a3e0262c63f058b1a9e9ea894988ff57e3caec1e73e097388035::config::GlobalConfig, arg2: address) {
        0xb739751c5704a3e0262c63f058b1a9e9ea894988ff57e3caec1e73e097388035::config::remove_member(arg0, arg1, arg2);
    }

    public entry fun remove_role(arg0: &0xb739751c5704a3e0262c63f058b1a9e9ea894988ff57e3caec1e73e097388035::config::AdminCap, arg1: &mut 0xb739751c5704a3e0262c63f058b1a9e9ea894988ff57e3caec1e73e097388035::config::GlobalConfig, arg2: address, arg3: u8) {
        0xb739751c5704a3e0262c63f058b1a9e9ea894988ff57e3caec1e73e097388035::config::remove_role(arg0, arg1, arg2, arg3);
    }

    public entry fun set_position_display(arg0: &0xb739751c5704a3e0262c63f058b1a9e9ea894988ff57e3caec1e73e097388035::config::GlobalConfig, arg1: &0x2::package::Publisher, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: &mut 0x2::tx_context::TxContext) {
        0xb739751c5704a3e0262c63f058b1a9e9ea894988ff57e3caec1e73e097388035::position::set_display(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public entry fun set_roles(arg0: &0xb739751c5704a3e0262c63f058b1a9e9ea894988ff57e3caec1e73e097388035::config::AdminCap, arg1: &mut 0xb739751c5704a3e0262c63f058b1a9e9ea894988ff57e3caec1e73e097388035::config::GlobalConfig, arg2: address, arg3: u128) {
        0xb739751c5704a3e0262c63f058b1a9e9ea894988ff57e3caec1e73e097388035::config::set_roles(arg0, arg1, arg2, arg3);
    }

    public entry fun setup(arg0: &0xb739751c5704a3e0262c63f058b1a9e9ea894988ff57e3caec1e73e097388035::config::AdminCap, arg1: &mut 0xb739751c5704a3e0262c63f058b1a9e9ea894988ff57e3caec1e73e097388035::config::GlobalConfig, arg2: &mut 0xb739751c5704a3e0262c63f058b1a9e9ea894988ff57e3caec1e73e097388035::partner::Partners, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        init_fee_tiers(arg1, arg0, arg4);
        0xb739751c5704a3e0262c63f058b1a9e9ea894988ff57e3caec1e73e097388035::partner::create_partner(arg1, arg2, 0x1::string::utf8(b"dead for aggregator"), 0, 0x2::clock::timestamp_ms(arg3) / 1000 + 1, 0x2::clock::timestamp_ms(arg3) / 1000 + 10, 0x2::tx_context::sender(arg4), arg3, arg4);
    }

    public entry fun update_fee_tier(arg0: &mut 0xb739751c5704a3e0262c63f058b1a9e9ea894988ff57e3caec1e73e097388035::config::GlobalConfig, arg1: u32, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0xb739751c5704a3e0262c63f058b1a9e9ea894988ff57e3caec1e73e097388035::config::update_fee_tier(arg0, arg1, arg2, arg3);
    }

    public entry fun update_protocol_fee_rate(arg0: &mut 0xb739751c5704a3e0262c63f058b1a9e9ea894988ff57e3caec1e73e097388035::config::GlobalConfig, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0xb739751c5704a3e0262c63f058b1a9e9ea894988ff57e3caec1e73e097388035::config::update_protocol_fee_rate(arg0, arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

