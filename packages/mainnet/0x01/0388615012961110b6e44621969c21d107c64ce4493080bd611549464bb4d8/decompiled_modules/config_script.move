module 0x10388615012961110b6e44621969c21d107c64ce4493080bd611549464bb4d8::config_script {
    public entry fun add_fee_tier(arg0: &mut 0x91657507890f065ad5ac9ad5f585ad54cce127f51d893ada7a18fa331a88af3c::config::GlobalConfig, arg1: u32, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x91657507890f065ad5ac9ad5f585ad54cce127f51d893ada7a18fa331a88af3c::config::add_fee_tier(arg0, arg1, arg2, arg3);
    }

    public entry fun add_role(arg0: &0x91657507890f065ad5ac9ad5f585ad54cce127f51d893ada7a18fa331a88af3c::config::AdminCap, arg1: &mut 0x91657507890f065ad5ac9ad5f585ad54cce127f51d893ada7a18fa331a88af3c::config::GlobalConfig, arg2: address, arg3: u8) {
        0x91657507890f065ad5ac9ad5f585ad54cce127f51d893ada7a18fa331a88af3c::config::add_role(arg0, arg1, arg2, arg3);
    }

    public entry fun delete_fee_tier(arg0: &mut 0x91657507890f065ad5ac9ad5f585ad54cce127f51d893ada7a18fa331a88af3c::config::GlobalConfig, arg1: u32, arg2: &mut 0x2::tx_context::TxContext) {
        0x91657507890f065ad5ac9ad5f585ad54cce127f51d893ada7a18fa331a88af3c::config::delete_fee_tier(arg0, arg1, arg2);
    }

    public entry fun init_fee_tiers(arg0: &mut 0x91657507890f065ad5ac9ad5f585ad54cce127f51d893ada7a18fa331a88af3c::config::GlobalConfig, arg1: &0x91657507890f065ad5ac9ad5f585ad54cce127f51d893ada7a18fa331a88af3c::config::AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        0x91657507890f065ad5ac9ad5f585ad54cce127f51d893ada7a18fa331a88af3c::config::add_fee_tier(arg0, 2, 100, arg2);
        0x91657507890f065ad5ac9ad5f585ad54cce127f51d893ada7a18fa331a88af3c::config::add_fee_tier(arg0, 10, 500, arg2);
        0x91657507890f065ad5ac9ad5f585ad54cce127f51d893ada7a18fa331a88af3c::config::add_fee_tier(arg0, 60, 2500, arg2);
        0x91657507890f065ad5ac9ad5f585ad54cce127f51d893ada7a18fa331a88af3c::config::add_fee_tier(arg0, 200, 10000, arg2);
    }

    public entry fun remove_member(arg0: &0x91657507890f065ad5ac9ad5f585ad54cce127f51d893ada7a18fa331a88af3c::config::AdminCap, arg1: &mut 0x91657507890f065ad5ac9ad5f585ad54cce127f51d893ada7a18fa331a88af3c::config::GlobalConfig, arg2: address) {
        0x91657507890f065ad5ac9ad5f585ad54cce127f51d893ada7a18fa331a88af3c::config::remove_member(arg0, arg1, arg2);
    }

    public entry fun remove_role(arg0: &0x91657507890f065ad5ac9ad5f585ad54cce127f51d893ada7a18fa331a88af3c::config::AdminCap, arg1: &mut 0x91657507890f065ad5ac9ad5f585ad54cce127f51d893ada7a18fa331a88af3c::config::GlobalConfig, arg2: address, arg3: u8) {
        0x91657507890f065ad5ac9ad5f585ad54cce127f51d893ada7a18fa331a88af3c::config::remove_role(arg0, arg1, arg2, arg3);
    }

    public entry fun set_position_display(arg0: &0x91657507890f065ad5ac9ad5f585ad54cce127f51d893ada7a18fa331a88af3c::config::GlobalConfig, arg1: &0x2::package::Publisher, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: &mut 0x2::tx_context::TxContext) {
        0x91657507890f065ad5ac9ad5f585ad54cce127f51d893ada7a18fa331a88af3c::position::set_display(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public entry fun set_roles(arg0: &0x91657507890f065ad5ac9ad5f585ad54cce127f51d893ada7a18fa331a88af3c::config::AdminCap, arg1: &mut 0x91657507890f065ad5ac9ad5f585ad54cce127f51d893ada7a18fa331a88af3c::config::GlobalConfig, arg2: address, arg3: u128) {
        0x91657507890f065ad5ac9ad5f585ad54cce127f51d893ada7a18fa331a88af3c::config::set_roles(arg0, arg1, arg2, arg3);
    }

    public entry fun update_fee_tier(arg0: &mut 0x91657507890f065ad5ac9ad5f585ad54cce127f51d893ada7a18fa331a88af3c::config::GlobalConfig, arg1: u32, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x91657507890f065ad5ac9ad5f585ad54cce127f51d893ada7a18fa331a88af3c::config::update_fee_tier(arg0, arg1, arg2, arg3);
    }

    public entry fun update_protocol_fee_rate(arg0: &mut 0x91657507890f065ad5ac9ad5f585ad54cce127f51d893ada7a18fa331a88af3c::config::GlobalConfig, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x91657507890f065ad5ac9ad5f585ad54cce127f51d893ada7a18fa331a88af3c::config::update_protocol_fee_rate(arg0, arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

