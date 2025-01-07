module 0x67fb8a9ad9bfc438c1c2935975279cdedac355475c366b10a7e724f37dc56575::dto {
    struct DTO has drop {
        dummy_field: bool,
    }

    fun init(arg0: DTO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DTO>(arg0, 6, b"DTO", b"DEVILS TAKEOVER", b"The devils never lose, became the rallying cry, and as the worlds elite fell, one truth remained: the devils didnt just take over they always ruled.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_7452_07d114e10b.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DTO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DTO>>(v1);
    }

    // decompiled from Move bytecode v6
}

