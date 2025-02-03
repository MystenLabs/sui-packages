module 0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::set_update_fee {
    struct UpdateFee {
        mantissa: u64,
        exponent: u64,
    }

    fun apply_exponent(arg0: u64, arg1: u8) : u64 {
        arg0 * 0x2::math::pow(10, arg1)
    }

    public fun authorize_governance(arg0: &0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::state::State, arg1: bool) : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::governance_message::DecreeTicket<0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::governance_witness::GovernanceWitness> {
        if (arg1) {
            0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::governance_message::authorize_verify_global<0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::governance_witness::GovernanceWitness>(0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::governance_witness::new_governance_witness(), 0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::state::governance_chain(arg0), 0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::state::governance_contract(arg0), 0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::state::governance_module(), 0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::governance_action::get_value(0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::governance_action::new_set_update_fee()))
        } else {
            0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::governance_message::authorize_verify_local<0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::governance_witness::GovernanceWitness>(0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::governance_witness::new_governance_witness(), 0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::state::governance_chain(arg0), 0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::state::governance_contract(arg0), 0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::state::governance_module(), 0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::governance_action::get_value(0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::governance_action::new_set_update_fee()))
        }
    }

    public(friend) fun execute(arg0: &0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::state::LatestOnly, arg1: &mut 0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::state::State, arg2: vector<u8>) {
        let UpdateFee {
            mantissa : v0,
            exponent : v1,
        } = from_byte_vec(arg2);
        assert!(v1 <= 255, 0);
        0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::state::set_base_update_fee(arg0, arg1, apply_exponent(v0, (v1 as u8)));
    }

    fun from_byte_vec(arg0: vector<u8>) : UpdateFee {
        let v0 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::new<u8>(arg0);
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::destroy_empty<u8>(v0);
        UpdateFee{
            mantissa : 0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::deserialize::deserialize_u64(&mut v0),
            exponent : 0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::deserialize::deserialize_u64(&mut v0),
        }
    }

    // decompiled from Move bytecode v6
}

