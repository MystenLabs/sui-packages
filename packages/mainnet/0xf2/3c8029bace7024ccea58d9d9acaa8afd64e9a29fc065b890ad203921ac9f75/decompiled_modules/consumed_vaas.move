module 0xf23c8029bace7024ccea58d9d9acaa8afd64e9a29fc065b890ad203921ac9f75::consumed_vaas {
    struct ConsumedVAAs has store {
        hashes: 0xf23c8029bace7024ccea58d9d9acaa8afd64e9a29fc065b890ad203921ac9f75::set::Set<0xf23c8029bace7024ccea58d9d9acaa8afd64e9a29fc065b890ad203921ac9f75::bytes32::Bytes32>,
    }

    public fun consume(arg0: &mut ConsumedVAAs, arg1: 0xf23c8029bace7024ccea58d9d9acaa8afd64e9a29fc065b890ad203921ac9f75::bytes32::Bytes32) {
        0xf23c8029bace7024ccea58d9d9acaa8afd64e9a29fc065b890ad203921ac9f75::set::add<0xf23c8029bace7024ccea58d9d9acaa8afd64e9a29fc065b890ad203921ac9f75::bytes32::Bytes32>(&mut arg0.hashes, arg1);
    }

    public fun new(arg0: &mut 0x2::tx_context::TxContext) : ConsumedVAAs {
        ConsumedVAAs{hashes: 0xf23c8029bace7024ccea58d9d9acaa8afd64e9a29fc065b890ad203921ac9f75::set::new<0xf23c8029bace7024ccea58d9d9acaa8afd64e9a29fc065b890ad203921ac9f75::bytes32::Bytes32>(arg0)}
    }

    // decompiled from Move bytecode v6
}

