module 0xf7919ec86e617c71144611111e3a941cd941ccd73f6e89b4654b816b697620cf::sf {
    struct SF has drop {
        dummy_field: bool,
    }

    fun init(arg0: SF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SF>(arg0, 6, b"SF", b"STARFISH SUI", b"A starfish wandering in the sea, afraid of being eaten by big fish. #SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/STARFISH_38b36da639.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SF>>(v1);
    }

    // decompiled from Move bytecode v6
}

