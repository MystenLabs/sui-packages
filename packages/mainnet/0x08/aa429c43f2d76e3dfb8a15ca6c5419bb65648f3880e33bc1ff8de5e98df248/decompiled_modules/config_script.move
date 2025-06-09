module 0x8aa429c43f2d76e3dfb8a15ca6c5419bb65648f3880e33bc1ff8de5e98df248::config_script {
    public entry fun add_fee_tier(arg0: &mut 0xd38b948241d565f80d838e2d68491d8bcd1461e16bd6d8cc4b503d23737c3ffe::config::GlobalConfig, arg1: u32, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0xd38b948241d565f80d838e2d68491d8bcd1461e16bd6d8cc4b503d23737c3ffe::config::add_fee_tier(arg0, arg1, arg2, arg3);
    }

    public entry fun add_role(arg0: &0xd38b948241d565f80d838e2d68491d8bcd1461e16bd6d8cc4b503d23737c3ffe::config::AdminCap, arg1: &mut 0xd38b948241d565f80d838e2d68491d8bcd1461e16bd6d8cc4b503d23737c3ffe::config::GlobalConfig, arg2: address, arg3: u8) {
        0xd38b948241d565f80d838e2d68491d8bcd1461e16bd6d8cc4b503d23737c3ffe::config::add_role(arg0, arg1, arg2, arg3);
    }

    public entry fun delete_fee_tier(arg0: &mut 0xd38b948241d565f80d838e2d68491d8bcd1461e16bd6d8cc4b503d23737c3ffe::config::GlobalConfig, arg1: u32, arg2: &0x2::tx_context::TxContext) {
        0xd38b948241d565f80d838e2d68491d8bcd1461e16bd6d8cc4b503d23737c3ffe::config::delete_fee_tier(arg0, arg1, arg2);
    }

    public entry fun remove_member(arg0: &0xd38b948241d565f80d838e2d68491d8bcd1461e16bd6d8cc4b503d23737c3ffe::config::AdminCap, arg1: &mut 0xd38b948241d565f80d838e2d68491d8bcd1461e16bd6d8cc4b503d23737c3ffe::config::GlobalConfig, arg2: address) {
        0xd38b948241d565f80d838e2d68491d8bcd1461e16bd6d8cc4b503d23737c3ffe::config::remove_member(arg0, arg1, arg2);
    }

    public entry fun remove_role(arg0: &0xd38b948241d565f80d838e2d68491d8bcd1461e16bd6d8cc4b503d23737c3ffe::config::AdminCap, arg1: &mut 0xd38b948241d565f80d838e2d68491d8bcd1461e16bd6d8cc4b503d23737c3ffe::config::GlobalConfig, arg2: address, arg3: u8) {
        0xd38b948241d565f80d838e2d68491d8bcd1461e16bd6d8cc4b503d23737c3ffe::config::remove_role(arg0, arg1, arg2, arg3);
    }

    public entry fun set_position_display(arg0: &0xd38b948241d565f80d838e2d68491d8bcd1461e16bd6d8cc4b503d23737c3ffe::config::GlobalConfig, arg1: &0x2::package::Publisher, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: &mut 0x2::tx_context::TxContext) {
        0xd38b948241d565f80d838e2d68491d8bcd1461e16bd6d8cc4b503d23737c3ffe::position::set_display(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public entry fun set_roles(arg0: &0xd38b948241d565f80d838e2d68491d8bcd1461e16bd6d8cc4b503d23737c3ffe::config::AdminCap, arg1: &mut 0xd38b948241d565f80d838e2d68491d8bcd1461e16bd6d8cc4b503d23737c3ffe::config::GlobalConfig, arg2: address, arg3: u128) {
        0xd38b948241d565f80d838e2d68491d8bcd1461e16bd6d8cc4b503d23737c3ffe::config::set_roles(arg0, arg1, arg2, arg3);
    }

    public entry fun update_fee_tier(arg0: &mut 0xd38b948241d565f80d838e2d68491d8bcd1461e16bd6d8cc4b503d23737c3ffe::config::GlobalConfig, arg1: u32, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0xd38b948241d565f80d838e2d68491d8bcd1461e16bd6d8cc4b503d23737c3ffe::config::update_fee_tier(arg0, arg1, arg2, arg3);
    }

    public entry fun update_protocol_fee_rate(arg0: &mut 0xd38b948241d565f80d838e2d68491d8bcd1461e16bd6d8cc4b503d23737c3ffe::config::GlobalConfig, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        0xd38b948241d565f80d838e2d68491d8bcd1461e16bd6d8cc4b503d23737c3ffe::config::update_protocol_fee_rate(arg0, arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

