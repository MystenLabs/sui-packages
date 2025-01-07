module 0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::governance {
    public fun execute_governance_instruction(arg0: &mut 0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::state::State, arg1: 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::governance_message::DecreeReceipt<0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::governance_witness::GovernanceWitness>) {
        let v0 = 0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::state::assert_latest_only(arg0);
        let v1 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::governance_message::sequence<0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::governance_witness::GovernanceWitness>(&arg1);
        assert!(v1 > 0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::state::get_last_executed_governance_sequence(arg0), 2);
        0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::state::set_last_executed_governance_sequence(&v0, arg0, v1);
        let v2 = 0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::governance_instruction::from_byte_vec(0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::governance_message::take_payload<0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::governance_witness::GovernanceWitness>(0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::state::borrow_mut_consumed_vaas(&v0, arg0), arg1));
        let v3 = 0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::governance_instruction::get_action(&v2);
        if (v3 == 0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::governance_action::new_contract_upgrade()) {
            abort 1
        };
        if (v3 == 0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::governance_action::new_set_governance_data_source()) {
            0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::set_governance_data_source::execute(&v0, arg0, 0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::governance_instruction::destroy(v2));
        } else if (v3 == 0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::governance_action::new_set_data_sources()) {
            0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::set_data_sources::execute(&v0, arg0, 0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::governance_instruction::destroy(v2));
        } else if (v3 == 0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::governance_action::new_set_update_fee()) {
            0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::set_update_fee::execute(&v0, arg0, 0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::governance_instruction::destroy(v2));
        } else if (v3 == 0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::governance_action::new_set_stale_price_threshold()) {
            0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::set_stale_price_threshold::execute(&v0, arg0, 0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::governance_instruction::destroy(v2));
        } else if (v3 == 0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::governance_action::new_set_fee_recipient()) {
            0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::set_fee_recipient::execute(&v0, arg0, 0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::governance_instruction::destroy(v2));
        } else {
            0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::governance_instruction::destroy(v2);
            abort 0
        };
    }

    // decompiled from Move bytecode v6
}

