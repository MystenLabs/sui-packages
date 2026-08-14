module 0xfcf790e8595b5b225c9488fa7566c97237d81fbfd7816db1a972217819918d45::source {
    struct DEV has drop {
        dummy_field: bool,
    }

    public(friend) fun assert_version(arg0: &0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::source::Source<DEV>) {
        0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::source::assert_version<DEV>(arg0, 1);
    }

    public fun create<T0>(arg0: &mut 0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::config::Config, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::authority::PACKAGE, T0>) : 0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::source::Source<DEV> {
        let v0 = DEV{dummy_field: false};
        0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::source::create<DEV, T0>(arg0, arg1, &v0, 1)
    }

    public fun authorize<T0>(arg0: &mut 0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::source::Source<DEV>, arg1: &0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::config::Config, arg2: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::authority::PACKAGE, T0>) {
        assert_version(arg0);
        0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::source::set_authorized<DEV, T0>(arg0, arg1, arg2, true);
    }

    public fun deauthorize<T0>(arg0: &mut 0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::source::Source<DEV>, arg1: &0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::config::Config, arg2: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::authority::PACKAGE, T0>) {
        assert_version(arg0);
        0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::source::set_authorized<DEV, T0>(arg0, arg1, arg2, false);
    }

    public(friend) fun source_cap(arg0: &0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::source::Source<DEV>) : &0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::authority::SourceCap {
        let v0 = DEV{dummy_field: false};
        0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::source::borrow_source_cap<DEV>(arg0, v0)
    }

    // decompiled from Move bytecode v7
}

