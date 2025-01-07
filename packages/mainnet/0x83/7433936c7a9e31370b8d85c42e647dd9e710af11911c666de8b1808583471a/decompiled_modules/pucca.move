module 0x837433936c7a9e31370b8d85c42e647dd9e710af11911c666de8b1808583471a::pucca {
    struct PUCCA has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUCCA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUCCA>(arg0, 6, b"PUCCA", b"Pucca Bear", b"PUCCA  MEME", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241228_183456_1ed261f364.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUCCA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUCCA>>(v1);
    }

    // decompiled from Move bytecode v6
}

