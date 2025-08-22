module 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::acl {
    struct Access has store, key {
        id: 0x2::object::UID,
    }

    struct SmartAccountAcl has key {
        id: 0x2::object::UID,
        access: Access,
    }

    public(friend) fun access(arg0: &SmartAccountAcl) : &Access {
        &arg0.access
    }

    public(friend) fun acl_id(arg0: &SmartAccountAcl) : 0x2::object::ID {
        0x2::object::id<Access>(&arg0.access)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Access{id: 0x2::object::new(arg0)};
        let v1 = SmartAccountAcl{
            id     : 0x2::object::new(arg0),
            access : v0,
        };
        0x2::transfer::share_object<SmartAccountAcl>(v1);
    }

    // decompiled from Move bytecode v6
}

