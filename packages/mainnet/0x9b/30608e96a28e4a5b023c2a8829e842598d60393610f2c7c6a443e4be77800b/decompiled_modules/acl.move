module 0x9b30608e96a28e4a5b023c2a8829e842598d60393610f2c7c6a443e4be77800b::acl {
    struct Access has store, key {
        id: 0x2::object::UID,
    }

    struct FeeReceiptAcl has key {
        id: 0x2::object::UID,
        access: Access,
    }

    public(friend) fun access(arg0: &FeeReceiptAcl) : &Access {
        &arg0.access
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Access{id: 0x2::object::new(arg0)};
        let v1 = FeeReceiptAcl{
            id     : 0x2::object::new(arg0),
            access : v0,
        };
        0x2::transfer::share_object<FeeReceiptAcl>(v1);
    }

    // decompiled from Move bytecode v6
}

