module 0x84e9c31d961436709798f0c4b69e2b9cf4e006517f2e3b4245349b2358d2a7d9::acl {
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

