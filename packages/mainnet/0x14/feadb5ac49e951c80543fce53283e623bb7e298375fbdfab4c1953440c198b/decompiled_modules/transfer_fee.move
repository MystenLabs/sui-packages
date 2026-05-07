module 0x14feadb5ac49e951c80543fce53283e623bb7e298375fbdfab4c1953440c198b::transfer_fee {
    struct GovernanceWitness has drop {
        dummy_field: bool,
    }

    struct TransferFee {
        amount: u64,
        recipient: address,
    }

    public fun transfer_fee(arg0: &mut 0x14feadb5ac49e951c80543fce53283e623bb7e298375fbdfab4c1953440c198b::state::State, arg1: 0x14feadb5ac49e951c80543fce53283e623bb7e298375fbdfab4c1953440c198b::governance_message::DecreeReceipt<GovernanceWitness>, arg2: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0x14feadb5ac49e951c80543fce53283e623bb7e298375fbdfab4c1953440c198b::state::assert_latest_only(arg0);
        let v1 = 0x14feadb5ac49e951c80543fce53283e623bb7e298375fbdfab4c1953440c198b::governance_message::take_payload<GovernanceWitness>(0x14feadb5ac49e951c80543fce53283e623bb7e298375fbdfab4c1953440c198b::state::borrow_mut_consumed_vaas(&v0, arg0), arg1);
        handle_transfer_fee(&v0, arg0, v1, arg2)
    }

    public fun authorize_governance(arg0: &0x14feadb5ac49e951c80543fce53283e623bb7e298375fbdfab4c1953440c198b::state::State) : 0x14feadb5ac49e951c80543fce53283e623bb7e298375fbdfab4c1953440c198b::governance_message::DecreeTicket<GovernanceWitness> {
        let v0 = GovernanceWitness{dummy_field: false};
        0x14feadb5ac49e951c80543fce53283e623bb7e298375fbdfab4c1953440c198b::governance_message::authorize_verify_local<GovernanceWitness>(v0, 0x14feadb5ac49e951c80543fce53283e623bb7e298375fbdfab4c1953440c198b::state::governance_chain(arg0), 0x14feadb5ac49e951c80543fce53283e623bb7e298375fbdfab4c1953440c198b::state::governance_contract(arg0), 0x14feadb5ac49e951c80543fce53283e623bb7e298375fbdfab4c1953440c198b::state::governance_module(), 4)
    }

    fun deserialize(arg0: vector<u8>) : TransferFee {
        let v0 = 0x14feadb5ac49e951c80543fce53283e623bb7e298375fbdfab4c1953440c198b::cursor::new<u8>(arg0);
        0x14feadb5ac49e951c80543fce53283e623bb7e298375fbdfab4c1953440c198b::cursor::destroy_empty<u8>(v0);
        TransferFee{
            amount    : (0x14feadb5ac49e951c80543fce53283e623bb7e298375fbdfab4c1953440c198b::bytes32::to_u64_be(0x14feadb5ac49e951c80543fce53283e623bb7e298375fbdfab4c1953440c198b::bytes32::take_bytes(&mut v0)) as u64),
            recipient : 0x14feadb5ac49e951c80543fce53283e623bb7e298375fbdfab4c1953440c198b::external_address::to_address(0x14feadb5ac49e951c80543fce53283e623bb7e298375fbdfab4c1953440c198b::external_address::take_nonzero(&mut v0)),
        }
    }

    fun handle_transfer_fee(arg0: &0x14feadb5ac49e951c80543fce53283e623bb7e298375fbdfab4c1953440c198b::state::LatestOnly, arg1: &mut 0x14feadb5ac49e951c80543fce53283e623bb7e298375fbdfab4c1953440c198b::state::State, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) : u64 {
        let TransferFee {
            amount    : v0,
            recipient : v1,
        } = deserialize(arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x14feadb5ac49e951c80543fce53283e623bb7e298375fbdfab4c1953440c198b::state::withdraw_fee(arg0, arg1, v0), arg3), v1);
        v0
    }

    // decompiled from Move bytecode v7
}

