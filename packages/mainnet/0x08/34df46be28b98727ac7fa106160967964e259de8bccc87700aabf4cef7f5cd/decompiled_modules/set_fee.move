module 0x834df46be28b98727ac7fa106160967964e259de8bccc87700aabf4cef7f5cd::set_fee {
    struct GovernanceWitness has drop {
        dummy_field: bool,
    }

    struct SetFee {
        amount: u64,
    }

    public fun set_fee(arg0: &mut 0x834df46be28b98727ac7fa106160967964e259de8bccc87700aabf4cef7f5cd::state::State, arg1: 0x834df46be28b98727ac7fa106160967964e259de8bccc87700aabf4cef7f5cd::governance_message::DecreeReceipt<GovernanceWitness>) : u64 {
        let v0 = 0x834df46be28b98727ac7fa106160967964e259de8bccc87700aabf4cef7f5cd::state::assert_latest_only(arg0);
        let SetFee { amount: v1 } = deserialize(0x834df46be28b98727ac7fa106160967964e259de8bccc87700aabf4cef7f5cd::governance_message::take_payload<GovernanceWitness>(0x834df46be28b98727ac7fa106160967964e259de8bccc87700aabf4cef7f5cd::state::borrow_mut_consumed_vaas(&v0, arg0), arg1));
        0x834df46be28b98727ac7fa106160967964e259de8bccc87700aabf4cef7f5cd::state::set_message_fee(&v0, arg0, v1);
        v1
    }

    public fun authorize_governance(arg0: &0x834df46be28b98727ac7fa106160967964e259de8bccc87700aabf4cef7f5cd::state::State) : 0x834df46be28b98727ac7fa106160967964e259de8bccc87700aabf4cef7f5cd::governance_message::DecreeTicket<GovernanceWitness> {
        let v0 = GovernanceWitness{dummy_field: false};
        0x834df46be28b98727ac7fa106160967964e259de8bccc87700aabf4cef7f5cd::governance_message::authorize_verify_local<GovernanceWitness>(v0, 0x834df46be28b98727ac7fa106160967964e259de8bccc87700aabf4cef7f5cd::state::governance_chain(arg0), 0x834df46be28b98727ac7fa106160967964e259de8bccc87700aabf4cef7f5cd::state::governance_contract(arg0), 0x834df46be28b98727ac7fa106160967964e259de8bccc87700aabf4cef7f5cd::state::governance_module(), 3)
    }

    fun deserialize(arg0: vector<u8>) : SetFee {
        let v0 = 0x834df46be28b98727ac7fa106160967964e259de8bccc87700aabf4cef7f5cd::cursor::new<u8>(arg0);
        0x834df46be28b98727ac7fa106160967964e259de8bccc87700aabf4cef7f5cd::cursor::destroy_empty<u8>(v0);
        SetFee{amount: (0x834df46be28b98727ac7fa106160967964e259de8bccc87700aabf4cef7f5cd::bytes32::to_u64_be(0x834df46be28b98727ac7fa106160967964e259de8bccc87700aabf4cef7f5cd::bytes32::take_bytes(&mut v0)) as u64)}
    }

    // decompiled from Move bytecode v6
}

