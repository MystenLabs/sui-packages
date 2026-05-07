module 0x9539d4ad25f6ca8e316cb5e97dac6fd9a73d33a0b93db4b1a5071cd629abd55::contract_upgrade {
    struct ContractUpgraded has copy, drop {
        old_contract: 0x2::object::ID,
        new_contract: 0x2::object::ID,
    }

    struct UpgradeContract {
        digest: 0x99de5c967d8206ef4b75c0afab3df2a59eb02b05c282821db803831008ac25b4::bytes32::Bytes32,
    }

    public fun authorize_upgrade(arg0: &mut 0x9539d4ad25f6ca8e316cb5e97dac6fd9a73d33a0b93db4b1a5071cd629abd55::state::State, arg1: 0x9539d4ad25f6ca8e316cb5e97dac6fd9a73d33a0b93db4b1a5071cd629abd55::governance::WormholeVAAVerificationReceipt) : 0x2::package::UpgradeTicket {
        let v0 = 0x9539d4ad25f6ca8e316cb5e97dac6fd9a73d33a0b93db4b1a5071cd629abd55::governance::take_sequence(&arg1);
        assert!(v0 > 0x9539d4ad25f6ca8e316cb5e97dac6fd9a73d33a0b93db4b1a5071cd629abd55::state::get_last_executed_governance_sequence(arg0), 3);
        0x9539d4ad25f6ca8e316cb5e97dac6fd9a73d33a0b93db4b1a5071cd629abd55::state::set_last_executed_governance_sequence_unchecked(arg0, v0);
        handle_upgrade_contract(arg0, take_upgrade_digest(arg1))
    }

    public fun commit_upgrade(arg0: &mut 0x9539d4ad25f6ca8e316cb5e97dac6fd9a73d33a0b93db4b1a5071cd629abd55::state::State, arg1: 0x2::package::UpgradeReceipt) {
        let (v0, v1) = 0x9539d4ad25f6ca8e316cb5e97dac6fd9a73d33a0b93db4b1a5071cd629abd55::state::commit_upgrade(arg0, arg1);
        let v2 = ContractUpgraded{
            old_contract : v0,
            new_contract : v1,
        };
        0x2::event::emit<ContractUpgraded>(v2);
    }

    fun deserialize(arg0: vector<u8>) : UpgradeContract {
        let v0 = 0x99de5c967d8206ef4b75c0afab3df2a59eb02b05c282821db803831008ac25b4::cursor::new<u8>(arg0);
        let v1 = 0x99de5c967d8206ef4b75c0afab3df2a59eb02b05c282821db803831008ac25b4::bytes32::take_bytes(&mut v0);
        assert!(0x99de5c967d8206ef4b75c0afab3df2a59eb02b05c282821db803831008ac25b4::bytes32::is_nonzero(&v1), 0);
        0x99de5c967d8206ef4b75c0afab3df2a59eb02b05c282821db803831008ac25b4::cursor::take_rest<u8>(v0);
        UpgradeContract{digest: v1}
    }

    fun handle_upgrade_contract(arg0: &mut 0x9539d4ad25f6ca8e316cb5e97dac6fd9a73d33a0b93db4b1a5071cd629abd55::state::State, arg1: 0x99de5c967d8206ef4b75c0afab3df2a59eb02b05c282821db803831008ac25b4::bytes32::Bytes32) : 0x2::package::UpgradeTicket {
        0x9539d4ad25f6ca8e316cb5e97dac6fd9a73d33a0b93db4b1a5071cd629abd55::state::authorize_upgrade(arg0, arg1)
    }

    public(friend) fun take_digest(arg0: vector<u8>) : 0x99de5c967d8206ef4b75c0afab3df2a59eb02b05c282821db803831008ac25b4::bytes32::Bytes32 {
        let UpgradeContract { digest: v0 } = deserialize(arg0);
        v0
    }

    public(friend) fun take_upgrade_digest(arg0: 0x9539d4ad25f6ca8e316cb5e97dac6fd9a73d33a0b93db4b1a5071cd629abd55::governance::WormholeVAAVerificationReceipt) : 0x99de5c967d8206ef4b75c0afab3df2a59eb02b05c282821db803831008ac25b4::bytes32::Bytes32 {
        let v0 = 0x9539d4ad25f6ca8e316cb5e97dac6fd9a73d33a0b93db4b1a5071cd629abd55::governance_instruction::from_byte_vec(0x9539d4ad25f6ca8e316cb5e97dac6fd9a73d33a0b93db4b1a5071cd629abd55::governance::take_payload(&arg0));
        assert!(0x9539d4ad25f6ca8e316cb5e97dac6fd9a73d33a0b93db4b1a5071cd629abd55::governance_instruction::get_action(&v0) == 0x9539d4ad25f6ca8e316cb5e97dac6fd9a73d33a0b93db4b1a5071cd629abd55::governance_action::new_contract_upgrade(), 1);
        assert!(0x9539d4ad25f6ca8e316cb5e97dac6fd9a73d33a0b93db4b1a5071cd629abd55::governance_instruction::get_target_chain_id(&v0) != 0, 2);
        0x9539d4ad25f6ca8e316cb5e97dac6fd9a73d33a0b93db4b1a5071cd629abd55::governance::destroy(arg0);
        take_digest(0x9539d4ad25f6ca8e316cb5e97dac6fd9a73d33a0b93db4b1a5071cd629abd55::governance_instruction::destroy(v0))
    }

    // decompiled from Move bytecode v7
}

