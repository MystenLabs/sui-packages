module 0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::set_fee_recipient {
    struct PythFeeRecipient {
        recipient: address,
    }

    public fun authorize_governance(arg0: &0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::state::State) : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::governance_message::DecreeTicket<0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::governance_witness::GovernanceWitness> {
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::governance_message::authorize_verify_local<0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::governance_witness::GovernanceWitness>(0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::governance_witness::new_governance_witness(), 0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::state::governance_chain(arg0), 0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::state::governance_contract(arg0), 0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::state::governance_module(), 0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::governance_action::get_value(0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::governance_action::new_set_fee_recipient()))
    }

    public(friend) fun execute(arg0: &0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::state::LatestOnly, arg1: &mut 0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::state::State, arg2: vector<u8>) {
        let PythFeeRecipient { recipient: v0 } = from_byte_vec(arg2);
        0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::state::set_fee_recipient(arg0, arg1, v0);
    }

    fun from_byte_vec(arg0: vector<u8>) : PythFeeRecipient {
        let v0 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::new<u8>(arg0);
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::destroy_empty<u8>(v0);
        PythFeeRecipient{recipient: 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::to_address(0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::take_nonzero(&mut v0))}
    }

    // decompiled from Move bytecode v6
}

