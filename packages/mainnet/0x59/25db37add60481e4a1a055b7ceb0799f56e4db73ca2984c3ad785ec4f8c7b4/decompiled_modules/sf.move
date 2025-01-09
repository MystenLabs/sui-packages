module 0x5925db37add60481e4a1a055b7ceb0799f56e4db73ca2984c3ad785ec4f8c7b4::sf {
    struct SF has drop {
        dummy_field: bool,
    }

    fun init(arg0: SF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SF>(arg0, 6, b"SF", b"SuiFlix Agent", b"Suiflix Token is a next-generation digital asset designed to power a seamless and innovative ecosystem, integrating entertainment, artificial intelligence, and user engagement.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736435322983.37")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SF>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SF>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

