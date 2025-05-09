module 0xad5c8cc71d5180dccb16d09adc117ebae4844770faa9b3d7461f286a55540454::subdomain {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct DomainKiosk has key {
        id: 0x2::object::UID,
        domain: 0x1::option::Option<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration>,
        whitelist: 0x2::table::Table<address, bool>,
        allow_mint: bool,
        total_minted: u64,
    }

    struct SubDomainMintedEvent has copy, drop {
        parent_id: 0x2::object::ID,
        subdomain_object_id: 0x2::object::ID,
        subdomain_name: 0x1::string::String,
        timestamp: u64,
        minter: address,
    }

    struct DomainAdded has copy, drop {
        domain: 0x2::object::ID,
        sender: address,
    }

    struct DomainTaken has copy, drop {
        domain: 0x2::object::ID,
        sender: address,
    }

    public fun add_domain(arg0: &AdminCap, arg1: &mut DomainKiosk, arg2: 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::option::is_none<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration>(&arg1.domain), 2);
        0x1::option::fill<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration>(&mut arg1.domain, arg2);
        let v0 = DomainAdded{
            domain : 0x2::object::id<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration>(&arg2),
            sender : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<DomainAdded>(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = DomainKiosk{
            id           : 0x2::object::new(arg0),
            domain       : 0x1::option::none<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration>(),
            whitelist    : 0x2::table::new<address, bool>(arg0),
            allow_mint   : true,
            total_minted : 0,
        };
        0x2::transfer::share_object<DomainKiosk>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun mint_subdomain(arg0: &mut DomainKiosk, arg1: &mut 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::SuiNS, arg2: 0x1::string::String, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::subdomain_registration::SubDomainRegistration {
        assert!(arg0.allow_mint, 1);
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(0x2::table::contains<address, bool>(&arg0.whitelist, v0), 1);
        let v1 = 0x2::table::borrow_mut<address, bool>(&mut arg0.whitelist, v0);
        assert!(*v1, 1);
        *v1 = false;
        let v2 = 0x1::option::borrow<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration>(&arg0.domain);
        let v3 = 0xe177697e191327901637f8d2c5ffbbde8b1aaac27ec1024c4b62d1ebd1cd7430::subdomains::new(arg1, v2, arg3, arg2, 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::expiration_timestamp_ms(v2), false, false, arg4);
        let v4 = SubDomainMintedEvent{
            parent_id           : 0x2::object::id<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration>(v2),
            subdomain_object_id : 0x2::object::id<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::subdomain_registration::SubDomainRegistration>(&v3),
            subdomain_name      : arg2,
            timestamp           : 0x2::clock::timestamp_ms(arg3) / 1000,
            minter              : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<SubDomainMintedEvent>(v4);
        arg0.total_minted = arg0.total_minted + 1;
        v3
    }

    public fun set_mint_access(arg0: &AdminCap, arg1: &mut DomainKiosk, arg2: bool) {
        arg1.allow_mint = arg2;
    }

    public fun set_whitelist(arg0: &AdminCap, arg1: &mut DomainKiosk, arg2: address, arg3: bool) {
        if (0x2::table::contains<address, bool>(&arg1.whitelist, arg2)) {
            *0x2::table::borrow_mut<address, bool>(&mut arg1.whitelist, arg2) = arg3;
        } else {
            0x2::table::add<address, bool>(&mut arg1.whitelist, arg2, arg3);
        };
    }

    public fun take_domain(arg0: &AdminCap, arg1: &mut DomainKiosk, arg2: &mut 0x2::tx_context::TxContext) : 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration {
        assert!(0x1::option::is_some<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration>(&arg1.domain), 2);
        let v0 = 0x1::option::extract<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration>(&mut arg1.domain);
        let v1 = DomainTaken{
            domain : 0x2::object::id<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration>(&v0),
            sender : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<DomainTaken>(v1);
        v0
    }

    // decompiled from Move bytecode v6
}

