module 0x715c9b7c7f632814636c4a9a755bd974a6c3cf3606cf3d4b8b5acd9de8903d16::vault {
    struct Vault<T0: store + key> has store, key {
        id: 0x2::object::UID,
        cap: 0x2::coin::TreasuryCap<T0>,
    }

    public entry fun deposit_cap<T0: store + key>(arg0: 0x2::coin::TreasuryCap<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Vault<T0>{
            id  : 0x2::object::new(arg1),
            cap : arg0,
        };
        0x2::transfer::public_transfer<Vault<T0>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

