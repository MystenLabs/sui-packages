module 0xdaf58abc5d6cb67d75d2fb7836a0ffb394d94f7a003be60ff54ef42716b985ea::suins_domain {
    struct DomainItem has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        expiration_time: u64,
        creator: address,
    }

    struct DomainCreated has copy, drop {
        domain_id: 0x2::object::ID,
        name: 0x1::string::String,
        creator: address,
        expiration_time: u64,
    }

    public entry fun create_domain_item(arg0: &0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::SuiNS, arg1: 0x1::string::String, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::registry::lookup(0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::registry<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::registry::Registry>(arg0), 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::domain::new(arg1));
        assert!(0x1::option::is_some<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::name_record::NameRecord>(&v0), 0);
        let v1 = 0x1::option::borrow<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::name_record::NameRecord>(&v0);
        assert!(!0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::name_record::has_expired(v1, arg2), 2);
        let v2 = 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::name_record::target_address(v1);
        assert!(0x1::option::is_some<address>(&v2), 1);
        let v3 = 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::name_record::target_address(v1);
        assert!(*0x1::option::borrow<address>(&v3) == 0x2::tx_context::sender(arg3), 3);
        let v4 = 0x2::clock::timestamp_ms(arg2) + 31536000000;
        let v5 = DomainItem{
            id              : 0x2::object::new(arg3),
            name            : arg1,
            expiration_time : v4,
            creator         : 0x2::tx_context::sender(arg3),
        };
        let v6 = DomainCreated{
            domain_id       : 0x2::object::id<DomainItem>(&v5),
            name            : arg1,
            creator         : 0x2::tx_context::sender(arg3),
            expiration_time : v4,
        };
        0x2::event::emit<DomainCreated>(v6);
        0x2::transfer::public_transfer<DomainItem>(v5, 0x2::tx_context::sender(arg3));
    }

    public fun expiration_time(arg0: &DomainItem) : u64 {
        arg0.expiration_time
    }

    public fun is_valid(arg0: &DomainItem, arg1: &0x2::clock::Clock) : bool {
        0x2::clock::timestamp_ms(arg1) < arg0.expiration_time
    }

    public fun name(arg0: &DomainItem) : &0x1::string::String {
        &arg0.name
    }

    // decompiled from Move bytecode v6
}

