module 0x9f064e7c71482219a716295dffd40efb522b4e197200d6ebb684cb6a81d1e367::set_fee {
    struct GovernanceWitness has drop {
        dummy_field: bool,
    }

    struct SetFee {
        amount: u64,
    }

    public fun set_fee(arg0: &mut 0x9f064e7c71482219a716295dffd40efb522b4e197200d6ebb684cb6a81d1e367::state::State, arg1: 0x9f064e7c71482219a716295dffd40efb522b4e197200d6ebb684cb6a81d1e367::governance_message::DecreeReceipt<GovernanceWitness>) : u64 {
        let v0 = 0x9f064e7c71482219a716295dffd40efb522b4e197200d6ebb684cb6a81d1e367::state::assert_latest_only(arg0);
        let SetFee { amount: v1 } = deserialize(0x9f064e7c71482219a716295dffd40efb522b4e197200d6ebb684cb6a81d1e367::governance_message::take_payload<GovernanceWitness>(0x9f064e7c71482219a716295dffd40efb522b4e197200d6ebb684cb6a81d1e367::state::borrow_mut_consumed_vaas(&v0, arg0), arg1));
        0x9f064e7c71482219a716295dffd40efb522b4e197200d6ebb684cb6a81d1e367::state::set_message_fee(&v0, arg0, v1);
        v1
    }

    public fun authorize_governance(arg0: &0x9f064e7c71482219a716295dffd40efb522b4e197200d6ebb684cb6a81d1e367::state::State) : 0x9f064e7c71482219a716295dffd40efb522b4e197200d6ebb684cb6a81d1e367::governance_message::DecreeTicket<GovernanceWitness> {
        let v0 = GovernanceWitness{dummy_field: false};
        0x9f064e7c71482219a716295dffd40efb522b4e197200d6ebb684cb6a81d1e367::governance_message::authorize_verify_local<GovernanceWitness>(v0, 0x9f064e7c71482219a716295dffd40efb522b4e197200d6ebb684cb6a81d1e367::state::governance_chain(arg0), 0x9f064e7c71482219a716295dffd40efb522b4e197200d6ebb684cb6a81d1e367::state::governance_contract(arg0), 0x9f064e7c71482219a716295dffd40efb522b4e197200d6ebb684cb6a81d1e367::state::governance_module(), 3)
    }

    fun deserialize(arg0: vector<u8>) : SetFee {
        let v0 = 0x9f064e7c71482219a716295dffd40efb522b4e197200d6ebb684cb6a81d1e367::cursor::new<u8>(arg0);
        0x9f064e7c71482219a716295dffd40efb522b4e197200d6ebb684cb6a81d1e367::cursor::destroy_empty<u8>(v0);
        SetFee{amount: (0x9f064e7c71482219a716295dffd40efb522b4e197200d6ebb684cb6a81d1e367::bytes32::to_u64_be(0x9f064e7c71482219a716295dffd40efb522b4e197200d6ebb684cb6a81d1e367::bytes32::take_bytes(&mut v0)) as u64)}
    }

    // decompiled from Move bytecode v6
}

