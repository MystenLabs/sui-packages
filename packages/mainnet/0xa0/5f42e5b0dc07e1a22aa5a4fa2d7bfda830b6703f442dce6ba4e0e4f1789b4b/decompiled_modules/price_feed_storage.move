module 0xa05f42e5b0dc07e1a22aa5a4fa2d7bfda830b6703f442dce6ba4e0e4f1789b4b::price_feed_storage {
    public fun force_remove_price_feed<T0>(arg0: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::source::Source<0xa05f42e5b0dc07e1a22aa5a4fa2d7bfda830b6703f442dce6ba4e0e4f1789b4b::source::DEV>, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::authority::PACKAGE, T0>, arg2: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::config::Config, arg3: &mut 0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage) {
        0xa05f42e5b0dc07e1a22aa5a4fa2d7bfda830b6703f442dce6ba4e0e4f1789b4b::source::assert_version(arg0);
        0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::force_remove_price_feed<T0>(arg3, arg1, arg2, 0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::source::source_id<0xa05f42e5b0dc07e1a22aa5a4fa2d7bfda830b6703f442dce6ba4e0e4f1789b4b::source::DEV>(arg0));
    }

    public fun new_price_feed<T0, T1>(arg0: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::source::Source<0xa05f42e5b0dc07e1a22aa5a4fa2d7bfda830b6703f442dce6ba4e0e4f1789b4b::source::DEV>, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::authority::VENDOR<T0>, T1>, arg2: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::config::Config, arg3: &mut 0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg4: u128, arg5: u64, arg6: u64) {
        0xa05f42e5b0dc07e1a22aa5a4fa2d7bfda830b6703f442dce6ba4e0e4f1789b4b::source::assert_version(arg0);
        0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::new_price_feed<T0, T1, 0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::source::Source<0xa05f42e5b0dc07e1a22aa5a4fa2d7bfda830b6703f442dce6ba4e0e4f1789b4b::source::DEV>>(arg3, arg1, arg2, 0xa05f42e5b0dc07e1a22aa5a4fa2d7bfda830b6703f442dce6ba4e0e4f1789b4b::source::source_cap(arg0), arg0, arg4, arg5, arg6);
    }

    public fun remove_price_feed<T0>(arg0: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::source::Source<0xa05f42e5b0dc07e1a22aa5a4fa2d7bfda830b6703f442dce6ba4e0e4f1789b4b::source::DEV>, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::authority::VENDOR<T0>, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>, arg2: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::config::Config, arg3: &mut 0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage) {
        0xa05f42e5b0dc07e1a22aa5a4fa2d7bfda830b6703f442dce6ba4e0e4f1789b4b::source::assert_version(arg0);
        0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::remove_price_feed<T0>(arg3, arg1, arg2, 0xa05f42e5b0dc07e1a22aa5a4fa2d7bfda830b6703f442dce6ba4e0e4f1789b4b::source::source_cap(arg0));
    }

    public fun set_twap_period_ms<T0, T1>(arg0: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::source::Source<0xa05f42e5b0dc07e1a22aa5a4fa2d7bfda830b6703f442dce6ba4e0e4f1789b4b::source::DEV>, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::authority::VENDOR<T0>, T1>, arg2: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::config::Config, arg3: &mut 0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg4: u64) {
        0xa05f42e5b0dc07e1a22aa5a4fa2d7bfda830b6703f442dce6ba4e0e4f1789b4b::source::assert_version(arg0);
        0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::set_twap_period_ms<T0, T1>(arg3, arg1, arg2, 0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::source::source_id<0xa05f42e5b0dc07e1a22aa5a4fa2d7bfda830b6703f442dce6ba4e0e4f1789b4b::source::DEV>(arg0), arg4);
    }

    public fun update_price_feed<T0, T1>(arg0: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::source::Source<0xa05f42e5b0dc07e1a22aa5a4fa2d7bfda830b6703f442dce6ba4e0e4f1789b4b::source::DEV>, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::authority::VENDOR<T0>, T1>, arg2: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::config::Config, arg3: &mut 0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg4: u128, arg5: u64) {
        0xa05f42e5b0dc07e1a22aa5a4fa2d7bfda830b6703f442dce6ba4e0e4f1789b4b::source::assert_version(arg0);
        0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::config::assert_package_version(arg2);
        0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::authority::assert_is_admin_or_assistant<T1>();
        0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::config::assert_vendor_authority_cap_is_valid<T0, T1>(arg2, arg1);
        0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::assert_has_vendor_authorization<T0>(arg3);
        0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::update_price_feed<0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::source::Source<0xa05f42e5b0dc07e1a22aa5a4fa2d7bfda830b6703f442dce6ba4e0e4f1789b4b::source::DEV>>(arg3, arg2, 0xa05f42e5b0dc07e1a22aa5a4fa2d7bfda830b6703f442dce6ba4e0e4f1789b4b::source::source_cap(arg0), arg0, arg4, arg5);
    }

    // decompiled from Move bytecode v7
}

