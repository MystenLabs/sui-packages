module 0x4c978aae37431cb06e4784651d400f5b1c6a8f55d62a82e78fc678820ab43e88::source {
    struct SWITCHBOARD has drop {
        dummy_field: bool,
    }

    public(friend) fun assert_version(arg0: &0x45a7f9bfb046a4c7eb5c9b73e5d2cb52be0e06e1320a5923c0587ac944730647::source::Source<SWITCHBOARD>) {
        0x45a7f9bfb046a4c7eb5c9b73e5d2cb52be0e06e1320a5923c0587ac944730647::source::assert_version<SWITCHBOARD>(arg0, 1);
    }

    public fun create<T0>(arg0: &mut 0x45a7f9bfb046a4c7eb5c9b73e5d2cb52be0e06e1320a5923c0587ac944730647::config::Config, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x45a7f9bfb046a4c7eb5c9b73e5d2cb52be0e06e1320a5923c0587ac944730647::authority::PACKAGE, T0>) : 0x45a7f9bfb046a4c7eb5c9b73e5d2cb52be0e06e1320a5923c0587ac944730647::source::Source<SWITCHBOARD> {
        let v0 = SWITCHBOARD{dummy_field: false};
        0x45a7f9bfb046a4c7eb5c9b73e5d2cb52be0e06e1320a5923c0587ac944730647::source::create<SWITCHBOARD, T0>(arg0, arg1, &v0, 1)
    }

    public fun authorize<T0>(arg0: &mut 0x45a7f9bfb046a4c7eb5c9b73e5d2cb52be0e06e1320a5923c0587ac944730647::source::Source<SWITCHBOARD>, arg1: &0x45a7f9bfb046a4c7eb5c9b73e5d2cb52be0e06e1320a5923c0587ac944730647::config::Config, arg2: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x45a7f9bfb046a4c7eb5c9b73e5d2cb52be0e06e1320a5923c0587ac944730647::authority::PACKAGE, T0>) {
        assert_version(arg0);
        0x45a7f9bfb046a4c7eb5c9b73e5d2cb52be0e06e1320a5923c0587ac944730647::source::set_authorized<SWITCHBOARD, T0>(arg0, arg1, arg2, true);
    }

    public fun deauthorize<T0>(arg0: &mut 0x45a7f9bfb046a4c7eb5c9b73e5d2cb52be0e06e1320a5923c0587ac944730647::source::Source<SWITCHBOARD>, arg1: &0x45a7f9bfb046a4c7eb5c9b73e5d2cb52be0e06e1320a5923c0587ac944730647::config::Config, arg2: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x45a7f9bfb046a4c7eb5c9b73e5d2cb52be0e06e1320a5923c0587ac944730647::authority::PACKAGE, T0>) {
        assert_version(arg0);
        0x45a7f9bfb046a4c7eb5c9b73e5d2cb52be0e06e1320a5923c0587ac944730647::source::set_authorized<SWITCHBOARD, T0>(arg0, arg1, arg2, false);
    }

    public(friend) fun source_cap(arg0: &0x45a7f9bfb046a4c7eb5c9b73e5d2cb52be0e06e1320a5923c0587ac944730647::source::Source<SWITCHBOARD>) : &0x45a7f9bfb046a4c7eb5c9b73e5d2cb52be0e06e1320a5923c0587ac944730647::authority::SourceCap {
        let v0 = SWITCHBOARD{dummy_field: false};
        0x45a7f9bfb046a4c7eb5c9b73e5d2cb52be0e06e1320a5923c0587ac944730647::source::borrow_source_cap<SWITCHBOARD>(arg0, v0)
    }

    // decompiled from Move bytecode v7
}

