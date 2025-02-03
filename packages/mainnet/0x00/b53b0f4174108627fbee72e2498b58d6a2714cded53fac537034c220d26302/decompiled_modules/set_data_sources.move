module 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::set_data_sources {
    struct DataSources {
        sources: vector<0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::data_source::DataSource>,
    }

    public fun authorize_governance(arg0: &0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::state::State, arg1: bool) : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::governance_message::DecreeTicket<0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::governance_witness::GovernanceWitness> {
        if (arg1) {
            0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::governance_message::authorize_verify_global<0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::governance_witness::GovernanceWitness>(0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::governance_witness::new_governance_witness(), 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::state::governance_chain(arg0), 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::state::governance_contract(arg0), 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::state::governance_module(), 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::governance_action::get_value(0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::governance_action::new_set_data_sources()))
        } else {
            0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::governance_message::authorize_verify_local<0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::governance_witness::GovernanceWitness>(0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::governance_witness::new_governance_witness(), 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::state::governance_chain(arg0), 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::state::governance_contract(arg0), 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::state::governance_module(), 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::governance_action::get_value(0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::governance_action::new_set_data_sources()))
        }
    }

    public(friend) fun execute(arg0: &0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::state::LatestOnly, arg1: &mut 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::state::State, arg2: vector<u8>) {
        let DataSources { sources: v0 } = from_byte_vec(arg2);
        0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::state::set_data_sources(arg0, arg1, v0);
    }

    fun from_byte_vec(arg0: vector<u8>) : DataSources {
        let v0 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::new<u8>(arg0);
        let v1 = 0x1::vector::empty<0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::data_source::DataSource>();
        let v2 = 0;
        while (v2 < 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::deserialize::deserialize_u8(&mut v0)) {
            0x1::vector::push_back<0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::data_source::DataSource>(&mut v1, 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::data_source::new((0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::deserialize::deserialize_u16(&mut v0) as u64), 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::new(0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes32::from_bytes(0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::deserialize::deserialize_vector(&mut v0, 32)))));
            v2 = v2 + 1;
        };
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::destroy_empty<u8>(v0);
        DataSources{sources: v1}
    }

    // decompiled from Move bytecode v6
}

