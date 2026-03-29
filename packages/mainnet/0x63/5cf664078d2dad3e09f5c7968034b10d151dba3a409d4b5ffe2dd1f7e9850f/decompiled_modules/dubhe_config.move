module 0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dubhe_config {
    struct DubheConfig has copy, drop, store {
        next_asset_id: u256,
        swap_fee: u256,
        fee_to: 0x1::ascii::String,
        max_swap_path_len: u64,
        admin: 0x1::ascii::String,
    }

    public fun new(arg0: u256, arg1: u256, arg2: 0x1::ascii::String, arg3: u64, arg4: 0x1::ascii::String) : DubheConfig {
        DubheConfig{
            next_asset_id     : arg0,
            swap_fee          : arg1,
            fee_to            : arg2,
            max_swap_path_len : arg3,
            admin             : arg4,
        }
    }

    public fun admin(arg0: &DubheConfig) : 0x1::ascii::String {
        arg0.admin
    }

    public fun decode(arg0: vector<u8>) : DubheConfig {
        let v0 = 0x2::bcs::new(arg0);
        DubheConfig{
            next_asset_id     : 0x2::bcs::peel_u256(&mut v0),
            swap_fee          : 0x2::bcs::peel_u256(&mut v0),
            fee_to            : 0x1::ascii::string(0x2::bcs::peel_vec_u8(&mut v0)),
            max_swap_path_len : 0x2::bcs::peel_u64(&mut v0),
            admin             : 0x1::ascii::string(0x2::bcs::peel_vec_u8(&mut v0)),
        }
    }

    public(friend) fun delete(arg0: &mut 0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::DappHub) {
        let v0 = 0x1::vector::empty<vector<u8>>();
        0x1::vector::push_back<vector<u8>>(&mut v0, b"dubhe_config");
        0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::delete_record<0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_key::DappKey>(arg0, 0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_key::new(), v0, 0x2::address::to_ascii_string(0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_key::package_id()));
    }

    public fun encode(arg0: u256, arg1: u256, arg2: 0x1::ascii::String, arg3: u64, arg4: 0x1::ascii::String) : vector<vector<u8>> {
        let v0 = 0x1::vector::empty<vector<u8>>();
        0x1::vector::push_back<vector<u8>>(&mut v0, 0x2::bcs::to_bytes<u256>(&arg0));
        0x1::vector::push_back<vector<u8>>(&mut v0, 0x2::bcs::to_bytes<u256>(&arg1));
        let v1 = 0x1::ascii::into_bytes(arg2);
        0x1::vector::push_back<vector<u8>>(&mut v0, 0x2::bcs::to_bytes<vector<u8>>(&v1));
        0x1::vector::push_back<vector<u8>>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg3));
        let v2 = 0x1::ascii::into_bytes(arg4);
        0x1::vector::push_back<vector<u8>>(&mut v0, 0x2::bcs::to_bytes<vector<u8>>(&v2));
        v0
    }

    public fun encode_struct(arg0: DubheConfig) : vector<vector<u8>> {
        encode(arg0.next_asset_id, arg0.swap_fee, arg0.fee_to, arg0.max_swap_path_len, arg0.admin)
    }

    public fun ensure_has(arg0: &0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::DappHub) {
        let v0 = 0x1::vector::empty<vector<u8>>();
        0x1::vector::push_back<vector<u8>>(&mut v0, b"dubhe_config");
        0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::ensure_has_record<0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_key::DappKey>(arg0, 0x2::address::to_ascii_string(0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_key::package_id()), v0);
    }

    public fun ensure_has_not(arg0: &0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::DappHub) {
        let v0 = 0x1::vector::empty<vector<u8>>();
        0x1::vector::push_back<vector<u8>>(&mut v0, b"dubhe_config");
        0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::ensure_has_not_record<0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_key::DappKey>(arg0, 0x2::address::to_ascii_string(0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_key::package_id()), v0);
    }

    public fun fee_to(arg0: &DubheConfig) : 0x1::ascii::String {
        arg0.fee_to
    }

    public fun get(arg0: &0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::DappHub) : (u256, u256, 0x1::ascii::String, u64, 0x1::ascii::String) {
        let v0 = 0x1::vector::empty<vector<u8>>();
        0x1::vector::push_back<vector<u8>>(&mut v0, b"dubhe_config");
        let v1 = 0x2::bcs::new(0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::get_record<0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_key::DappKey>(arg0, 0x2::address::to_ascii_string(0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_key::package_id()), v0));
        (0x2::bcs::peel_u256(&mut v1), 0x2::bcs::peel_u256(&mut v1), 0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::bcs::peel_string(&mut v1), 0x2::bcs::peel_u64(&mut v1), 0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::bcs::peel_string(&mut v1))
    }

    public fun get_admin(arg0: &0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::DappHub) : 0x1::ascii::String {
        let v0 = 0x1::vector::empty<vector<u8>>();
        0x1::vector::push_back<vector<u8>>(&mut v0, b"dubhe_config");
        let v1 = 0x2::bcs::new(0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::get_field<0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_key::DappKey>(arg0, 0x2::address::to_ascii_string(0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_key::package_id()), v0, 4));
        0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::bcs::peel_string(&mut v1)
    }

    public fun get_fee_to(arg0: &0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::DappHub) : 0x1::ascii::String {
        let v0 = 0x1::vector::empty<vector<u8>>();
        0x1::vector::push_back<vector<u8>>(&mut v0, b"dubhe_config");
        let v1 = 0x2::bcs::new(0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::get_field<0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_key::DappKey>(arg0, 0x2::address::to_ascii_string(0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_key::package_id()), v0, 2));
        0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::bcs::peel_string(&mut v1)
    }

    public fun get_max_swap_path_len(arg0: &0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::DappHub) : u64 {
        let v0 = 0x1::vector::empty<vector<u8>>();
        0x1::vector::push_back<vector<u8>>(&mut v0, b"dubhe_config");
        let v1 = 0x2::bcs::new(0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::get_field<0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_key::DappKey>(arg0, 0x2::address::to_ascii_string(0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_key::package_id()), v0, 3));
        0x2::bcs::peel_u64(&mut v1)
    }

    public fun get_next_asset_id(arg0: &0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::DappHub) : u256 {
        let v0 = 0x1::vector::empty<vector<u8>>();
        0x1::vector::push_back<vector<u8>>(&mut v0, b"dubhe_config");
        let v1 = 0x2::bcs::new(0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::get_field<0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_key::DappKey>(arg0, 0x2::address::to_ascii_string(0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_key::package_id()), v0, 0));
        0x2::bcs::peel_u256(&mut v1)
    }

    public fun get_struct(arg0: &0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::DappHub) : DubheConfig {
        let v0 = 0x1::vector::empty<vector<u8>>();
        0x1::vector::push_back<vector<u8>>(&mut v0, b"dubhe_config");
        decode(0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::get_record<0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_key::DappKey>(arg0, 0x2::address::to_ascii_string(0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_key::package_id()), v0))
    }

    public fun get_swap_fee(arg0: &0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::DappHub) : u256 {
        let v0 = 0x1::vector::empty<vector<u8>>();
        0x1::vector::push_back<vector<u8>>(&mut v0, b"dubhe_config");
        let v1 = 0x2::bcs::new(0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::get_field<0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_key::DappKey>(arg0, 0x2::address::to_ascii_string(0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_key::package_id()), v0, 1));
        0x2::bcs::peel_u256(&mut v1)
    }

    public fun has(arg0: &0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::DappHub) : bool {
        let v0 = 0x1::vector::empty<vector<u8>>();
        0x1::vector::push_back<vector<u8>>(&mut v0, b"dubhe_config");
        0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::has_record<0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_key::DappKey>(arg0, 0x2::address::to_ascii_string(0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_key::package_id()), v0)
    }

    public fun max_swap_path_len(arg0: &DubheConfig) : u64 {
        arg0.max_swap_path_len
    }

    public fun next_asset_id(arg0: &DubheConfig) : u256 {
        arg0.next_asset_id
    }

    public(friend) fun set(arg0: &mut 0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::DappHub, arg1: u256, arg2: u256, arg3: 0x1::ascii::String, arg4: u64, arg5: 0x1::ascii::String, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<vector<u8>>();
        0x1::vector::push_back<vector<u8>>(&mut v0, b"dubhe_config");
        0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::set_record<0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_key::DappKey>(arg0, 0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_key::new(), v0, encode(arg1, arg2, arg3, arg4, arg5), 0x2::address::to_ascii_string(0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_key::package_id()), false, arg6);
    }

    public(friend) fun set_admin(arg0: &mut 0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::DappHub, arg1: 0x1::ascii::String, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<vector<u8>>();
        0x1::vector::push_back<vector<u8>>(&mut v0, b"dubhe_config");
        let v1 = 0x1::ascii::into_bytes(arg1);
        0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::set_field<0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_key::DappKey>(arg0, 0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_key::new(), 0x2::address::to_ascii_string(0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_key::package_id()), v0, 4, 0x2::bcs::to_bytes<vector<u8>>(&v1), arg2);
    }

    public(friend) fun set_fee_to(arg0: &mut 0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::DappHub, arg1: 0x1::ascii::String, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<vector<u8>>();
        0x1::vector::push_back<vector<u8>>(&mut v0, b"dubhe_config");
        let v1 = 0x1::ascii::into_bytes(arg1);
        0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::set_field<0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_key::DappKey>(arg0, 0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_key::new(), 0x2::address::to_ascii_string(0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_key::package_id()), v0, 2, 0x2::bcs::to_bytes<vector<u8>>(&v1), arg2);
    }

    public(friend) fun set_max_swap_path_len(arg0: &mut 0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::DappHub, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<vector<u8>>();
        0x1::vector::push_back<vector<u8>>(&mut v0, b"dubhe_config");
        0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::set_field<0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_key::DappKey>(arg0, 0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_key::new(), 0x2::address::to_ascii_string(0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_key::package_id()), v0, 3, 0x2::bcs::to_bytes<u64>(&arg1), arg2);
    }

    public(friend) fun set_next_asset_id(arg0: &mut 0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::DappHub, arg1: u256, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<vector<u8>>();
        0x1::vector::push_back<vector<u8>>(&mut v0, b"dubhe_config");
        0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::set_field<0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_key::DappKey>(arg0, 0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_key::new(), 0x2::address::to_ascii_string(0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_key::package_id()), v0, 0, 0x2::bcs::to_bytes<u256>(&arg1), arg2);
    }

    public(friend) fun set_struct(arg0: &mut 0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::DappHub, arg1: DubheConfig, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<vector<u8>>();
        0x1::vector::push_back<vector<u8>>(&mut v0, b"dubhe_config");
        0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::set_record<0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_key::DappKey>(arg0, 0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_key::new(), v0, encode_struct(arg1), 0x2::address::to_ascii_string(0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_key::package_id()), false, arg2);
    }

    public(friend) fun set_swap_fee(arg0: &mut 0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::DappHub, arg1: u256, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<vector<u8>>();
        0x1::vector::push_back<vector<u8>>(&mut v0, b"dubhe_config");
        0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::set_field<0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_key::DappKey>(arg0, 0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_key::new(), 0x2::address::to_ascii_string(0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_key::package_id()), v0, 1, 0x2::bcs::to_bytes<u256>(&arg1), arg2);
    }

    public fun swap_fee(arg0: &DubheConfig) : u256 {
        arg0.swap_fee
    }

    public fun update_admin(arg0: &mut DubheConfig, arg1: 0x1::ascii::String) {
        arg0.admin = arg1;
    }

    public fun update_fee_to(arg0: &mut DubheConfig, arg1: 0x1::ascii::String) {
        arg0.fee_to = arg1;
    }

    public fun update_max_swap_path_len(arg0: &mut DubheConfig, arg1: u64) {
        arg0.max_swap_path_len = arg1;
    }

    public fun update_next_asset_id(arg0: &mut DubheConfig, arg1: u256) {
        arg0.next_asset_id = arg1;
    }

    public fun update_swap_fee(arg0: &mut DubheConfig, arg1: u256) {
        arg0.swap_fee = arg1;
    }

    // decompiled from Move bytecode v6
}

