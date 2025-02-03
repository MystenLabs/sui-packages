module 0x3fbdad435cdb4210427bc3993b80459b8b0e3c0ec0f9caa9302b4e719391314::set_governance_data_source {
    struct GovernanceDataSource {
        emitter_chain_id: u64,
        emitter_address: 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::ExternalAddress,
        initial_sequence: u64,
    }

    public(friend) fun execute(arg0: &0x3fbdad435cdb4210427bc3993b80459b8b0e3c0ec0f9caa9302b4e719391314::state::LatestOnly, arg1: &mut 0x3fbdad435cdb4210427bc3993b80459b8b0e3c0ec0f9caa9302b4e719391314::state::State, arg2: vector<u8>) {
        let GovernanceDataSource {
            emitter_chain_id : v0,
            emitter_address  : v1,
            initial_sequence : v2,
        } = from_byte_vec(arg2);
        0x3fbdad435cdb4210427bc3993b80459b8b0e3c0ec0f9caa9302b4e719391314::state::set_governance_data_source(arg0, arg1, 0x3fbdad435cdb4210427bc3993b80459b8b0e3c0ec0f9caa9302b4e719391314::data_source::new(v0, v1));
        0x3fbdad435cdb4210427bc3993b80459b8b0e3c0ec0f9caa9302b4e719391314::state::set_last_executed_governance_sequence(arg0, arg1, v2);
    }

    fun from_byte_vec(arg0: vector<u8>) : GovernanceDataSource {
        let v0 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::new<u8>(arg0);
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::destroy_empty<u8>(v0);
        GovernanceDataSource{
            emitter_chain_id : (0x3fbdad435cdb4210427bc3993b80459b8b0e3c0ec0f9caa9302b4e719391314::deserialize::deserialize_u16(&mut v0) as u64),
            emitter_address  : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::new(0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes32::from_bytes(0x3fbdad435cdb4210427bc3993b80459b8b0e3c0ec0f9caa9302b4e719391314::deserialize::deserialize_vector(&mut v0, 32))),
            initial_sequence : 0x3fbdad435cdb4210427bc3993b80459b8b0e3c0ec0f9caa9302b4e719391314::deserialize::deserialize_u64(&mut v0),
        }
    }

    // decompiled from Move bytecode v6
}

