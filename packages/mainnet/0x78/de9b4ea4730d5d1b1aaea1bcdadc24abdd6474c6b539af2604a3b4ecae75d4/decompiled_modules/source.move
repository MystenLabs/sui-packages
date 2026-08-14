module 0x78de9b4ea4730d5d1b1aaea1bcdadc24abdd6474c6b539af2604a3b4ecae75d4::source {
    struct SWITCHBOARD has drop {
        dummy_field: bool,
    }

    public(friend) fun assert_version(arg0: &0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::source::Source<SWITCHBOARD>) {
        0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::source::assert_version<SWITCHBOARD>(arg0, 1);
    }

    public fun authorize<T0>(arg0: &mut 0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::source::Source<SWITCHBOARD>, arg1: &0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::config::Config, arg2: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::authority::PACKAGE, T0>) {
        assert_version(arg0);
        0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::source::set_authorized<SWITCHBOARD, T0>(arg0, arg1, arg2, true);
    }

    public fun create<T0>(arg0: &mut 0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::config::Config, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::authority::PACKAGE, T0>) : 0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::source::Source<SWITCHBOARD> {
        let v0 = SWITCHBOARD{dummy_field: false};
        0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::source::create<SWITCHBOARD, T0>(arg0, arg1, &v0, 1)
    }

    public fun deauthorize<T0>(arg0: &mut 0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::source::Source<SWITCHBOARD>, arg1: &0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::config::Config, arg2: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::authority::PACKAGE, T0>) {
        assert_version(arg0);
        0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::source::set_authorized<SWITCHBOARD, T0>(arg0, arg1, arg2, false);
    }

    public(friend) fun source_cap(arg0: &0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::source::Source<SWITCHBOARD>) : &0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::authority::SourceCap {
        let v0 = SWITCHBOARD{dummy_field: false};
        0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::source::borrow_source_cap<SWITCHBOARD>(arg0, v0)
    }

    // decompiled from Move bytecode v7
}

