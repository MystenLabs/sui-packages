module 0x7065c17a097025d2d3b60602c735b9b4e3e1b1e4ca81661be3f5e7097d3fde41::dapp_schema {
    struct Dapp has store, key {
        id: 0x2::object::UID,
    }

    public(friend) fun add_schema<T0: store + key>(arg0: &mut Dapp, arg1: T0, arg2: &0x2::tx_context::TxContext) {
        assert!(0x1ec50128fe12af3bec330f7be7297e01386701d803b6616e01dcd396bdac240c::storage_value::contains<0x7065c17a097025d2d3b60602c735b9b4e3e1b1e4ca81661be3f5e7097d3fde41::dapp_metadata::DappMetadata>(borrow_metadata(arg0)), 0);
        assert!(0x1ec50128fe12af3bec330f7be7297e01386701d803b6616e01dcd396bdac240c::storage_value::get<address>(borrow_admin(arg0)) == 0x2::tx_context::sender(arg2), 0);
        0x1::vector::push_back<address>(0x1ec50128fe12af3bec330f7be7297e01386701d803b6616e01dcd396bdac240c::storage_value::borrow_mut<vector<address>>(borrow_mut_schemas(arg0)), 0x2::object::id_address<T0>(&arg1));
        0x2::transfer::public_share_object<T0>(arg1);
    }

    public fun borrow_admin(arg0: &Dapp) : &0x1ec50128fe12af3bec330f7be7297e01386701d803b6616e01dcd396bdac240c::storage_value::StorageValue<address> {
        0x1ec50128fe12af3bec330f7be7297e01386701d803b6616e01dcd396bdac240c::storage_migration::borrow_field<0x1ec50128fe12af3bec330f7be7297e01386701d803b6616e01dcd396bdac240c::storage_value::StorageValue<address>>(&arg0.id, b"admin")
    }

    public fun borrow_metadata(arg0: &Dapp) : &0x1ec50128fe12af3bec330f7be7297e01386701d803b6616e01dcd396bdac240c::storage_value::StorageValue<0x7065c17a097025d2d3b60602c735b9b4e3e1b1e4ca81661be3f5e7097d3fde41::dapp_metadata::DappMetadata> {
        0x1ec50128fe12af3bec330f7be7297e01386701d803b6616e01dcd396bdac240c::storage_migration::borrow_field<0x1ec50128fe12af3bec330f7be7297e01386701d803b6616e01dcd396bdac240c::storage_value::StorageValue<0x7065c17a097025d2d3b60602c735b9b4e3e1b1e4ca81661be3f5e7097d3fde41::dapp_metadata::DappMetadata>>(&arg0.id, b"metadata")
    }

    public(friend) fun borrow_mut_admin(arg0: &mut Dapp) : &mut 0x1ec50128fe12af3bec330f7be7297e01386701d803b6616e01dcd396bdac240c::storage_value::StorageValue<address> {
        0x1ec50128fe12af3bec330f7be7297e01386701d803b6616e01dcd396bdac240c::storage_migration::borrow_mut_field<0x1ec50128fe12af3bec330f7be7297e01386701d803b6616e01dcd396bdac240c::storage_value::StorageValue<address>>(&mut arg0.id, b"admin")
    }

    public(friend) fun borrow_mut_metadata(arg0: &mut Dapp) : &mut 0x1ec50128fe12af3bec330f7be7297e01386701d803b6616e01dcd396bdac240c::storage_value::StorageValue<0x7065c17a097025d2d3b60602c735b9b4e3e1b1e4ca81661be3f5e7097d3fde41::dapp_metadata::DappMetadata> {
        0x1ec50128fe12af3bec330f7be7297e01386701d803b6616e01dcd396bdac240c::storage_migration::borrow_mut_field<0x1ec50128fe12af3bec330f7be7297e01386701d803b6616e01dcd396bdac240c::storage_value::StorageValue<0x7065c17a097025d2d3b60602c735b9b4e3e1b1e4ca81661be3f5e7097d3fde41::dapp_metadata::DappMetadata>>(&mut arg0.id, b"metadata")
    }

    public(friend) fun borrow_mut_package_id(arg0: &mut Dapp) : &mut 0x1ec50128fe12af3bec330f7be7297e01386701d803b6616e01dcd396bdac240c::storage_value::StorageValue<address> {
        0x1ec50128fe12af3bec330f7be7297e01386701d803b6616e01dcd396bdac240c::storage_migration::borrow_mut_field<0x1ec50128fe12af3bec330f7be7297e01386701d803b6616e01dcd396bdac240c::storage_value::StorageValue<address>>(&mut arg0.id, b"package_id")
    }

    public(friend) fun borrow_mut_safe_mode(arg0: &mut Dapp) : &mut 0x1ec50128fe12af3bec330f7be7297e01386701d803b6616e01dcd396bdac240c::storage_value::StorageValue<bool> {
        0x1ec50128fe12af3bec330f7be7297e01386701d803b6616e01dcd396bdac240c::storage_migration::borrow_mut_field<0x1ec50128fe12af3bec330f7be7297e01386701d803b6616e01dcd396bdac240c::storage_value::StorageValue<bool>>(&mut arg0.id, b"safe_mode")
    }

    public(friend) fun borrow_mut_schemas(arg0: &mut Dapp) : &mut 0x1ec50128fe12af3bec330f7be7297e01386701d803b6616e01dcd396bdac240c::storage_value::StorageValue<vector<address>> {
        0x1ec50128fe12af3bec330f7be7297e01386701d803b6616e01dcd396bdac240c::storage_migration::borrow_mut_field<0x1ec50128fe12af3bec330f7be7297e01386701d803b6616e01dcd396bdac240c::storage_value::StorageValue<vector<address>>>(&mut arg0.id, b"schemas")
    }

    public(friend) fun borrow_mut_version(arg0: &mut Dapp) : &mut 0x1ec50128fe12af3bec330f7be7297e01386701d803b6616e01dcd396bdac240c::storage_value::StorageValue<u32> {
        0x1ec50128fe12af3bec330f7be7297e01386701d803b6616e01dcd396bdac240c::storage_migration::borrow_mut_field<0x1ec50128fe12af3bec330f7be7297e01386701d803b6616e01dcd396bdac240c::storage_value::StorageValue<u32>>(&mut arg0.id, b"version")
    }

    public fun borrow_package_id(arg0: &Dapp) : &0x1ec50128fe12af3bec330f7be7297e01386701d803b6616e01dcd396bdac240c::storage_value::StorageValue<address> {
        0x1ec50128fe12af3bec330f7be7297e01386701d803b6616e01dcd396bdac240c::storage_migration::borrow_field<0x1ec50128fe12af3bec330f7be7297e01386701d803b6616e01dcd396bdac240c::storage_value::StorageValue<address>>(&arg0.id, b"package_id")
    }

    public fun borrow_safe_mode(arg0: &Dapp) : &0x1ec50128fe12af3bec330f7be7297e01386701d803b6616e01dcd396bdac240c::storage_value::StorageValue<bool> {
        0x1ec50128fe12af3bec330f7be7297e01386701d803b6616e01dcd396bdac240c::storage_migration::borrow_field<0x1ec50128fe12af3bec330f7be7297e01386701d803b6616e01dcd396bdac240c::storage_value::StorageValue<bool>>(&arg0.id, b"safe_mode")
    }

    public fun borrow_schemas(arg0: &Dapp) : &0x1ec50128fe12af3bec330f7be7297e01386701d803b6616e01dcd396bdac240c::storage_value::StorageValue<vector<address>> {
        0x1ec50128fe12af3bec330f7be7297e01386701d803b6616e01dcd396bdac240c::storage_migration::borrow_field<0x1ec50128fe12af3bec330f7be7297e01386701d803b6616e01dcd396bdac240c::storage_value::StorageValue<vector<address>>>(&arg0.id, b"schemas")
    }

    public fun borrow_version(arg0: &Dapp) : &0x1ec50128fe12af3bec330f7be7297e01386701d803b6616e01dcd396bdac240c::storage_value::StorageValue<u32> {
        0x1ec50128fe12af3bec330f7be7297e01386701d803b6616e01dcd396bdac240c::storage_migration::borrow_field<0x1ec50128fe12af3bec330f7be7297e01386701d803b6616e01dcd396bdac240c::storage_value::StorageValue<u32>>(&arg0.id, b"version")
    }

    public(friend) fun create(arg0: &mut 0x2::tx_context::TxContext) : Dapp {
        let v0 = 0x2::object::new(arg0);
        0x1ec50128fe12af3bec330f7be7297e01386701d803b6616e01dcd396bdac240c::storage_migration::add_field<0x1ec50128fe12af3bec330f7be7297e01386701d803b6616e01dcd396bdac240c::storage_value::StorageValue<address>>(&mut v0, b"admin", 0x1ec50128fe12af3bec330f7be7297e01386701d803b6616e01dcd396bdac240c::storage_value::new<address>());
        0x1ec50128fe12af3bec330f7be7297e01386701d803b6616e01dcd396bdac240c::storage_migration::add_field<0x1ec50128fe12af3bec330f7be7297e01386701d803b6616e01dcd396bdac240c::storage_value::StorageValue<address>>(&mut v0, b"package_id", 0x1ec50128fe12af3bec330f7be7297e01386701d803b6616e01dcd396bdac240c::storage_value::new<address>());
        0x1ec50128fe12af3bec330f7be7297e01386701d803b6616e01dcd396bdac240c::storage_migration::add_field<0x1ec50128fe12af3bec330f7be7297e01386701d803b6616e01dcd396bdac240c::storage_value::StorageValue<u32>>(&mut v0, b"version", 0x1ec50128fe12af3bec330f7be7297e01386701d803b6616e01dcd396bdac240c::storage_value::new<u32>());
        0x1ec50128fe12af3bec330f7be7297e01386701d803b6616e01dcd396bdac240c::storage_migration::add_field<0x1ec50128fe12af3bec330f7be7297e01386701d803b6616e01dcd396bdac240c::storage_value::StorageValue<0x7065c17a097025d2d3b60602c735b9b4e3e1b1e4ca81661be3f5e7097d3fde41::dapp_metadata::DappMetadata>>(&mut v0, b"metadata", 0x1ec50128fe12af3bec330f7be7297e01386701d803b6616e01dcd396bdac240c::storage_value::new<0x7065c17a097025d2d3b60602c735b9b4e3e1b1e4ca81661be3f5e7097d3fde41::dapp_metadata::DappMetadata>());
        0x1ec50128fe12af3bec330f7be7297e01386701d803b6616e01dcd396bdac240c::storage_migration::add_field<0x1ec50128fe12af3bec330f7be7297e01386701d803b6616e01dcd396bdac240c::storage_value::StorageValue<vector<address>>>(&mut v0, b"schemas", 0x1ec50128fe12af3bec330f7be7297e01386701d803b6616e01dcd396bdac240c::storage_value::new<vector<address>>());
        0x1ec50128fe12af3bec330f7be7297e01386701d803b6616e01dcd396bdac240c::storage_migration::add_field<0x1ec50128fe12af3bec330f7be7297e01386701d803b6616e01dcd396bdac240c::storage_value::StorageValue<bool>>(&mut v0, b"safe_mode", 0x1ec50128fe12af3bec330f7be7297e01386701d803b6616e01dcd396bdac240c::storage_value::new<bool>());
        Dapp{id: v0}
    }

    public(friend) fun upgrade<T0: drop>(arg0: &mut Dapp, arg1: &0x2::tx_context::TxContext) {
        assert!(0x1ec50128fe12af3bec330f7be7297e01386701d803b6616e01dcd396bdac240c::storage_value::contains<0x7065c17a097025d2d3b60602c735b9b4e3e1b1e4ca81661be3f5e7097d3fde41::dapp_metadata::DappMetadata>(borrow_metadata(arg0)), 0);
        assert!(0x1ec50128fe12af3bec330f7be7297e01386701d803b6616e01dcd396bdac240c::storage_value::get<address>(borrow_admin(arg0)) == 0x2::tx_context::sender(arg1), 0);
        let v0 = borrow_mut_package_id(arg0);
        0x1ec50128fe12af3bec330f7be7297e01386701d803b6616e01dcd396bdac240c::storage_value::set<address>(v0, 0x1ec50128fe12af3bec330f7be7297e01386701d803b6616e01dcd396bdac240c::type_info::current_package_id<T0>());
        let v1 = 0x1ec50128fe12af3bec330f7be7297e01386701d803b6616e01dcd396bdac240c::storage_value::borrow_mut<u32>(borrow_mut_version(arg0));
        *v1 = *v1 + 1;
    }

    // decompiled from Move bytecode v6
}

