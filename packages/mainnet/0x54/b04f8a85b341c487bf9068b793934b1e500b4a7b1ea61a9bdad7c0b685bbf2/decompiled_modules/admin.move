module 0x8a1c8b3523bd37e9aa47bf9216ed25fef1b639d347b142b8f4c9a52114d7d87f::admin {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
        admin: address,
    }

    public fun new(arg0: address, arg1: &mut 0x2::tx_context::TxContext) : AdminCap {
        AdminCap{
            id    : 0x2::object::new(arg1),
            admin : arg0,
        }
    }

    public fun admin(arg0: &AdminCap) : address {
        arg0.admin
    }

    public fun assert_admin(arg0: &AdminCap, arg1: address) {
        assert!(arg0.admin == arg1, 100);
    }

    // decompiled from Move bytecode v7
}

