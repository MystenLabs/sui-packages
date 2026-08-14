module 0x29eb979ffe805aef1153327b8b840672743b601726e4300c8a594a6b45703267::feed_info_object {
    struct FeedInfoObjectKey<phantom T0> has copy, drop, store {
        pos0: vector<u8>,
    }

    struct SharePolicy {
        pos0: 0x2::object::ID,
    }

    struct FeedInfoObject has store, key {
        id: 0x2::object::UID,
        feed_id: vector<u8>,
    }

    public fun feed_id(arg0: &FeedInfoObject) : vector<u8> {
        arg0.feed_id
    }

    public fun new<T0, T1>(arg0: &mut 0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::source::Source<0x29eb979ffe805aef1153327b8b840672743b601726e4300c8a594a6b45703267::source::STORK>, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::authority::VENDOR<T0>, T1>, arg2: &0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::config::Config, arg3: vector<u8>) : (FeedInfoObject, SharePolicy) {
        0x29eb979ffe805aef1153327b8b840672743b601726e4300c8a594a6b45703267::source::assert_version(arg0);
        0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::config::assert_package_version(arg2);
        0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::authority::assert_is_admin_or_assistant<T1>();
        0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::config::assert_vendor_authority_cap_is_valid<T0, T1>(arg2, arg1);
        let v0 = FeedInfoObjectKey<T0>{pos0: arg3};
        assert!(!0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::source::child_exists<0x29eb979ffe805aef1153327b8b840672743b601726e4300c8a594a6b45703267::source::STORK, FeedInfoObjectKey<T0>>(arg0, v0), 13835058446124187649);
        let v1 = FeedInfoObject{
            id      : 0x2::derived_object::claim<FeedInfoObjectKey<T0>>(0x29eb979ffe805aef1153327b8b840672743b601726e4300c8a594a6b45703267::source::borrow_mut_id(arg0), v0),
            feed_id : arg3,
        };
        let v2 = SharePolicy{pos0: 0x2::object::uid_to_inner(&v1.id)};
        (v1, v2)
    }

    public fun share(arg0: FeedInfoObject, arg1: SharePolicy) {
        let SharePolicy { pos0: v0 } = arg1;
        assert!(0x2::object::uid_to_inner(&arg0.id) == v0, 13835340041360113667);
        0x2::transfer::share_object<FeedInfoObject>(arg0);
    }

    // decompiled from Move bytecode v7
}

