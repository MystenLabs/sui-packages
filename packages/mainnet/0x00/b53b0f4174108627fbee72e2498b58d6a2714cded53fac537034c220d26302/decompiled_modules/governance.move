module 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::governance {
    public fun execute_governance_instruction(arg0: &mut 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::state::State, arg1: 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::governance_message::DecreeReceipt<0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::governance_witness::GovernanceWitness>) {
        let v0 = 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::state::assert_latest_only(arg0);
        let v1 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::governance_message::sequence<0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::governance_witness::GovernanceWitness>(&arg1);
        assert!(v1 > 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::state::get_last_executed_governance_sequence(arg0), 2);
        0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::state::set_last_executed_governance_sequence(&v0, arg0, v1);
        let v2 = 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::governance_instruction::from_byte_vec(0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::governance_message::take_payload<0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::governance_witness::GovernanceWitness>(0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::state::borrow_mut_consumed_vaas(&v0, arg0), arg1));
        let v3 = 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::governance_instruction::get_action(&v2);
        if (v3 == 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::governance_action::new_contract_upgrade()) {
            abort 1
        };
        if (v3 == 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::governance_action::new_set_governance_data_source()) {
            0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::set_governance_data_source::execute(&v0, arg0, 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::governance_instruction::destroy(v2));
        } else if (v3 == 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::governance_action::new_set_data_sources()) {
            0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::set_data_sources::execute(&v0, arg0, 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::governance_instruction::destroy(v2));
        } else if (v3 == 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::governance_action::new_set_update_fee()) {
            0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::set_update_fee::execute(&v0, arg0, 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::governance_instruction::destroy(v2));
        } else if (v3 == 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::governance_action::new_set_stale_price_threshold()) {
            0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::set_stale_price_threshold::execute(&v0, arg0, 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::governance_instruction::destroy(v2));
        } else if (v3 == 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::governance_action::new_set_fee_recipient()) {
            0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::set_fee_recipient::execute(&v0, arg0, 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::governance_instruction::destroy(v2));
        } else {
            0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::governance_instruction::destroy(v2);
            abort 0
        };
    }

    // decompiled from Move bytecode v6
}

