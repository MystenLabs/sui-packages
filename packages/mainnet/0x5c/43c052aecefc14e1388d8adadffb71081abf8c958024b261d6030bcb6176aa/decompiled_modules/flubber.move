module 0x5c43c052aecefc14e1388d8adadffb71081abf8c958024b261d6030bcb6176aa::flubber {
    struct FLUBBER has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLUBBER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLUBBER>(arg0, 6, b"FLUBBER", b"SuiFLub", b"Flubber traveled from 1997 to 2024 to bwing the best meme coin ever ! Take me to king of the hill! And I'll take you to the big gween candles !!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000004397_c940147462.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLUBBER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FLUBBER>>(v1);
    }

    // decompiled from Move bytecode v6
}

