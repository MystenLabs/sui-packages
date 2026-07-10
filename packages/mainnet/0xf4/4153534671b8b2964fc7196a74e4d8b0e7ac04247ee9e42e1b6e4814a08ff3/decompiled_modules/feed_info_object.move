module 0xf44153534671b8b2964fc7196a74e4d8b0e7ac04247ee9e42e1b6e4814a08ff3::feed_info_object {
    struct FeedInfoObjectKey<phantom T0> has copy, drop, store {
        pos0: u32,
    }

    struct FeedInfoObject has store, key {
        id: 0x2::object::UID,
        feed_id: u32,
    }

    public fun feed_id(arg0: &FeedInfoObject) : u32 {
        arg0.feed_id
    }

    public fun new<T0, T1>(arg0: &mut 0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::source::Source<0xf44153534671b8b2964fc7196a74e4d8b0e7ac04247ee9e42e1b6e4814a08ff3::source::PYTH_LAZER>, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::authority::VENDOR<T0>, T1>, arg2: &0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::config::Config, arg3: u32) : FeedInfoObject {
        0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::config::assert_package_version(arg2);
        0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::authority::assert_is_admin_or_assistant<T1>();
        0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::config::assert_vendor_authority_cap_is_valid<T0, T1>(arg2, arg1);
        let v0 = FeedInfoObjectKey<T0>{pos0: arg3};
        assert!(!0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::source::child_exists<0xf44153534671b8b2964fc7196a74e4d8b0e7ac04247ee9e42e1b6e4814a08ff3::source::PYTH_LAZER, FeedInfoObjectKey<T0>>(arg0, v0), 13835058351634907137);
        FeedInfoObject{
            id      : 0x2::derived_object::claim<FeedInfoObjectKey<T0>>(0xf44153534671b8b2964fc7196a74e4d8b0e7ac04247ee9e42e1b6e4814a08ff3::source::borrow_mut_id(arg0), v0),
            feed_id : arg3,
        }
    }

    // decompiled from Move bytecode v7
}

