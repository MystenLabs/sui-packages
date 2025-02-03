module 0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::set_governance_data_source {
    struct GovernanceDataSource {
        emitter_chain_id: u64,
        emitter_address: 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::ExternalAddress,
        initial_sequence: u64,
    }

    public fun authorize_governance(arg0: &0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::state::State, arg1: bool) : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::governance_message::DecreeTicket<0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::governance_witness::GovernanceWitness> {
        if (arg1) {
            0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::governance_message::authorize_verify_global<0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::governance_witness::GovernanceWitness>(0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::governance_witness::new_governance_witness(), 0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::state::governance_chain(arg0), 0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::state::governance_contract(arg0), 0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::state::governance_module(), 0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::governance_action::get_value(0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::governance_action::new_set_governance_data_source()))
        } else {
            0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::governance_message::authorize_verify_local<0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::governance_witness::GovernanceWitness>(0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::governance_witness::new_governance_witness(), 0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::state::governance_chain(arg0), 0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::state::governance_contract(arg0), 0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::state::governance_module(), 0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::governance_action::get_value(0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::governance_action::new_set_governance_data_source()))
        }
    }

    public(friend) fun execute(arg0: &0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::state::LatestOnly, arg1: &mut 0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::state::State, arg2: vector<u8>) {
        let GovernanceDataSource {
            emitter_chain_id : v0,
            emitter_address  : v1,
            initial_sequence : v2,
        } = from_byte_vec(arg2);
        0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::state::set_governance_data_source(arg0, arg1, 0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::data_source::new(v0, v1));
        0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::state::set_last_executed_governance_sequence(arg0, arg1, v2);
    }

    fun from_byte_vec(arg0: vector<u8>) : GovernanceDataSource {
        let v0 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::new<u8>(arg0);
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::destroy_empty<u8>(v0);
        GovernanceDataSource{
            emitter_chain_id : (0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::deserialize::deserialize_u16(&mut v0) as u64),
            emitter_address  : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::new(0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes32::from_bytes(0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::deserialize::deserialize_vector(&mut v0, 32))),
            initial_sequence : 0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::deserialize::deserialize_u64(&mut v0),
        }
    }

    // decompiled from Move bytecode v6
}

