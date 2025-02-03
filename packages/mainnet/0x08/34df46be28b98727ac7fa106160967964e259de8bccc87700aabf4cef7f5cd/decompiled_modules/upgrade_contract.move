module 0x834df46be28b98727ac7fa106160967964e259de8bccc87700aabf4cef7f5cd::upgrade_contract {
    struct GovernanceWitness has drop {
        dummy_field: bool,
    }

    struct ContractUpgraded has copy, drop {
        old_contract: 0x2::object::ID,
        new_contract: 0x2::object::ID,
    }

    struct UpgradeContract {
        digest: 0x834df46be28b98727ac7fa106160967964e259de8bccc87700aabf4cef7f5cd::bytes32::Bytes32,
    }

    public fun authorize_upgrade(arg0: &mut 0x834df46be28b98727ac7fa106160967964e259de8bccc87700aabf4cef7f5cd::state::State, arg1: 0x834df46be28b98727ac7fa106160967964e259de8bccc87700aabf4cef7f5cd::governance_message::DecreeReceipt<GovernanceWitness>) : 0x2::package::UpgradeTicket {
        let v0 = 0x834df46be28b98727ac7fa106160967964e259de8bccc87700aabf4cef7f5cd::governance_message::take_payload<GovernanceWitness>(0x834df46be28b98727ac7fa106160967964e259de8bccc87700aabf4cef7f5cd::state::borrow_mut_consumed_vaas_unchecked(arg0), arg1);
        handle_upgrade_contract(arg0, v0)
    }

    public fun commit_upgrade(arg0: &mut 0x834df46be28b98727ac7fa106160967964e259de8bccc87700aabf4cef7f5cd::state::State, arg1: 0x2::package::UpgradeReceipt) {
        let (v0, v1) = 0x834df46be28b98727ac7fa106160967964e259de8bccc87700aabf4cef7f5cd::state::commit_upgrade(arg0, arg1);
        let v2 = ContractUpgraded{
            old_contract : v0,
            new_contract : v1,
        };
        0x2::event::emit<ContractUpgraded>(v2);
    }

    public fun authorize_governance(arg0: &0x834df46be28b98727ac7fa106160967964e259de8bccc87700aabf4cef7f5cd::state::State) : 0x834df46be28b98727ac7fa106160967964e259de8bccc87700aabf4cef7f5cd::governance_message::DecreeTicket<GovernanceWitness> {
        let v0 = GovernanceWitness{dummy_field: false};
        0x834df46be28b98727ac7fa106160967964e259de8bccc87700aabf4cef7f5cd::governance_message::authorize_verify_local<GovernanceWitness>(v0, 0x834df46be28b98727ac7fa106160967964e259de8bccc87700aabf4cef7f5cd::state::governance_chain(arg0), 0x834df46be28b98727ac7fa106160967964e259de8bccc87700aabf4cef7f5cd::state::governance_contract(arg0), 0x834df46be28b98727ac7fa106160967964e259de8bccc87700aabf4cef7f5cd::state::governance_module(), 1)
    }

    fun deserialize(arg0: vector<u8>) : UpgradeContract {
        let v0 = 0x834df46be28b98727ac7fa106160967964e259de8bccc87700aabf4cef7f5cd::cursor::new<u8>(arg0);
        let v1 = 0x834df46be28b98727ac7fa106160967964e259de8bccc87700aabf4cef7f5cd::bytes32::take_bytes(&mut v0);
        assert!(0x834df46be28b98727ac7fa106160967964e259de8bccc87700aabf4cef7f5cd::bytes32::is_nonzero(&v1), 0);
        0x834df46be28b98727ac7fa106160967964e259de8bccc87700aabf4cef7f5cd::cursor::destroy_empty<u8>(v0);
        UpgradeContract{digest: v1}
    }

    fun handle_upgrade_contract(arg0: &mut 0x834df46be28b98727ac7fa106160967964e259de8bccc87700aabf4cef7f5cd::state::State, arg1: vector<u8>) : 0x2::package::UpgradeTicket {
        0x834df46be28b98727ac7fa106160967964e259de8bccc87700aabf4cef7f5cd::state::authorize_upgrade(arg0, take_digest(arg1))
    }

    public(friend) fun take_digest(arg0: vector<u8>) : 0x834df46be28b98727ac7fa106160967964e259de8bccc87700aabf4cef7f5cd::bytes32::Bytes32 {
        let UpgradeContract { digest: v0 } = deserialize(arg0);
        v0
    }

    // decompiled from Move bytecode v6
}

