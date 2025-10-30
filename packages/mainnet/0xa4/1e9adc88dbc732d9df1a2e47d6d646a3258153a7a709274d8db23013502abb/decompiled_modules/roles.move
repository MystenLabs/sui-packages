module 0x9added62ef3a869653ef13e754d51fb62adc9f93e2717d2e23ba1214c4ef8d15::roles {
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

