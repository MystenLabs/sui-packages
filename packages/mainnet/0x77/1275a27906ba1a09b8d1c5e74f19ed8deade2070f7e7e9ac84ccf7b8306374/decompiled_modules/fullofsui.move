module 0x771275a27906ba1a09b8d1c5e74f19ed8deade2070f7e7e9ac84ccf7b8306374::fullofsui {
    struct FULLOFSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: FULLOFSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FULLOFSUI>(arg0, 6, b"FULLOFSUI", x"66756c6c206f662073756920f09f92a7", x"69206d2066756c6c206f66207375692e207520722066756c6c206f66207375692e0a77652061726520616c6c2066756c6c206f66207375692e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730469613587.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FULLOFSUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FULLOFSUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

