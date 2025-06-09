module 0xd8e0851cf9e671e2cb343851d66cf7b279b695212dca8d81a80fc252ca0e57fd::config_script {
    public entry fun add_fee_tier(arg0: &mut 0x6571924145092da6384e39a0a3bb85b54238fe850a444bca96a77941671e0d7f::config::GlobalConfig, arg1: u32, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0x6571924145092da6384e39a0a3bb85b54238fe850a444bca96a77941671e0d7f::config::add_fee_tier(arg0, arg1, arg2, arg3);
    }

    public entry fun add_role(arg0: &0x6571924145092da6384e39a0a3bb85b54238fe850a444bca96a77941671e0d7f::config::AdminCap, arg1: &mut 0x6571924145092da6384e39a0a3bb85b54238fe850a444bca96a77941671e0d7f::config::GlobalConfig, arg2: address, arg3: u8) {
        0x6571924145092da6384e39a0a3bb85b54238fe850a444bca96a77941671e0d7f::config::add_role(arg0, arg1, arg2, arg3);
    }

    public entry fun delete_fee_tier(arg0: &mut 0x6571924145092da6384e39a0a3bb85b54238fe850a444bca96a77941671e0d7f::config::GlobalConfig, arg1: u32, arg2: &0x2::tx_context::TxContext) {
        0x6571924145092da6384e39a0a3bb85b54238fe850a444bca96a77941671e0d7f::config::delete_fee_tier(arg0, arg1, arg2);
    }

    public entry fun remove_member(arg0: &0x6571924145092da6384e39a0a3bb85b54238fe850a444bca96a77941671e0d7f::config::AdminCap, arg1: &mut 0x6571924145092da6384e39a0a3bb85b54238fe850a444bca96a77941671e0d7f::config::GlobalConfig, arg2: address) {
        0x6571924145092da6384e39a0a3bb85b54238fe850a444bca96a77941671e0d7f::config::remove_member(arg0, arg1, arg2);
    }

    public entry fun remove_role(arg0: &0x6571924145092da6384e39a0a3bb85b54238fe850a444bca96a77941671e0d7f::config::AdminCap, arg1: &mut 0x6571924145092da6384e39a0a3bb85b54238fe850a444bca96a77941671e0d7f::config::GlobalConfig, arg2: address, arg3: u8) {
        0x6571924145092da6384e39a0a3bb85b54238fe850a444bca96a77941671e0d7f::config::remove_role(arg0, arg1, arg2, arg3);
    }

    public entry fun set_roles(arg0: &0x6571924145092da6384e39a0a3bb85b54238fe850a444bca96a77941671e0d7f::config::AdminCap, arg1: &mut 0x6571924145092da6384e39a0a3bb85b54238fe850a444bca96a77941671e0d7f::config::GlobalConfig, arg2: address, arg3: u128) {
        0x6571924145092da6384e39a0a3bb85b54238fe850a444bca96a77941671e0d7f::config::set_roles(arg0, arg1, arg2, arg3);
    }

    public entry fun update_fee_tier(arg0: &mut 0x6571924145092da6384e39a0a3bb85b54238fe850a444bca96a77941671e0d7f::config::GlobalConfig, arg1: u32, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0x6571924145092da6384e39a0a3bb85b54238fe850a444bca96a77941671e0d7f::config::update_fee_tier(arg0, arg1, arg2, arg3);
    }

    public entry fun update_protocol_fee_rate(arg0: &mut 0x6571924145092da6384e39a0a3bb85b54238fe850a444bca96a77941671e0d7f::config::GlobalConfig, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        0x6571924145092da6384e39a0a3bb85b54238fe850a444bca96a77941671e0d7f::config::update_protocol_fee_rate(arg0, arg1, arg2);
    }

    public entry fun set_position_display(arg0: &0x6571924145092da6384e39a0a3bb85b54238fe850a444bca96a77941671e0d7f::config::GlobalConfig, arg1: &0x2::package::Publisher, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: &mut 0x2::tx_context::TxContext) {
        0x6571924145092da6384e39a0a3bb85b54238fe850a444bca96a77941671e0d7f::position::set_display(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    // decompiled from Move bytecode v6
}

