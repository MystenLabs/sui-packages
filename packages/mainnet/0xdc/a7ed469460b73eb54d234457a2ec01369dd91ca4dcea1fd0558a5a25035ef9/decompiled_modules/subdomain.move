module 0xdca7ed469460b73eb54d234457a2ec01369dd91ca4dcea1fd0558a5a25035ef9::subdomain {
    struct KioskAdmin has store, key {
        id: 0x2::object::UID,
    }

    struct DomainKiosk has store, key {
        id: 0x2::object::UID,
        table: 0x2::object_table::ObjectTable<0x2::object::ID, 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration>,
        allow_mint: bool,
    }

    struct DomainAddedEvent has copy, drop {
        domain_id: 0x2::object::ID,
        name: 0x1::string::String,
        timestamp: u64,
        by: address,
    }

    struct DomainRemovedEvent has copy, drop {
        domain_id: 0x2::object::ID,
        name: 0x1::string::String,
        timestamp: u64,
        by: address,
    }

    struct SubDomainMintedEvent has copy, drop {
        parent_id: 0x2::object::ID,
        subdomain_name: 0x1::string::String,
        timestamp: u64,
        by: address,
    }

    public entry fun add_domain(arg0: &KioskAdmin, arg1: &mut DomainKiosk, arg2: 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration>(&arg2);
        let v1 = DomainAddedEvent{
            domain_id : v0,
            name      : 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::domain_name(&arg2),
            timestamp : 0x2::clock::timestamp_ms(arg3),
            by        : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<DomainAddedEvent>(v1);
        0x2::object_table::add<0x2::object::ID, 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration>(&mut arg1.table, v0, arg2);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = DomainKiosk{
            id         : 0x2::object::new(arg0),
            table      : 0x2::object_table::new<0x2::object::ID, 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration>(arg0),
            allow_mint : true,
        };
        0x2::transfer::public_share_object<DomainKiosk>(v0);
        let v1 = KioskAdmin{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<KioskAdmin>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun mint_subdomain(arg0: &mut DomainKiosk, arg1: &mut 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::SuiNS, arg2: 0x2::object::ID, arg3: 0x1::string::String, arg4: bool, arg5: bool, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::subdomain_registration::SubDomainRegistration {
        assert!(arg0.allow_mint, 2);
        assert!(0x2::object_table::contains<0x2::object::ID, 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration>(&arg0.table, arg2), 1);
        let v0 = 0x2::object_table::borrow<0x2::object::ID, 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration>(&arg0.table, arg2);
        let v1 = SubDomainMintedEvent{
            parent_id      : arg2,
            subdomain_name : arg3,
            timestamp      : 0x2::clock::timestamp_ms(arg6),
            by             : 0x2::tx_context::sender(arg7),
        };
        0x2::event::emit<SubDomainMintedEvent>(v1);
        0xe177697e191327901637f8d2c5ffbbde8b1aaac27ec1024c4b62d1ebd1cd7430::subdomains::new(arg1, v0, arg6, arg3, 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::expiration_timestamp_ms(v0), arg4, arg5, arg7)
    }

    public entry fun remove_domain(arg0: &KioskAdmin, arg1: &mut DomainKiosk, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::object_table::contains<0x2::object::ID, 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration>(&arg1.table, arg2), 1);
        let v0 = 0x2::object_table::remove<0x2::object::ID, 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration>(&mut arg1.table, arg2);
        let v1 = DomainRemovedEvent{
            domain_id : arg2,
            name      : 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::domain_name(&v0),
            timestamp : 0x2::clock::timestamp_ms(arg3),
            by        : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<DomainRemovedEvent>(v1);
        0x2::transfer::public_transfer<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration>(v0, 0x2::tx_context::sender(arg4));
    }

    public fun toggle_mint_access(arg0: &KioskAdmin, arg1: &mut DomainKiosk, arg2: bool) {
        arg1.allow_mint = arg2;
    }

    // decompiled from Move bytecode v6
}

