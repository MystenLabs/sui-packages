module 0xcfbc51a75cc79cb11811b5fd8bc732f85bf16ca3c524a1aa3b4583bad3d46520::dapp_schema {
    struct Dapp has store, key {
        id: 0x2::object::UID,
    }

    public(friend) fun add_schema<T0: store + key>(arg0: &mut Dapp, arg1: T0) {
        let v0 = schemas(arg0);
        let v1 = *0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_value::get<vector<address>>(v0);
        0x1::vector::push_back<address>(&mut v1, 0x2::object::id_address<T0>(&arg1));
        0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_value::set<vector<address>>(schemas(arg0), v1);
        0x2::transfer::public_share_object<T0>(arg1);
    }

    public(friend) fun admin(arg0: &mut Dapp) : &mut 0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_value::StorageValue<address> {
        0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage::borrow_mut_field<0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_value::StorageValue<address>>(&mut arg0.id, b"admin")
    }

    public fun borrow_admin(arg0: &Dapp) : &0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_value::StorageValue<address> {
        0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage::borrow_field<0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_value::StorageValue<address>>(&arg0.id, b"admin")
    }

    public fun borrow_metadata(arg0: &Dapp) : &0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_value::StorageValue<0xcfbc51a75cc79cb11811b5fd8bc732f85bf16ca3c524a1aa3b4583bad3d46520::dapp_metadata::DappMetadata> {
        0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage::borrow_field<0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_value::StorageValue<0xcfbc51a75cc79cb11811b5fd8bc732f85bf16ca3c524a1aa3b4583bad3d46520::dapp_metadata::DappMetadata>>(&arg0.id, b"metadata")
    }

    public fun borrow_package_id(arg0: &Dapp) : &0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_value::StorageValue<address> {
        0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage::borrow_field<0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_value::StorageValue<address>>(&arg0.id, b"package_id")
    }

    public fun borrow_safe_mode(arg0: &Dapp) : &0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_value::StorageValue<bool> {
        0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage::borrow_field<0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_value::StorageValue<bool>>(&arg0.id, b"safe_mode")
    }

    public(friend) fun borrow_schemas(arg0: &Dapp) : &0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_value::StorageValue<vector<address>> {
        0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage::borrow_field<0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_value::StorageValue<vector<address>>>(&arg0.id, b"schemas")
    }

    public fun borrow_version(arg0: &Dapp) : &0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_value::StorageValue<u32> {
        0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage::borrow_field<0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_value::StorageValue<u32>>(&arg0.id, b"version")
    }

    public(friend) fun create(arg0: &mut 0x2::tx_context::TxContext) : Dapp {
        let v0 = 0x2::object::new(arg0);
        0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage::add_field<0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_value::StorageValue<address>>(&mut v0, b"admin", 0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_value::new<address>(b"admin", arg0));
        0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage::add_field<0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_value::StorageValue<address>>(&mut v0, b"package_id", 0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_value::new<address>(b"package_id", arg0));
        0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage::add_field<0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_value::StorageValue<u32>>(&mut v0, b"version", 0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_value::new<u32>(b"version", arg0));
        0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage::add_field<0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_value::StorageValue<0xcfbc51a75cc79cb11811b5fd8bc732f85bf16ca3c524a1aa3b4583bad3d46520::dapp_metadata::DappMetadata>>(&mut v0, b"metadata", 0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_value::new<0xcfbc51a75cc79cb11811b5fd8bc732f85bf16ca3c524a1aa3b4583bad3d46520::dapp_metadata::DappMetadata>(b"metadata", arg0));
        0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage::add_field<0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_value::StorageValue<bool>>(&mut v0, b"safe_mode", 0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_value::new<bool>(b"safe_mode", arg0));
        0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage::add_field<0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_value::StorageValue<vector<address>>>(&mut v0, b"schemas", 0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_value::new<vector<address>>(b"schemas", arg0));
        Dapp{id: v0}
    }

    public(friend) fun metadata(arg0: &mut Dapp) : &mut 0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_value::StorageValue<0xcfbc51a75cc79cb11811b5fd8bc732f85bf16ca3c524a1aa3b4583bad3d46520::dapp_metadata::DappMetadata> {
        0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage::borrow_mut_field<0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_value::StorageValue<0xcfbc51a75cc79cb11811b5fd8bc732f85bf16ca3c524a1aa3b4583bad3d46520::dapp_metadata::DappMetadata>>(&mut arg0.id, b"metadata")
    }

    public(friend) fun package_id(arg0: &mut Dapp) : &mut 0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_value::StorageValue<address> {
        0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage::borrow_mut_field<0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_value::StorageValue<address>>(&mut arg0.id, b"package_id")
    }

    public(friend) fun safe_mode(arg0: &mut Dapp) : &mut 0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_value::StorageValue<bool> {
        0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage::borrow_mut_field<0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_value::StorageValue<bool>>(&mut arg0.id, b"safe_mode")
    }

    public(friend) fun schemas(arg0: &mut Dapp) : &mut 0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_value::StorageValue<vector<address>> {
        0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage::borrow_mut_field<0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_value::StorageValue<vector<address>>>(&mut arg0.id, b"schemas")
    }

    public(friend) fun upgrade<T0: drop>(arg0: &mut Dapp, arg1: &0x2::tx_context::TxContext) {
        assert!(0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_value::contains<0xcfbc51a75cc79cb11811b5fd8bc732f85bf16ca3c524a1aa3b4583bad3d46520::dapp_metadata::DappMetadata>(borrow_metadata(arg0)), 0);
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_value::get<address>(borrow_admin(arg0)) == &v0, 0);
        let v1 = package_id(arg0);
        0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_value::set<address>(v1, 0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::type_info::current_package_id<T0>());
        let v2 = version(arg0);
        0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_value::set<u32>(version(arg0), *0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_value::get<u32>(v2) + 1);
    }

    public(friend) fun version(arg0: &mut Dapp) : &mut 0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_value::StorageValue<u32> {
        0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage::borrow_mut_field<0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_value::StorageValue<u32>>(&mut arg0.id, b"version")
    }

    // decompiled from Move bytecode v6
}

