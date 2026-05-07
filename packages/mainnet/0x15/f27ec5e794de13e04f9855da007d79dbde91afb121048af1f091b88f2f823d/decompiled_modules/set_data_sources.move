module 0x15f27ec5e794de13e04f9855da007d79dbde91afb121048af1f091b88f2f823d::set_data_sources {
    struct DataSources {
        sources: vector<0x15f27ec5e794de13e04f9855da007d79dbde91afb121048af1f091b88f2f823d::data_source::DataSource>,
    }

    public(friend) fun execute(arg0: &0x15f27ec5e794de13e04f9855da007d79dbde91afb121048af1f091b88f2f823d::state::LatestOnly, arg1: &mut 0x15f27ec5e794de13e04f9855da007d79dbde91afb121048af1f091b88f2f823d::state::State, arg2: vector<u8>) {
        let DataSources { sources: v0 } = from_byte_vec(arg2);
        0x15f27ec5e794de13e04f9855da007d79dbde91afb121048af1f091b88f2f823d::state::set_data_sources(arg0, arg1, v0);
    }

    fun from_byte_vec(arg0: vector<u8>) : DataSources {
        let v0 = 0x99de5c967d8206ef4b75c0afab3df2a59eb02b05c282821db803831008ac25b4::cursor::new<u8>(arg0);
        let v1 = 0x1::vector::empty<0x15f27ec5e794de13e04f9855da007d79dbde91afb121048af1f091b88f2f823d::data_source::DataSource>();
        let v2 = 0;
        while (v2 < 0x15f27ec5e794de13e04f9855da007d79dbde91afb121048af1f091b88f2f823d::deserialize::deserialize_u8(&mut v0)) {
            0x1::vector::push_back<0x15f27ec5e794de13e04f9855da007d79dbde91afb121048af1f091b88f2f823d::data_source::DataSource>(&mut v1, 0x15f27ec5e794de13e04f9855da007d79dbde91afb121048af1f091b88f2f823d::data_source::new((0x15f27ec5e794de13e04f9855da007d79dbde91afb121048af1f091b88f2f823d::deserialize::deserialize_u16(&mut v0) as u64), 0x99de5c967d8206ef4b75c0afab3df2a59eb02b05c282821db803831008ac25b4::external_address::new(0x99de5c967d8206ef4b75c0afab3df2a59eb02b05c282821db803831008ac25b4::bytes32::from_bytes(0x15f27ec5e794de13e04f9855da007d79dbde91afb121048af1f091b88f2f823d::deserialize::deserialize_vector(&mut v0, 32)))));
            v2 = v2 + 1;
        };
        0x99de5c967d8206ef4b75c0afab3df2a59eb02b05c282821db803831008ac25b4::cursor::destroy_empty<u8>(v0);
        DataSources{sources: v1}
    }

    // decompiled from Move bytecode v7
}

