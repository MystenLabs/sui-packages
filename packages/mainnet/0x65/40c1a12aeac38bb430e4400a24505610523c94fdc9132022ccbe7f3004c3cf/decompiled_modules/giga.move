module 0x6540c1a12aeac38bb430e4400a24505610523c94fdc9132022ccbe7f3004c3cf::giga {
    struct GIGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: GIGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GIGA>(arg0, 6, b"GIGA", b"giga snowman", b"Giga snowman, is the most giga meme in all of sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731031989992.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GIGA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GIGA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

