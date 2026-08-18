module 0xa5428da682b4fad53e40f73dc07b547e33be078ec1c5d4a4378d6a316f0d9104::feed_info_object {
    struct FeedInfoObjectKey<phantom T0> has copy, drop, store {
        pos0: u32,
    }

    struct SharePolicy {
        pos0: 0x2::object::ID,
    }

    struct FeedInfoObject has store, key {
        id: 0x2::object::UID,
        feed_id: u32,
    }

    public fun feed_id(arg0: &FeedInfoObject) : u32 {
        arg0.feed_id
    }

    public fun new<T0, T1>(arg0: &mut 0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::source::Source<0xa5428da682b4fad53e40f73dc07b547e33be078ec1c5d4a4378d6a316f0d9104::source::PYTH_LAZER>, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::authority::VENDOR<T0>, T1>, arg2: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::config::Config, arg3: u32) : (FeedInfoObject, SharePolicy) {
        0xa5428da682b4fad53e40f73dc07b547e33be078ec1c5d4a4378d6a316f0d9104::source::assert_version(arg0);
        0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::config::assert_package_version(arg2);
        0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::authority::assert_is_admin_or_assistant<T1>();
        0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::config::assert_vendor_authority_cap_is_valid<T0, T1>(arg2, arg1);
        let v0 = FeedInfoObjectKey<T0>{pos0: arg3};
        assert!(!0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::source::child_exists<0xa5428da682b4fad53e40f73dc07b547e33be078ec1c5d4a4378d6a316f0d9104::source::PYTH_LAZER, FeedInfoObjectKey<T0>>(arg0, v0), 13835058437534253057);
        let v1 = FeedInfoObject{
            id      : 0x2::derived_object::claim<FeedInfoObjectKey<T0>>(0xa5428da682b4fad53e40f73dc07b547e33be078ec1c5d4a4378d6a316f0d9104::source::borrow_mut_id(arg0), v0),
            feed_id : arg3,
        };
        let v2 = SharePolicy{pos0: 0x2::object::uid_to_inner(&v1.id)};
        (v1, v2)
    }

    public fun share(arg0: FeedInfoObject, arg1: SharePolicy) {
        let SharePolicy { pos0: v0 } = arg1;
        assert!(0x2::object::uid_to_inner(&arg0.id) == v0, 13835340032770179075);
        0x2::transfer::share_object<FeedInfoObject>(arg0);
    }

    // decompiled from Move bytecode v7
}

