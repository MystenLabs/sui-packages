module 0x4d927627f53ff3c7fb40f83658047c6dbd1b01c7c834c9d9fd2d5e57ea5148ae::admin {
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

