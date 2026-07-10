module 0xe6c17648d1d8cbb8512a869fda517b068c18089d07a5f65c0da3a5edb5185c0f::source {
    struct STORK has drop {
        dummy_field: bool,
    }

    public(friend) fun borrow_mut_id(arg0: &mut 0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::source::Source<STORK>) : &mut 0x2::object::UID {
        let v0 = STORK{dummy_field: false};
        0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::source::borrow_mut_id<STORK>(arg0, v0)
    }

    public fun create<T0>(arg0: &mut 0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::config::Config, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::authority::PACKAGE, T0>) : 0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::source::Source<STORK> {
        0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::source::create<STORK, T0>(arg0, arg1)
    }

    public fun authorize<T0>(arg0: &mut 0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::source::Source<STORK>, arg1: &0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::config::Config, arg2: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::authority::PACKAGE, T0>) {
        0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::source::set_authorized<STORK, T0>(arg0, arg1, arg2, true);
    }

    public fun deauthorize<T0>(arg0: &mut 0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::source::Source<STORK>, arg1: &0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::config::Config, arg2: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::authority::PACKAGE, T0>) {
        0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::source::set_authorized<STORK, T0>(arg0, arg1, arg2, false);
    }

    public(friend) fun source_cap(arg0: &0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::source::Source<STORK>) : &0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::authority::SourceCap {
        let v0 = STORK{dummy_field: false};
        0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::source::borrow_source_cap<STORK>(arg0, v0)
    }

    // decompiled from Move bytecode v7
}

