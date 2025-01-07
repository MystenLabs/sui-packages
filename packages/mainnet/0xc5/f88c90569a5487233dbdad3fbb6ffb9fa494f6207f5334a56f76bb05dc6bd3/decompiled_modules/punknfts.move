module 0xc5f88c90569a5487233dbdad3fbb6ffb9fa494f6207f5334a56f76bb05dc6bd3::punknfts {
    struct PUNKNFTS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUNKNFTS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUNKNFTS>(arg0, 6, b"Punknfts", b"Punknftonsui", b"New rebranding", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5256_b33fce39e1.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUNKNFTS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUNKNFTS>>(v1);
    }

    // decompiled from Move bytecode v6
}

