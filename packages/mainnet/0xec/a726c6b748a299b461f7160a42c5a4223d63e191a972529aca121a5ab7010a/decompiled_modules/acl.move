module 0xeca726c6b748a299b461f7160a42c5a4223d63e191a972529aca121a5ab7010a::acl {
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

