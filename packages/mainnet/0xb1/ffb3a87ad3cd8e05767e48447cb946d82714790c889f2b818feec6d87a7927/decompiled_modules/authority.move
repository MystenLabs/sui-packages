module 0xb1ffb3a87ad3cd8e05767e48447cb946d82714790c889f2b818feec6d87a7927::authority {
    public fun authorize(arg0: &mut 0xb1ffb3a87ad3cd8e05767e48447cb946d82714790c889f2b818feec6d87a7927::dev::OracleAggregatorDevIntegration, arg1: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::authority::AuthorityCap<0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::authority::PACKAGE, 0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::authority::ADMIN>) {
        0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::authority::add_authorization(0xb1ffb3a87ad3cd8e05767e48447cb946d82714790c889f2b818feec6d87a7927::dev::borrow_mut_id(arg0, arg1), arg1);
    }

    public fun deauthorize(arg0: &mut 0xb1ffb3a87ad3cd8e05767e48447cb946d82714790c889f2b818feec6d87a7927::dev::OracleAggregatorDevIntegration, arg1: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::authority::AuthorityCap<0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::authority::PACKAGE, 0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::authority::ADMIN>) {
        0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::authority::remove_authorization(0xb1ffb3a87ad3cd8e05767e48447cb946d82714790c889f2b818feec6d87a7927::dev::borrow_mut_id(arg0, arg1), arg1);
    }

    // decompiled from Move bytecode v6
}

