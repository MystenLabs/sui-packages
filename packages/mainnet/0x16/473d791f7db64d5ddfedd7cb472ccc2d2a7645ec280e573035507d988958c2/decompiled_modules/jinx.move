module 0x16473d791f7db64d5ddfedd7cb472ccc2d2a7645ec280e573035507d988958c2::jinx {
    struct JINX has drop {
        dummy_field: bool,
    }

    fun init(arg0: JINX, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<JINX>(arg0, 6, b"JINX", b"JINX by SuiAI", b"JINX", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/images_16_a201b894cf.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<JINX>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JINX>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

