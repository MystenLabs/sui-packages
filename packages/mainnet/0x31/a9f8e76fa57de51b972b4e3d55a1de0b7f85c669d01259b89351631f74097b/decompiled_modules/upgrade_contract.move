module 0x31a9f8e76fa57de51b972b4e3d55a1de0b7f85c669d01259b89351631f74097b::upgrade_contract {
    struct GovernanceWitness has drop {
        dummy_field: bool,
    }

    struct ContractUpgraded has copy, drop {
        old_contract: 0x2::object::ID,
        new_contract: 0x2::object::ID,
    }

    struct UpgradeContract {
        digest: 0x31a9f8e76fa57de51b972b4e3d55a1de0b7f85c669d01259b89351631f74097b::bytes32::Bytes32,
    }

    public fun authorize_upgrade(arg0: &mut 0x31a9f8e76fa57de51b972b4e3d55a1de0b7f85c669d01259b89351631f74097b::state::State, arg1: 0x31a9f8e76fa57de51b972b4e3d55a1de0b7f85c669d01259b89351631f74097b::governance_message::DecreeReceipt<GovernanceWitness>) : 0x2::package::UpgradeTicket {
        let v0 = 0x31a9f8e76fa57de51b972b4e3d55a1de0b7f85c669d01259b89351631f74097b::governance_message::take_payload<GovernanceWitness>(0x31a9f8e76fa57de51b972b4e3d55a1de0b7f85c669d01259b89351631f74097b::state::borrow_mut_consumed_vaas_unchecked(arg0), arg1);
        handle_upgrade_contract(arg0, v0)
    }

    public fun commit_upgrade(arg0: &mut 0x31a9f8e76fa57de51b972b4e3d55a1de0b7f85c669d01259b89351631f74097b::state::State, arg1: 0x2::package::UpgradeReceipt) {
        let (v0, v1) = 0x31a9f8e76fa57de51b972b4e3d55a1de0b7f85c669d01259b89351631f74097b::state::commit_upgrade(arg0, arg1);
        let v2 = ContractUpgraded{
            old_contract : v0,
            new_contract : v1,
        };
        0x2::event::emit<ContractUpgraded>(v2);
    }

    public fun authorize_governance(arg0: &0x31a9f8e76fa57de51b972b4e3d55a1de0b7f85c669d01259b89351631f74097b::state::State) : 0x31a9f8e76fa57de51b972b4e3d55a1de0b7f85c669d01259b89351631f74097b::governance_message::DecreeTicket<GovernanceWitness> {
        let v0 = GovernanceWitness{dummy_field: false};
        0x31a9f8e76fa57de51b972b4e3d55a1de0b7f85c669d01259b89351631f74097b::governance_message::authorize_verify_local<GovernanceWitness>(v0, 0x31a9f8e76fa57de51b972b4e3d55a1de0b7f85c669d01259b89351631f74097b::state::governance_chain(arg0), 0x31a9f8e76fa57de51b972b4e3d55a1de0b7f85c669d01259b89351631f74097b::state::governance_contract(arg0), 0x31a9f8e76fa57de51b972b4e3d55a1de0b7f85c669d01259b89351631f74097b::state::governance_module(), 1)
    }

    fun deserialize(arg0: vector<u8>) : UpgradeContract {
        let v0 = 0x31a9f8e76fa57de51b972b4e3d55a1de0b7f85c669d01259b89351631f74097b::cursor::new<u8>(arg0);
        let v1 = 0x31a9f8e76fa57de51b972b4e3d55a1de0b7f85c669d01259b89351631f74097b::bytes32::take_bytes(&mut v0);
        assert!(0x31a9f8e76fa57de51b972b4e3d55a1de0b7f85c669d01259b89351631f74097b::bytes32::is_nonzero(&v1), 0);
        0x31a9f8e76fa57de51b972b4e3d55a1de0b7f85c669d01259b89351631f74097b::cursor::destroy_empty<u8>(v0);
        UpgradeContract{digest: v1}
    }

    fun handle_upgrade_contract(arg0: &mut 0x31a9f8e76fa57de51b972b4e3d55a1de0b7f85c669d01259b89351631f74097b::state::State, arg1: vector<u8>) : 0x2::package::UpgradeTicket {
        0x31a9f8e76fa57de51b972b4e3d55a1de0b7f85c669d01259b89351631f74097b::state::authorize_upgrade(arg0, take_digest(arg1))
    }

    public(friend) fun take_digest(arg0: vector<u8>) : 0x31a9f8e76fa57de51b972b4e3d55a1de0b7f85c669d01259b89351631f74097b::bytes32::Bytes32 {
        let UpgradeContract { digest: v0 } = deserialize(arg0);
        v0
    }

    // decompiled from Move bytecode v6
}

