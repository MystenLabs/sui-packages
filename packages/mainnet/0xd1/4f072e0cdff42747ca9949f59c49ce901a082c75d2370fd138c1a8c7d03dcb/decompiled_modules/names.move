module 0xd14f072e0cdff42747ca9949f59c49ce901a082c75d2370fd138c1a8c7d03dcb::names {
    struct Names has key {
        id: 0x2::object::UID,
        version: u64,
        entries: 0x2::table::Table<0x1::string::String, Official>,
    }

    struct Official has copy, drop, store {
        name: 0x1::string::String,
        design: 0x1::string::String,
    }

    struct OfficialNameSet has copy, drop {
        key: 0x1::string::String,
        name: 0x1::string::String,
        design: 0x1::string::String,
    }

    struct OfficialNameRemoved has copy, drop {
        key: 0x1::string::String,
    }

    public fun remove(arg0: &mut Names, arg1: &0xd14f072e0cdff42747ca9949f59c49ce901a082c75d2370fd138c1a8c7d03dcb::universe::AdminCap, arg2: 0x1::string::String) {
        assert!(arg0.version == 1, 13906834578070503428);
        assert!(0x2::table::contains<0x1::string::String, Official>(&arg0.entries, arg2), 13906834582365732872);
        0x2::table::remove<0x1::string::String, Official>(&mut arg0.entries, arg2);
        let v0 = OfficialNameRemoved{key: arg2};
        0x2::event::emit<OfficialNameRemoved>(v0);
    }

    public fun has(arg0: &Names, arg1: 0x1::string::String) : bool {
        0x2::table::contains<0x1::string::String, Official>(&arg0.entries, arg1)
    }

    public fun migrate(arg0: &mut Names, arg1: &0xd14f072e0cdff42747ca9949f59c49ce901a082c75d2370fd138c1a8c7d03dcb::universe::AdminCap) {
        assert!(arg0.version < 1, 13906834612430372870);
        arg0.version = 1;
    }

    public fun needs_rename(arg0: &Names, arg1: &0xd14f072e0cdff42747ca9949f59c49ce901a082c75d2370fd138c1a8c7d03dcb::universe::Item) : bool {
        let v0 = *0xd14f072e0cdff42747ca9949f59c49ce901a082c75d2370fd138c1a8c7d03dcb::universe::key(arg1);
        if (!has(arg0, v0)) {
            return false
        };
        let v1 = 0x2::table::borrow<0x1::string::String, Official>(&arg0.entries, v0);
        let v2 = 0xd14f072e0cdff42747ca9949f59c49ce901a082c75d2370fd138c1a8c7d03dcb::universe::full_name(arg1, v1.name);
        &v2 != 0xd14f072e0cdff42747ca9949f59c49ce901a082c75d2370fd138c1a8c7d03dcb::universe::name(arg1) || &v1.design != 0xd14f072e0cdff42747ca9949f59c49ce901a082c75d2370fd138c1a8c7d03dcb::universe::design(arg1)
    }

    public fun official_design(arg0: &Names, arg1: 0x1::string::String) : 0x1::string::String {
        0x2::table::borrow<0x1::string::String, Official>(&arg0.entries, arg1).design
    }

    public fun official_name(arg0: &Names, arg1: 0x1::string::String) : 0x1::string::String {
        0x2::table::borrow<0x1::string::String, Official>(&arg0.entries, arg1).name
    }

    public fun rename(arg0: &Names, arg1: &mut 0xd14f072e0cdff42747ca9949f59c49ce901a082c75d2370fd138c1a8c7d03dcb::universe::Item) : bool {
        assert!(arg0.version == 1, 13906834655379914756);
        assert!(has(arg0, *0xd14f072e0cdff42747ca9949f59c49ce901a082c75d2370fd138c1a8c7d03dcb::universe::key(arg1)), 13906834659675144200);
        if (!needs_rename(arg0, arg1)) {
            return false
        };
        let v0 = *0x2::table::borrow<0x1::string::String, Official>(&arg0.entries, *0xd14f072e0cdff42747ca9949f59c49ce901a082c75d2370fd138c1a8c7d03dcb::universe::key(arg1));
        0xd14f072e0cdff42747ca9949f59c49ce901a082c75d2370fd138c1a8c7d03dcb::universe::set_name_and_design(arg1, 0xd14f072e0cdff42747ca9949f59c49ce901a082c75d2370fd138c1a8c7d03dcb::universe::full_name(arg1, v0.name), v0.design);
        true
    }

    public fun set(arg0: &mut Names, arg1: &0xd14f072e0cdff42747ca9949f59c49ce901a082c75d2370fd138c1a8c7d03dcb::universe::AdminCap, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String) {
        assert!(arg0.version == 1, 13906834530825863172);
        assert!(0x1::string::length(&arg3) > 0 && 0x1::string::length(&arg3) <= 64, 13906834535121354764);
        assert!(0x1::string::length(&arg4) > 0 && 0x1::string::length(&arg4) <= 32, 13906834539416453134);
        let v0 = Official{
            name   : arg3,
            design : arg4,
        };
        if (0x2::table::contains<0x1::string::String, Official>(&arg0.entries, arg2)) {
            *0x2::table::borrow_mut<0x1::string::String, Official>(&mut arg0.entries, arg2) = v0;
        } else {
            0x2::table::add<0x1::string::String, Official>(&mut arg0.entries, arg2, v0);
        };
        let v1 = OfficialNameSet{
            key    : arg2,
            name   : arg3,
            design : arg4,
        };
        0x2::event::emit<OfficialNameSet>(v1);
    }

    public fun setup(arg0: &0xd14f072e0cdff42747ca9949f59c49ce901a082c75d2370fd138c1a8c7d03dcb::universe::AdminCap, arg1: vector<0x1::string::String>, arg2: vector<0x1::string::String>, arg3: vector<0x1::string::String>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<0x1::string::String>(&arg1);
        assert!(0x1::vector::length<0x1::string::String>(&arg2) == v0 && 0x1::vector::length<0x1::string::String>(&arg3) == v0, 13906834496466518026);
        let v1 = Names{
            id      : 0x2::object::new(arg4),
            version : 1,
            entries : 0x2::table::new<0x1::string::String, Official>(arg4),
        };
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::string::String>(&arg1)) {
            let v3 = &mut v1;
            set(v3, arg0, 0x1::vector::pop_back<0x1::string::String>(&mut arg1), 0x1::vector::pop_back<0x1::string::String>(&mut arg2), 0x1::vector::pop_back<0x1::string::String>(&mut arg3));
            v2 = v2 + 1;
        };
        0x1::vector::destroy_empty<0x1::string::String>(arg1);
        0x2::transfer::share_object<Names>(v1);
    }

    public fun version(arg0: &Names) : u64 {
        arg0.version
    }

    // decompiled from Move bytecode v7
}

