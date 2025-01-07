module 0x36ddd03d443c0ea1b9122c7dd340126918c4176adb3d686767763b36c6df208::axol {
    struct AXOL has drop {
        dummy_field: bool,
    }

    fun init(arg0: AXOL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AXOL>(arg0, 6, b"AXOL", b"AXOL on SUI Chain", b"Meet AXOL, the cutest amphibian on SUI!@", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730958620225.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AXOL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AXOL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

