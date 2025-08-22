module 0x58a3b265ca4aa1fd874c04975b7bbb540f34c3345948fec12cd6f2511d1e3de3::ns_acct {
    struct Registry has key {
        id: 0x2::object::UID,
        namespaces: 0x2::table::Table<0x1::string::String, Namespace>,
        owner: address,
    }

    struct Namespace has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        entries: 0x2::table::Table<0x1::string::String, AcctObject>,
    }

    struct AcctObject has store, key {
        id: 0x2::object::UID,
        data: 0x1::string::String,
    }

    public fun acct_data(arg0: &AcctObject) : 0x1::string::String {
        arg0.data
    }

    public fun add_namespace(arg0: &mut Registry, arg1: 0x1::string::String, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 == arg0.owner, 0);
        let v0 = Namespace{
            id      : 0x2::object::new(arg3),
            name    : arg1,
            entries : 0x2::table::new<0x1::string::String, AcctObject>(arg3),
        };
        0x2::table::add<0x1::string::String, Namespace>(&mut arg0.namespaces, arg1, v0);
    }

    public fun create_acct_object(arg0: 0x1::string::String, arg1: &mut 0x2::tx_context::TxContext) : AcctObject {
        AcctObject{
            id   : 0x2::object::new(arg1),
            data : arg0,
        }
    }

    entry fun create_registry(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = init_registry(arg0);
        0x2::transfer::transfer<Registry>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun get_account_data(arg0: &Registry, arg1: 0x1::string::String, arg2: 0x1::string::String) : (0x1::string::String, 0x1::string::String) {
        (arg2, query(arg0, arg1, arg2).data)
    }

    public fun init_registry(arg0: &mut 0x2::tx_context::TxContext) : Registry {
        Registry{
            id         : 0x2::object::new(arg0),
            namespaces : 0x2::table::new<0x1::string::String, Namespace>(arg0),
            owner      : 0x2::tx_context::sender(arg0),
        }
    }

    fun is_subdomain_of(arg0: 0x1::string::String, arg1: 0x1::string::String) : bool {
        let v0 = 0x1::string::as_bytes(&arg0);
        let v1 = 0x1::string::as_bytes(&arg1);
        let v2 = 0x1::vector::length<u8>(v0);
        let v3 = 0x1::vector::length<u8>(v1);
        if (v2 <= v3) {
            return false
        };
        let v4 = 0;
        while (v4 < v3) {
            if (*0x1::vector::borrow<u8>(v0, v2 - v3 + v4) != *0x1::vector::borrow<u8>(v1, v4)) {
                return false
            };
            v4 = v4 + 1;
        };
        true
    }

    public fun namespace_exists(arg0: &Registry, arg1: 0x1::string::String) : bool {
        0x2::table::contains<0x1::string::String, Namespace>(&arg0.namespaces, arg1)
    }

    public fun namespace_name(arg0: &Namespace) : 0x1::string::String {
        arg0.name
    }

    fun parse_domain_string(arg0: &0x1::string::String) : 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::domain::Domain {
        0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::domain::new(*arg0)
    }

    public fun query(arg0: &Registry, arg1: 0x1::string::String, arg2: 0x1::string::String) : &AcctObject {
        assert!(0x2::table::contains<0x1::string::String, Namespace>(&arg0.namespaces, arg1), 1);
        let v0 = 0x2::table::borrow<0x1::string::String, Namespace>(&arg0.namespaces, arg1);
        assert!(0x2::table::contains<0x1::string::String, AcctObject>(&v0.entries, arg2), 3);
        0x2::table::borrow<0x1::string::String, AcctObject>(&v0.entries, arg2)
    }

    public fun registry_owner(arg0: &Registry) : address {
        arg0.owner
    }

    public fun remove_entry(arg0: &mut Registry, arg1: &0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::SuiNS, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: address) {
        assert!(0x2::table::contains<0x1::string::String, Namespace>(&arg0.namespaces, arg2), 1);
        let v0 = 0x2::table::borrow_mut<0x1::string::String, Namespace>(&mut arg0.namespaces, arg2);
        assert!(0x2::table::contains<0x1::string::String, AcctObject>(&v0.entries, arg3), 3);
        0x2::table::borrow<0x1::string::String, AcctObject>(&v0.entries, arg3);
        assert!(verify_domain_ownership(arg1, arg3, arg4), 0);
        0x2::transfer::public_transfer<AcctObject>(0x2::table::remove<0x1::string::String, AcctObject>(&mut v0.entries, arg3), @0x0);
    }

    public fun update_entry(arg0: &mut Registry, arg1: &0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::SuiNS, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: address, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<0x1::string::String, Namespace>(&arg0.namespaces, arg2), 1);
        let v0 = 0x2::table::borrow_mut<0x1::string::String, Namespace>(&mut arg0.namespaces, arg2);
        assert!(verify_domain_ownership(arg1, arg3, arg5), 0);
        let v1 = AcctObject{
            id   : 0x2::object::new(arg6),
            data : arg4,
        };
        if (0x2::table::contains<0x1::string::String, AcctObject>(&v0.entries, arg3)) {
            0x2::transfer::public_transfer<AcctObject>(0x2::table::remove<0x1::string::String, AcctObject>(&mut v0.entries, arg3), @0x0);
        };
        0x2::table::add<0x1::string::String, AcctObject>(&mut v0.entries, arg3, v1);
    }

    public fun update_entry_with_nft(arg0: &mut Registry, arg1: &0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::SuiNS, arg2: &0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<0x1::string::String, Namespace>(&arg0.namespaces, arg3), 1);
        let v0 = 0x2::table::borrow_mut<0x1::string::String, Namespace>(&mut arg0.namespaces, arg3);
        assert!(verify_domain_ownership_with_nft(arg1, arg2), 0);
        let v1 = 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::domain(arg2);
        let v2 = 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::domain::to_string(&v1);
        let v3 = AcctObject{
            id   : 0x2::object::new(arg5),
            data : arg4,
        };
        if (0x2::table::contains<0x1::string::String, AcctObject>(&v0.entries, v2)) {
            0x2::transfer::public_transfer<AcctObject>(0x2::table::remove<0x1::string::String, AcctObject>(&mut v0.entries, v2), @0x0);
        };
        0x2::table::add<0x1::string::String, AcctObject>(&mut v0.entries, v2, v3);
    }

    public fun update_subdomain_entry_by_target(arg0: &mut Registry, arg1: &0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::SuiNS, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<0x1::string::String, Namespace>(&arg0.namespaces, arg2), 1);
        let v0 = 0x2::table::borrow_mut<0x1::string::String, Namespace>(&mut arg0.namespaces, arg2);
        assert!(verify_subdomain_target_control(arg1, arg3, 0x2::tx_context::sender(arg5)), 0);
        let v1 = AcctObject{
            id   : 0x2::object::new(arg5),
            data : arg4,
        };
        if (0x2::table::contains<0x1::string::String, AcctObject>(&v0.entries, arg3)) {
            0x2::transfer::public_transfer<AcctObject>(0x2::table::remove<0x1::string::String, AcctObject>(&mut v0.entries, arg3), @0x0);
        };
        0x2::table::add<0x1::string::String, AcctObject>(&mut v0.entries, arg3, v1);
    }

    public fun update_subdomain_entry_with_nft(arg0: &mut Registry, arg1: &0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::SuiNS, arg2: &0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        update_subdomain_entry_with_verification(arg0, arg1, arg2, arg3, arg4, arg5, v0, arg6);
    }

    public fun update_subdomain_entry_with_verification(arg0: &mut Registry, arg1: &0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::SuiNS, arg2: &0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: address, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<0x1::string::String, Namespace>(&arg0.namespaces, arg3), 1);
        let v0 = 0x2::table::borrow_mut<0x1::string::String, Namespace>(&mut arg0.namespaces, arg3);
        let v1 = 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::domain(arg2);
        let v2 = 0x1::string::utf8(b".");
        0x1::string::append(&mut v2, 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::domain::to_string(&v1));
        assert!(is_subdomain_of(arg4, v2), 0);
        assert!(verify_subdomain_control(arg1, arg2, arg4, arg6), 0);
        let v3 = AcctObject{
            id   : 0x2::object::new(arg7),
            data : arg5,
        };
        if (0x2::table::contains<0x1::string::String, AcctObject>(&v0.entries, arg4)) {
            0x2::transfer::public_transfer<AcctObject>(0x2::table::remove<0x1::string::String, AcctObject>(&mut v0.entries, arg4), @0x0);
        };
        0x2::table::add<0x1::string::String, AcctObject>(&mut v0.entries, arg4, v3);
    }

    public fun verify_domain_ownership(arg0: &0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::SuiNS, arg1: 0x1::string::String, arg2: address) : bool {
        let v0 = 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::registry::lookup(0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::registry<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::registry::Registry>(arg0), parse_domain_string(&arg1));
        if (0x1::option::is_none<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::name_record::NameRecord>(&v0)) {
            return false
        };
        let v1 = 0x1::option::extract<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::name_record::NameRecord>(&mut v0);
        let v2 = 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::name_record::target_address(&v1);
        0x1::option::is_some<address>(&v2) && *0x1::option::borrow<address>(&v2) == arg2
    }

    public fun verify_domain_ownership_with_nft(arg0: &0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::SuiNS, arg1: &0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration) : bool {
        let v0 = 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::registry::lookup(0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::registry<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::registry::Registry>(arg0), 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::domain(arg1));
        if (0x1::option::is_none<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::name_record::NameRecord>(&v0)) {
            return false
        };
        0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::name_record::nft_id(0x1::option::borrow<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::name_record::NameRecord>(&v0)) == 0x2::object::id<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration>(arg1)
    }

    fun verify_subdomain_control(arg0: &0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::SuiNS, arg1: &0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration, arg2: 0x1::string::String, arg3: address) : bool {
        verify_domain_ownership_with_nft(arg0, arg1)
    }

    fun verify_subdomain_target_control(arg0: &0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::SuiNS, arg1: 0x1::string::String, arg2: address) : bool {
        verify_domain_ownership(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

