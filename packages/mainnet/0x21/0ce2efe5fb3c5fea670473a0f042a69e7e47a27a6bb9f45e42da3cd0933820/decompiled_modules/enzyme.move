module 0x210ce2efe5fb3c5fea670473a0f042a69e7e47a27a6bb9f45e42da3cd0933820::enzyme {
    struct ENZYME has drop {
        dummy_field: bool,
    }

    fun init(arg0: ENZYME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ENZYME>(arg0, 6, b"ENZYME", b"Enzyme", b"Introducing Enzyme ($ENZYME), the meme coin that catalyzes the future of crypto with the energy of a biological breakthrough! Inspired by the power of enzymes in biology, this project accelerates the fusion of technology and community.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1734189666136.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ENZYME>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ENZYME>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

