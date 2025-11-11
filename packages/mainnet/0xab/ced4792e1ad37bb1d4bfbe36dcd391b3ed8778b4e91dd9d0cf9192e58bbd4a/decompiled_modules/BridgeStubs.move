module 0xabced4792e1ad37bb1d4bfbe36dcd391b3ed8778b4e91dd9d0cf9192e58bbd4a::BridgeStubs {
    struct Attestor has store, key {
        id: 0x2::object::UID,
        admin: address,
    }

    public entry fun init_attestor(arg0: address, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Attestor{
            id    : 0x2::object::new(arg1),
            admin : arg0,
        };
        0x2::transfer::share_object<Attestor>(v0);
    }

    public fun is_admin(arg0: &Attestor, arg1: address) : bool {
        arg0.admin == arg1
    }

    // decompiled from Move bytecode v6
}

