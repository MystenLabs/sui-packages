module 0xb1751bdfcc38e7d1b6b6f42ecc231a637c0ede7109ff2e4f1fa6946af8d36184::authority {
    public fun authorize(arg0: &mut 0xb1751bdfcc38e7d1b6b6f42ecc231a637c0ede7109ff2e4f1fa6946af8d36184::pyth_lazer_rolling::OracleAggregatorPythLazerRollingIntegration, arg1: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::authority::AuthorityCap<0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::authority::PACKAGE, 0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::authority::ADMIN>) {
        0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::authority::add_authorization(0xb1751bdfcc38e7d1b6b6f42ecc231a637c0ede7109ff2e4f1fa6946af8d36184::pyth_lazer_rolling::borrow_mut_id<0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::authority::ADMIN>(arg0, arg1), arg1);
    }

    public fun deauthorize(arg0: &mut 0xb1751bdfcc38e7d1b6b6f42ecc231a637c0ede7109ff2e4f1fa6946af8d36184::pyth_lazer_rolling::OracleAggregatorPythLazerRollingIntegration, arg1: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::authority::AuthorityCap<0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::authority::PACKAGE, 0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::authority::ADMIN>) {
        0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::authority::remove_authorization(0xb1751bdfcc38e7d1b6b6f42ecc231a637c0ede7109ff2e4f1fa6946af8d36184::pyth_lazer_rolling::borrow_mut_id<0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::authority::ADMIN>(arg0, arg1), arg1);
    }

    // decompiled from Move bytecode v6
}

