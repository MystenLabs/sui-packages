module 0xc14866d64854a1dd6ecb417f32849f24daa662b3eb855226c40a144f767fe7f5::acl {
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

