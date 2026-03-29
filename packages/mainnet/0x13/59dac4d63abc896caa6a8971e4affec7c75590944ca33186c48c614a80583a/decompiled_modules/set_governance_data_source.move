module 0x1359dac4d63abc896caa6a8971e4affec7c75590944ca33186c48c614a80583a::set_governance_data_source {
    struct GovernanceDataSource {
        emitter_chain_id: u64,
        emitter_address: 0x913c5b4adfe7d198b085e1f8d2682c9ae08e9673bcd4bcbd023a9f9ad62cf665::external_address::ExternalAddress,
        initial_sequence: u64,
    }

    public(friend) fun execute(arg0: &0x1359dac4d63abc896caa6a8971e4affec7c75590944ca33186c48c614a80583a::state::LatestOnly, arg1: &mut 0x1359dac4d63abc896caa6a8971e4affec7c75590944ca33186c48c614a80583a::state::State, arg2: vector<u8>) {
        let GovernanceDataSource {
            emitter_chain_id : v0,
            emitter_address  : v1,
            initial_sequence : v2,
        } = from_byte_vec(arg2);
        0x1359dac4d63abc896caa6a8971e4affec7c75590944ca33186c48c614a80583a::state::set_governance_data_source(arg0, arg1, 0x1359dac4d63abc896caa6a8971e4affec7c75590944ca33186c48c614a80583a::data_source::new(v0, v1));
        0x1359dac4d63abc896caa6a8971e4affec7c75590944ca33186c48c614a80583a::state::set_last_executed_governance_sequence(arg0, arg1, v2);
    }

    fun from_byte_vec(arg0: vector<u8>) : GovernanceDataSource {
        let v0 = 0x913c5b4adfe7d198b085e1f8d2682c9ae08e9673bcd4bcbd023a9f9ad62cf665::cursor::new<u8>(arg0);
        0x913c5b4adfe7d198b085e1f8d2682c9ae08e9673bcd4bcbd023a9f9ad62cf665::cursor::destroy_empty<u8>(v0);
        GovernanceDataSource{
            emitter_chain_id : (0x1359dac4d63abc896caa6a8971e4affec7c75590944ca33186c48c614a80583a::deserialize::deserialize_u16(&mut v0) as u64),
            emitter_address  : 0x913c5b4adfe7d198b085e1f8d2682c9ae08e9673bcd4bcbd023a9f9ad62cf665::external_address::new(0x913c5b4adfe7d198b085e1f8d2682c9ae08e9673bcd4bcbd023a9f9ad62cf665::bytes32::from_bytes(0x1359dac4d63abc896caa6a8971e4affec7c75590944ca33186c48c614a80583a::deserialize::deserialize_vector(&mut v0, 32))),
            initial_sequence : 0x1359dac4d63abc896caa6a8971e4affec7c75590944ca33186c48c614a80583a::deserialize::deserialize_u64(&mut v0),
        }
    }

    // decompiled from Move bytecode v6
}

