module 0x5e6ba4462e6a70f69e0a680e155dab419dad2dad7067f4a4a34e18cd59ec58d8::miau {
    struct MIAU has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIAU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MIAU>(arg0, 6, b"MIAU", b"Miau", b"miau miau miau", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730959185875.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MIAU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIAU>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

