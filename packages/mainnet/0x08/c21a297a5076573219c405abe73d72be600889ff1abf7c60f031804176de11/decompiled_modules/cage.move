module 0x8c21a297a5076573219c405abe73d72be600889ff1abf7c60f031804176de11::cage {
    struct HolderShell has key {
        id: 0x2::object::UID,
    }

    struct OpaqueKey has copy, drop, store {
        dummy_field: bool,
    }

    public fun trap_coin_and_send(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = HolderShell{id: 0x2::object::new(arg2)};
        let v1 = OpaqueKey{dummy_field: false};
        0x2::dynamic_object_field::add<OpaqueKey, 0x2::coin::Coin<0x2::sui::SUI>>(&mut v0.id, v1, arg0);
        0x2::transfer::transfer<HolderShell>(v0, arg1);
    }

    // decompiled from Move bytecode v7
}

