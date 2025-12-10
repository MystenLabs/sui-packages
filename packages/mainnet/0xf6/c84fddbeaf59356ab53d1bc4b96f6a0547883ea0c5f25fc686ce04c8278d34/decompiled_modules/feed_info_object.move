module 0xf6c84fddbeaf59356ab53d1bc4b96f6a0547883ea0c5f25fc686ce04c8278d34::feed_info_object {
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

    public fun new<T0>(arg0: &mut 0xf6c84fddbeaf59356ab53d1bc4b96f6a0547883ea0c5f25fc686ce04c8278d34::stork::OracleAggregatorStorkIntegration, arg1: &0x855b6d7d8a712a5ab48bb7a2d1c20c85cefdd51af68dc3691c59bfccb372e49::authority::AuthorityCap<0x855b6d7d8a712a5ab48bb7a2d1c20c85cefdd51af68dc3691c59bfccb372e49::authority::PACKAGE, T0>, arg2: &0x855b6d7d8a712a5ab48bb7a2d1c20c85cefdd51af68dc3691c59bfccb372e49::config::Config, arg3: vector<u8>) : FeedInfoObject {
        0x855b6d7d8a712a5ab48bb7a2d1c20c85cefdd51af68dc3691c59bfccb372e49::config::assert_package_version(arg2);
        0x855b6d7d8a712a5ab48bb7a2d1c20c85cefdd51af68dc3691c59bfccb372e49::config::assert_authority_cap_is_valid<T0>(arg2, arg1);
        let v0 = 0xf6c84fddbeaf59356ab53d1bc4b96f6a0547883ea0c5f25fc686ce04c8278d34::stork::borrow_mut_id<T0>(arg0, arg1);
        let v1 = FeedInfoObjectKey{pos0: arg3};
        assert!(!0x2::derived_object::exists<FeedInfoObjectKey>(v0, v1), 0);
        FeedInfoObject{
            id      : 0x2::derived_object::claim<FeedInfoObjectKey>(v0, v1),
            feed_id : arg3,
        }
    }

    // decompiled from Move bytecode v6
}

