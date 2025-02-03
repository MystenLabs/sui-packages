module 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::set_data_sources {
    struct DataSources {
        sources: vector<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::data_source::DataSource>,
    }

    public(friend) fun execute(arg0: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::LatestOnly, arg1: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg2: vector<u8>) {
        let DataSources { sources: v0 } = from_byte_vec(arg2);
        0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::set_data_sources(arg0, arg1, v0);
    }

    fun from_byte_vec(arg0: vector<u8>) : DataSources {
        let v0 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::new<u8>(arg0);
        let v1 = 0x1::vector::empty<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::data_source::DataSource>();
        let v2 = 0;
        while (v2 < 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v0)) {
            0x1::vector::push_back<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::data_source::DataSource>(&mut v1, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::data_source::new((0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u16(&mut v0) as u64), 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::new(0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes32::from_bytes(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v0, 32)))));
            v2 = v2 + 1;
        };
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::destroy_empty<u8>(v0);
        DataSources{sources: v1}
    }

    // decompiled from Move bytecode v6
}

