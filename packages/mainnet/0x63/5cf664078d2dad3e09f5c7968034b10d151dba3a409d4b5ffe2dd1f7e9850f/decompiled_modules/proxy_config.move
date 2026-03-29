module 0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::proxy_config {
    struct ProxyConfig has copy, drop, store {
        owner: 0x1::ascii::String,
        expires_at: u64,
    }

    public fun new(arg0: 0x1::ascii::String, arg1: u64) : ProxyConfig {
        ProxyConfig{
            owner      : arg0,
            expires_at : arg1,
        }
    }

    public fun decode(arg0: vector<u8>) : ProxyConfig {
        let v0 = 0x2::bcs::new(arg0);
        ProxyConfig{
            owner      : 0x1::ascii::string(0x2::bcs::peel_vec_u8(&mut v0)),
            expires_at : 0x2::bcs::peel_u64(&mut v0),
        }
    }

    public(friend) fun delete(arg0: &mut 0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::DappHub, arg1: 0x1::ascii::String, arg2: 0x1::ascii::String) {
        let v0 = 0x1::vector::empty<vector<u8>>();
        0x1::vector::push_back<vector<u8>>(&mut v0, b"proxy_config");
        0x1::vector::push_back<vector<u8>>(&mut v0, 0x2::bcs::to_bytes<0x1::ascii::String>(&arg1));
        0x1::vector::push_back<vector<u8>>(&mut v0, 0x2::bcs::to_bytes<0x1::ascii::String>(&arg2));
        0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::delete_record<0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_key::DappKey>(arg0, 0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_key::new(), v0, 0x2::address::to_ascii_string(0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_key::package_id()));
    }

    public fun encode(arg0: 0x1::ascii::String, arg1: u64) : vector<vector<u8>> {
        let v0 = 0x1::vector::empty<vector<u8>>();
        let v1 = 0x1::ascii::into_bytes(arg0);
        0x1::vector::push_back<vector<u8>>(&mut v0, 0x2::bcs::to_bytes<vector<u8>>(&v1));
        0x1::vector::push_back<vector<u8>>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg1));
        v0
    }

    public fun encode_struct(arg0: ProxyConfig) : vector<vector<u8>> {
        encode(arg0.owner, arg0.expires_at)
    }

    public fun ensure_has(arg0: &0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::DappHub, arg1: 0x1::ascii::String, arg2: 0x1::ascii::String) {
        let v0 = 0x1::vector::empty<vector<u8>>();
        0x1::vector::push_back<vector<u8>>(&mut v0, b"proxy_config");
        0x1::vector::push_back<vector<u8>>(&mut v0, 0x2::bcs::to_bytes<0x1::ascii::String>(&arg1));
        0x1::vector::push_back<vector<u8>>(&mut v0, 0x2::bcs::to_bytes<0x1::ascii::String>(&arg2));
        0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::ensure_has_record<0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_key::DappKey>(arg0, 0x2::address::to_ascii_string(0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_key::package_id()), v0);
    }

    public fun ensure_has_not(arg0: &0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::DappHub, arg1: 0x1::ascii::String, arg2: 0x1::ascii::String) {
        let v0 = 0x1::vector::empty<vector<u8>>();
        0x1::vector::push_back<vector<u8>>(&mut v0, b"proxy_config");
        0x1::vector::push_back<vector<u8>>(&mut v0, 0x2::bcs::to_bytes<0x1::ascii::String>(&arg1));
        0x1::vector::push_back<vector<u8>>(&mut v0, 0x2::bcs::to_bytes<0x1::ascii::String>(&arg2));
        0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::ensure_has_not_record<0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_key::DappKey>(arg0, 0x2::address::to_ascii_string(0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_key::package_id()), v0);
    }

    public fun expires_at(arg0: &ProxyConfig) : u64 {
        arg0.expires_at
    }

    public fun get(arg0: &0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::DappHub, arg1: 0x1::ascii::String, arg2: 0x1::ascii::String) : (0x1::ascii::String, u64) {
        let v0 = 0x1::vector::empty<vector<u8>>();
        0x1::vector::push_back<vector<u8>>(&mut v0, b"proxy_config");
        0x1::vector::push_back<vector<u8>>(&mut v0, 0x2::bcs::to_bytes<0x1::ascii::String>(&arg1));
        0x1::vector::push_back<vector<u8>>(&mut v0, 0x2::bcs::to_bytes<0x1::ascii::String>(&arg2));
        let v1 = 0x2::bcs::new(0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::get_record<0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_key::DappKey>(arg0, 0x2::address::to_ascii_string(0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_key::package_id()), v0));
        (0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::bcs::peel_string(&mut v1), 0x2::bcs::peel_u64(&mut v1))
    }

    public fun get_expires_at(arg0: &0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::DappHub, arg1: 0x1::ascii::String, arg2: 0x1::ascii::String) : u64 {
        let v0 = 0x1::vector::empty<vector<u8>>();
        0x1::vector::push_back<vector<u8>>(&mut v0, b"proxy_config");
        0x1::vector::push_back<vector<u8>>(&mut v0, 0x2::bcs::to_bytes<0x1::ascii::String>(&arg1));
        0x1::vector::push_back<vector<u8>>(&mut v0, 0x2::bcs::to_bytes<0x1::ascii::String>(&arg2));
        let v1 = 0x2::bcs::new(0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::get_field<0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_key::DappKey>(arg0, 0x2::address::to_ascii_string(0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_key::package_id()), v0, 1));
        0x2::bcs::peel_u64(&mut v1)
    }

    public fun get_owner(arg0: &0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::DappHub, arg1: 0x1::ascii::String, arg2: 0x1::ascii::String) : 0x1::ascii::String {
        let v0 = 0x1::vector::empty<vector<u8>>();
        0x1::vector::push_back<vector<u8>>(&mut v0, b"proxy_config");
        0x1::vector::push_back<vector<u8>>(&mut v0, 0x2::bcs::to_bytes<0x1::ascii::String>(&arg1));
        0x1::vector::push_back<vector<u8>>(&mut v0, 0x2::bcs::to_bytes<0x1::ascii::String>(&arg2));
        let v1 = 0x2::bcs::new(0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::get_field<0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_key::DappKey>(arg0, 0x2::address::to_ascii_string(0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_key::package_id()), v0, 0));
        0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::bcs::peel_string(&mut v1)
    }

    public fun get_struct(arg0: &0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::DappHub, arg1: 0x1::ascii::String, arg2: 0x1::ascii::String) : ProxyConfig {
        let v0 = 0x1::vector::empty<vector<u8>>();
        0x1::vector::push_back<vector<u8>>(&mut v0, b"proxy_config");
        0x1::vector::push_back<vector<u8>>(&mut v0, 0x2::bcs::to_bytes<0x1::ascii::String>(&arg1));
        0x1::vector::push_back<vector<u8>>(&mut v0, 0x2::bcs::to_bytes<0x1::ascii::String>(&arg2));
        decode(0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::get_record<0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_key::DappKey>(arg0, 0x2::address::to_ascii_string(0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_key::package_id()), v0))
    }

    public fun has(arg0: &0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::DappHub, arg1: 0x1::ascii::String, arg2: 0x1::ascii::String) : bool {
        let v0 = 0x1::vector::empty<vector<u8>>();
        0x1::vector::push_back<vector<u8>>(&mut v0, b"proxy_config");
        0x1::vector::push_back<vector<u8>>(&mut v0, 0x2::bcs::to_bytes<0x1::ascii::String>(&arg1));
        0x1::vector::push_back<vector<u8>>(&mut v0, 0x2::bcs::to_bytes<0x1::ascii::String>(&arg2));
        0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::has_record<0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_key::DappKey>(arg0, 0x2::address::to_ascii_string(0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_key::package_id()), v0)
    }

    public fun owner(arg0: &ProxyConfig) : 0x1::ascii::String {
        arg0.owner
    }

    public(friend) fun set(arg0: &mut 0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::DappHub, arg1: 0x1::ascii::String, arg2: 0x1::ascii::String, arg3: 0x1::ascii::String, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<vector<u8>>();
        0x1::vector::push_back<vector<u8>>(&mut v0, b"proxy_config");
        0x1::vector::push_back<vector<u8>>(&mut v0, 0x2::bcs::to_bytes<0x1::ascii::String>(&arg1));
        0x1::vector::push_back<vector<u8>>(&mut v0, 0x2::bcs::to_bytes<0x1::ascii::String>(&arg2));
        0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::set_record<0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_key::DappKey>(arg0, 0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_key::new(), v0, encode(arg3, arg4), 0x2::address::to_ascii_string(0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_key::package_id()), false, arg5);
    }

    public(friend) fun set_expires_at(arg0: &mut 0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::DappHub, arg1: 0x1::ascii::String, arg2: 0x1::ascii::String, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<vector<u8>>();
        0x1::vector::push_back<vector<u8>>(&mut v0, b"proxy_config");
        0x1::vector::push_back<vector<u8>>(&mut v0, 0x2::bcs::to_bytes<0x1::ascii::String>(&arg1));
        0x1::vector::push_back<vector<u8>>(&mut v0, 0x2::bcs::to_bytes<0x1::ascii::String>(&arg2));
        0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::set_field<0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_key::DappKey>(arg0, 0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_key::new(), 0x2::address::to_ascii_string(0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_key::package_id()), v0, 1, 0x2::bcs::to_bytes<u64>(&arg3), arg4);
    }

    public(friend) fun set_owner(arg0: &mut 0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::DappHub, arg1: 0x1::ascii::String, arg2: 0x1::ascii::String, arg3: 0x1::ascii::String, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<vector<u8>>();
        0x1::vector::push_back<vector<u8>>(&mut v0, b"proxy_config");
        0x1::vector::push_back<vector<u8>>(&mut v0, 0x2::bcs::to_bytes<0x1::ascii::String>(&arg1));
        0x1::vector::push_back<vector<u8>>(&mut v0, 0x2::bcs::to_bytes<0x1::ascii::String>(&arg2));
        let v1 = 0x1::ascii::into_bytes(arg3);
        0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::set_field<0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_key::DappKey>(arg0, 0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_key::new(), 0x2::address::to_ascii_string(0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_key::package_id()), v0, 0, 0x2::bcs::to_bytes<vector<u8>>(&v1), arg4);
    }

    public(friend) fun set_struct(arg0: &mut 0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::DappHub, arg1: 0x1::ascii::String, arg2: 0x1::ascii::String, arg3: ProxyConfig, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<vector<u8>>();
        0x1::vector::push_back<vector<u8>>(&mut v0, b"proxy_config");
        0x1::vector::push_back<vector<u8>>(&mut v0, 0x2::bcs::to_bytes<0x1::ascii::String>(&arg1));
        0x1::vector::push_back<vector<u8>>(&mut v0, 0x2::bcs::to_bytes<0x1::ascii::String>(&arg2));
        0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::set_record<0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_key::DappKey>(arg0, 0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_key::new(), v0, encode_struct(arg3), 0x2::address::to_ascii_string(0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_key::package_id()), false, arg4);
    }

    public fun update_expires_at(arg0: &mut ProxyConfig, arg1: u64) {
        arg0.expires_at = arg1;
    }

    public fun update_owner(arg0: &mut ProxyConfig, arg1: 0x1::ascii::String) {
        arg0.owner = arg1;
    }

    // decompiled from Move bytecode v6
}

