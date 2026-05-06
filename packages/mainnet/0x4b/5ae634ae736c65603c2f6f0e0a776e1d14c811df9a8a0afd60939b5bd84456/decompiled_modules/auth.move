module 0x4b5ae634ae736c65603c2f6f0e0a776e1d14c811df9a8a0afd60939b5bd84456::auth {
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

