module 0x14feadb5ac49e951c80543fce53283e623bb7e298375fbdfab4c1953440c198b::upgrade_contract {
    struct GovernanceWitness has drop {
        dummy_field: bool,
    }

    struct ContractUpgraded has copy, drop {
        old_contract: 0x2::object::ID,
        new_contract: 0x2::object::ID,
    }

    struct UpgradeContract {
        digest: 0x14feadb5ac49e951c80543fce53283e623bb7e298375fbdfab4c1953440c198b::bytes32::Bytes32,
    }

    public fun authorize_upgrade(arg0: &mut 0x14feadb5ac49e951c80543fce53283e623bb7e298375fbdfab4c1953440c198b::state::State, arg1: 0x14feadb5ac49e951c80543fce53283e623bb7e298375fbdfab4c1953440c198b::governance_message::DecreeReceipt<GovernanceWitness>) : 0x2::package::UpgradeTicket {
        let v0 = 0x14feadb5ac49e951c80543fce53283e623bb7e298375fbdfab4c1953440c198b::governance_message::take_payload<GovernanceWitness>(0x14feadb5ac49e951c80543fce53283e623bb7e298375fbdfab4c1953440c198b::state::borrow_mut_consumed_vaas_unchecked(arg0), arg1);
        handle_upgrade_contract(arg0, v0)
    }

    public fun commit_upgrade(arg0: &mut 0x14feadb5ac49e951c80543fce53283e623bb7e298375fbdfab4c1953440c198b::state::State, arg1: 0x2::package::UpgradeReceipt) {
        let (v0, v1) = 0x14feadb5ac49e951c80543fce53283e623bb7e298375fbdfab4c1953440c198b::state::commit_upgrade(arg0, arg1);
        let v2 = ContractUpgraded{
            old_contract : v0,
            new_contract : v1,
        };
        0x2::event::emit<ContractUpgraded>(v2);
    }

    public fun authorize_governance(arg0: &0x14feadb5ac49e951c80543fce53283e623bb7e298375fbdfab4c1953440c198b::state::State) : 0x14feadb5ac49e951c80543fce53283e623bb7e298375fbdfab4c1953440c198b::governance_message::DecreeTicket<GovernanceWitness> {
        let v0 = GovernanceWitness{dummy_field: false};
        0x14feadb5ac49e951c80543fce53283e623bb7e298375fbdfab4c1953440c198b::governance_message::authorize_verify_local<GovernanceWitness>(v0, 0x14feadb5ac49e951c80543fce53283e623bb7e298375fbdfab4c1953440c198b::state::governance_chain(arg0), 0x14feadb5ac49e951c80543fce53283e623bb7e298375fbdfab4c1953440c198b::state::governance_contract(arg0), 0x14feadb5ac49e951c80543fce53283e623bb7e298375fbdfab4c1953440c198b::state::governance_module(), 1)
    }

    fun deserialize(arg0: vector<u8>) : UpgradeContract {
        let v0 = 0x14feadb5ac49e951c80543fce53283e623bb7e298375fbdfab4c1953440c198b::cursor::new<u8>(arg0);
        let v1 = 0x14feadb5ac49e951c80543fce53283e623bb7e298375fbdfab4c1953440c198b::bytes32::take_bytes(&mut v0);
        assert!(0x14feadb5ac49e951c80543fce53283e623bb7e298375fbdfab4c1953440c198b::bytes32::is_nonzero(&v1), 0);
        0x14feadb5ac49e951c80543fce53283e623bb7e298375fbdfab4c1953440c198b::cursor::destroy_empty<u8>(v0);
        UpgradeContract{digest: v1}
    }

    fun handle_upgrade_contract(arg0: &mut 0x14feadb5ac49e951c80543fce53283e623bb7e298375fbdfab4c1953440c198b::state::State, arg1: vector<u8>) : 0x2::package::UpgradeTicket {
        0x14feadb5ac49e951c80543fce53283e623bb7e298375fbdfab4c1953440c198b::state::authorize_upgrade(arg0, take_digest(arg1))
    }

    public(friend) fun take_digest(arg0: vector<u8>) : 0x14feadb5ac49e951c80543fce53283e623bb7e298375fbdfab4c1953440c198b::bytes32::Bytes32 {
        let UpgradeContract { digest: v0 } = deserialize(arg0);
        v0
    }

    // decompiled from Move bytecode v7
}

