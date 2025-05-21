module 0xfadc2a695e4d92612a203f5bfc48e9f0a5be4d6bad9d08b1e8f06ce9be7a3f5a::roles {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    entry fun transfer_admin_cap(arg0: AdminCap, arg1: &mut 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::vaults::VaultStore, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::transfer<AdminCap>(arg0, arg2);
        0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::vaults::set_admin(arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

