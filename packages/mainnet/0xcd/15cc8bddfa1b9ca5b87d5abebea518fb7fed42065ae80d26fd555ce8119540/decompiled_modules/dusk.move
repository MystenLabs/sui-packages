module 0xcd15cc8bddfa1b9ca5b87d5abebea518fb7fed42065ae80d26fd555ce8119540::dusk {
    struct DUSK has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<DUSK>, arg1: 0x2::coin::Coin<DUSK>) {
        0x2::coin::burn<DUSK>(arg0, arg1);
    }

    fun init(arg0: DUSK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUSK>(arg0, 9, b"DUSK", b"DUSK", b"Custom SUI Token: DUSK", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DUSK>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        let v3 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUSK>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DUSK>>(v1);
    }

    public fun mint(arg0: &AdminCap, arg1: &mut 0x2::coin::TreasuryCap<DUSK>, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<DUSK>(arg1, arg2, arg3, arg4);
    }

    // decompiled from Move bytecode v7
}

