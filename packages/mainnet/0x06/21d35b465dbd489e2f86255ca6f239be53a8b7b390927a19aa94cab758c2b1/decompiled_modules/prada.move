module 0x621d35b465dbd489e2f86255ca6f239be53a8b7b390927a19aa94cab758c2b1::prada {
    struct PRADA has drop {
        dummy_field: bool,
    }

    fun init(arg0: PRADA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PRADA>(arg0, 9, b"PRADA", b"PRADA", b"Prada Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PRADA>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PRADA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PRADA>>(v1);
    }

    // decompiled from Move bytecode v6
}

