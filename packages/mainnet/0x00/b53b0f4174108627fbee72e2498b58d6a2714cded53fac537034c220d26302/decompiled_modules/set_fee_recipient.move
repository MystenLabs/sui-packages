module 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::set_fee_recipient {
    struct PythFeeRecipient {
        recipient: address,
    }

    public fun authorize_governance(arg0: &0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::state::State) : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::governance_message::DecreeTicket<0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::governance_witness::GovernanceWitness> {
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::governance_message::authorize_verify_local<0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::governance_witness::GovernanceWitness>(0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::governance_witness::new_governance_witness(), 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::state::governance_chain(arg0), 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::state::governance_contract(arg0), 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::state::governance_module(), 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::governance_action::get_value(0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::governance_action::new_set_fee_recipient()))
    }

    public(friend) fun execute(arg0: &0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::state::LatestOnly, arg1: &mut 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::state::State, arg2: vector<u8>) {
        let PythFeeRecipient { recipient: v0 } = from_byte_vec(arg2);
        0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::state::set_fee_recipient(arg0, arg1, v0);
    }

    fun from_byte_vec(arg0: vector<u8>) : PythFeeRecipient {
        let v0 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::new<u8>(arg0);
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::destroy_empty<u8>(v0);
        PythFeeRecipient{recipient: 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::to_address(0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::take_nonzero(&mut v0))}
    }

    // decompiled from Move bytecode v6
}

