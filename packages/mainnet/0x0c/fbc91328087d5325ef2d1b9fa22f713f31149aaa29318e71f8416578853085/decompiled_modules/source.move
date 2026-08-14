module 0xcfbc91328087d5325ef2d1b9fa22f713f31149aaa29318e71f8416578853085::source {
    struct PYTH_LAZER has drop {
        dummy_field: bool,
    }

    public(friend) fun assert_version(arg0: &0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::source::Source<PYTH_LAZER>) {
        0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::source::assert_version<PYTH_LAZER>(arg0, 1);
    }

    public fun authorize<T0>(arg0: &mut 0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::source::Source<PYTH_LAZER>, arg1: &0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::config::Config, arg2: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::authority::PACKAGE, T0>) {
        assert_version(arg0);
        0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::source::set_authorized<PYTH_LAZER, T0>(arg0, arg1, arg2, true);
    }

    public(friend) fun borrow_mut_id(arg0: &mut 0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::source::Source<PYTH_LAZER>) : &mut 0x2::object::UID {
        0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::source::assert_version<PYTH_LAZER>(arg0, 1);
        let v0 = PYTH_LAZER{dummy_field: false};
        0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::source::borrow_mut_id<PYTH_LAZER>(arg0, v0)
    }

    public fun create<T0>(arg0: &mut 0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::config::Config, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::authority::PACKAGE, T0>) : 0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::source::Source<PYTH_LAZER> {
        let v0 = PYTH_LAZER{dummy_field: false};
        0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::source::create<PYTH_LAZER, T0>(arg0, arg1, &v0, 1)
    }

    public fun deauthorize<T0>(arg0: &mut 0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::source::Source<PYTH_LAZER>, arg1: &0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::config::Config, arg2: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::authority::PACKAGE, T0>) {
        assert_version(arg0);
        0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::source::set_authorized<PYTH_LAZER, T0>(arg0, arg1, arg2, false);
    }

    public(friend) fun source_cap(arg0: &0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::source::Source<PYTH_LAZER>) : &0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::authority::SourceCap {
        let v0 = PYTH_LAZER{dummy_field: false};
        0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::source::borrow_source_cap<PYTH_LAZER>(arg0, v0)
    }

    // decompiled from Move bytecode v7
}

