module 0x14feadb5ac49e951c80543fce53283e623bb7e298375fbdfab4c1953440c198b::set_fee {
    struct GovernanceWitness has drop {
        dummy_field: bool,
    }

    struct SetFee {
        amount: u64,
    }

    public fun set_fee(arg0: &mut 0x14feadb5ac49e951c80543fce53283e623bb7e298375fbdfab4c1953440c198b::state::State, arg1: 0x14feadb5ac49e951c80543fce53283e623bb7e298375fbdfab4c1953440c198b::governance_message::DecreeReceipt<GovernanceWitness>) : u64 {
        let v0 = 0x14feadb5ac49e951c80543fce53283e623bb7e298375fbdfab4c1953440c198b::state::assert_latest_only(arg0);
        let SetFee { amount: v1 } = deserialize(0x14feadb5ac49e951c80543fce53283e623bb7e298375fbdfab4c1953440c198b::governance_message::take_payload<GovernanceWitness>(0x14feadb5ac49e951c80543fce53283e623bb7e298375fbdfab4c1953440c198b::state::borrow_mut_consumed_vaas(&v0, arg0), arg1));
        0x14feadb5ac49e951c80543fce53283e623bb7e298375fbdfab4c1953440c198b::state::set_message_fee(&v0, arg0, v1);
        v1
    }

    public fun authorize_governance(arg0: &0x14feadb5ac49e951c80543fce53283e623bb7e298375fbdfab4c1953440c198b::state::State) : 0x14feadb5ac49e951c80543fce53283e623bb7e298375fbdfab4c1953440c198b::governance_message::DecreeTicket<GovernanceWitness> {
        let v0 = GovernanceWitness{dummy_field: false};
        0x14feadb5ac49e951c80543fce53283e623bb7e298375fbdfab4c1953440c198b::governance_message::authorize_verify_local<GovernanceWitness>(v0, 0x14feadb5ac49e951c80543fce53283e623bb7e298375fbdfab4c1953440c198b::state::governance_chain(arg0), 0x14feadb5ac49e951c80543fce53283e623bb7e298375fbdfab4c1953440c198b::state::governance_contract(arg0), 0x14feadb5ac49e951c80543fce53283e623bb7e298375fbdfab4c1953440c198b::state::governance_module(), 3)
    }

    fun deserialize(arg0: vector<u8>) : SetFee {
        let v0 = 0x14feadb5ac49e951c80543fce53283e623bb7e298375fbdfab4c1953440c198b::cursor::new<u8>(arg0);
        0x14feadb5ac49e951c80543fce53283e623bb7e298375fbdfab4c1953440c198b::cursor::destroy_empty<u8>(v0);
        SetFee{amount: (0x14feadb5ac49e951c80543fce53283e623bb7e298375fbdfab4c1953440c198b::bytes32::to_u64_be(0x14feadb5ac49e951c80543fce53283e623bb7e298375fbdfab4c1953440c198b::bytes32::take_bytes(&mut v0)) as u64)}
    }

    // decompiled from Move bytecode v7
}

