module 0x1359dac4d63abc896caa6a8971e4affec7c75590944ca33186c48c614a80583a::set_data_sources {
    struct DataSources {
        sources: vector<0x1359dac4d63abc896caa6a8971e4affec7c75590944ca33186c48c614a80583a::data_source::DataSource>,
    }

    public(friend) fun execute(arg0: &0x1359dac4d63abc896caa6a8971e4affec7c75590944ca33186c48c614a80583a::state::LatestOnly, arg1: &mut 0x1359dac4d63abc896caa6a8971e4affec7c75590944ca33186c48c614a80583a::state::State, arg2: vector<u8>) {
        let DataSources { sources: v0 } = from_byte_vec(arg2);
        0x1359dac4d63abc896caa6a8971e4affec7c75590944ca33186c48c614a80583a::state::set_data_sources(arg0, arg1, v0);
    }

    fun from_byte_vec(arg0: vector<u8>) : DataSources {
        let v0 = 0x913c5b4adfe7d198b085e1f8d2682c9ae08e9673bcd4bcbd023a9f9ad62cf665::cursor::new<u8>(arg0);
        let v1 = 0x1::vector::empty<0x1359dac4d63abc896caa6a8971e4affec7c75590944ca33186c48c614a80583a::data_source::DataSource>();
        let v2 = 0;
        while (v2 < 0x1359dac4d63abc896caa6a8971e4affec7c75590944ca33186c48c614a80583a::deserialize::deserialize_u8(&mut v0)) {
            0x1::vector::push_back<0x1359dac4d63abc896caa6a8971e4affec7c75590944ca33186c48c614a80583a::data_source::DataSource>(&mut v1, 0x1359dac4d63abc896caa6a8971e4affec7c75590944ca33186c48c614a80583a::data_source::new((0x1359dac4d63abc896caa6a8971e4affec7c75590944ca33186c48c614a80583a::deserialize::deserialize_u16(&mut v0) as u64), 0x913c5b4adfe7d198b085e1f8d2682c9ae08e9673bcd4bcbd023a9f9ad62cf665::external_address::new(0x913c5b4adfe7d198b085e1f8d2682c9ae08e9673bcd4bcbd023a9f9ad62cf665::bytes32::from_bytes(0x1359dac4d63abc896caa6a8971e4affec7c75590944ca33186c48c614a80583a::deserialize::deserialize_vector(&mut v0, 32)))));
            v2 = v2 + 1;
        };
        0x913c5b4adfe7d198b085e1f8d2682c9ae08e9673bcd4bcbd023a9f9ad62cf665::cursor::destroy_empty<u8>(v0);
        DataSources{sources: v1}
    }

    // decompiled from Move bytecode v6
}

