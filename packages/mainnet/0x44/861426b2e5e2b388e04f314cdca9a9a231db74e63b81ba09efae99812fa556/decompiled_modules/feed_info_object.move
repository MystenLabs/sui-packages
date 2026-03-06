module 0x44861426b2e5e2b388e04f314cdca9a9a231db74e63b81ba09efae99812fa556::feed_info_object {
    struct FeedInfoObjectKey has copy, drop, store {
        pos0: u32,
    }

    struct FeedInfoObject has store, key {
        id: 0x2::object::UID,
        feed_id: u32,
    }

    public fun feed_id(arg0: &FeedInfoObject) : u32 {
        arg0.feed_id
    }

    public fun new<T0>(arg0: &mut 0x44861426b2e5e2b388e04f314cdca9a9a231db74e63b81ba09efae99812fa556::pyth_lazer::OracleAggregatorPythLazerIntegration, arg1: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::authority::AuthorityCap<0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::authority::PACKAGE, T0>, arg2: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::config::Config, arg3: u32) : FeedInfoObject {
        0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::config::assert_package_version(arg2);
        0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::config::assert_authority_cap_is_valid<T0>(arg2, arg1);
        let v0 = 0x44861426b2e5e2b388e04f314cdca9a9a231db74e63b81ba09efae99812fa556::pyth_lazer::borrow_mut_id<T0>(arg0, arg1);
        let v1 = FeedInfoObjectKey{pos0: arg3};
        assert!(!0x2::derived_object::exists<FeedInfoObjectKey>(v0, v1), 0);
        FeedInfoObject{
            id      : 0x2::derived_object::claim<FeedInfoObjectKey>(v0, v1),
            feed_id : arg3,
        }
    }

    // decompiled from Move bytecode v6
}

