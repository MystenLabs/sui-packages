module 0x15f27ec5e794de13e04f9855da007d79dbde91afb121048af1f091b88f2f823d::set_governance_data_source {
    struct GovernanceDataSource {
        emitter_chain_id: u64,
        emitter_address: 0x99de5c967d8206ef4b75c0afab3df2a59eb02b05c282821db803831008ac25b4::external_address::ExternalAddress,
        initial_sequence: u64,
    }

    public(friend) fun execute(arg0: &0x15f27ec5e794de13e04f9855da007d79dbde91afb121048af1f091b88f2f823d::state::LatestOnly, arg1: &mut 0x15f27ec5e794de13e04f9855da007d79dbde91afb121048af1f091b88f2f823d::state::State, arg2: vector<u8>) {
        let GovernanceDataSource {
            emitter_chain_id : v0,
            emitter_address  : v1,
            initial_sequence : v2,
        } = from_byte_vec(arg2);
        0x15f27ec5e794de13e04f9855da007d79dbde91afb121048af1f091b88f2f823d::state::set_governance_data_source(arg0, arg1, 0x15f27ec5e794de13e04f9855da007d79dbde91afb121048af1f091b88f2f823d::data_source::new(v0, v1));
        0x15f27ec5e794de13e04f9855da007d79dbde91afb121048af1f091b88f2f823d::state::set_last_executed_governance_sequence(arg0, arg1, v2);
    }

    fun from_byte_vec(arg0: vector<u8>) : GovernanceDataSource {
        let v0 = 0x99de5c967d8206ef4b75c0afab3df2a59eb02b05c282821db803831008ac25b4::cursor::new<u8>(arg0);
        0x99de5c967d8206ef4b75c0afab3df2a59eb02b05c282821db803831008ac25b4::cursor::destroy_empty<u8>(v0);
        GovernanceDataSource{
            emitter_chain_id : (0x15f27ec5e794de13e04f9855da007d79dbde91afb121048af1f091b88f2f823d::deserialize::deserialize_u16(&mut v0) as u64),
            emitter_address  : 0x99de5c967d8206ef4b75c0afab3df2a59eb02b05c282821db803831008ac25b4::external_address::new(0x99de5c967d8206ef4b75c0afab3df2a59eb02b05c282821db803831008ac25b4::bytes32::from_bytes(0x15f27ec5e794de13e04f9855da007d79dbde91afb121048af1f091b88f2f823d::deserialize::deserialize_vector(&mut v0, 32))),
            initial_sequence : 0x15f27ec5e794de13e04f9855da007d79dbde91afb121048af1f091b88f2f823d::deserialize::deserialize_u64(&mut v0),
        }
    }

    // decompiled from Move bytecode v7
}

