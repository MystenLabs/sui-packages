module 0x3ab442fe7bdf90fcb990f72a4df4ed786d49f7dc5d907a47db27d8599b795e31::set_fee {
    struct GovernanceWitness has drop {
        dummy_field: bool,
    }

    struct SetFee {
        amount: u64,
    }

    public fun set_fee(arg0: &mut 0x3ab442fe7bdf90fcb990f72a4df4ed786d49f7dc5d907a47db27d8599b795e31::state::State, arg1: 0x3ab442fe7bdf90fcb990f72a4df4ed786d49f7dc5d907a47db27d8599b795e31::governance_message::DecreeReceipt<GovernanceWitness>) : u64 {
        let v0 = 0x3ab442fe7bdf90fcb990f72a4df4ed786d49f7dc5d907a47db27d8599b795e31::state::assert_latest_only(arg0);
        let SetFee { amount: v1 } = deserialize(0x3ab442fe7bdf90fcb990f72a4df4ed786d49f7dc5d907a47db27d8599b795e31::governance_message::take_payload<GovernanceWitness>(0x3ab442fe7bdf90fcb990f72a4df4ed786d49f7dc5d907a47db27d8599b795e31::state::borrow_mut_consumed_vaas(&v0, arg0), arg1));
        0x3ab442fe7bdf90fcb990f72a4df4ed786d49f7dc5d907a47db27d8599b795e31::state::set_message_fee(&v0, arg0, v1);
        v1
    }

    public fun authorize_governance(arg0: &0x3ab442fe7bdf90fcb990f72a4df4ed786d49f7dc5d907a47db27d8599b795e31::state::State) : 0x3ab442fe7bdf90fcb990f72a4df4ed786d49f7dc5d907a47db27d8599b795e31::governance_message::DecreeTicket<GovernanceWitness> {
        let v0 = GovernanceWitness{dummy_field: false};
        0x3ab442fe7bdf90fcb990f72a4df4ed786d49f7dc5d907a47db27d8599b795e31::governance_message::authorize_verify_local<GovernanceWitness>(v0, 0x3ab442fe7bdf90fcb990f72a4df4ed786d49f7dc5d907a47db27d8599b795e31::state::governance_chain(arg0), 0x3ab442fe7bdf90fcb990f72a4df4ed786d49f7dc5d907a47db27d8599b795e31::state::governance_contract(arg0), 0x3ab442fe7bdf90fcb990f72a4df4ed786d49f7dc5d907a47db27d8599b795e31::state::governance_module(), 3)
    }

    fun deserialize(arg0: vector<u8>) : SetFee {
        let v0 = 0x3ab442fe7bdf90fcb990f72a4df4ed786d49f7dc5d907a47db27d8599b795e31::cursor::new<u8>(arg0);
        0x3ab442fe7bdf90fcb990f72a4df4ed786d49f7dc5d907a47db27d8599b795e31::cursor::destroy_empty<u8>(v0);
        SetFee{amount: (0x3ab442fe7bdf90fcb990f72a4df4ed786d49f7dc5d907a47db27d8599b795e31::bytes32::to_u64_be(0x3ab442fe7bdf90fcb990f72a4df4ed786d49f7dc5d907a47db27d8599b795e31::bytes32::take_bytes(&mut v0)) as u64)}
    }

    // decompiled from Move bytecode v6
}

