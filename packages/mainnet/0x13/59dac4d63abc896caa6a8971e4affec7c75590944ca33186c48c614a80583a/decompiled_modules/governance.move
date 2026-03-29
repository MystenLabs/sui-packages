module 0x1359dac4d63abc896caa6a8971e4affec7c75590944ca33186c48c614a80583a::governance {
    struct WormholeVAAVerificationReceipt {
        payload: vector<u8>,
        digest: 0x913c5b4adfe7d198b085e1f8d2682c9ae08e9673bcd4bcbd023a9f9ad62cf665::bytes32::Bytes32,
        sequence: u64,
    }

    public fun destroy(arg0: WormholeVAAVerificationReceipt) {
        let WormholeVAAVerificationReceipt {
            payload  : _,
            digest   : _,
            sequence : _,
        } = arg0;
    }

    public fun execute_governance_instruction(arg0: &mut 0x1359dac4d63abc896caa6a8971e4affec7c75590944ca33186c48c614a80583a::state::State, arg1: WormholeVAAVerificationReceipt) {
        let v0 = 0x1359dac4d63abc896caa6a8971e4affec7c75590944ca33186c48c614a80583a::state::assert_latest_only(arg0);
        let v1 = arg1.sequence;
        assert!(v1 > 0x1359dac4d63abc896caa6a8971e4affec7c75590944ca33186c48c614a80583a::state::get_last_executed_governance_sequence(arg0), 2);
        0x1359dac4d63abc896caa6a8971e4affec7c75590944ca33186c48c614a80583a::state::set_last_executed_governance_sequence(&v0, arg0, v1);
        destroy(arg1);
        let v2 = 0x1359dac4d63abc896caa6a8971e4affec7c75590944ca33186c48c614a80583a::governance_instruction::from_byte_vec(arg1.payload);
        let v3 = 0x1359dac4d63abc896caa6a8971e4affec7c75590944ca33186c48c614a80583a::governance_instruction::get_action(&v2);
        if (v3 == 0x1359dac4d63abc896caa6a8971e4affec7c75590944ca33186c48c614a80583a::governance_action::new_contract_upgrade()) {
            abort 1
        };
        if (v3 == 0x1359dac4d63abc896caa6a8971e4affec7c75590944ca33186c48c614a80583a::governance_action::new_set_governance_data_source()) {
            0x1359dac4d63abc896caa6a8971e4affec7c75590944ca33186c48c614a80583a::set_governance_data_source::execute(&v0, arg0, 0x1359dac4d63abc896caa6a8971e4affec7c75590944ca33186c48c614a80583a::governance_instruction::destroy(v2));
        } else if (v3 == 0x1359dac4d63abc896caa6a8971e4affec7c75590944ca33186c48c614a80583a::governance_action::new_set_data_sources()) {
            0x1359dac4d63abc896caa6a8971e4affec7c75590944ca33186c48c614a80583a::set_data_sources::execute(&v0, arg0, 0x1359dac4d63abc896caa6a8971e4affec7c75590944ca33186c48c614a80583a::governance_instruction::destroy(v2));
        } else if (v3 == 0x1359dac4d63abc896caa6a8971e4affec7c75590944ca33186c48c614a80583a::governance_action::new_set_update_fee()) {
            0x1359dac4d63abc896caa6a8971e4affec7c75590944ca33186c48c614a80583a::set_update_fee::execute(&v0, arg0, 0x1359dac4d63abc896caa6a8971e4affec7c75590944ca33186c48c614a80583a::governance_instruction::destroy(v2));
        } else if (v3 == 0x1359dac4d63abc896caa6a8971e4affec7c75590944ca33186c48c614a80583a::governance_action::new_set_stale_price_threshold()) {
            0x1359dac4d63abc896caa6a8971e4affec7c75590944ca33186c48c614a80583a::set_stale_price_threshold::execute(&v0, arg0, 0x1359dac4d63abc896caa6a8971e4affec7c75590944ca33186c48c614a80583a::governance_instruction::destroy(v2));
        } else if (v3 == 0x1359dac4d63abc896caa6a8971e4affec7c75590944ca33186c48c614a80583a::governance_action::new_set_fee_recipient()) {
            0x1359dac4d63abc896caa6a8971e4affec7c75590944ca33186c48c614a80583a::set_fee_recipient::execute(&v0, arg0, 0x1359dac4d63abc896caa6a8971e4affec7c75590944ca33186c48c614a80583a::governance_instruction::destroy(v2));
        } else {
            0x1359dac4d63abc896caa6a8971e4affec7c75590944ca33186c48c614a80583a::governance_instruction::destroy(v2);
            abort 0
        };
    }

    public fun take_digest(arg0: &WormholeVAAVerificationReceipt) : 0x913c5b4adfe7d198b085e1f8d2682c9ae08e9673bcd4bcbd023a9f9ad62cf665::bytes32::Bytes32 {
        arg0.digest
    }

    public fun take_payload(arg0: &WormholeVAAVerificationReceipt) : vector<u8> {
        arg0.payload
    }

    public fun take_sequence(arg0: &WormholeVAAVerificationReceipt) : u64 {
        arg0.sequence
    }

    public fun verify_vaa(arg0: &0x1359dac4d63abc896caa6a8971e4affec7c75590944ca33186c48c614a80583a::state::State, arg1: 0x913c5b4adfe7d198b085e1f8d2682c9ae08e9673bcd4bcbd023a9f9ad62cf665::vaa::VAA) : WormholeVAAVerificationReceipt {
        0x1359dac4d63abc896caa6a8971e4affec7c75590944ca33186c48c614a80583a::state::assert_latest_only(arg0);
        assert!(0x1359dac4d63abc896caa6a8971e4affec7c75590944ca33186c48c614a80583a::state::is_valid_governance_data_source(arg0, 0x1359dac4d63abc896caa6a8971e4affec7c75590944ca33186c48c614a80583a::data_source::new((0x913c5b4adfe7d198b085e1f8d2682c9ae08e9673bcd4bcbd023a9f9ad62cf665::vaa::emitter_chain(&arg1) as u64), 0x913c5b4adfe7d198b085e1f8d2682c9ae08e9673bcd4bcbd023a9f9ad62cf665::vaa::emitter_address(&arg1))), 4);
        WormholeVAAVerificationReceipt{
            payload  : 0x913c5b4adfe7d198b085e1f8d2682c9ae08e9673bcd4bcbd023a9f9ad62cf665::vaa::take_payload(arg1),
            digest   : 0x913c5b4adfe7d198b085e1f8d2682c9ae08e9673bcd4bcbd023a9f9ad62cf665::vaa::digest(&arg1),
            sequence : 0x913c5b4adfe7d198b085e1f8d2682c9ae08e9673bcd4bcbd023a9f9ad62cf665::vaa::sequence(&arg1),
        }
    }

    // decompiled from Move bytecode v6
}

