module 0xf23c8029bace7024ccea58d9d9acaa8afd64e9a29fc065b890ad203921ac9f75::transfer_fee {
    struct GovernanceWitness has drop {
        dummy_field: bool,
    }

    struct TransferFee {
        amount: u64,
        recipient: address,
    }

    public fun transfer_fee(arg0: &mut 0xf23c8029bace7024ccea58d9d9acaa8afd64e9a29fc065b890ad203921ac9f75::state::State, arg1: 0xf23c8029bace7024ccea58d9d9acaa8afd64e9a29fc065b890ad203921ac9f75::governance_message::DecreeReceipt<GovernanceWitness>, arg2: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0xf23c8029bace7024ccea58d9d9acaa8afd64e9a29fc065b890ad203921ac9f75::state::assert_latest_only(arg0);
        let v1 = 0xf23c8029bace7024ccea58d9d9acaa8afd64e9a29fc065b890ad203921ac9f75::governance_message::take_payload<GovernanceWitness>(0xf23c8029bace7024ccea58d9d9acaa8afd64e9a29fc065b890ad203921ac9f75::state::borrow_mut_consumed_vaas(&v0, arg0), arg1);
        handle_transfer_fee(&v0, arg0, v1, arg2)
    }

    public fun authorize_governance(arg0: &0xf23c8029bace7024ccea58d9d9acaa8afd64e9a29fc065b890ad203921ac9f75::state::State) : 0xf23c8029bace7024ccea58d9d9acaa8afd64e9a29fc065b890ad203921ac9f75::governance_message::DecreeTicket<GovernanceWitness> {
        let v0 = GovernanceWitness{dummy_field: false};
        0xf23c8029bace7024ccea58d9d9acaa8afd64e9a29fc065b890ad203921ac9f75::governance_message::authorize_verify_local<GovernanceWitness>(v0, 0xf23c8029bace7024ccea58d9d9acaa8afd64e9a29fc065b890ad203921ac9f75::state::governance_chain(arg0), 0xf23c8029bace7024ccea58d9d9acaa8afd64e9a29fc065b890ad203921ac9f75::state::governance_contract(arg0), 0xf23c8029bace7024ccea58d9d9acaa8afd64e9a29fc065b890ad203921ac9f75::state::governance_module(), 4)
    }

    fun deserialize(arg0: vector<u8>) : TransferFee {
        let v0 = 0xf23c8029bace7024ccea58d9d9acaa8afd64e9a29fc065b890ad203921ac9f75::cursor::new<u8>(arg0);
        0xf23c8029bace7024ccea58d9d9acaa8afd64e9a29fc065b890ad203921ac9f75::cursor::destroy_empty<u8>(v0);
        TransferFee{
            amount    : (0xf23c8029bace7024ccea58d9d9acaa8afd64e9a29fc065b890ad203921ac9f75::bytes32::to_u64_be(0xf23c8029bace7024ccea58d9d9acaa8afd64e9a29fc065b890ad203921ac9f75::bytes32::take_bytes(&mut v0)) as u64),
            recipient : 0xf23c8029bace7024ccea58d9d9acaa8afd64e9a29fc065b890ad203921ac9f75::external_address::to_address(0xf23c8029bace7024ccea58d9d9acaa8afd64e9a29fc065b890ad203921ac9f75::external_address::take_nonzero(&mut v0)),
        }
    }

    fun handle_transfer_fee(arg0: &0xf23c8029bace7024ccea58d9d9acaa8afd64e9a29fc065b890ad203921ac9f75::state::LatestOnly, arg1: &mut 0xf23c8029bace7024ccea58d9d9acaa8afd64e9a29fc065b890ad203921ac9f75::state::State, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) : u64 {
        let TransferFee {
            amount    : v0,
            recipient : v1,
        } = deserialize(arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0xf23c8029bace7024ccea58d9d9acaa8afd64e9a29fc065b890ad203921ac9f75::state::withdraw_fee(arg0, arg1, v0), arg3), v1);
        v0
    }

    // decompiled from Move bytecode v6
}

