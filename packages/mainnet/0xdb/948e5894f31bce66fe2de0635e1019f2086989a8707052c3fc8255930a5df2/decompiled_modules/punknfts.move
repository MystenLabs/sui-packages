module 0xdb948e5894f31bce66fe2de0635e1019f2086989a8707052c3fc8255930a5df2::punknfts {
    struct PUNKNFTS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUNKNFTS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUNKNFTS>(arg0, 6, b"Punknfts", b"Punknftonsui", b"The new rebranding token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5256_b54f412934.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUNKNFTS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUNKNFTS>>(v1);
    }

    // decompiled from Move bytecode v6
}

