module 0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::source {
    struct SourceObjectKey has copy, drop, store {
        pos0: u16,
    }

    struct Source<phantom T0> has store, key {
        id: 0x2::object::UID,
        source_cap: 0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::authority::SourceCap,
        version: u64,
    }

    public fun source_id<T0>(arg0: &Source<T0>) : u16 {
        0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::authority::source_id(&arg0.source_cap)
    }

    public fun borrow_mut_id<T0: drop>(arg0: &mut Source<T0>, arg1: T0) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    public fun set_authorized<T0, T1>(arg0: &mut Source<T0>, arg1: &0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::config::Config, arg2: &0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::AuthorityCap<0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::authority::PACKAGE, T1>, arg3: bool) {
        0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::config::set_authorized<T1>(arg1, arg2, &mut arg0.source_cap, arg3);
    }

    public fun assert_version<T0>(arg0: &Source<T0>, arg1: u64) {
        if (arg0.version > arg1) {
            abort 13835058617922879489
        };
    }

    public fun borrow_id<T0>(arg0: &Source<T0>) : &0x2::object::UID {
        &arg0.id
    }

    public fun borrow_source_cap<T0: drop>(arg0: &Source<T0>, arg1: T0) : &0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::authority::SourceCap {
        &arg0.source_cap
    }

    public fun child_exists<T0, T1: copy + drop + store>(arg0: &Source<T0>, arg1: T1) : bool {
        0x2::derived_object::exists<T1>(&arg0.id, arg1)
    }

    public fun child_id<T0, T1: copy + drop + store>(arg0: &Source<T0>, arg1: T1) : 0x2::object::ID {
        0x2::object::id_from_address(0x2::derived_object::derive_address<T1>(0x2::object::uid_to_inner(&arg0.id), arg1))
    }

    public fun create<T0, T1>(arg0: &mut 0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::config::Config, arg1: &0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::AuthorityCap<0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::authority::PACKAGE, T1>, arg2: &T0, arg3: u64) : Source<T0> {
        let v0 = 0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::config::new_source_id<T0, T1>(arg0, arg1);
        let v1 = 0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::authority::source_id(&v0);
        let v2 = SourceObjectKey{pos0: v1};
        let v3 = Source<T0>{
            id         : 0x2::derived_object::claim<SourceObjectKey>(0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::config::borrow_mut_id(arg0), v2),
            source_cap : v0,
            version    : arg3,
        };
        0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::events::emit_created_source(v1, 0x2::object::uid_to_inner(&v3.id));
        v3
    }

    public fun derived_id(arg0: &0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::config::Config, arg1: u16) : 0x2::object::ID {
        let v0 = SourceObjectKey{pos0: arg1};
        0x2::object::id_from_address(0x2::derived_object::derive_address<SourceObjectKey>(0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::config::id(arg0), v0))
    }

    public fun object_id<T0>(arg0: &Source<T0>) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun upgrade_version<T0, T1>(arg0: &mut Source<T0>, arg1: &0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::config::Config, arg2: &0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::AuthorityCap<0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::authority::PACKAGE, T1>, arg3: u64) {
        assert!(arg0.version < arg3, 13835058321570136065);
        0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::config::assert_package_version(arg1);
        0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::authority::assert_is_admin_or_assistant<T1>();
        0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::config::assert_package_authority_cap_is_valid<T1>(arg1, arg2);
        arg0.version = arg3;
        0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::events::emit_upgraded_source_version(0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::authority::source_id(&arg0.source_cap), arg3);
    }

    public fun version<T0>(arg0: &Source<T0>) : u64 {
        arg0.version
    }

    // decompiled from Move bytecode v7
}

