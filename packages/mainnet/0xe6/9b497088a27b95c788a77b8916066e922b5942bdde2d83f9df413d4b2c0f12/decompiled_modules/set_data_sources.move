module 0xe69b497088a27b95c788a77b8916066e922b5942bdde2d83f9df413d4b2c0f12::set_data_sources {
    struct DataSources {
        sources: vector<0xe69b497088a27b95c788a77b8916066e922b5942bdde2d83f9df413d4b2c0f12::data_source::DataSource>,
    }

    public(friend) fun execute(arg0: &0xe69b497088a27b95c788a77b8916066e922b5942bdde2d83f9df413d4b2c0f12::state::LatestOnly, arg1: &mut 0xe69b497088a27b95c788a77b8916066e922b5942bdde2d83f9df413d4b2c0f12::state::State, arg2: vector<u8>) {
        let DataSources { sources: v0 } = from_byte_vec(arg2);
        0xe69b497088a27b95c788a77b8916066e922b5942bdde2d83f9df413d4b2c0f12::state::set_data_sources(arg0, arg1, v0);
    }

    fun from_byte_vec(arg0: vector<u8>) : DataSources {
        let v0 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::new<u8>(arg0);
        let v1 = 0x1::vector::empty<0xe69b497088a27b95c788a77b8916066e922b5942bdde2d83f9df413d4b2c0f12::data_source::DataSource>();
        let v2 = 0;
        while (v2 < 0xe69b497088a27b95c788a77b8916066e922b5942bdde2d83f9df413d4b2c0f12::deserialize::deserialize_u8(&mut v0)) {
            0x1::vector::push_back<0xe69b497088a27b95c788a77b8916066e922b5942bdde2d83f9df413d4b2c0f12::data_source::DataSource>(&mut v1, 0xe69b497088a27b95c788a77b8916066e922b5942bdde2d83f9df413d4b2c0f12::data_source::new((0xe69b497088a27b95c788a77b8916066e922b5942bdde2d83f9df413d4b2c0f12::deserialize::deserialize_u16(&mut v0) as u64), 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::new(0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes32::from_bytes(0xe69b497088a27b95c788a77b8916066e922b5942bdde2d83f9df413d4b2c0f12::deserialize::deserialize_vector(&mut v0, 32)))));
            v2 = v2 + 1;
        };
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::destroy_empty<u8>(v0);
        DataSources{sources: v1}
    }

    // decompiled from Move bytecode v6
}

