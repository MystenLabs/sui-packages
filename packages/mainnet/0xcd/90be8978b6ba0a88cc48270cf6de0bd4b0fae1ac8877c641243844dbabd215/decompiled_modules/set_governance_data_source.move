module 0xcd90be8978b6ba0a88cc48270cf6de0bd4b0fae1ac8877c641243844dbabd215::set_governance_data_source {
    struct GovernanceDataSource {
        emitter_chain_id: u64,
        emitter_address: 0x87b72ec8f76c43e24dc06f534ab3e0e7e2339e0e6f35294b18316e42662027d8::external_address::ExternalAddress,
        initial_sequence: u64,
    }

    public(friend) fun execute(arg0: &0xcd90be8978b6ba0a88cc48270cf6de0bd4b0fae1ac8877c641243844dbabd215::state::LatestOnly, arg1: &mut 0xcd90be8978b6ba0a88cc48270cf6de0bd4b0fae1ac8877c641243844dbabd215::state::State, arg2: vector<u8>) {
        let GovernanceDataSource {
            emitter_chain_id : v0,
            emitter_address  : v1,
            initial_sequence : v2,
        } = from_byte_vec(arg2);
        0xcd90be8978b6ba0a88cc48270cf6de0bd4b0fae1ac8877c641243844dbabd215::state::set_governance_data_source(arg0, arg1, 0xcd90be8978b6ba0a88cc48270cf6de0bd4b0fae1ac8877c641243844dbabd215::data_source::new(v0, v1));
        0xcd90be8978b6ba0a88cc48270cf6de0bd4b0fae1ac8877c641243844dbabd215::state::set_last_executed_governance_sequence(arg0, arg1, v2);
    }

    fun from_byte_vec(arg0: vector<u8>) : GovernanceDataSource {
        let v0 = 0x87b72ec8f76c43e24dc06f534ab3e0e7e2339e0e6f35294b18316e42662027d8::cursor::new<u8>(arg0);
        0x87b72ec8f76c43e24dc06f534ab3e0e7e2339e0e6f35294b18316e42662027d8::cursor::destroy_empty<u8>(v0);
        GovernanceDataSource{
            emitter_chain_id : (0xcd90be8978b6ba0a88cc48270cf6de0bd4b0fae1ac8877c641243844dbabd215::deserialize::deserialize_u16(&mut v0) as u64),
            emitter_address  : 0x87b72ec8f76c43e24dc06f534ab3e0e7e2339e0e6f35294b18316e42662027d8::external_address::new(0x87b72ec8f76c43e24dc06f534ab3e0e7e2339e0e6f35294b18316e42662027d8::bytes32::from_bytes(0xcd90be8978b6ba0a88cc48270cf6de0bd4b0fae1ac8877c641243844dbabd215::deserialize::deserialize_vector(&mut v0, 32))),
            initial_sequence : 0xcd90be8978b6ba0a88cc48270cf6de0bd4b0fae1ac8877c641243844dbabd215::deserialize::deserialize_u64(&mut v0),
        }
    }

    // decompiled from Move bytecode v6
}

