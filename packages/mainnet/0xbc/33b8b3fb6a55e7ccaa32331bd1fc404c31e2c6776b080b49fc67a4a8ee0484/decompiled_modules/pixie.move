module 0xbc33b8b3fb6a55e7ccaa32331bd1fc404c31e2c6776b080b49fc67a4a8ee0484::pixie {
    struct PIXIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIXIE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<PIXIE>(arg0, 6, b"PIXIE", b"Pixie AI by SuiAI", b"Pixie AI: Effortlessly transform ideas into unique, high-quality visuals. Create, customize, and download stunning artwork in just a few clicks!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/o0_O_Sue_Ir_400x400_4cbc4529b9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PIXIE>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIXIE>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

