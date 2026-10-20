module 0xc90ed2fbb74ba735aaaeb86bbe376972a8119c62f4f1d59cf734de6815b9feee::names {
    struct Names has key {
        id: 0x2::object::UID,
        version: u64,
        list: 0x2::table::Table<0x1::string::String, Official>,
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

    public fun remove(arg0: &mut Names, arg1: &0xc90ed2fbb74ba735aaaeb86bbe376972a8119c62f4f1d59cf734de6815b9feee::item::AdminCap, arg2: 0x1::string::String) {
        assert!(arg0.version == 5, 13906834599545339908);
        assert!(0x2::table::contains<0x1::string::String, Official>(&arg0.list, arg2), 13906834603840569352);
        0x2::table::remove<0x1::string::String, Official>(&mut arg0.list, arg2);
        let v0 = OfficialNameRemoved{key: arg2};
        0x2::event::emit<OfficialNameRemoved>(v0);
    }

    public fun has(arg0: &Names, arg1: 0x1::string::String) : bool {
        0x2::table::contains<0x1::string::String, Official>(&arg0.list, arg1)
    }

    public fun migrate(arg0: &mut Names, arg1: &0xc90ed2fbb74ba735aaaeb86bbe376972a8119c62f4f1d59cf734de6815b9feee::item::AdminCap) {
        assert!(arg0.version < 5, 13906834633905209350);
        arg0.version = 5;
    }

    public fun needs_rename(arg0: &Names, arg1: &0xc90ed2fbb74ba735aaaeb86bbe376972a8119c62f4f1d59cf734de6815b9feee::universe::Item) : bool {
        let v0 = *0xc90ed2fbb74ba735aaaeb86bbe376972a8119c62f4f1d59cf734de6815b9feee::universe::key(arg1);
        if (!0x2::table::contains<0x1::string::String, Official>(&arg0.list, v0)) {
            return false
        };
        let v1 = *0x2::table::borrow<0x1::string::String, Official>(&arg0.list, v0);
        let v2 = 0xc90ed2fbb74ba735aaaeb86bbe376972a8119c62f4f1d59cf734de6815b9feee::universe::full_name(arg1, v1.name);
        &v2 != 0xc90ed2fbb74ba735aaaeb86bbe376972a8119c62f4f1d59cf734de6815b9feee::universe::name(arg1) || &v1.design != 0xc90ed2fbb74ba735aaaeb86bbe376972a8119c62f4f1d59cf734de6815b9feee::universe::design(arg1)
    }

    public fun official_design(arg0: &Names, arg1: 0x1::string::String) : 0x1::string::String {
        0x2::table::borrow<0x1::string::String, Official>(&arg0.list, arg1).design
    }

    public fun official_name(arg0: &Names, arg1: 0x1::string::String) : 0x1::string::String {
        0x2::table::borrow<0x1::string::String, Official>(&arg0.list, arg1).name
    }

    public fun rename(arg0: &Names, arg1: &mut 0xc90ed2fbb74ba735aaaeb86bbe376972a8119c62f4f1d59cf734de6815b9feee::universe::Item) : bool {
        assert!(arg0.version == 5, 13906834676854751236);
        let v0 = *0xc90ed2fbb74ba735aaaeb86bbe376972a8119c62f4f1d59cf734de6815b9feee::universe::key(arg1);
        assert!(0x2::table::contains<0x1::string::String, Official>(&arg0.list, v0), 13906834685444947976);
        let v1 = *0x2::table::borrow<0x1::string::String, Official>(&arg0.list, v0);
        let v2 = 0xc90ed2fbb74ba735aaaeb86bbe376972a8119c62f4f1d59cf734de6815b9feee::universe::full_name(arg1, v1.name);
        if (&v2 == 0xc90ed2fbb74ba735aaaeb86bbe376972a8119c62f4f1d59cf734de6815b9feee::universe::name(arg1) && &v1.design == 0xc90ed2fbb74ba735aaaeb86bbe376972a8119c62f4f1d59cf734de6815b9feee::universe::design(arg1)) {
            return false
        };
        0xc90ed2fbb74ba735aaaeb86bbe376972a8119c62f4f1d59cf734de6815b9feee::universe::set_name_and_design(arg1, v2, v1.design);
        true
    }

    public fun set(arg0: &mut Names, arg1: &0xc90ed2fbb74ba735aaaeb86bbe376972a8119c62f4f1d59cf734de6815b9feee::item::AdminCap, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String) {
        assert!(arg0.version == 5, 13906834556595666948);
        assert!(0x1::string::length(&arg3) > 0 && 0x1::string::length(&arg3) <= 64, 13906834560891158540);
        assert!(0x1::string::length(&arg4) > 0 && 0x1::string::length(&arg4) <= 32, 13906834565186256910);
        if (0x2::table::contains<0x1::string::String, Official>(&arg0.list, arg2)) {
            0x2::table::remove<0x1::string::String, Official>(&mut arg0.list, arg2);
        };
        let v0 = Official{
            name   : arg3,
            design : arg4,
        };
        0x2::table::add<0x1::string::String, Official>(&mut arg0.list, arg2, v0);
        let v1 = OfficialNameSet{
            key    : arg2,
            name   : arg3,
            design : arg4,
        };
        0x2::event::emit<OfficialNameSet>(v1);
    }

    public fun setup(arg0: &0xc90ed2fbb74ba735aaaeb86bbe376972a8119c62f4f1d59cf734de6815b9feee::item::AdminCap, arg1: vector<0x1::string::String>, arg2: vector<0x1::string::String>, arg3: vector<0x1::string::String>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<0x1::string::String>(&arg1);
        assert!(0x1::vector::length<0x1::string::String>(&arg2) == v0 && 0x1::vector::length<0x1::string::String>(&arg3) == v0, 13906834505056452618);
        let v1 = Names{
            id      : 0x2::object::new(arg4),
            version : 5,
            list    : 0x2::table::new<0x1::string::String, Official>(arg4),
        };
        let v2 = 0;
        while (v2 < v0) {
            let v3 = &mut v1;
            set(v3, arg0, *0x1::vector::borrow<0x1::string::String>(&arg1, v2), *0x1::vector::borrow<0x1::string::String>(&arg2, v2), *0x1::vector::borrow<0x1::string::String>(&arg3, v2));
            v2 = v2 + 1;
        };
        0x2::transfer::share_object<Names>(v1);
    }

    public fun version(arg0: &Names) : u64 {
        arg0.version
    }

    // decompiled from Move bytecode v7
}

