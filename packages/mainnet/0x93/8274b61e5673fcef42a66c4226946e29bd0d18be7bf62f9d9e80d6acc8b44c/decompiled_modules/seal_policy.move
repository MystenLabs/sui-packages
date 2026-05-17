module 0x938274b61e5673fcef42a66c4226946e29bd0d18be7bf62f9d9e80d6acc8b44c::seal_policy {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun mint_admin_cap(arg0: &AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg2)};
        0x2::transfer::public_transfer<AdminCap>(v0, arg1);
    }

    public entry fun seal_approve(arg0: vector<u8>, arg1: &AdminCap) {
    }

    // decompiled from Move bytecode v7
}

