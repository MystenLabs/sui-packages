module 0xe6c17648d1d8cbb8512a869fda517b068c18089d07a5f65c0da3a5edb5185c0f::feed_info_object {
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

    public fun new<T0, T1>(arg0: &mut 0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::source::Source<0xe6c17648d1d8cbb8512a869fda517b068c18089d07a5f65c0da3a5edb5185c0f::source::STORK>, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::authority::VENDOR<T0>, T1>, arg2: &0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::config::Config, arg3: vector<u8>) : FeedInfoObject {
        0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::config::assert_package_version(arg2);
        0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::authority::assert_is_admin_or_assistant<T1>();
        0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::config::assert_vendor_authority_cap_is_valid<T0, T1>(arg2, arg1);
        let v0 = FeedInfoObjectKey<T0>{pos0: arg3};
        assert!(!0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::source::child_exists<0xe6c17648d1d8cbb8512a869fda517b068c18089d07a5f65c0da3a5edb5185c0f::source::STORK, FeedInfoObjectKey<T0>>(arg0, v0), 13835058360224841729);
        FeedInfoObject{
            id      : 0x2::derived_object::claim<FeedInfoObjectKey<T0>>(0xe6c17648d1d8cbb8512a869fda517b068c18089d07a5f65c0da3a5edb5185c0f::source::borrow_mut_id(arg0), v0),
            feed_id : arg3,
        }
    }

    // decompiled from Move bytecode v7
}

