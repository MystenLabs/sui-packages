module 0x4c642de2d3d08a142ee12219f193d06e4f0699c3def67028ed57c514ac048fc6::auth {
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

