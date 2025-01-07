module 0x57805cc4f5b44fdcb78a0138dce47116410086725fd4c82edc681e3f9ce3814a::dapp_system {
    struct DappKey has drop {
        dummy_field: bool,
    }

    public(friend) fun new() : DappKey {
        DappKey{dummy_field: false}
    }

    public(friend) fun create(arg0: 0x1::ascii::String, arg1: 0x1::ascii::String, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x57805cc4f5b44fdcb78a0138dce47116410086725fd4c82edc681e3f9ce3814a::dapp_schema::Dapp {
        let v0 = 0x57805cc4f5b44fdcb78a0138dce47116410086725fd4c82edc681e3f9ce3814a::dapp_schema::create(arg3);
        assert!(!0x1ec50128fe12af3bec330f7be7297e01386701d803b6616e01dcd396bdac240c::storage_value::contains<0x57805cc4f5b44fdcb78a0138dce47116410086725fd4c82edc681e3f9ce3814a::dapp_metadata::DappMetadata>(0x57805cc4f5b44fdcb78a0138dce47116410086725fd4c82edc681e3f9ce3814a::dapp_schema::borrow_metadata(&v0)), 0);
        0x1ec50128fe12af3bec330f7be7297e01386701d803b6616e01dcd396bdac240c::storage_value::set<0x57805cc4f5b44fdcb78a0138dce47116410086725fd4c82edc681e3f9ce3814a::dapp_metadata::DappMetadata>(0x57805cc4f5b44fdcb78a0138dce47116410086725fd4c82edc681e3f9ce3814a::dapp_schema::borrow_mut_metadata(&mut v0), 0x57805cc4f5b44fdcb78a0138dce47116410086725fd4c82edc681e3f9ce3814a::dapp_metadata::new(arg0, arg1, 0x1::ascii::string(b""), 0x1::ascii::string(b""), 0x2::clock::timestamp_ms(arg2), 0x1::vector::empty<0x1::ascii::String>()));
        0x1ec50128fe12af3bec330f7be7297e01386701d803b6616e01dcd396bdac240c::storage_value::set<address>(0x57805cc4f5b44fdcb78a0138dce47116410086725fd4c82edc681e3f9ce3814a::dapp_schema::borrow_mut_package_id(&mut v0), 0x1ec50128fe12af3bec330f7be7297e01386701d803b6616e01dcd396bdac240c::type_info::current_package_id<DappKey>());
        0x1ec50128fe12af3bec330f7be7297e01386701d803b6616e01dcd396bdac240c::storage_value::set<address>(0x57805cc4f5b44fdcb78a0138dce47116410086725fd4c82edc681e3f9ce3814a::dapp_schema::borrow_mut_admin(&mut v0), 0x2::tx_context::sender(arg3));
        0x1ec50128fe12af3bec330f7be7297e01386701d803b6616e01dcd396bdac240c::storage_value::set<u32>(0x57805cc4f5b44fdcb78a0138dce47116410086725fd4c82edc681e3f9ce3814a::dapp_schema::borrow_mut_version(&mut v0), 1);
        0x1ec50128fe12af3bec330f7be7297e01386701d803b6616e01dcd396bdac240c::storage_value::set<bool>(0x57805cc4f5b44fdcb78a0138dce47116410086725fd4c82edc681e3f9ce3814a::dapp_schema::borrow_mut_safe_mode(&mut v0), false);
        0x1ec50128fe12af3bec330f7be7297e01386701d803b6616e01dcd396bdac240c::storage_value::set<vector<address>>(0x57805cc4f5b44fdcb78a0138dce47116410086725fd4c82edc681e3f9ce3814a::dapp_schema::borrow_mut_schemas(&mut v0), vector[]);
        v0
    }

    public fun ensure_has_authority(arg0: &0x57805cc4f5b44fdcb78a0138dce47116410086725fd4c82edc681e3f9ce3814a::dapp_schema::Dapp, arg1: &0x2::tx_context::TxContext) {
        assert!(0x1ec50128fe12af3bec330f7be7297e01386701d803b6616e01dcd396bdac240c::storage_value::get<address>(0x57805cc4f5b44fdcb78a0138dce47116410086725fd4c82edc681e3f9ce3814a::dapp_schema::borrow_admin(arg0)) == 0x2::tx_context::sender(arg1), 0);
    }

    public fun ensure_has_schema<T0: store + key>(arg0: &0x57805cc4f5b44fdcb78a0138dce47116410086725fd4c82edc681e3f9ce3814a::dapp_schema::Dapp, arg1: &T0) {
        let v0 = 0x2::object::id_address<T0>(arg1);
        let v1 = 0x1ec50128fe12af3bec330f7be7297e01386701d803b6616e01dcd396bdac240c::storage_value::get<vector<address>>(0x57805cc4f5b44fdcb78a0138dce47116410086725fd4c82edc681e3f9ce3814a::dapp_schema::borrow_schemas(arg0));
        assert!(0x1::vector::contains<address>(&v1, &v0), 0);
    }

    public fun ensure_no_safe_mode(arg0: &0x57805cc4f5b44fdcb78a0138dce47116410086725fd4c82edc681e3f9ce3814a::dapp_schema::Dapp) {
        assert!(!0x1ec50128fe12af3bec330f7be7297e01386701d803b6616e01dcd396bdac240c::storage_value::get<bool>(0x57805cc4f5b44fdcb78a0138dce47116410086725fd4c82edc681e3f9ce3814a::dapp_schema::borrow_safe_mode(arg0)), 0);
    }

    public entry fun set_metadata(arg0: &mut 0x57805cc4f5b44fdcb78a0138dce47116410086725fd4c82edc681e3f9ce3814a::dapp_schema::Dapp, arg1: 0x1::ascii::String, arg2: 0x1::ascii::String, arg3: 0x1::ascii::String, arg4: 0x1::ascii::String, arg5: vector<0x1::ascii::String>, arg6: &0x2::tx_context::TxContext) {
        assert!(0x1ec50128fe12af3bec330f7be7297e01386701d803b6616e01dcd396bdac240c::storage_value::contains<address>(0x57805cc4f5b44fdcb78a0138dce47116410086725fd4c82edc681e3f9ce3814a::dapp_schema::borrow_admin(arg0)), 0);
        assert!(0x1ec50128fe12af3bec330f7be7297e01386701d803b6616e01dcd396bdac240c::storage_value::get<address>(0x57805cc4f5b44fdcb78a0138dce47116410086725fd4c82edc681e3f9ce3814a::dapp_schema::borrow_admin(arg0)) == 0x2::tx_context::sender(arg6), 0);
        0x1ec50128fe12af3bec330f7be7297e01386701d803b6616e01dcd396bdac240c::storage_value::set<0x57805cc4f5b44fdcb78a0138dce47116410086725fd4c82edc681e3f9ce3814a::dapp_metadata::DappMetadata>(0x57805cc4f5b44fdcb78a0138dce47116410086725fd4c82edc681e3f9ce3814a::dapp_schema::borrow_mut_metadata(arg0), 0x57805cc4f5b44fdcb78a0138dce47116410086725fd4c82edc681e3f9ce3814a::dapp_metadata::new(arg1, arg2, arg3, arg4, 0x57805cc4f5b44fdcb78a0138dce47116410086725fd4c82edc681e3f9ce3814a::dapp_metadata::get_created_at(0x1ec50128fe12af3bec330f7be7297e01386701d803b6616e01dcd396bdac240c::storage_value::take<0x57805cc4f5b44fdcb78a0138dce47116410086725fd4c82edc681e3f9ce3814a::dapp_metadata::DappMetadata>(0x57805cc4f5b44fdcb78a0138dce47116410086725fd4c82edc681e3f9ce3814a::dapp_schema::borrow_mut_metadata(arg0))), arg5));
    }

    public entry fun set_safe_mode(arg0: &mut 0x57805cc4f5b44fdcb78a0138dce47116410086725fd4c82edc681e3f9ce3814a::dapp_schema::Dapp, arg1: bool, arg2: &0x2::tx_context::TxContext) {
        assert!(0x1ec50128fe12af3bec330f7be7297e01386701d803b6616e01dcd396bdac240c::storage_value::contains<address>(0x57805cc4f5b44fdcb78a0138dce47116410086725fd4c82edc681e3f9ce3814a::dapp_schema::borrow_admin(arg0)), 0);
        assert!(0x1ec50128fe12af3bec330f7be7297e01386701d803b6616e01dcd396bdac240c::storage_value::get<address>(0x57805cc4f5b44fdcb78a0138dce47116410086725fd4c82edc681e3f9ce3814a::dapp_schema::borrow_admin(arg0)) == 0x2::tx_context::sender(arg2), 0);
        0x1ec50128fe12af3bec330f7be7297e01386701d803b6616e01dcd396bdac240c::storage_value::set<bool>(0x57805cc4f5b44fdcb78a0138dce47116410086725fd4c82edc681e3f9ce3814a::dapp_schema::borrow_mut_safe_mode(arg0), arg1);
    }

    public entry fun transfer_ownership(arg0: &mut 0x57805cc4f5b44fdcb78a0138dce47116410086725fd4c82edc681e3f9ce3814a::dapp_schema::Dapp, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x1ec50128fe12af3bec330f7be7297e01386701d803b6616e01dcd396bdac240c::storage_value::contains<address>(0x57805cc4f5b44fdcb78a0138dce47116410086725fd4c82edc681e3f9ce3814a::dapp_schema::borrow_admin(arg0)), 0);
        assert!(0x1ec50128fe12af3bec330f7be7297e01386701d803b6616e01dcd396bdac240c::storage_value::get<address>(0x57805cc4f5b44fdcb78a0138dce47116410086725fd4c82edc681e3f9ce3814a::dapp_schema::borrow_admin(arg0)) == 0x2::tx_context::sender(arg2), 0);
        0x1ec50128fe12af3bec330f7be7297e01386701d803b6616e01dcd396bdac240c::storage_value::set<address>(0x57805cc4f5b44fdcb78a0138dce47116410086725fd4c82edc681e3f9ce3814a::dapp_schema::borrow_mut_admin(arg0), arg1);
    }

    // decompiled from Move bytecode v6
}

