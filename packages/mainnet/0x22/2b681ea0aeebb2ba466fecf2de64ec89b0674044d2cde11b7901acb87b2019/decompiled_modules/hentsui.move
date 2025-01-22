module 0x222b681ea0aeebb2ba466fecf2de64ec89b0674044d2cde11b7901acb87b2019::hentsui {
    struct HENTSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HENTSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HENTSUI>(arg0, 6, b"HENTSUI", b"HENTAICOIN ON SUI", b"HENTAI COIN ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250122_160559_546_f9a7e07369.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HENTSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HENTSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

