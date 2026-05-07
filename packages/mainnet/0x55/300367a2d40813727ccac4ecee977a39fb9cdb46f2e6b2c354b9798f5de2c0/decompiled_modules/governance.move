module 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::governance {
    struct WormholeVAAVerificationReceipt {
        payload: vector<u8>,
        digest: 0x99de5c967d8206ef4b75c0afab3df2a59eb02b05c282821db803831008ac25b4::bytes32::Bytes32,
        sequence: u64,
    }

    public fun destroy(arg0: WormholeVAAVerificationReceipt) {
        let WormholeVAAVerificationReceipt {
            payload  : _,
            digest   : _,
            sequence : _,
        } = arg0;
    }

    public fun execute_governance_instruction(arg0: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::state::State, arg1: WormholeVAAVerificationReceipt) {
        let v0 = 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::state::assert_latest_only(arg0);
        let v1 = arg1.sequence;
        assert!(v1 > 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::state::get_last_executed_governance_sequence(arg0), 2);
        0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::state::set_last_executed_governance_sequence(&v0, arg0, v1);
        destroy(arg1);
        let v2 = 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::governance_instruction::from_byte_vec(arg1.payload);
        let v3 = 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::governance_instruction::get_action(&v2);
        if (v3 == 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::governance_action::new_contract_upgrade()) {
            abort 1
        };
        if (v3 == 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::governance_action::new_set_governance_data_source()) {
            0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::set_governance_data_source::execute(&v0, arg0, 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::governance_instruction::destroy(v2));
        } else if (v3 == 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::governance_action::new_set_data_sources()) {
            0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::set_data_sources::execute(&v0, arg0, 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::governance_instruction::destroy(v2));
        } else if (v3 == 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::governance_action::new_set_update_fee()) {
            0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::set_update_fee::execute(&v0, arg0, 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::governance_instruction::destroy(v2));
        } else if (v3 == 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::governance_action::new_set_stale_price_threshold()) {
            0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::set_stale_price_threshold::execute(&v0, arg0, 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::governance_instruction::destroy(v2));
        } else if (v3 == 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::governance_action::new_set_fee_recipient()) {
            0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::set_fee_recipient::execute(&v0, arg0, 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::governance_instruction::destroy(v2));
        } else {
            0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::governance_instruction::destroy(v2);
            abort 0
        };
    }

    public fun take_digest(arg0: &WormholeVAAVerificationReceipt) : 0x99de5c967d8206ef4b75c0afab3df2a59eb02b05c282821db803831008ac25b4::bytes32::Bytes32 {
        arg0.digest
    }

    public fun take_payload(arg0: &WormholeVAAVerificationReceipt) : vector<u8> {
        arg0.payload
    }

    public fun take_sequence(arg0: &WormholeVAAVerificationReceipt) : u64 {
        arg0.sequence
    }

    public fun verify_vaa(arg0: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::state::State, arg1: 0x99de5c967d8206ef4b75c0afab3df2a59eb02b05c282821db803831008ac25b4::vaa::VAA) : WormholeVAAVerificationReceipt {
        0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::state::assert_latest_only(arg0);
        assert!(0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::state::is_valid_governance_data_source(arg0, 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::data_source::new((0x99de5c967d8206ef4b75c0afab3df2a59eb02b05c282821db803831008ac25b4::vaa::emitter_chain(&arg1) as u64), 0x99de5c967d8206ef4b75c0afab3df2a59eb02b05c282821db803831008ac25b4::vaa::emitter_address(&arg1))), 4);
        WormholeVAAVerificationReceipt{
            payload  : 0x99de5c967d8206ef4b75c0afab3df2a59eb02b05c282821db803831008ac25b4::vaa::take_payload(arg1),
            digest   : 0x99de5c967d8206ef4b75c0afab3df2a59eb02b05c282821db803831008ac25b4::vaa::digest(&arg1),
            sequence : 0x99de5c967d8206ef4b75c0afab3df2a59eb02b05c282821db803831008ac25b4::vaa::sequence(&arg1),
        }
    }

    // decompiled from Move bytecode v6
}

