module 0x44316e84ccadcdb69ce0837d10df1510dee91963104dcf304d23fdf31443c218::acl {
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

