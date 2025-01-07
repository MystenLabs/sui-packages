module 0xd9a75e027c86eb7358073acd390ea8ab95e7c5ecf67a377075c2008aac364226::arafuru {
    struct ARAFURU has drop {
        dummy_field: bool,
    }

    fun init(arg0: ARAFURU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ARAFURU>(arg0, 6, b"Arafuru", b"ArafuruSui", b"The best meme token on sui chain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730988705796.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ARAFURU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ARAFURU>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

