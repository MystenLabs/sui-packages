module 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::acl {
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

