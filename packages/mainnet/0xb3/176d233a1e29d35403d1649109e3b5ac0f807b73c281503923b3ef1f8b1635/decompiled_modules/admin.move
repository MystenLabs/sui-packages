module 0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::admin {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct AdminTransferredV1 has copy, drop {
        cap: 0x2::object::ID,
        to: address,
    }

    public(friend) fun mint_to(arg0: address, arg1: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v0, arg0);
        0x2::object::id<AdminCap>(&v0)
    }

    entry fun transfer_admin(arg0: AdminCap, arg1: address) {
        assert!(arg1 != @0x0, 0);
        let v0 = AdminTransferredV1{
            cap : 0x2::object::id<AdminCap>(&arg0),
            to  : arg1,
        };
        0x2::event::emit<AdminTransferredV1>(v0);
        0x2::transfer::transfer<AdminCap>(arg0, arg1);
    }

    // decompiled from Move bytecode v7
}

