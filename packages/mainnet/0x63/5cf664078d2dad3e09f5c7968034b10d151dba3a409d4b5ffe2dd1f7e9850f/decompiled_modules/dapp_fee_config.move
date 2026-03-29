module 0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_fee_config {
    struct DappFeeConfig has copy, drop, store {
        free_credit: u256,
        base_fee: u256,
        byte_fee: u256,
        admin: address,
    }

    public fun new(arg0: u256, arg1: u256, arg2: u256, arg3: address) : DappFeeConfig {
        DappFeeConfig{
            free_credit : arg0,
            base_fee    : arg1,
            byte_fee    : arg2,
            admin       : arg3,
        }
    }

    public fun admin(arg0: &DappFeeConfig) : address {
        arg0.admin
    }

    public fun base_fee(arg0: &DappFeeConfig) : u256 {
        arg0.base_fee
    }

    public fun byte_fee(arg0: &DappFeeConfig) : u256 {
        arg0.byte_fee
    }

    public fun decode(arg0: vector<u8>) : DappFeeConfig {
        let v0 = 0x2::bcs::new(arg0);
        DappFeeConfig{
            free_credit : 0x2::bcs::peel_u256(&mut v0),
            base_fee    : 0x2::bcs::peel_u256(&mut v0),
            byte_fee    : 0x2::bcs::peel_u256(&mut v0),
            admin       : 0x2::bcs::peel_address(&mut v0),
        }
    }

    public(friend) fun delete(arg0: &mut 0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::DappHub) {
        let v0 = 0x1::vector::empty<vector<u8>>();
        0x1::vector::push_back<vector<u8>>(&mut v0, b"dapp_fee_config");
        0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::delete_record<0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_key::DappKey>(arg0, 0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_key::new(), v0, 0x2::address::to_ascii_string(0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_key::package_id()));
    }

    public fun encode(arg0: u256, arg1: u256, arg2: u256, arg3: address) : vector<vector<u8>> {
        let v0 = 0x1::vector::empty<vector<u8>>();
        0x1::vector::push_back<vector<u8>>(&mut v0, 0x2::bcs::to_bytes<u256>(&arg0));
        0x1::vector::push_back<vector<u8>>(&mut v0, 0x2::bcs::to_bytes<u256>(&arg1));
        0x1::vector::push_back<vector<u8>>(&mut v0, 0x2::bcs::to_bytes<u256>(&arg2));
        0x1::vector::push_back<vector<u8>>(&mut v0, 0x2::bcs::to_bytes<address>(&arg3));
        v0
    }

    public fun encode_struct(arg0: DappFeeConfig) : vector<vector<u8>> {
        encode(arg0.free_credit, arg0.base_fee, arg0.byte_fee, arg0.admin)
    }

    public fun ensure_has(arg0: &0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::DappHub) {
        let v0 = 0x1::vector::empty<vector<u8>>();
        0x1::vector::push_back<vector<u8>>(&mut v0, b"dapp_fee_config");
        0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::ensure_has_record<0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_key::DappKey>(arg0, 0x2::address::to_ascii_string(0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_key::package_id()), v0);
    }

    public fun ensure_has_not(arg0: &0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::DappHub) {
        let v0 = 0x1::vector::empty<vector<u8>>();
        0x1::vector::push_back<vector<u8>>(&mut v0, b"dapp_fee_config");
        0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::ensure_has_not_record<0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_key::DappKey>(arg0, 0x2::address::to_ascii_string(0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_key::package_id()), v0);
    }

    public fun free_credit(arg0: &DappFeeConfig) : u256 {
        arg0.free_credit
    }

    public fun get(arg0: &0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::DappHub) : (u256, u256, u256, address) {
        let v0 = 0x1::vector::empty<vector<u8>>();
        0x1::vector::push_back<vector<u8>>(&mut v0, b"dapp_fee_config");
        let v1 = 0x2::bcs::new(0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::get_record<0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_key::DappKey>(arg0, 0x2::address::to_ascii_string(0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_key::package_id()), v0));
        (0x2::bcs::peel_u256(&mut v1), 0x2::bcs::peel_u256(&mut v1), 0x2::bcs::peel_u256(&mut v1), 0x2::bcs::peel_address(&mut v1))
    }

    public fun get_admin(arg0: &0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::DappHub) : address {
        let v0 = 0x1::vector::empty<vector<u8>>();
        0x1::vector::push_back<vector<u8>>(&mut v0, b"dapp_fee_config");
        let v1 = 0x2::bcs::new(0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::get_field<0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_key::DappKey>(arg0, 0x2::address::to_ascii_string(0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_key::package_id()), v0, 3));
        0x2::bcs::peel_address(&mut v1)
    }

    public fun get_base_fee(arg0: &0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::DappHub) : u256 {
        let v0 = 0x1::vector::empty<vector<u8>>();
        0x1::vector::push_back<vector<u8>>(&mut v0, b"dapp_fee_config");
        let v1 = 0x2::bcs::new(0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::get_field<0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_key::DappKey>(arg0, 0x2::address::to_ascii_string(0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_key::package_id()), v0, 1));
        0x2::bcs::peel_u256(&mut v1)
    }

    public fun get_byte_fee(arg0: &0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::DappHub) : u256 {
        let v0 = 0x1::vector::empty<vector<u8>>();
        0x1::vector::push_back<vector<u8>>(&mut v0, b"dapp_fee_config");
        let v1 = 0x2::bcs::new(0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::get_field<0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_key::DappKey>(arg0, 0x2::address::to_ascii_string(0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_key::package_id()), v0, 2));
        0x2::bcs::peel_u256(&mut v1)
    }

    public fun get_free_credit(arg0: &0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::DappHub) : u256 {
        let v0 = 0x1::vector::empty<vector<u8>>();
        0x1::vector::push_back<vector<u8>>(&mut v0, b"dapp_fee_config");
        let v1 = 0x2::bcs::new(0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::get_field<0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_key::DappKey>(arg0, 0x2::address::to_ascii_string(0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_key::package_id()), v0, 0));
        0x2::bcs::peel_u256(&mut v1)
    }

    public fun get_struct(arg0: &0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::DappHub) : DappFeeConfig {
        let v0 = 0x1::vector::empty<vector<u8>>();
        0x1::vector::push_back<vector<u8>>(&mut v0, b"dapp_fee_config");
        decode(0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::get_record<0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_key::DappKey>(arg0, 0x2::address::to_ascii_string(0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_key::package_id()), v0))
    }

    public fun has(arg0: &0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::DappHub) : bool {
        let v0 = 0x1::vector::empty<vector<u8>>();
        0x1::vector::push_back<vector<u8>>(&mut v0, b"dapp_fee_config");
        0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::has_record<0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_key::DappKey>(arg0, 0x2::address::to_ascii_string(0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_key::package_id()), v0)
    }

    public(friend) fun set(arg0: &mut 0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::DappHub, arg1: u256, arg2: u256, arg3: u256, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<vector<u8>>();
        0x1::vector::push_back<vector<u8>>(&mut v0, b"dapp_fee_config");
        0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::set_record<0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_key::DappKey>(arg0, 0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_key::new(), v0, encode(arg1, arg2, arg3, arg4), 0x2::address::to_ascii_string(0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_key::package_id()), false, arg5);
    }

    public(friend) fun set_admin(arg0: &mut 0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::DappHub, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<vector<u8>>();
        0x1::vector::push_back<vector<u8>>(&mut v0, b"dapp_fee_config");
        0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::set_field<0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_key::DappKey>(arg0, 0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_key::new(), 0x2::address::to_ascii_string(0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_key::package_id()), v0, 3, 0x2::bcs::to_bytes<address>(&arg1), arg2);
    }

    public(friend) fun set_base_fee(arg0: &mut 0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::DappHub, arg1: u256, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<vector<u8>>();
        0x1::vector::push_back<vector<u8>>(&mut v0, b"dapp_fee_config");
        0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::set_field<0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_key::DappKey>(arg0, 0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_key::new(), 0x2::address::to_ascii_string(0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_key::package_id()), v0, 1, 0x2::bcs::to_bytes<u256>(&arg1), arg2);
    }

    public(friend) fun set_byte_fee(arg0: &mut 0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::DappHub, arg1: u256, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<vector<u8>>();
        0x1::vector::push_back<vector<u8>>(&mut v0, b"dapp_fee_config");
        0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::set_field<0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_key::DappKey>(arg0, 0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_key::new(), 0x2::address::to_ascii_string(0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_key::package_id()), v0, 2, 0x2::bcs::to_bytes<u256>(&arg1), arg2);
    }

    public(friend) fun set_free_credit(arg0: &mut 0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::DappHub, arg1: u256, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<vector<u8>>();
        0x1::vector::push_back<vector<u8>>(&mut v0, b"dapp_fee_config");
        0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::set_field<0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_key::DappKey>(arg0, 0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_key::new(), 0x2::address::to_ascii_string(0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_key::package_id()), v0, 0, 0x2::bcs::to_bytes<u256>(&arg1), arg2);
    }

    public(friend) fun set_struct(arg0: &mut 0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::DappHub, arg1: DappFeeConfig, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<vector<u8>>();
        0x1::vector::push_back<vector<u8>>(&mut v0, b"dapp_fee_config");
        0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::set_record<0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_key::DappKey>(arg0, 0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_key::new(), v0, encode_struct(arg1), 0x2::address::to_ascii_string(0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_key::package_id()), false, arg2);
    }

    public fun update_admin(arg0: &mut DappFeeConfig, arg1: address) {
        arg0.admin = arg1;
    }

    public fun update_base_fee(arg0: &mut DappFeeConfig, arg1: u256) {
        arg0.base_fee = arg1;
    }

    public fun update_byte_fee(arg0: &mut DappFeeConfig, arg1: u256) {
        arg0.byte_fee = arg1;
    }

    public fun update_free_credit(arg0: &mut DappFeeConfig, arg1: u256) {
        arg0.free_credit = arg1;
    }

    // decompiled from Move bytecode v6
}

