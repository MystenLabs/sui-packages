module 0x834df46be28b98727ac7fa106160967964e259de8bccc87700aabf4cef7f5cd::transfer_fee {
    struct GovernanceWitness has drop {
        dummy_field: bool,
    }

    struct TransferFee {
        amount: u64,
        recipient: address,
    }

    public fun transfer_fee(arg0: &mut 0x834df46be28b98727ac7fa106160967964e259de8bccc87700aabf4cef7f5cd::state::State, arg1: 0x834df46be28b98727ac7fa106160967964e259de8bccc87700aabf4cef7f5cd::governance_message::DecreeReceipt<GovernanceWitness>, arg2: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0x834df46be28b98727ac7fa106160967964e259de8bccc87700aabf4cef7f5cd::state::assert_latest_only(arg0);
        let v1 = 0x834df46be28b98727ac7fa106160967964e259de8bccc87700aabf4cef7f5cd::governance_message::take_payload<GovernanceWitness>(0x834df46be28b98727ac7fa106160967964e259de8bccc87700aabf4cef7f5cd::state::borrow_mut_consumed_vaas(&v0, arg0), arg1);
        handle_transfer_fee(&v0, arg0, v1, arg2)
    }

    public fun authorize_governance(arg0: &0x834df46be28b98727ac7fa106160967964e259de8bccc87700aabf4cef7f5cd::state::State) : 0x834df46be28b98727ac7fa106160967964e259de8bccc87700aabf4cef7f5cd::governance_message::DecreeTicket<GovernanceWitness> {
        let v0 = GovernanceWitness{dummy_field: false};
        0x834df46be28b98727ac7fa106160967964e259de8bccc87700aabf4cef7f5cd::governance_message::authorize_verify_local<GovernanceWitness>(v0, 0x834df46be28b98727ac7fa106160967964e259de8bccc87700aabf4cef7f5cd::state::governance_chain(arg0), 0x834df46be28b98727ac7fa106160967964e259de8bccc87700aabf4cef7f5cd::state::governance_contract(arg0), 0x834df46be28b98727ac7fa106160967964e259de8bccc87700aabf4cef7f5cd::state::governance_module(), 4)
    }

    fun deserialize(arg0: vector<u8>) : TransferFee {
        let v0 = 0x834df46be28b98727ac7fa106160967964e259de8bccc87700aabf4cef7f5cd::cursor::new<u8>(arg0);
        0x834df46be28b98727ac7fa106160967964e259de8bccc87700aabf4cef7f5cd::cursor::destroy_empty<u8>(v0);
        TransferFee{
            amount    : (0x834df46be28b98727ac7fa106160967964e259de8bccc87700aabf4cef7f5cd::bytes32::to_u64_be(0x834df46be28b98727ac7fa106160967964e259de8bccc87700aabf4cef7f5cd::bytes32::take_bytes(&mut v0)) as u64),
            recipient : 0x834df46be28b98727ac7fa106160967964e259de8bccc87700aabf4cef7f5cd::external_address::to_address(0x834df46be28b98727ac7fa106160967964e259de8bccc87700aabf4cef7f5cd::external_address::take_nonzero(&mut v0)),
        }
    }

    fun handle_transfer_fee(arg0: &0x834df46be28b98727ac7fa106160967964e259de8bccc87700aabf4cef7f5cd::state::LatestOnly, arg1: &mut 0x834df46be28b98727ac7fa106160967964e259de8bccc87700aabf4cef7f5cd::state::State, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) : u64 {
        let TransferFee {
            amount    : v0,
            recipient : v1,
        } = deserialize(arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x834df46be28b98727ac7fa106160967964e259de8bccc87700aabf4cef7f5cd::state::withdraw_fee(arg0, arg1, v0), arg3), v1);
        v0
    }

    // decompiled from Move bytecode v6
}

