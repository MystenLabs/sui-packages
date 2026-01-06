module 0x46f9b906c50dda5bfd2a7d207a620496eeb88b73904f7c0031ae3f87c59e2507::feed_info_object {
    struct FeedInfoObjectKey has copy, drop, store {
        pos0: vector<u8>,
    }

    struct FeedInfoObject has store, key {
        id: 0x2::object::UID,
        feed_id: vector<u8>,
    }

    public fun feed_id(arg0: &FeedInfoObject) : vector<u8> {
        arg0.feed_id
    }

    public fun new<T0>(arg0: &mut 0x46f9b906c50dda5bfd2a7d207a620496eeb88b73904f7c0031ae3f87c59e2507::stork::OracleAggregatorStorkIntegration, arg1: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::authority::AuthorityCap<0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::authority::PACKAGE, T0>, arg2: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::config::Config, arg3: vector<u8>) : FeedInfoObject {
        0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::config::assert_package_version(arg2);
        0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::config::assert_authority_cap_is_valid<T0>(arg2, arg1);
        let v0 = 0x46f9b906c50dda5bfd2a7d207a620496eeb88b73904f7c0031ae3f87c59e2507::stork::borrow_mut_id<T0>(arg0, arg1);
        let v1 = FeedInfoObjectKey{pos0: arg3};
        assert!(!0x2::derived_object::exists<FeedInfoObjectKey>(v0, v1), 0);
        FeedInfoObject{
            id      : 0x2::derived_object::claim<FeedInfoObjectKey>(v0, v1),
            feed_id : arg3,
        }
    }

    // decompiled from Move bytecode v6
}

