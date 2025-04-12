module 0x5591505a373f2cf8320653162c2d04d118db65ef7560f81a8dc028bb5ad11340::app {
    struct VaultAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct APP has drop {
        dummy_field: bool,
    }

    fun init(arg0: APP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = init_interal(arg0, arg1);
        0x2::transfer::transfer<VaultAdminCap>(v0, 0x2::tx_context::sender(arg1));
    }

    fun init_interal(arg0: APP, arg1: &mut 0x2::tx_context::TxContext) : VaultAdminCap {
        let v0 = VaultAdminCap{id: 0x2::object::new(arg1)};
        0x2::package::claim_and_keep<APP>(arg0, arg1);
        v0
    }

    // decompiled from Move bytecode v6
}

