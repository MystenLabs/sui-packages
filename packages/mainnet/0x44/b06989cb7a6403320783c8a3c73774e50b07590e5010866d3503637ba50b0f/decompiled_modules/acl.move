module 0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::acl {
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

