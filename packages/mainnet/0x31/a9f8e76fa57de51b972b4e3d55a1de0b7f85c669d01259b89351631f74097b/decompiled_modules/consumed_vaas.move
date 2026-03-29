module 0x31a9f8e76fa57de51b972b4e3d55a1de0b7f85c669d01259b89351631f74097b::consumed_vaas {
    struct ConsumedVAAs has store {
        hashes: 0x31a9f8e76fa57de51b972b4e3d55a1de0b7f85c669d01259b89351631f74097b::set::Set<0x31a9f8e76fa57de51b972b4e3d55a1de0b7f85c669d01259b89351631f74097b::bytes32::Bytes32>,
    }

    public fun consume(arg0: &mut ConsumedVAAs, arg1: 0x31a9f8e76fa57de51b972b4e3d55a1de0b7f85c669d01259b89351631f74097b::bytes32::Bytes32) {
        0x31a9f8e76fa57de51b972b4e3d55a1de0b7f85c669d01259b89351631f74097b::set::add<0x31a9f8e76fa57de51b972b4e3d55a1de0b7f85c669d01259b89351631f74097b::bytes32::Bytes32>(&mut arg0.hashes, arg1);
    }

    public fun new(arg0: &mut 0x2::tx_context::TxContext) : ConsumedVAAs {
        ConsumedVAAs{hashes: 0x31a9f8e76fa57de51b972b4e3d55a1de0b7f85c669d01259b89351631f74097b::set::new<0x31a9f8e76fa57de51b972b4e3d55a1de0b7f85c669d01259b89351631f74097b::bytes32::Bytes32>(arg0)}
    }

    // decompiled from Move bytecode v6
}

