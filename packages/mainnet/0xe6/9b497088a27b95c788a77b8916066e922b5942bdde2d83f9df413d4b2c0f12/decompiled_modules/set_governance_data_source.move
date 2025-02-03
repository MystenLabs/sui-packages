module 0xe69b497088a27b95c788a77b8916066e922b5942bdde2d83f9df413d4b2c0f12::set_governance_data_source {
    struct GovernanceDataSource {
        emitter_chain_id: u64,
        emitter_address: 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::ExternalAddress,
        initial_sequence: u64,
    }

    public(friend) fun execute(arg0: &0xe69b497088a27b95c788a77b8916066e922b5942bdde2d83f9df413d4b2c0f12::state::LatestOnly, arg1: &mut 0xe69b497088a27b95c788a77b8916066e922b5942bdde2d83f9df413d4b2c0f12::state::State, arg2: vector<u8>) {
        let GovernanceDataSource {
            emitter_chain_id : v0,
            emitter_address  : v1,
            initial_sequence : v2,
        } = from_byte_vec(arg2);
        0xe69b497088a27b95c788a77b8916066e922b5942bdde2d83f9df413d4b2c0f12::state::set_governance_data_source(arg0, arg1, 0xe69b497088a27b95c788a77b8916066e922b5942bdde2d83f9df413d4b2c0f12::data_source::new(v0, v1));
        0xe69b497088a27b95c788a77b8916066e922b5942bdde2d83f9df413d4b2c0f12::state::set_last_executed_governance_sequence(arg0, arg1, v2);
    }

    fun from_byte_vec(arg0: vector<u8>) : GovernanceDataSource {
        let v0 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::new<u8>(arg0);
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::destroy_empty<u8>(v0);
        GovernanceDataSource{
            emitter_chain_id : (0xe69b497088a27b95c788a77b8916066e922b5942bdde2d83f9df413d4b2c0f12::deserialize::deserialize_u16(&mut v0) as u64),
            emitter_address  : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::new(0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes32::from_bytes(0xe69b497088a27b95c788a77b8916066e922b5942bdde2d83f9df413d4b2c0f12::deserialize::deserialize_vector(&mut v0, 32))),
            initial_sequence : 0xe69b497088a27b95c788a77b8916066e922b5942bdde2d83f9df413d4b2c0f12::deserialize::deserialize_u64(&mut v0),
        }
    }

    // decompiled from Move bytecode v6
}

