module 0x226568ed25fad09f73ff964136b2b7bc0a1255272de9a8f5eaecc38732a83f4b::rofoly {
    struct ROFOLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROFOLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROFOLY>(arg0, 9, b"ROFOLY", b"Bloody Helmet Rofoly", b"Mascot Sui ecosystem", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdna.https://cdna.artstation.com/p/assets/images/images/078/675/366/large/till-freitag-2024-redhelmet-tillfreitag-final-v2-002.jpg?1722785388.com/p/assets/images/images/080/510/032/large/julie-bijjou-2024-monkey-coco-aymeric-bages-concept-eranalboher-003-bamboo-insta-ld-2.jpg?1727776268")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ROFOLY>(&mut v2, 5000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROFOLY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ROFOLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

