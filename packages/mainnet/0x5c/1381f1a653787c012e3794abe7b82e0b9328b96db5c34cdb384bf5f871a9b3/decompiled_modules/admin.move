module 0x5c1381f1a653787c012e3794abe7b82e0b9328b96db5c34cdb384bf5f871a9b3::admin {
    struct AdminConfig has store, key {
        id: 0x2::object::UID,
        owner: address,
        offchain: address,
    }

    public entry fun change_offchain(arg0: &mut AdminConfig, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 1);
        arg0.offchain = arg1;
    }

    public fun get_offchain(arg0: &AdminConfig) : address {
        arg0.offchain
    }

    public fun get_owner(arg0: &AdminConfig) : address {
        arg0.owner
    }

    public(friend) fun init_(arg0: &mut 0x2::tx_context::TxContext) : AdminConfig {
        let v0 = 0x2::tx_context::sender(arg0);
        AdminConfig{
            id       : 0x2::object::new(arg0),
            owner    : v0,
            offchain : v0,
        }
    }

    public(friend) fun propagate(arg0: AdminConfig) {
        0x2::transfer::share_object<AdminConfig>(arg0);
    }

    public entry fun transfer_ownership(arg0: &mut AdminConfig, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 1);
        arg0.owner = arg1;
    }

    // decompiled from Move bytecode v6
}

