module 0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::tagged_output {
    struct TaggedOutput has drop {
        tag: vector<u8>,
        named_payload: 0x2::vec_map::VecMap<vector<u8>, 0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::data::NexusData>,
    }

    public fun from_parts(arg0: vector<u8>, arg1: 0x2::vec_map::VecMap<vector<u8>, 0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::data::NexusData>) : TaggedOutput {
        TaggedOutput{
            tag           : arg0,
            named_payload : arg1,
        }
    }

    public fun into_parts(arg0: TaggedOutput) : (vector<u8>, 0x2::vec_map::VecMap<vector<u8>, 0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::data::NexusData>) {
        let TaggedOutput {
            tag           : v0,
            named_payload : v1,
        } = arg0;
        (v0, v1)
    }

    public fun named_payload(arg0: &TaggedOutput) : &0x2::vec_map::VecMap<vector<u8>, 0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::data::NexusData> {
        &arg0.named_payload
    }

    public fun new(arg0: vector<u8>) : TaggedOutput {
        TaggedOutput{
            tag           : arg0,
            named_payload : 0x2::vec_map::empty<vector<u8>, 0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::data::NexusData>(),
        }
    }

    public fun tag(arg0: &TaggedOutput) : &vector<u8> {
        &arg0.tag
    }

    public fun with_named_payload(arg0: TaggedOutput, arg1: vector<u8>, arg2: 0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::data::NexusValue) : TaggedOutput {
        0x2::vec_map::insert<vector<u8>, 0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::data::NexusData>(&mut arg0.named_payload, arg1, 0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::data::one(arg2));
        arg0
    }

    public fun with_named_payload_many(arg0: TaggedOutput, arg1: vector<u8>, arg2: vector<0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::data::NexusValue>) : TaggedOutput {
        0x2::vec_map::insert<vector<u8>, 0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::data::NexusData>(&mut arg0.named_payload, arg1, 0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::data::many(arg2));
        arg0
    }

    // decompiled from Move bytecode v7
}

