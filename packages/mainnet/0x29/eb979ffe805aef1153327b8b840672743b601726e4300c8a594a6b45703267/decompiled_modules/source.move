module 0x29eb979ffe805aef1153327b8b840672743b601726e4300c8a594a6b45703267::source {
    struct STORK has drop {
        dummy_field: bool,
    }

    public(friend) fun assert_version(arg0: &0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::source::Source<STORK>) {
        0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::source::assert_version<STORK>(arg0, 1);
    }

    public fun authorize<T0>(arg0: &mut 0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::source::Source<STORK>, arg1: &0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::config::Config, arg2: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::authority::PACKAGE, T0>) {
        assert_version(arg0);
        0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::source::set_authorized<STORK, T0>(arg0, arg1, arg2, true);
    }

    public(friend) fun borrow_mut_id(arg0: &mut 0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::source::Source<STORK>) : &mut 0x2::object::UID {
        let v0 = STORK{dummy_field: false};
        0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::source::borrow_mut_id<STORK>(arg0, v0)
    }

    public fun create<T0>(arg0: &mut 0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::config::Config, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::authority::PACKAGE, T0>) : 0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::source::Source<STORK> {
        let v0 = STORK{dummy_field: false};
        0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::source::create<STORK, T0>(arg0, arg1, &v0, 1)
    }

    public fun deauthorize<T0>(arg0: &mut 0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::source::Source<STORK>, arg1: &0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::config::Config, arg2: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::authority::PACKAGE, T0>) {
        assert_version(arg0);
        0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::source::set_authorized<STORK, T0>(arg0, arg1, arg2, false);
    }

    public(friend) fun source_cap(arg0: &0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::source::Source<STORK>) : &0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::authority::SourceCap {
        let v0 = STORK{dummy_field: false};
        0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::source::borrow_source_cap<STORK>(arg0, v0)
    }

    // decompiled from Move bytecode v7
}

