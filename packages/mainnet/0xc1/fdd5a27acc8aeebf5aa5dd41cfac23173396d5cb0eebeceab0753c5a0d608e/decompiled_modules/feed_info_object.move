module 0xc1fdd5a27acc8aeebf5aa5dd41cfac23173396d5cb0eebeceab0753c5a0d608e::feed_info_object {
    struct FeedInfoObjectKey<phantom T0> has copy, drop, store {
        pos0: u32,
        pos1: u32,
    }

    struct SharePolicy {
        pos0: 0x2::object::ID,
    }

    struct FeedInfoObject has store, key {
        id: 0x2::object::UID,
        base_feed_id: u32,
        quote_feed_id: u32,
        invert_quote_feed: bool,
    }

    public fun base_feed_id(arg0: &FeedInfoObject) : u32 {
        arg0.base_feed_id
    }

    public fun derived_id<T0>(arg0: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::source::Source<0xc1fdd5a27acc8aeebf5aa5dd41cfac23173396d5cb0eebeceab0753c5a0d608e::source::PYTH_LAZER_NORMALIZED>, arg1: u32, arg2: u32) : 0x2::object::ID {
        let v0 = FeedInfoObjectKey<T0>{
            pos0 : arg1,
            pos1 : arg2,
        };
        0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::source::child_id<0xc1fdd5a27acc8aeebf5aa5dd41cfac23173396d5cb0eebeceab0753c5a0d608e::source::PYTH_LAZER_NORMALIZED, FeedInfoObjectKey<T0>>(arg0, v0)
    }

    public fun invert_quote_feed(arg0: &FeedInfoObject) : bool {
        arg0.invert_quote_feed
    }

    public fun new<T0, T1>(arg0: &mut 0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::source::Source<0xc1fdd5a27acc8aeebf5aa5dd41cfac23173396d5cb0eebeceab0753c5a0d608e::source::PYTH_LAZER_NORMALIZED>, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::authority::VENDOR<T0>, T1>, arg2: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::config::Config, arg3: u32, arg4: u32, arg5: bool) : (FeedInfoObject, SharePolicy) {
        0xc1fdd5a27acc8aeebf5aa5dd41cfac23173396d5cb0eebeceab0753c5a0d608e::source::assert_version(arg0);
        0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::config::assert_package_version(arg2);
        0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::authority::assert_is_admin_or_assistant<T1>();
        0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::config::assert_vendor_authority_cap_is_valid<T0, T1>(arg2, arg1);
        assert!(arg4 != arg3, 13835621567876562949);
        let v0 = FeedInfoObjectKey<T0>{
            pos0 : arg3,
            pos1 : arg4,
        };
        assert!(!0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::source::child_exists<0xc1fdd5a27acc8aeebf5aa5dd41cfac23173396d5cb0eebeceab0753c5a0d608e::source::PYTH_LAZER_NORMALIZED, FeedInfoObjectKey<T0>>(arg0, v0), 13835058647987650561);
        let v1 = FeedInfoObject{
            id                : 0x2::derived_object::claim<FeedInfoObjectKey<T0>>(0xc1fdd5a27acc8aeebf5aa5dd41cfac23173396d5cb0eebeceab0753c5a0d608e::source::borrow_mut_id(arg0), v0),
            base_feed_id      : arg3,
            quote_feed_id     : arg4,
            invert_quote_feed : arg5,
        };
        let v2 = SharePolicy{pos0: 0x2::object::uid_to_inner(&v1.id)};
        (v1, v2)
    }

    public fun quote_feed_id(arg0: &FeedInfoObject) : u32 {
        arg0.quote_feed_id
    }

    public fun share(arg0: FeedInfoObject, arg1: SharePolicy) {
        let SharePolicy { pos0: v0 } = arg1;
        assert!(0x2::object::uid_to_inner(&arg0.id) == v0, 13835340251813511171);
        0x2::transfer::share_object<FeedInfoObject>(arg0);
    }

    // decompiled from Move bytecode v7
}

