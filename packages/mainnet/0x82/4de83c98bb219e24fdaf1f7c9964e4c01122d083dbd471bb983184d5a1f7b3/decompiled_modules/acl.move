module 0x824de83c98bb219e24fdaf1f7c9964e4c01122d083dbd471bb983184d5a1f7b3::acl {
    struct Access has store, key {
        id: 0x2::object::UID,
    }

    struct RouterAcl has key {
        id: 0x2::object::UID,
        access: Access,
    }

    public(friend) fun access(arg0: &RouterAcl) : &Access {
        &arg0.access
    }

    public fun access_id(arg0: &RouterAcl) : 0x2::object::ID {
        0x2::object::id<Access>(&arg0.access)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Access{id: 0x2::object::new(arg0)};
        let v1 = RouterAcl{
            id     : 0x2::object::new(arg0),
            access : v0,
        };
        0x2::transfer::share_object<RouterAcl>(v1);
    }

    // decompiled from Move bytecode v6
}

