module 0x53a5a74e4d02a2c95aa59a9c6a364e76c0d4fa52966a564038cb7d8277913d2d::admin {
    struct CitizenCap has store, key {
        id: 0x2::object::UID,
    }

    public fun destroy_admin_cap(arg0: CitizenCap) {
        let CitizenCap { id: v0 } = arg0;
        0x2::object::delete(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = CitizenCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<CitizenCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun mint(arg0: &CitizenCap, arg1: &mut 0x2::tx_context::TxContext) : CitizenCap {
        CitizenCap{id: 0x2::object::new(arg1)}
    }

    // decompiled from Move bytecode v6
}

