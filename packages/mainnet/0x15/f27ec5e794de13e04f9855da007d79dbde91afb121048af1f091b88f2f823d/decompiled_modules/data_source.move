module 0x15f27ec5e794de13e04f9855da007d79dbde91afb121048af1f091b88f2f823d::data_source {
    struct DataSource has copy, drop, store {
        emitter_chain: u64,
        emitter_address: 0x99de5c967d8206ef4b75c0afab3df2a59eb02b05c282821db803831008ac25b4::external_address::ExternalAddress,
    }

    public(friend) fun empty(arg0: &mut 0x2::object::UID) {
        0x15f27ec5e794de13e04f9855da007d79dbde91afb121048af1f091b88f2f823d::set::empty<DataSource>(0x2::dynamic_field::borrow_mut<vector<u8>, 0x15f27ec5e794de13e04f9855da007d79dbde91afb121048af1f091b88f2f823d::set::Set<DataSource>>(arg0, b"data_sources"));
    }

    public(friend) fun add(arg0: &mut 0x2::object::UID, arg1: DataSource) {
        assert!(!contains(arg0, arg1), 1);
        0x15f27ec5e794de13e04f9855da007d79dbde91afb121048af1f091b88f2f823d::set::add<DataSource>(0x2::dynamic_field::borrow_mut<vector<u8>, 0x15f27ec5e794de13e04f9855da007d79dbde91afb121048af1f091b88f2f823d::set::Set<DataSource>>(arg0, b"data_sources"), arg1);
    }

    public fun contains(arg0: &0x2::object::UID, arg1: DataSource) : bool {
        0x15f27ec5e794de13e04f9855da007d79dbde91afb121048af1f091b88f2f823d::set::contains<DataSource>(0x2::dynamic_field::borrow<vector<u8>, 0x15f27ec5e794de13e04f9855da007d79dbde91afb121048af1f091b88f2f823d::set::Set<DataSource>>(arg0, b"data_sources"), arg1)
    }

    public fun emitter_address(arg0: &DataSource) : 0x99de5c967d8206ef4b75c0afab3df2a59eb02b05c282821db803831008ac25b4::external_address::ExternalAddress {
        arg0.emitter_address
    }

    public fun emitter_chain(arg0: &DataSource) : u64 {
        arg0.emitter_chain
    }

    public(friend) fun new(arg0: u64, arg1: 0x99de5c967d8206ef4b75c0afab3df2a59eb02b05c282821db803831008ac25b4::external_address::ExternalAddress) : DataSource {
        DataSource{
            emitter_chain   : arg0,
            emitter_address : arg1,
        }
    }

    public(friend) fun new_data_source_registry(arg0: &mut 0x2::object::UID, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(!0x2::dynamic_field::exists_<vector<u8>>(arg0, b"data_sources"), 0);
        0x2::dynamic_field::add<vector<u8>, 0x15f27ec5e794de13e04f9855da007d79dbde91afb121048af1f091b88f2f823d::set::Set<DataSource>>(arg0, b"data_sources", 0x15f27ec5e794de13e04f9855da007d79dbde91afb121048af1f091b88f2f823d::set::new<DataSource>(arg1));
    }

    // decompiled from Move bytecode v7
}

