module 0x4643a9779fe25d1f13143071f35f6688a8e3ecd24d798f1560dc61dc5baee197::acl {
    struct Access has store, key {
        id: 0x2::object::UID,
    }

    struct AggregatorAcl has key {
        id: 0x2::object::UID,
        access: Access,
    }

    public(friend) fun access(arg0: &AggregatorAcl) : &Access {
        &arg0.access
    }

    public fun access_id(arg0: &AggregatorAcl) : 0x2::object::ID {
        0x2::object::id<Access>(&arg0.access)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Access{id: 0x2::object::new(arg0)};
        let v1 = AggregatorAcl{
            id     : 0x2::object::new(arg0),
            access : v0,
        };
        0x2::transfer::share_object<AggregatorAcl>(v1);
    }

    // decompiled from Move bytecode v6
}

