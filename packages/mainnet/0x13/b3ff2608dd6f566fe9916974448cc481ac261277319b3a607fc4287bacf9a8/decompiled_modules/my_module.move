module 0x13b3ff2608dd6f566fe9916974448cc481ac261277319b3a607fc4287bacf9a8::my_module {
    struct OwnerCap has key {
        id: 0x2::object::UID,
    }

    public entry fun exec<T0>(arg0: &mut OwnerCap, arg1: &mut 0xbbc3dc993218b13253c8b4ccc2f39fbc3c8964850d7e6a913c820f2c2f0ffcb5::flash::Oops<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0xbbc3dc993218b13253c8b4ccc2f39fbc3c8964850d7e6a913c820f2c2f0ffcb5::flash::woop<T0>(arg1, arg2, 0x2::address::to_bytes(v0), arg3), v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = OwnerCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<OwnerCap>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

