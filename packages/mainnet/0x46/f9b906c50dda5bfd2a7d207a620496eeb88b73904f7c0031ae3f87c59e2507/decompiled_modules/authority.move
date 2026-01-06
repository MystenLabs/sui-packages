module 0x46f9b906c50dda5bfd2a7d207a620496eeb88b73904f7c0031ae3f87c59e2507::authority {
    public fun authorize(arg0: &mut 0x46f9b906c50dda5bfd2a7d207a620496eeb88b73904f7c0031ae3f87c59e2507::stork::OracleAggregatorStorkIntegration, arg1: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::authority::AuthorityCap<0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::authority::PACKAGE, 0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::authority::ADMIN>) {
        0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::authority::add_authorization(0x46f9b906c50dda5bfd2a7d207a620496eeb88b73904f7c0031ae3f87c59e2507::stork::borrow_mut_id<0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::authority::ADMIN>(arg0, arg1), arg1);
    }

    public fun deauthorize(arg0: &mut 0x46f9b906c50dda5bfd2a7d207a620496eeb88b73904f7c0031ae3f87c59e2507::stork::OracleAggregatorStorkIntegration, arg1: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::authority::AuthorityCap<0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::authority::PACKAGE, 0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::authority::ADMIN>) {
        0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::authority::remove_authorization(0x46f9b906c50dda5bfd2a7d207a620496eeb88b73904f7c0031ae3f87c59e2507::stork::borrow_mut_id<0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::authority::ADMIN>(arg0, arg1), arg1);
    }

    // decompiled from Move bytecode v6
}

