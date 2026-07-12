module 0xec2dcd65271127019351678ddd05287176a0b9b7fc59ef6ceef34fdbc36e87db::domain_registry {
    struct DomainRegistry has key {
        id: 0x2::object::UID,
        domains: 0x2::table::Table<0x1::string::String, 0x2::object::ID>,
    }

    struct DomainLinked has copy, drop {
        domain: 0x1::string::String,
        site_id: 0x2::object::ID,
    }

    struct DomainUnlinked has copy, drop {
        domain: 0x1::string::String,
    }

    public fun contains(arg0: &DomainRegistry, arg1: 0x1::string::String) : bool {
        0x2::table::contains<0x1::string::String, 0x2::object::ID>(&arg0.domains, arg1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = DomainRegistry{
            id      : 0x2::object::new(arg0),
            domains : 0x2::table::new<0x1::string::String, 0x2::object::ID>(arg0),
        };
        0x2::transfer::share_object<DomainRegistry>(v0);
    }

    public fun link_domain(arg0: &0xec2dcd65271127019351678ddd05287176a0b9b7fc59ef6ceef34fdbc36e87db::version::Version, arg1: &mut DomainRegistry, arg2: &0xec2dcd65271127019351678ddd05287176a0b9b7fc59ef6ceef34fdbc36e87db::site::SiteAdminCap, arg3: &0xec2dcd65271127019351678ddd05287176a0b9b7fc59ef6ceef34fdbc36e87db::site::Site, arg4: 0x1::string::String) {
        0xec2dcd65271127019351678ddd05287176a0b9b7fc59ef6ceef34fdbc36e87db::version::assert_version(arg0);
        let v0 = 0x2::object::id<0xec2dcd65271127019351678ddd05287176a0b9b7fc59ef6ceef34fdbc36e87db::site::Site>(arg3);
        assert!(0xec2dcd65271127019351678ddd05287176a0b9b7fc59ef6ceef34fdbc36e87db::site::cap_site_id(arg2) == v0, 1);
        assert!(!0x2::table::contains<0x1::string::String, 0x2::object::ID>(&arg1.domains, arg4), 0);
        0x2::table::add<0x1::string::String, 0x2::object::ID>(&mut arg1.domains, arg4, v0);
        let v1 = DomainLinked{
            domain  : arg4,
            site_id : v0,
        };
        0x2::event::emit<DomainLinked>(v1);
    }

    public fun site_id_of(arg0: &DomainRegistry, arg1: 0x1::string::String) : 0x2::object::ID {
        *0x2::table::borrow<0x1::string::String, 0x2::object::ID>(&arg0.domains, arg1)
    }

    public fun unlink_domain(arg0: &0xec2dcd65271127019351678ddd05287176a0b9b7fc59ef6ceef34fdbc36e87db::version::Version, arg1: &mut DomainRegistry, arg2: &0xec2dcd65271127019351678ddd05287176a0b9b7fc59ef6ceef34fdbc36e87db::site::SiteAdminCap, arg3: 0x1::string::String) {
        0xec2dcd65271127019351678ddd05287176a0b9b7fc59ef6ceef34fdbc36e87db::version::assert_version(arg0);
        assert!(0x2::table::contains<0x1::string::String, 0x2::object::ID>(&arg1.domains, arg3), 2);
        assert!(0xec2dcd65271127019351678ddd05287176a0b9b7fc59ef6ceef34fdbc36e87db::site::cap_site_id(arg2) == *0x2::table::borrow<0x1::string::String, 0x2::object::ID>(&arg1.domains, arg3), 1);
        0x2::table::remove<0x1::string::String, 0x2::object::ID>(&mut arg1.domains, arg3);
        let v0 = DomainUnlinked{domain: arg3};
        0x2::event::emit<DomainUnlinked>(v0);
    }

    // decompiled from Move bytecode v7
}

