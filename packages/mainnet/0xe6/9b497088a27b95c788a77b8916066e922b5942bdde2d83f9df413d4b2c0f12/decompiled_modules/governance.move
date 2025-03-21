module 0xe69b497088a27b95c788a77b8916066e922b5942bdde2d83f9df413d4b2c0f12::governance {
    struct WormholeVAAVerificationReceipt {
        payload: vector<u8>,
        digest: 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes32::Bytes32,
        sequence: u64,
    }

    public fun take_payload(arg0: &WormholeVAAVerificationReceipt) : vector<u8> {
        arg0.payload
    }

    public fun destroy(arg0: WormholeVAAVerificationReceipt) {
        let WormholeVAAVerificationReceipt {
            payload  : _,
            digest   : _,
            sequence : _,
        } = arg0;
    }

    public fun execute_governance_instruction(arg0: &mut 0xe69b497088a27b95c788a77b8916066e922b5942bdde2d83f9df413d4b2c0f12::state::State, arg1: WormholeVAAVerificationReceipt) {
        let v0 = 0xe69b497088a27b95c788a77b8916066e922b5942bdde2d83f9df413d4b2c0f12::state::assert_latest_only(arg0);
        let v1 = arg1.sequence;
        assert!(v1 > 0xe69b497088a27b95c788a77b8916066e922b5942bdde2d83f9df413d4b2c0f12::state::get_last_executed_governance_sequence(arg0), 2);
        0xe69b497088a27b95c788a77b8916066e922b5942bdde2d83f9df413d4b2c0f12::state::set_last_executed_governance_sequence(&v0, arg0, v1);
        destroy(arg1);
        let v2 = 0xe69b497088a27b95c788a77b8916066e922b5942bdde2d83f9df413d4b2c0f12::governance_instruction::from_byte_vec(arg1.payload);
        let v3 = 0xe69b497088a27b95c788a77b8916066e922b5942bdde2d83f9df413d4b2c0f12::governance_instruction::get_action(&v2);
        if (v3 == 0xe69b497088a27b95c788a77b8916066e922b5942bdde2d83f9df413d4b2c0f12::governance_action::new_contract_upgrade()) {
            abort 1
        };
        if (v3 == 0xe69b497088a27b95c788a77b8916066e922b5942bdde2d83f9df413d4b2c0f12::governance_action::new_set_governance_data_source()) {
            0xe69b497088a27b95c788a77b8916066e922b5942bdde2d83f9df413d4b2c0f12::set_governance_data_source::execute(&v0, arg0, 0xe69b497088a27b95c788a77b8916066e922b5942bdde2d83f9df413d4b2c0f12::governance_instruction::destroy(v2));
        } else if (v3 == 0xe69b497088a27b95c788a77b8916066e922b5942bdde2d83f9df413d4b2c0f12::governance_action::new_set_data_sources()) {
            0xe69b497088a27b95c788a77b8916066e922b5942bdde2d83f9df413d4b2c0f12::set_data_sources::execute(&v0, arg0, 0xe69b497088a27b95c788a77b8916066e922b5942bdde2d83f9df413d4b2c0f12::governance_instruction::destroy(v2));
        } else if (v3 == 0xe69b497088a27b95c788a77b8916066e922b5942bdde2d83f9df413d4b2c0f12::governance_action::new_set_update_fee()) {
            0xe69b497088a27b95c788a77b8916066e922b5942bdde2d83f9df413d4b2c0f12::set_update_fee::execute(&v0, arg0, 0xe69b497088a27b95c788a77b8916066e922b5942bdde2d83f9df413d4b2c0f12::governance_instruction::destroy(v2));
        } else if (v3 == 0xe69b497088a27b95c788a77b8916066e922b5942bdde2d83f9df413d4b2c0f12::governance_action::new_set_stale_price_threshold()) {
            0xe69b497088a27b95c788a77b8916066e922b5942bdde2d83f9df413d4b2c0f12::set_stale_price_threshold::execute(&v0, arg0, 0xe69b497088a27b95c788a77b8916066e922b5942bdde2d83f9df413d4b2c0f12::governance_instruction::destroy(v2));
        } else if (v3 == 0xe69b497088a27b95c788a77b8916066e922b5942bdde2d83f9df413d4b2c0f12::governance_action::new_set_fee_recipient()) {
            0xe69b497088a27b95c788a77b8916066e922b5942bdde2d83f9df413d4b2c0f12::set_fee_recipient::execute(&v0, arg0, 0xe69b497088a27b95c788a77b8916066e922b5942bdde2d83f9df413d4b2c0f12::governance_instruction::destroy(v2));
        } else {
            0xe69b497088a27b95c788a77b8916066e922b5942bdde2d83f9df413d4b2c0f12::governance_instruction::destroy(v2);
            abort 0
        };
    }

    public fun take_digest(arg0: &WormholeVAAVerificationReceipt) : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes32::Bytes32 {
        arg0.digest
    }

    public fun take_sequence(arg0: &WormholeVAAVerificationReceipt) : u64 {
        arg0.sequence
    }

    public fun verify_vaa(arg0: &0xe69b497088a27b95c788a77b8916066e922b5942bdde2d83f9df413d4b2c0f12::state::State, arg1: 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::VAA) : WormholeVAAVerificationReceipt {
        0xe69b497088a27b95c788a77b8916066e922b5942bdde2d83f9df413d4b2c0f12::state::assert_latest_only(arg0);
        assert!(0xe69b497088a27b95c788a77b8916066e922b5942bdde2d83f9df413d4b2c0f12::state::is_valid_governance_data_source(arg0, 0xe69b497088a27b95c788a77b8916066e922b5942bdde2d83f9df413d4b2c0f12::data_source::new((0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::emitter_chain(&arg1) as u64), 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::emitter_address(&arg1))), 4);
        WormholeVAAVerificationReceipt{
            payload  : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::take_payload(arg1),
            digest   : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::digest(&arg1),
            sequence : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::sequence(&arg1),
        }
    }

    // decompiled from Move bytecode v6
}

