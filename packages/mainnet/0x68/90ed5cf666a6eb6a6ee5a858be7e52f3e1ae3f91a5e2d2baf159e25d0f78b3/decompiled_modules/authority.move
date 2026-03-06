module 0x6890ed5cf666a6eb6a6ee5a858be7e52f3e1ae3f91a5e2d2baf159e25d0f78b3::authority {
    public fun authorize(arg0: &mut 0x6890ed5cf666a6eb6a6ee5a858be7e52f3e1ae3f91a5e2d2baf159e25d0f78b3::pyth_lazer_rolling::OracleAggregatorPythLazerRollingIntegration, arg1: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::authority::AuthorityCap<0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::authority::PACKAGE, 0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::authority::ADMIN>) {
        0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::authority::add_authorization(0x6890ed5cf666a6eb6a6ee5a858be7e52f3e1ae3f91a5e2d2baf159e25d0f78b3::pyth_lazer_rolling::borrow_mut_id<0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::authority::ADMIN>(arg0, arg1), arg1);
    }

    public fun deauthorize(arg0: &mut 0x6890ed5cf666a6eb6a6ee5a858be7e52f3e1ae3f91a5e2d2baf159e25d0f78b3::pyth_lazer_rolling::OracleAggregatorPythLazerRollingIntegration, arg1: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::authority::AuthorityCap<0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::authority::PACKAGE, 0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::authority::ADMIN>) {
        0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::authority::remove_authorization(0x6890ed5cf666a6eb6a6ee5a858be7e52f3e1ae3f91a5e2d2baf159e25d0f78b3::pyth_lazer_rolling::borrow_mut_id<0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::authority::ADMIN>(arg0, arg1), arg1);
    }

    // decompiled from Move bytecode v6
}

