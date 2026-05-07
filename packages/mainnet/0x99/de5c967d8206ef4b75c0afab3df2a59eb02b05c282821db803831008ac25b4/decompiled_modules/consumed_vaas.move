module 0x99de5c967d8206ef4b75c0afab3df2a59eb02b05c282821db803831008ac25b4::consumed_vaas {
    struct ConsumedVAAs has store {
        hashes: 0x99de5c967d8206ef4b75c0afab3df2a59eb02b05c282821db803831008ac25b4::set::Set<0x99de5c967d8206ef4b75c0afab3df2a59eb02b05c282821db803831008ac25b4::bytes32::Bytes32>,
    }

    public fun consume(arg0: &mut ConsumedVAAs, arg1: 0x99de5c967d8206ef4b75c0afab3df2a59eb02b05c282821db803831008ac25b4::bytes32::Bytes32) {
        0x99de5c967d8206ef4b75c0afab3df2a59eb02b05c282821db803831008ac25b4::set::add<0x99de5c967d8206ef4b75c0afab3df2a59eb02b05c282821db803831008ac25b4::bytes32::Bytes32>(&mut arg0.hashes, arg1);
    }

    public fun new(arg0: &mut 0x2::tx_context::TxContext) : ConsumedVAAs {
        ConsumedVAAs{hashes: 0x99de5c967d8206ef4b75c0afab3df2a59eb02b05c282821db803831008ac25b4::set::new<0x99de5c967d8206ef4b75c0afab3df2a59eb02b05c282821db803831008ac25b4::bytes32::Bytes32>(arg0)}
    }

    // decompiled from Move bytecode v6
}

