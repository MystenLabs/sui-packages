module 0x9f064e7c71482219a716295dffd40efb522b4e197200d6ebb684cb6a81d1e367::upgrade_contract {
    struct GovernanceWitness has drop {
        dummy_field: bool,
    }

    struct ContractUpgraded has copy, drop {
        old_contract: 0x2::object::ID,
        new_contract: 0x2::object::ID,
    }

    struct UpgradeContract {
        digest: 0x9f064e7c71482219a716295dffd40efb522b4e197200d6ebb684cb6a81d1e367::bytes32::Bytes32,
    }

    public fun authorize_upgrade(arg0: &mut 0x9f064e7c71482219a716295dffd40efb522b4e197200d6ebb684cb6a81d1e367::state::State, arg1: 0x9f064e7c71482219a716295dffd40efb522b4e197200d6ebb684cb6a81d1e367::governance_message::DecreeReceipt<GovernanceWitness>) : 0x2::package::UpgradeTicket {
        let v0 = 0x9f064e7c71482219a716295dffd40efb522b4e197200d6ebb684cb6a81d1e367::governance_message::take_payload<GovernanceWitness>(0x9f064e7c71482219a716295dffd40efb522b4e197200d6ebb684cb6a81d1e367::state::borrow_mut_consumed_vaas_unchecked(arg0), arg1);
        handle_upgrade_contract(arg0, v0)
    }

    public fun commit_upgrade(arg0: &mut 0x9f064e7c71482219a716295dffd40efb522b4e197200d6ebb684cb6a81d1e367::state::State, arg1: 0x2::package::UpgradeReceipt) {
        let (v0, v1) = 0x9f064e7c71482219a716295dffd40efb522b4e197200d6ebb684cb6a81d1e367::state::commit_upgrade(arg0, arg1);
        let v2 = ContractUpgraded{
            old_contract : v0,
            new_contract : v1,
        };
        0x2::event::emit<ContractUpgraded>(v2);
    }

    public fun authorize_governance(arg0: &0x9f064e7c71482219a716295dffd40efb522b4e197200d6ebb684cb6a81d1e367::state::State) : 0x9f064e7c71482219a716295dffd40efb522b4e197200d6ebb684cb6a81d1e367::governance_message::DecreeTicket<GovernanceWitness> {
        let v0 = GovernanceWitness{dummy_field: false};
        0x9f064e7c71482219a716295dffd40efb522b4e197200d6ebb684cb6a81d1e367::governance_message::authorize_verify_local<GovernanceWitness>(v0, 0x9f064e7c71482219a716295dffd40efb522b4e197200d6ebb684cb6a81d1e367::state::governance_chain(arg0), 0x9f064e7c71482219a716295dffd40efb522b4e197200d6ebb684cb6a81d1e367::state::governance_contract(arg0), 0x9f064e7c71482219a716295dffd40efb522b4e197200d6ebb684cb6a81d1e367::state::governance_module(), 1)
    }

    fun deserialize(arg0: vector<u8>) : UpgradeContract {
        let v0 = 0x9f064e7c71482219a716295dffd40efb522b4e197200d6ebb684cb6a81d1e367::cursor::new<u8>(arg0);
        let v1 = 0x9f064e7c71482219a716295dffd40efb522b4e197200d6ebb684cb6a81d1e367::bytes32::take_bytes(&mut v0);
        assert!(0x9f064e7c71482219a716295dffd40efb522b4e197200d6ebb684cb6a81d1e367::bytes32::is_nonzero(&v1), 0);
        0x9f064e7c71482219a716295dffd40efb522b4e197200d6ebb684cb6a81d1e367::cursor::destroy_empty<u8>(v0);
        UpgradeContract{digest: v1}
    }

    fun handle_upgrade_contract(arg0: &mut 0x9f064e7c71482219a716295dffd40efb522b4e197200d6ebb684cb6a81d1e367::state::State, arg1: vector<u8>) : 0x2::package::UpgradeTicket {
        0x9f064e7c71482219a716295dffd40efb522b4e197200d6ebb684cb6a81d1e367::state::authorize_upgrade(arg0, take_digest(arg1))
    }

    public(friend) fun take_digest(arg0: vector<u8>) : 0x9f064e7c71482219a716295dffd40efb522b4e197200d6ebb684cb6a81d1e367::bytes32::Bytes32 {
        let UpgradeContract { digest: v0 } = deserialize(arg0);
        v0
    }

    // decompiled from Move bytecode v6
}

