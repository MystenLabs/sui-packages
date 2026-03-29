module 0x31a9f8e76fa57de51b972b4e3d55a1de0b7f85c669d01259b89351631f74097b::set_fee {
    struct GovernanceWitness has drop {
        dummy_field: bool,
    }

    struct SetFee {
        amount: u64,
    }

    public fun set_fee(arg0: &mut 0x31a9f8e76fa57de51b972b4e3d55a1de0b7f85c669d01259b89351631f74097b::state::State, arg1: 0x31a9f8e76fa57de51b972b4e3d55a1de0b7f85c669d01259b89351631f74097b::governance_message::DecreeReceipt<GovernanceWitness>) : u64 {
        let v0 = 0x31a9f8e76fa57de51b972b4e3d55a1de0b7f85c669d01259b89351631f74097b::state::assert_latest_only(arg0);
        let SetFee { amount: v1 } = deserialize(0x31a9f8e76fa57de51b972b4e3d55a1de0b7f85c669d01259b89351631f74097b::governance_message::take_payload<GovernanceWitness>(0x31a9f8e76fa57de51b972b4e3d55a1de0b7f85c669d01259b89351631f74097b::state::borrow_mut_consumed_vaas(&v0, arg0), arg1));
        0x31a9f8e76fa57de51b972b4e3d55a1de0b7f85c669d01259b89351631f74097b::state::set_message_fee(&v0, arg0, v1);
        v1
    }

    public fun authorize_governance(arg0: &0x31a9f8e76fa57de51b972b4e3d55a1de0b7f85c669d01259b89351631f74097b::state::State) : 0x31a9f8e76fa57de51b972b4e3d55a1de0b7f85c669d01259b89351631f74097b::governance_message::DecreeTicket<GovernanceWitness> {
        let v0 = GovernanceWitness{dummy_field: false};
        0x31a9f8e76fa57de51b972b4e3d55a1de0b7f85c669d01259b89351631f74097b::governance_message::authorize_verify_local<GovernanceWitness>(v0, 0x31a9f8e76fa57de51b972b4e3d55a1de0b7f85c669d01259b89351631f74097b::state::governance_chain(arg0), 0x31a9f8e76fa57de51b972b4e3d55a1de0b7f85c669d01259b89351631f74097b::state::governance_contract(arg0), 0x31a9f8e76fa57de51b972b4e3d55a1de0b7f85c669d01259b89351631f74097b::state::governance_module(), 3)
    }

    fun deserialize(arg0: vector<u8>) : SetFee {
        let v0 = 0x31a9f8e76fa57de51b972b4e3d55a1de0b7f85c669d01259b89351631f74097b::cursor::new<u8>(arg0);
        0x31a9f8e76fa57de51b972b4e3d55a1de0b7f85c669d01259b89351631f74097b::cursor::destroy_empty<u8>(v0);
        SetFee{amount: (0x31a9f8e76fa57de51b972b4e3d55a1de0b7f85c669d01259b89351631f74097b::bytes32::to_u64_be(0x31a9f8e76fa57de51b972b4e3d55a1de0b7f85c669d01259b89351631f74097b::bytes32::take_bytes(&mut v0)) as u64)}
    }

    // decompiled from Move bytecode v6
}

