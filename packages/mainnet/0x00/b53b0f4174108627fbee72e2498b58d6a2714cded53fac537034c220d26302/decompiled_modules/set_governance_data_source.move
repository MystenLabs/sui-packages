module 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::set_governance_data_source {
    struct GovernanceDataSource {
        emitter_chain_id: u64,
        emitter_address: 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::ExternalAddress,
        initial_sequence: u64,
    }

    public fun authorize_governance(arg0: &0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::state::State, arg1: bool) : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::governance_message::DecreeTicket<0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::governance_witness::GovernanceWitness> {
        if (arg1) {
            0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::governance_message::authorize_verify_global<0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::governance_witness::GovernanceWitness>(0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::governance_witness::new_governance_witness(), 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::state::governance_chain(arg0), 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::state::governance_contract(arg0), 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::state::governance_module(), 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::governance_action::get_value(0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::governance_action::new_set_governance_data_source()))
        } else {
            0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::governance_message::authorize_verify_local<0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::governance_witness::GovernanceWitness>(0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::governance_witness::new_governance_witness(), 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::state::governance_chain(arg0), 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::state::governance_contract(arg0), 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::state::governance_module(), 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::governance_action::get_value(0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::governance_action::new_set_governance_data_source()))
        }
    }

    public(friend) fun execute(arg0: &0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::state::LatestOnly, arg1: &mut 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::state::State, arg2: vector<u8>) {
        let GovernanceDataSource {
            emitter_chain_id : v0,
            emitter_address  : v1,
            initial_sequence : v2,
        } = from_byte_vec(arg2);
        0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::state::set_governance_data_source(arg0, arg1, 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::data_source::new(v0, v1));
        0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::state::set_last_executed_governance_sequence(arg0, arg1, v2);
    }

    fun from_byte_vec(arg0: vector<u8>) : GovernanceDataSource {
        let v0 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::new<u8>(arg0);
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::destroy_empty<u8>(v0);
        GovernanceDataSource{
            emitter_chain_id : (0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::deserialize::deserialize_u16(&mut v0) as u64),
            emitter_address  : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::new(0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes32::from_bytes(0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::deserialize::deserialize_vector(&mut v0, 32))),
            initial_sequence : 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::deserialize::deserialize_u64(&mut v0),
        }
    }

    // decompiled from Move bytecode v6
}

