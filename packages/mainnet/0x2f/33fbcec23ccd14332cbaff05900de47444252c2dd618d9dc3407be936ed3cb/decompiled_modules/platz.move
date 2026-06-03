module 0x2f33fbcec23ccd14332cbaff05900de47444252c2dd618d9dc3407be936ed3cb::platz {
    struct PLATZ has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<PLATZ>, arg1: 0x2::coin::Coin<PLATZ>) {
        0x2::coin::burn<PLATZ>(arg0, arg1);
    }

    fun init(arg0: PLATZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PLATZ>(arg0, 9, b"PLATZ", b"PLATZ", b"Custom SUI Token: PLATZ", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PLATZ>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        let v3 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PLATZ>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PLATZ>>(v1);
    }

    public fun mint(arg0: &AdminCap, arg1: &mut 0x2::coin::TreasuryCap<PLATZ>, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<PLATZ>(arg1, arg2, arg3, arg4);
    }

    // decompiled from Move bytecode v7
}

