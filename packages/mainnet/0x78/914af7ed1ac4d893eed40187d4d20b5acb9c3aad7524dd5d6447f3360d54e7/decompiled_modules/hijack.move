module 0x78914af7ed1ac4d893eed40187d4d20b5acb9c3aad7524dd5d6447f3360d54e7::hijack {
    struct HIJACK has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<HIJACK>, arg1: 0x2::coin::Coin<HIJACK>) {
        0x2::coin::burn<HIJACK>(arg0, arg1);
    }

    fun init(arg0: HIJACK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HIJACK>(arg0, 9, b"HIJACK", b"HIJACK", b"Custom SUI Token: HIJACK", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<HIJACK>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        let v3 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HIJACK>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HIJACK>>(v1);
    }

    public fun mint(arg0: &AdminCap, arg1: &mut 0x2::coin::TreasuryCap<HIJACK>, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<HIJACK>(arg1, arg2, arg3, arg4);
    }

    // decompiled from Move bytecode v7
}

