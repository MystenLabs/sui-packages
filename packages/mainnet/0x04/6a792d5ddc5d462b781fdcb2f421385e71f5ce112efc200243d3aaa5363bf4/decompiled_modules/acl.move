module 0x46a792d5ddc5d462b781fdcb2f421385e71f5ce112efc200243d3aaa5363bf4::acl {
    struct Access has store, key {
        id: 0x2::object::UID,
    }

    struct Acl has key {
        id: 0x2::object::UID,
        access: Access,
    }

    public(friend) fun access(arg0: &Acl) : &Access {
        &arg0.access
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Access{id: 0x2::object::new(arg0)};
        let v1 = Acl{
            id     : 0x2::object::new(arg0),
            access : v0,
        };
        0x2::transfer::share_object<Acl>(v1);
    }

    // decompiled from Move bytecode v6
}

