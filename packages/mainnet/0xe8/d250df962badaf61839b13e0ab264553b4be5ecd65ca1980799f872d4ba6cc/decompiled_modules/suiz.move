module 0xe8d250df962badaf61839b13e0ab264553b4be5ecd65ca1980799f872d4ba6cc::suiz {
    struct SUIZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIZ>(arg0, 6, b"SUIZ", b"ZEUS", b"GOD OF SUI MEMES, ALTER-EGO OF MATT FURIE AND ONLY DOG OF LEGENDARY PEPE.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1740_ccb09617ad.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

