module 0x29a425252cc04cd03b7bd8d4c48e25452742346be740d4a443c0f750be3a1150::acl {
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

