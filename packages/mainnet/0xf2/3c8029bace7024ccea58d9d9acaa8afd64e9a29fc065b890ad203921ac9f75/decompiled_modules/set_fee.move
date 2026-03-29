module 0xf23c8029bace7024ccea58d9d9acaa8afd64e9a29fc065b890ad203921ac9f75::set_fee {
    struct GovernanceWitness has drop {
        dummy_field: bool,
    }

    struct SetFee {
        amount: u64,
    }

    public fun set_fee(arg0: &mut 0xf23c8029bace7024ccea58d9d9acaa8afd64e9a29fc065b890ad203921ac9f75::state::State, arg1: 0xf23c8029bace7024ccea58d9d9acaa8afd64e9a29fc065b890ad203921ac9f75::governance_message::DecreeReceipt<GovernanceWitness>) : u64 {
        let v0 = 0xf23c8029bace7024ccea58d9d9acaa8afd64e9a29fc065b890ad203921ac9f75::state::assert_latest_only(arg0);
        let SetFee { amount: v1 } = deserialize(0xf23c8029bace7024ccea58d9d9acaa8afd64e9a29fc065b890ad203921ac9f75::governance_message::take_payload<GovernanceWitness>(0xf23c8029bace7024ccea58d9d9acaa8afd64e9a29fc065b890ad203921ac9f75::state::borrow_mut_consumed_vaas(&v0, arg0), arg1));
        0xf23c8029bace7024ccea58d9d9acaa8afd64e9a29fc065b890ad203921ac9f75::state::set_message_fee(&v0, arg0, v1);
        v1
    }

    public fun authorize_governance(arg0: &0xf23c8029bace7024ccea58d9d9acaa8afd64e9a29fc065b890ad203921ac9f75::state::State) : 0xf23c8029bace7024ccea58d9d9acaa8afd64e9a29fc065b890ad203921ac9f75::governance_message::DecreeTicket<GovernanceWitness> {
        let v0 = GovernanceWitness{dummy_field: false};
        0xf23c8029bace7024ccea58d9d9acaa8afd64e9a29fc065b890ad203921ac9f75::governance_message::authorize_verify_local<GovernanceWitness>(v0, 0xf23c8029bace7024ccea58d9d9acaa8afd64e9a29fc065b890ad203921ac9f75::state::governance_chain(arg0), 0xf23c8029bace7024ccea58d9d9acaa8afd64e9a29fc065b890ad203921ac9f75::state::governance_contract(arg0), 0xf23c8029bace7024ccea58d9d9acaa8afd64e9a29fc065b890ad203921ac9f75::state::governance_module(), 3)
    }

    fun deserialize(arg0: vector<u8>) : SetFee {
        let v0 = 0xf23c8029bace7024ccea58d9d9acaa8afd64e9a29fc065b890ad203921ac9f75::cursor::new<u8>(arg0);
        0xf23c8029bace7024ccea58d9d9acaa8afd64e9a29fc065b890ad203921ac9f75::cursor::destroy_empty<u8>(v0);
        SetFee{amount: (0xf23c8029bace7024ccea58d9d9acaa8afd64e9a29fc065b890ad203921ac9f75::bytes32::to_u64_be(0xf23c8029bace7024ccea58d9d9acaa8afd64e9a29fc065b890ad203921ac9f75::bytes32::take_bytes(&mut v0)) as u64)}
    }

    // decompiled from Move bytecode v6
}

