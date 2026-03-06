module 0x44861426b2e5e2b388e04f314cdca9a9a231db74e63b81ba09efae99812fa556::authority {
    public fun authorize(arg0: &mut 0x44861426b2e5e2b388e04f314cdca9a9a231db74e63b81ba09efae99812fa556::pyth_lazer::OracleAggregatorPythLazerIntegration, arg1: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::authority::AuthorityCap<0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::authority::PACKAGE, 0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::authority::ADMIN>) {
        0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::authority::add_authorization(0x44861426b2e5e2b388e04f314cdca9a9a231db74e63b81ba09efae99812fa556::pyth_lazer::borrow_mut_id<0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::authority::ADMIN>(arg0, arg1), arg1);
    }

    public fun deauthorize(arg0: &mut 0x44861426b2e5e2b388e04f314cdca9a9a231db74e63b81ba09efae99812fa556::pyth_lazer::OracleAggregatorPythLazerIntegration, arg1: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::authority::AuthorityCap<0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::authority::PACKAGE, 0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::authority::ADMIN>) {
        0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::authority::remove_authorization(0x44861426b2e5e2b388e04f314cdca9a9a231db74e63b81ba09efae99812fa556::pyth_lazer::borrow_mut_id<0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::authority::ADMIN>(arg0, arg1), arg1);
    }

    // decompiled from Move bytecode v6
}

