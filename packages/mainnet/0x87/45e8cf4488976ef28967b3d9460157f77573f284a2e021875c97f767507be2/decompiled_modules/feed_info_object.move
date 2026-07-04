module 0x8745e8cf4488976ef28967b3d9460157f77573f284a2e021875c97f767507be2::feed_info_object {
    struct FeedInfoObjectKey<phantom T0> has copy, drop, store {
        pos0: vector<u8>,
    }

    struct FeedInfoObject has store, key {
        id: 0x2::object::UID,
        feed_id: vector<u8>,
    }

    public fun feed_id(arg0: &FeedInfoObject) : vector<u8> {
        arg0.feed_id
    }

    public fun new<T0, T1>(arg0: &mut 0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::source::Source<0x8745e8cf4488976ef28967b3d9460157f77573f284a2e021875c97f767507be2::source::STORK>, arg1: &0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::authority::VENDOR<T0>, T1>, arg2: &0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::config::Config, arg3: vector<u8>) : FeedInfoObject {
        0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::config::assert_package_version(arg2);
        0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::authority::assert_is_admin_or_assistant<T1>();
        0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::config::assert_vendor_authority_cap_is_valid<T0, T1>(arg2, arg1);
        let v0 = FeedInfoObjectKey<T0>{pos0: arg3};
        assert!(!0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::source::child_exists<0x8745e8cf4488976ef28967b3d9460157f77573f284a2e021875c97f767507be2::source::STORK, FeedInfoObjectKey<T0>>(arg0, v0), 13835058360224841729);
        FeedInfoObject{
            id      : 0x2::derived_object::claim<FeedInfoObjectKey<T0>>(0x8745e8cf4488976ef28967b3d9460157f77573f284a2e021875c97f767507be2::source::borrow_mut_id(arg0), v0),
            feed_id : arg3,
        }
    }

    // decompiled from Move bytecode v7
}

