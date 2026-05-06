module 0xfe53558dfe4f0a1e4fd66f4d96d724a7e7683552b27016464fc101ea1f03af63::auth {
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

