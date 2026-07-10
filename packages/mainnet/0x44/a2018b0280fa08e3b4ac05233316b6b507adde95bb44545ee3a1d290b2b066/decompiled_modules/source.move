module 0x44a2018b0280fa08e3b4ac05233316b6b507adde95bb44545ee3a1d290b2b066::source {
    struct SWITCHBOARD has drop {
        dummy_field: bool,
    }

    public fun authorize<T0>(arg0: &mut 0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::source::Source<SWITCHBOARD>, arg1: &0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::config::Config, arg2: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::authority::PACKAGE, T0>) {
        0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::source::set_authorized<SWITCHBOARD, T0>(arg0, arg1, arg2, true);
    }

    public fun create<T0>(arg0: &mut 0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::config::Config, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::authority::PACKAGE, T0>) : 0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::source::Source<SWITCHBOARD> {
        0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::source::create<SWITCHBOARD, T0>(arg0, arg1)
    }

    public fun deauthorize<T0>(arg0: &mut 0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::source::Source<SWITCHBOARD>, arg1: &0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::config::Config, arg2: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::authority::PACKAGE, T0>) {
        0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::source::set_authorized<SWITCHBOARD, T0>(arg0, arg1, arg2, false);
    }

    public(friend) fun source_cap(arg0: &0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::source::Source<SWITCHBOARD>) : &0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::authority::SourceCap {
        let v0 = SWITCHBOARD{dummy_field: false};
        0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::source::borrow_source_cap<SWITCHBOARD>(arg0, v0)
    }

    // decompiled from Move bytecode v7
}

