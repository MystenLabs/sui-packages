module 0xa5428da682b4fad53e40f73dc07b547e33be078ec1c5d4a4378d6a316f0d9104::source {
    struct PYTH_LAZER has drop {
        dummy_field: bool,
    }

    public(friend) fun assert_version(arg0: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::source::Source<PYTH_LAZER>) {
        0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::source::assert_version<PYTH_LAZER>(arg0, 1);
    }

    public(friend) fun borrow_mut_id(arg0: &mut 0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::source::Source<PYTH_LAZER>) : &mut 0x2::object::UID {
        0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::source::assert_version<PYTH_LAZER>(arg0, 1);
        let v0 = PYTH_LAZER{dummy_field: false};
        0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::source::borrow_mut_id<PYTH_LAZER>(arg0, v0)
    }

    public fun create<T0>(arg0: &mut 0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::config::Config, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::authority::PACKAGE, T0>) : 0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::source::Source<PYTH_LAZER> {
        let v0 = PYTH_LAZER{dummy_field: false};
        0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::source::create<PYTH_LAZER, T0>(arg0, arg1, &v0, 1)
    }

    public fun authorize<T0>(arg0: &mut 0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::source::Source<PYTH_LAZER>, arg1: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::config::Config, arg2: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::authority::PACKAGE, T0>) {
        assert_version(arg0);
        0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::source::set_authorized<PYTH_LAZER, T0>(arg0, arg1, arg2, true);
    }

    public fun deauthorize<T0>(arg0: &mut 0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::source::Source<PYTH_LAZER>, arg1: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::config::Config, arg2: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::authority::PACKAGE, T0>) {
        assert_version(arg0);
        0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::source::set_authorized<PYTH_LAZER, T0>(arg0, arg1, arg2, false);
    }

    public(friend) fun source_cap(arg0: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::source::Source<PYTH_LAZER>) : &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::authority::SourceCap {
        let v0 = PYTH_LAZER{dummy_field: false};
        0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::source::borrow_source_cap<PYTH_LAZER>(arg0, v0)
    }

    // decompiled from Move bytecode v7
}

