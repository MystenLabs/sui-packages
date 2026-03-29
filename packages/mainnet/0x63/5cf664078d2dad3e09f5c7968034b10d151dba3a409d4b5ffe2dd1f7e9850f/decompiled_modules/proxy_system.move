module 0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::proxy_system {
    fun build_expected_message(arg0: address, arg1: &0x1::ascii::String, arg2: &0x1::ascii::String, arg3: u64) : vector<u8> {
        let v0 = b"dubhe proxy:";
        0x1::vector::append<u8>(&mut v0, 0x1::ascii::into_bytes(0x2::address::to_ascii_string(arg0)));
        0x1::vector::append<u8>(&mut v0, b":");
        0x1::vector::append<u8>(&mut v0, 0x1::ascii::into_bytes(*arg1));
        0x1::vector::append<u8>(&mut v0, b":");
        0x1::vector::append<u8>(&mut v0, 0x1::ascii::into_bytes(*arg2));
        0x1::vector::append<u8>(&mut v0, b":");
        0x1::vector::append<u8>(&mut v0, u64_to_ascii(arg3));
        v0
    }

    public fun create_proxy<T0: copy + drop>(arg0: &mut 0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::DappHub, arg1: vector<u8>, arg2: vector<u8>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        assert!(0x1::vector::length<u8>(&arg1) == 32, 2);
        assert!(0x1::vector::length<u8>(&arg2) == 64, 3);
        let v2 = 0x2::tx_context::epoch_timestamp_ms(arg4);
        assert!(arg3 > v2, 6);
        assert!(arg3 <= v2 + 604800000, 8);
        let v3 = derive_sui_address_from_pubkey(&arg1);
        if (0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::proxy_config::has(arg0, v1, v3)) {
            let (v4, v5) = 0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::proxy_config::get(arg0, v1, v3);
            if (v2 < v5) {
                assert!(v4 == 0x2::address::to_ascii_string(v0), 7);
            };
        };
        let v6 = build_expected_message(v0, &v3, &v1, arg3);
        assert!(0x2::ed25519::ed25519_verify(&arg2, &arg1, &v6), 1);
        0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::proxy_config::set(arg0, v1, v3, 0x2::address::to_ascii_string(v0), arg3, arg4);
    }

    fun derive_sui_address_from_pubkey(arg0: &vector<u8>) : 0x1::ascii::String {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::push_back<u8>(&mut v0, 0);
        0x1::vector::append<u8>(&mut v0, *arg0);
        0x2::address::to_ascii_string(0x2::address::from_bytes(0x2::hash::blake2b256(&v0)))
    }

    public fun extend_proxy<T0: copy + drop>(arg0: &mut 0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::DappHub, arg1: 0x1::ascii::String, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        assert!(0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::proxy_config::has(arg0, v0, arg1), 4);
        0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::errors::no_permission_error(0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::proxy_config::get_owner(arg0, v0, arg1) == 0x2::address::to_ascii_string(0x2::tx_context::sender(arg3)));
        let v1 = 0x2::tx_context::epoch_timestamp_ms(arg3);
        assert!(v1 < 0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::proxy_config::get_expires_at(arg0, v0, arg1), 5);
        assert!(arg2 > v1, 6);
        assert!(arg2 <= v1 + 604800000, 8);
        0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::proxy_config::set_expires_at(arg0, v0, arg1, arg2, arg3);
    }

    public fun is_proxy_active<T0: copy + drop>(arg0: &0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::DappHub, arg1: 0x1::ascii::String, arg2: &0x2::clock::Clock) : bool {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        if (!0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::proxy_config::has(arg0, v0, arg1)) {
            return false
        };
        0x2::clock::timestamp_ms(arg2) < 0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::proxy_config::get_expires_at(arg0, v0, arg1)
    }

    public fun proxy_message<T0: copy + drop>(arg0: address, arg1: &vector<u8>, arg2: u64) : vector<u8> {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        let v1 = derive_sui_address_from_pubkey(arg1);
        build_expected_message(arg0, &v1, &v0, arg2)
    }

    public fun remove_proxy<T0: copy + drop>(arg0: &mut 0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::DappHub, arg1: 0x1::ascii::String, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        assert!(0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::proxy_config::has(arg0, v0, arg1), 4);
        0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::errors::no_permission_error(0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::proxy_config::get_owner(arg0, v0, arg1) == 0x2::address::to_ascii_string(0x2::tx_context::sender(arg2)));
        0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::proxy_config::delete(arg0, v0, arg1);
    }

    fun u64_to_ascii(arg0: u64) : vector<u8> {
        if (arg0 == 0) {
            return b"0"
        };
        let v0 = 0x1::vector::empty<u8>();
        while (arg0 > 0) {
            0x1::vector::push_back<u8>(&mut v0, ((arg0 % 10) as u8) + 48);
            arg0 = arg0 / 10;
        };
        0x1::vector::reverse<u8>(&mut v0);
        v0
    }

    // decompiled from Move bytecode v6
}

