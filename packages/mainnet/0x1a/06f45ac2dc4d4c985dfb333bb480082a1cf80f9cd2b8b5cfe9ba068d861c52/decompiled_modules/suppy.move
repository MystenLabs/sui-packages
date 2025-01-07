module 0x1a06f45ac2dc4d4c985dfb333bb480082a1cf80f9cd2b8b5cfe9ba068d861c52::suppy {
    struct SUPPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUPPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUPPY>(arg0, 6, b"SUPPY", b"Suppy", b"The OG pepe of Sui chain, letting you earn $SUI while you stake $SUPPY tokens. Backed by MH Global Ventures.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_03_13_26_49_405032ce34.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUPPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUPPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

