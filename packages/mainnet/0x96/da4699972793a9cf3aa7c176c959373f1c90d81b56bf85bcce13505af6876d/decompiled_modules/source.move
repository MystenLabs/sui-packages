module 0x96da4699972793a9cf3aa7c176c959373f1c90d81b56bf85bcce13505af6876d::source {
    struct DEV has drop {
        dummy_field: bool,
    }

    public(friend) fun assert_version(arg0: &0x45a7f9bfb046a4c7eb5c9b73e5d2cb52be0e06e1320a5923c0587ac944730647::source::Source<DEV>) {
        0x45a7f9bfb046a4c7eb5c9b73e5d2cb52be0e06e1320a5923c0587ac944730647::source::assert_version<DEV>(arg0, 1);
    }

    public fun create<T0>(arg0: &mut 0x45a7f9bfb046a4c7eb5c9b73e5d2cb52be0e06e1320a5923c0587ac944730647::config::Config, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x45a7f9bfb046a4c7eb5c9b73e5d2cb52be0e06e1320a5923c0587ac944730647::authority::PACKAGE, T0>) : 0x45a7f9bfb046a4c7eb5c9b73e5d2cb52be0e06e1320a5923c0587ac944730647::source::Source<DEV> {
        let v0 = DEV{dummy_field: false};
        0x45a7f9bfb046a4c7eb5c9b73e5d2cb52be0e06e1320a5923c0587ac944730647::source::create<DEV, T0>(arg0, arg1, &v0, 1)
    }

    public fun authorize<T0>(arg0: &mut 0x45a7f9bfb046a4c7eb5c9b73e5d2cb52be0e06e1320a5923c0587ac944730647::source::Source<DEV>, arg1: &0x45a7f9bfb046a4c7eb5c9b73e5d2cb52be0e06e1320a5923c0587ac944730647::config::Config, arg2: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x45a7f9bfb046a4c7eb5c9b73e5d2cb52be0e06e1320a5923c0587ac944730647::authority::PACKAGE, T0>) {
        assert_version(arg0);
        0x45a7f9bfb046a4c7eb5c9b73e5d2cb52be0e06e1320a5923c0587ac944730647::source::set_authorized<DEV, T0>(arg0, arg1, arg2, true);
    }

    public fun deauthorize<T0>(arg0: &mut 0x45a7f9bfb046a4c7eb5c9b73e5d2cb52be0e06e1320a5923c0587ac944730647::source::Source<DEV>, arg1: &0x45a7f9bfb046a4c7eb5c9b73e5d2cb52be0e06e1320a5923c0587ac944730647::config::Config, arg2: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x45a7f9bfb046a4c7eb5c9b73e5d2cb52be0e06e1320a5923c0587ac944730647::authority::PACKAGE, T0>) {
        assert_version(arg0);
        0x45a7f9bfb046a4c7eb5c9b73e5d2cb52be0e06e1320a5923c0587ac944730647::source::set_authorized<DEV, T0>(arg0, arg1, arg2, false);
    }

    public(friend) fun source_cap(arg0: &0x45a7f9bfb046a4c7eb5c9b73e5d2cb52be0e06e1320a5923c0587ac944730647::source::Source<DEV>) : &0x45a7f9bfb046a4c7eb5c9b73e5d2cb52be0e06e1320a5923c0587ac944730647::authority::SourceCap {
        let v0 = DEV{dummy_field: false};
        0x45a7f9bfb046a4c7eb5c9b73e5d2cb52be0e06e1320a5923c0587ac944730647::source::borrow_source_cap<DEV>(arg0, v0)
    }

    // decompiled from Move bytecode v7
}

