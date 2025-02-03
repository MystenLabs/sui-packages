module 0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::set_data_sources {
    struct DataSources {
        sources: vector<0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::data_source::DataSource>,
    }

    public fun authorize_governance(arg0: &0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::state::State, arg1: bool) : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::governance_message::DecreeTicket<0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::governance_witness::GovernanceWitness> {
        if (arg1) {
            0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::governance_message::authorize_verify_global<0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::governance_witness::GovernanceWitness>(0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::governance_witness::new_governance_witness(), 0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::state::governance_chain(arg0), 0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::state::governance_contract(arg0), 0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::state::governance_module(), 0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::governance_action::get_value(0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::governance_action::new_set_data_sources()))
        } else {
            0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::governance_message::authorize_verify_local<0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::governance_witness::GovernanceWitness>(0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::governance_witness::new_governance_witness(), 0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::state::governance_chain(arg0), 0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::state::governance_contract(arg0), 0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::state::governance_module(), 0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::governance_action::get_value(0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::governance_action::new_set_data_sources()))
        }
    }

    public(friend) fun execute(arg0: &0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::state::LatestOnly, arg1: &mut 0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::state::State, arg2: vector<u8>) {
        let DataSources { sources: v0 } = from_byte_vec(arg2);
        0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::state::set_data_sources(arg0, arg1, v0);
    }

    fun from_byte_vec(arg0: vector<u8>) : DataSources {
        let v0 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::new<u8>(arg0);
        let v1 = 0x1::vector::empty<0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::data_source::DataSource>();
        let v2 = 0;
        while (v2 < 0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::deserialize::deserialize_u8(&mut v0)) {
            0x1::vector::push_back<0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::data_source::DataSource>(&mut v1, 0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::data_source::new((0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::deserialize::deserialize_u16(&mut v0) as u64), 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::new(0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes32::from_bytes(0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::deserialize::deserialize_vector(&mut v0, 32)))));
            v2 = v2 + 1;
        };
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::destroy_empty<u8>(v0);
        DataSources{sources: v1}
    }

    // decompiled from Move bytecode v6
}

