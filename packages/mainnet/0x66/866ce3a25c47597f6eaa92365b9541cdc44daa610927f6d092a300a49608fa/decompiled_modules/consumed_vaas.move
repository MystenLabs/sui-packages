module 0x66866ce3a25c47597f6eaa92365b9541cdc44daa610927f6d092a300a49608fa::consumed_vaas {
    struct ConsumedVAAs has store {
        hashes: 0x66866ce3a25c47597f6eaa92365b9541cdc44daa610927f6d092a300a49608fa::set::Set<0x66866ce3a25c47597f6eaa92365b9541cdc44daa610927f6d092a300a49608fa::bytes32::Bytes32>,
    }

    public fun consume(arg0: &mut ConsumedVAAs, arg1: 0x66866ce3a25c47597f6eaa92365b9541cdc44daa610927f6d092a300a49608fa::bytes32::Bytes32) {
        0x66866ce3a25c47597f6eaa92365b9541cdc44daa610927f6d092a300a49608fa::set::add<0x66866ce3a25c47597f6eaa92365b9541cdc44daa610927f6d092a300a49608fa::bytes32::Bytes32>(&mut arg0.hashes, arg1);
    }

    public fun new(arg0: &mut 0x2::tx_context::TxContext) : ConsumedVAAs {
        ConsumedVAAs{hashes: 0x66866ce3a25c47597f6eaa92365b9541cdc44daa610927f6d092a300a49608fa::set::new<0x66866ce3a25c47597f6eaa92365b9541cdc44daa610927f6d092a300a49608fa::bytes32::Bytes32>(arg0)}
    }

    // decompiled from Move bytecode v6
}

