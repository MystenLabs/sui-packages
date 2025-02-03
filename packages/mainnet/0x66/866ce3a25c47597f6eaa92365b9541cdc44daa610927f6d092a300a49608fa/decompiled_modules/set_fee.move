module 0x66866ce3a25c47597f6eaa92365b9541cdc44daa610927f6d092a300a49608fa::set_fee {
    struct GovernanceWitness has drop {
        dummy_field: bool,
    }

    struct SetFee {
        amount: u64,
    }

    public fun set_fee(arg0: &mut 0x66866ce3a25c47597f6eaa92365b9541cdc44daa610927f6d092a300a49608fa::state::State, arg1: 0x66866ce3a25c47597f6eaa92365b9541cdc44daa610927f6d092a300a49608fa::governance_message::DecreeReceipt<GovernanceWitness>) : u64 {
        let v0 = 0x66866ce3a25c47597f6eaa92365b9541cdc44daa610927f6d092a300a49608fa::state::assert_latest_only(arg0);
        let SetFee { amount: v1 } = deserialize(0x66866ce3a25c47597f6eaa92365b9541cdc44daa610927f6d092a300a49608fa::governance_message::take_payload<GovernanceWitness>(0x66866ce3a25c47597f6eaa92365b9541cdc44daa610927f6d092a300a49608fa::state::borrow_mut_consumed_vaas(&v0, arg0), arg1));
        0x66866ce3a25c47597f6eaa92365b9541cdc44daa610927f6d092a300a49608fa::state::set_message_fee(&v0, arg0, v1);
        v1
    }

    public fun authorize_governance(arg0: &0x66866ce3a25c47597f6eaa92365b9541cdc44daa610927f6d092a300a49608fa::state::State) : 0x66866ce3a25c47597f6eaa92365b9541cdc44daa610927f6d092a300a49608fa::governance_message::DecreeTicket<GovernanceWitness> {
        let v0 = GovernanceWitness{dummy_field: false};
        0x66866ce3a25c47597f6eaa92365b9541cdc44daa610927f6d092a300a49608fa::governance_message::authorize_verify_local<GovernanceWitness>(v0, 0x66866ce3a25c47597f6eaa92365b9541cdc44daa610927f6d092a300a49608fa::state::governance_chain(arg0), 0x66866ce3a25c47597f6eaa92365b9541cdc44daa610927f6d092a300a49608fa::state::governance_contract(arg0), 0x66866ce3a25c47597f6eaa92365b9541cdc44daa610927f6d092a300a49608fa::state::governance_module(), 3)
    }

    fun deserialize(arg0: vector<u8>) : SetFee {
        let v0 = 0x66866ce3a25c47597f6eaa92365b9541cdc44daa610927f6d092a300a49608fa::cursor::new<u8>(arg0);
        0x66866ce3a25c47597f6eaa92365b9541cdc44daa610927f6d092a300a49608fa::cursor::destroy_empty<u8>(v0);
        SetFee{amount: (0x66866ce3a25c47597f6eaa92365b9541cdc44daa610927f6d092a300a49608fa::bytes32::to_u64_be(0x66866ce3a25c47597f6eaa92365b9541cdc44daa610927f6d092a300a49608fa::bytes32::take_bytes(&mut v0)) as u64)}
    }

    // decompiled from Move bytecode v6
}

