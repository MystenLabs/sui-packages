module 0xe1877e54a33548cce269cc41b2b5f20ce9923d3c7b26ff1fa39a2aadb76702b1::memes {
    struct MEMES has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEMES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEMES>(arg0, 6, b"Memes", b"Memeland on sui", x"4d656d656c616e64204d616b696e67207761766573206f6e207375690a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241008_001111_4eed751ce6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEMES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MEMES>>(v1);
    }

    // decompiled from Move bytecode v6
}

