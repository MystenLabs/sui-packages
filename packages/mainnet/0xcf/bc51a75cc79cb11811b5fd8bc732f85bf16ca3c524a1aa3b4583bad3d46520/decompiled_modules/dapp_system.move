module 0xcfbc51a75cc79cb11811b5fd8bc732f85bf16ca3c524a1aa3b4583bad3d46520::dapp_system {
    struct DappKey has drop {
        dummy_field: bool,
    }

    public(friend) fun new() : DappKey {
        DappKey{dummy_field: false}
    }

    public(friend) fun create(arg0: 0x1::ascii::String, arg1: 0x1::ascii::String, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0xcfbc51a75cc79cb11811b5fd8bc732f85bf16ca3c524a1aa3b4583bad3d46520::dapp_schema::Dapp {
        let v0 = 0xcfbc51a75cc79cb11811b5fd8bc732f85bf16ca3c524a1aa3b4583bad3d46520::dapp_schema::create(arg3);
        assert!(!0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_value::contains<0xcfbc51a75cc79cb11811b5fd8bc732f85bf16ca3c524a1aa3b4583bad3d46520::dapp_metadata::DappMetadata>(0xcfbc51a75cc79cb11811b5fd8bc732f85bf16ca3c524a1aa3b4583bad3d46520::dapp_schema::borrow_metadata(&v0)), 0);
        0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_value::set<0xcfbc51a75cc79cb11811b5fd8bc732f85bf16ca3c524a1aa3b4583bad3d46520::dapp_metadata::DappMetadata>(0xcfbc51a75cc79cb11811b5fd8bc732f85bf16ca3c524a1aa3b4583bad3d46520::dapp_schema::metadata(&mut v0), 0xcfbc51a75cc79cb11811b5fd8bc732f85bf16ca3c524a1aa3b4583bad3d46520::dapp_metadata::new(arg0, arg1, 0x1::ascii::string(b""), 0x1::ascii::string(b""), 0x2::clock::timestamp_ms(arg2), 0x1::vector::empty<0x1::ascii::String>()));
        0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_value::set<address>(0xcfbc51a75cc79cb11811b5fd8bc732f85bf16ca3c524a1aa3b4583bad3d46520::dapp_schema::package_id(&mut v0), 0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::type_info::current_package_id<DappKey>());
        0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_value::set<address>(0xcfbc51a75cc79cb11811b5fd8bc732f85bf16ca3c524a1aa3b4583bad3d46520::dapp_schema::admin(&mut v0), 0x2::tx_context::sender(arg3));
        0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_value::set<u32>(0xcfbc51a75cc79cb11811b5fd8bc732f85bf16ca3c524a1aa3b4583bad3d46520::dapp_schema::version(&mut v0), 1);
        0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_value::set<bool>(0xcfbc51a75cc79cb11811b5fd8bc732f85bf16ca3c524a1aa3b4583bad3d46520::dapp_schema::safe_mode(&mut v0), false);
        0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_value::set<vector<address>>(0xcfbc51a75cc79cb11811b5fd8bc732f85bf16ca3c524a1aa3b4583bad3d46520::dapp_schema::schemas(&mut v0), vector[]);
        v0
    }

    public fun ensure_has_authority(arg0: &0xcfbc51a75cc79cb11811b5fd8bc732f85bf16ca3c524a1aa3b4583bad3d46520::dapp_schema::Dapp, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_value::get<address>(0xcfbc51a75cc79cb11811b5fd8bc732f85bf16ca3c524a1aa3b4583bad3d46520::dapp_schema::borrow_admin(arg0)) == &v0, 0);
    }

    public fun ensure_has_schema<T0: store + key>(arg0: &0xcfbc51a75cc79cb11811b5fd8bc732f85bf16ca3c524a1aa3b4583bad3d46520::dapp_schema::Dapp, arg1: &T0) {
        let v0 = 0x2::object::id_address<T0>(arg1);
        assert!(0x1::vector::contains<address>(0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_value::get<vector<address>>(0xcfbc51a75cc79cb11811b5fd8bc732f85bf16ca3c524a1aa3b4583bad3d46520::dapp_schema::borrow_schemas(arg0)), &v0), 0);
    }

    public fun ensure_no_safe_mode(arg0: &0xcfbc51a75cc79cb11811b5fd8bc732f85bf16ca3c524a1aa3b4583bad3d46520::dapp_schema::Dapp) {
        assert!(!*0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_value::get<bool>(0xcfbc51a75cc79cb11811b5fd8bc732f85bf16ca3c524a1aa3b4583bad3d46520::dapp_schema::borrow_safe_mode(arg0)), 0);
    }

    public entry fun set_metadata(arg0: &mut 0xcfbc51a75cc79cb11811b5fd8bc732f85bf16ca3c524a1aa3b4583bad3d46520::dapp_schema::Dapp, arg1: 0x1::ascii::String, arg2: 0x1::ascii::String, arg3: 0x1::ascii::String, arg4: 0x1::ascii::String, arg5: vector<0x1::ascii::String>, arg6: &0x2::tx_context::TxContext) {
        assert!(0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_value::try_get<address>(0xcfbc51a75cc79cb11811b5fd8bc732f85bf16ca3c524a1aa3b4583bad3d46520::dapp_schema::admin(arg0)) == 0x1::option::some<address>(0x2::tx_context::sender(arg6)), 0);
        0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_value::set<0xcfbc51a75cc79cb11811b5fd8bc732f85bf16ca3c524a1aa3b4583bad3d46520::dapp_metadata::DappMetadata>(0xcfbc51a75cc79cb11811b5fd8bc732f85bf16ca3c524a1aa3b4583bad3d46520::dapp_schema::metadata(arg0), 0xcfbc51a75cc79cb11811b5fd8bc732f85bf16ca3c524a1aa3b4583bad3d46520::dapp_metadata::new(arg1, arg2, arg3, arg4, 0xcfbc51a75cc79cb11811b5fd8bc732f85bf16ca3c524a1aa3b4583bad3d46520::dapp_metadata::get_created_at(0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_value::get<0xcfbc51a75cc79cb11811b5fd8bc732f85bf16ca3c524a1aa3b4583bad3d46520::dapp_metadata::DappMetadata>(0xcfbc51a75cc79cb11811b5fd8bc732f85bf16ca3c524a1aa3b4583bad3d46520::dapp_schema::metadata(arg0))), arg5));
    }

    public entry fun set_safe_mode(arg0: &mut 0xcfbc51a75cc79cb11811b5fd8bc732f85bf16ca3c524a1aa3b4583bad3d46520::dapp_schema::Dapp, arg1: bool, arg2: &0x2::tx_context::TxContext) {
        assert!(0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_value::try_get<address>(0xcfbc51a75cc79cb11811b5fd8bc732f85bf16ca3c524a1aa3b4583bad3d46520::dapp_schema::admin(arg0)) == 0x1::option::some<address>(0x2::tx_context::sender(arg2)), 0);
        0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_value::set<bool>(0xcfbc51a75cc79cb11811b5fd8bc732f85bf16ca3c524a1aa3b4583bad3d46520::dapp_schema::safe_mode(arg0), arg1);
    }

    public entry fun transfer_ownership(arg0: &mut 0xcfbc51a75cc79cb11811b5fd8bc732f85bf16ca3c524a1aa3b4583bad3d46520::dapp_schema::Dapp, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_value::try_get<address>(0xcfbc51a75cc79cb11811b5fd8bc732f85bf16ca3c524a1aa3b4583bad3d46520::dapp_schema::admin(arg0)) == 0x1::option::some<address>(0x2::tx_context::sender(arg2)), 0);
        0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_value::set<address>(0xcfbc51a75cc79cb11811b5fd8bc732f85bf16ca3c524a1aa3b4583bad3d46520::dapp_schema::admin(arg0), arg1);
    }

    // decompiled from Move bytecode v6
}

