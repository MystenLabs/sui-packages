module 0x293df32871b6ade0e6efd0ba7d4a264fec2dee067040a073e2932458b0afff97::authority {
    public fun authorize(arg0: &mut 0x293df32871b6ade0e6efd0ba7d4a264fec2dee067040a073e2932458b0afff97::pyth::OracleAggregatorPythIntegration, arg1: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::authority::AuthorityCap<0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::authority::PACKAGE, 0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::authority::ADMIN>) {
        0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::authority::add_authorization(0x293df32871b6ade0e6efd0ba7d4a264fec2dee067040a073e2932458b0afff97::pyth::borrow_mut_id(arg0, arg1), arg1);
    }

    public fun deauthorize(arg0: &mut 0x293df32871b6ade0e6efd0ba7d4a264fec2dee067040a073e2932458b0afff97::pyth::OracleAggregatorPythIntegration, arg1: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::authority::AuthorityCap<0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::authority::PACKAGE, 0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::authority::ADMIN>) {
        0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::authority::remove_authorization(0x293df32871b6ade0e6efd0ba7d4a264fec2dee067040a073e2932458b0afff97::pyth::borrow_mut_id(arg0, arg1), arg1);
    }

    // decompiled from Move bytecode v6
}

