module 0xf857fa9df5811e6df2a0240a1029d365db24b5026896776ddd1c3c70803bccd3::registry_v2 {
    struct SuiLinkRegistryV2 has key {
        id: 0x2::object::UID,
        version: u8,
        registry: 0x2::bag::Bag,
    }

    struct RecordsV1 has copy, drop, store {
        dummy_field: bool,
    }

    public fun admin_burn<T0>(arg0: &mut SuiLinkRegistryV2, arg1: &0xf857fa9df5811e6df2a0240a1029d365db24b5026896776ddd1c3c70803bccd3::suilink::AdminCap, arg2: 0x2::transfer::Receiving<0xf857fa9df5811e6df2a0240a1029d365db24b5026896776ddd1c3c70803bccd3::suilink::SuiLink<T0>>) {
        0xf857fa9df5811e6df2a0240a1029d365db24b5026896776ddd1c3c70803bccd3::suilink::destroy<T0>(0xf857fa9df5811e6df2a0240a1029d365db24b5026896776ddd1c3c70803bccd3::suilink::transfer_receive<T0>(&mut arg0.id, arg2));
    }

    public fun create_from_v1(arg0: 0xf857fa9df5811e6df2a0240a1029d365db24b5026896776ddd1c3c70803bccd3::suilink::SuiLinkRegistry, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg1);
        let v1 = RecordsV1{dummy_field: false};
        0x2::dynamic_field::add<RecordsV1, vector<vector<u8>>>(&mut v0, v1, 0x2::vec_set::into_keys<vector<u8>>(0xf857fa9df5811e6df2a0240a1029d365db24b5026896776ddd1c3c70803bccd3::suilink::destroy_registry(arg0)));
        let v2 = SuiLinkRegistryV2{
            id       : v0,
            version  : 3,
            registry : 0x2::bag::new(arg1),
        };
        0x2::transfer::share_object<SuiLinkRegistryV2>(v2);
    }

    public fun delete<T0>(arg0: &mut SuiLinkRegistryV2, arg1: 0xf857fa9df5811e6df2a0240a1029d365db24b5026896776ddd1c3c70803bccd3::suilink::SuiLink<T0>, arg2: u32, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 3, 1);
        0x2::bag::remove<vector<u8>, bool>(&mut arg0.registry, 0xf857fa9df5811e6df2a0240a1029d365db24b5026896776ddd1c3c70803bccd3::utils::hash_registry_entry(arg2, 0x2::tx_context::sender(arg3), 0xf857fa9df5811e6df2a0240a1029d365db24b5026896776ddd1c3c70803bccd3::suilink::network_address<T0>(&arg1)));
        0xf857fa9df5811e6df2a0240a1029d365db24b5026896776ddd1c3c70803bccd3::suilink::nullify_network_address<T0>(&mut arg1);
        0xf857fa9df5811e6df2a0240a1029d365db24b5026896776ddd1c3c70803bccd3::suilink::nullify_timestamp_ms<T0>(&mut arg1);
        0xf857fa9df5811e6df2a0240a1029d365db24b5026896776ddd1c3c70803bccd3::suilink::transfer<T0>(arg1, 0x2::object::uid_to_address(&arg0.id));
    }

    public fun migrate_records(arg0: &mut SuiLinkRegistryV2) {
        let v0 = RecordsV1{dummy_field: false};
        assert!(0x2::dynamic_field::exists_<RecordsV1>(&arg0.id, v0), 3);
        let v1 = RecordsV1{dummy_field: false};
        let v2 = 0x2::dynamic_field::borrow_mut<RecordsV1, vector<vector<u8>>>(&mut arg0.id, v1);
        let v3 = 0;
        while (!0x1::vector::is_empty<vector<u8>>(v2) && v3 <= 250) {
            let v4 = 0x1::vector::pop_back<vector<u8>>(v2);
            0x2::bag::add<vector<u8>, bool>(&mut arg0.registry, 0xf857fa9df5811e6df2a0240a1029d365db24b5026896776ddd1c3c70803bccd3::utils::migration_hash_registry_entry(0, v4), true);
            0x2::bag::add<vector<u8>, bool>(&mut arg0.registry, 0xf857fa9df5811e6df2a0240a1029d365db24b5026896776ddd1c3c70803bccd3::utils::migration_hash_registry_entry(1, v4), true);
            v3 = v3 + 1;
        };
        if (0x1::vector::is_empty<vector<u8>>(v2)) {
            let v5 = RecordsV1{dummy_field: false};
            0x2::dynamic_field::remove<RecordsV1, vector<vector<u8>>>(&mut arg0.id, v5);
        };
    }

    public(friend) fun mint<T0>(arg0: &mut SuiLinkRegistryV2, arg1: 0x1::string::String, arg2: &0x2::clock::Clock, arg3: u32, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = RecordsV1{dummy_field: false};
        assert!(!0x2::dynamic_field::exists_<RecordsV1>(&arg0.id, v0), 2);
        assert!(arg0.version == 3, 1);
        let v1 = 0x2::tx_context::sender(arg4);
        let v2 = 0xf857fa9df5811e6df2a0240a1029d365db24b5026896776ddd1c3c70803bccd3::utils::hash_registry_entry(arg3, v1, arg1);
        assert!(!0x2::bag::contains<vector<u8>>(&arg0.registry, v2), 0);
        0x2::bag::add<vector<u8>, bool>(&mut arg0.registry, v2, true);
        0xf857fa9df5811e6df2a0240a1029d365db24b5026896776ddd1c3c70803bccd3::suilink::transfer<T0>(0xf857fa9df5811e6df2a0240a1029d365db24b5026896776ddd1c3c70803bccd3::suilink::mint<T0>(arg1, 0x2::clock::timestamp_ms(arg2), arg4), v1);
    }

    public fun update_version(arg0: &mut SuiLinkRegistryV2) {
        if (3 > arg0.version) {
            arg0.version = 3;
        };
    }

    // decompiled from Move bytecode v6
}

