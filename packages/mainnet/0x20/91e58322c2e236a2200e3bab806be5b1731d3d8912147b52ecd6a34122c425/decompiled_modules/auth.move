module 0x2091e58322c2e236a2200e3bab806be5b1731d3d8912147b52ecd6a34122c425::auth {
    struct OwnerCap has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = OwnerCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<OwnerCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun renounce_ownership(arg0: OwnerCap) {
        let OwnerCap { id: v0 } = arg0;
        0x2::object::delete(v0);
    }

    public entry fun transfer_ownership(arg0: OwnerCap, arg1: address) {
        0x2::transfer::transfer<OwnerCap>(arg0, arg1);
    }

    // decompiled from Move bytecode v7
}

