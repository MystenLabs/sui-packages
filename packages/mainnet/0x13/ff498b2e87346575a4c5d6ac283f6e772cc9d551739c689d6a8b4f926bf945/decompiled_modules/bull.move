module 0x13ff498b2e87346575a4c5d6ac283f6e772cc9d551739c689d6a8b4f926bf945::bull {
    struct BULL has drop {
        dummy_field: bool,
    }

    fun init(arg0: BULL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BULL>(arg0, 6, b"BULL", b"SBULL", b"He is Master Bulltron. He behaved like a true gentleman. MasterBullTRON is generous with his time, wisdom, and resources. Be part of gentlemen's SUI-Club.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/121121_04f16c11e6_7cc21def4c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BULL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BULL>>(v1);
    }

    // decompiled from Move bytecode v6
}

