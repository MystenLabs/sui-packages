module 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::data_source {
    struct DataSource has copy, drop, store {
        emitter_chain: u64,
        emitter_address: 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::ExternalAddress,
    }

    public(friend) fun empty(arg0: &mut 0x2::object::UID) {
        0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::set::empty<DataSource>(0x2::dynamic_field::borrow_mut<vector<u8>, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::set::Set<DataSource>>(arg0, b"data_sources"));
    }

    public(friend) fun add(arg0: &mut 0x2::object::UID, arg1: DataSource) {
        assert!(!contains(arg0, arg1), 1);
        0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::set::add<DataSource>(0x2::dynamic_field::borrow_mut<vector<u8>, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::set::Set<DataSource>>(arg0, b"data_sources"), arg1);
    }

    public fun contains(arg0: &0x2::object::UID, arg1: DataSource) : bool {
        0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::set::contains<DataSource>(0x2::dynamic_field::borrow<vector<u8>, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::set::Set<DataSource>>(arg0, b"data_sources"), arg1)
    }

    public fun emitter_address(arg0: &DataSource) : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::ExternalAddress {
        arg0.emitter_address
    }

    public fun emitter_chain(arg0: &DataSource) : u64 {
        arg0.emitter_chain
    }

    public(friend) fun new(arg0: u64, arg1: 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::ExternalAddress) : DataSource {
        DataSource{
            emitter_chain   : arg0,
            emitter_address : arg1,
        }
    }

    public(friend) fun new_data_source_registry(arg0: &mut 0x2::object::UID, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(!0x2::dynamic_field::exists_<vector<u8>>(arg0, b"data_sources"), 0);
        0x2::dynamic_field::add<vector<u8>, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::set::Set<DataSource>>(arg0, b"data_sources", 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::set::new<DataSource>(arg1));
    }

    // decompiled from Move bytecode v6
}

