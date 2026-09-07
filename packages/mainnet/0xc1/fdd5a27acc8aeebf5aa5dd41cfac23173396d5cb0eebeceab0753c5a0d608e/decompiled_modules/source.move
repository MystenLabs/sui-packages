module 0xc1fdd5a27acc8aeebf5aa5dd41cfac23173396d5cb0eebeceab0753c5a0d608e::source {
    struct PYTH_LAZER_NORMALIZED has drop {
        dummy_field: bool,
    }

    public(friend) fun assert_version(arg0: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::source::Source<PYTH_LAZER_NORMALIZED>) {
        0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::source::assert_version<PYTH_LAZER_NORMALIZED>(arg0, 1);
    }

    public(friend) fun borrow_mut_id(arg0: &mut 0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::source::Source<PYTH_LAZER_NORMALIZED>) : &mut 0x2::object::UID {
        let v0 = PYTH_LAZER_NORMALIZED{dummy_field: false};
        0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::source::borrow_mut_id<PYTH_LAZER_NORMALIZED>(arg0, v0)
    }

    public fun create<T0>(arg0: &mut 0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::config::Config, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::authority::PACKAGE, T0>) : 0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::source::Source<PYTH_LAZER_NORMALIZED> {
        let v0 = PYTH_LAZER_NORMALIZED{dummy_field: false};
        0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::source::create<PYTH_LAZER_NORMALIZED, T0>(arg0, arg1, &v0, 1)
    }

    public fun authorize<T0>(arg0: &mut 0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::source::Source<PYTH_LAZER_NORMALIZED>, arg1: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::config::Config, arg2: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::authority::PACKAGE, T0>) {
        assert_version(arg0);
        0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::source::set_authorized<PYTH_LAZER_NORMALIZED, T0>(arg0, arg1, arg2, true);
    }

    public fun deauthorize<T0>(arg0: &mut 0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::source::Source<PYTH_LAZER_NORMALIZED>, arg1: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::config::Config, arg2: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::authority::PACKAGE, T0>) {
        assert_version(arg0);
        0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::source::set_authorized<PYTH_LAZER_NORMALIZED, T0>(arg0, arg1, arg2, false);
    }

    public(friend) fun source_cap(arg0: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::source::Source<PYTH_LAZER_NORMALIZED>) : &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::authority::SourceCap {
        let v0 = PYTH_LAZER_NORMALIZED{dummy_field: false};
        0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::source::borrow_source_cap<PYTH_LAZER_NORMALIZED>(arg0, v0)
    }

    // decompiled from Move bytecode v7
}

