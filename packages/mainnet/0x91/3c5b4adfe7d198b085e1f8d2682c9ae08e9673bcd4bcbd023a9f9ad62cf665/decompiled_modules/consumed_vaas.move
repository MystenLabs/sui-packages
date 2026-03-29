module 0x913c5b4adfe7d198b085e1f8d2682c9ae08e9673bcd4bcbd023a9f9ad62cf665::consumed_vaas {
    struct ConsumedVAAs has store {
        hashes: 0x913c5b4adfe7d198b085e1f8d2682c9ae08e9673bcd4bcbd023a9f9ad62cf665::set::Set<0x913c5b4adfe7d198b085e1f8d2682c9ae08e9673bcd4bcbd023a9f9ad62cf665::bytes32::Bytes32>,
    }

    public fun consume(arg0: &mut ConsumedVAAs, arg1: 0x913c5b4adfe7d198b085e1f8d2682c9ae08e9673bcd4bcbd023a9f9ad62cf665::bytes32::Bytes32) {
        0x913c5b4adfe7d198b085e1f8d2682c9ae08e9673bcd4bcbd023a9f9ad62cf665::set::add<0x913c5b4adfe7d198b085e1f8d2682c9ae08e9673bcd4bcbd023a9f9ad62cf665::bytes32::Bytes32>(&mut arg0.hashes, arg1);
    }

    public fun new(arg0: &mut 0x2::tx_context::TxContext) : ConsumedVAAs {
        ConsumedVAAs{hashes: 0x913c5b4adfe7d198b085e1f8d2682c9ae08e9673bcd4bcbd023a9f9ad62cf665::set::new<0x913c5b4adfe7d198b085e1f8d2682c9ae08e9673bcd4bcbd023a9f9ad62cf665::bytes32::Bytes32>(arg0)}
    }

    // decompiled from Move bytecode v6
}

