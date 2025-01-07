module 0x45d3b20891d427582f5c505406d9b54a7dd601bfadebf8a0b7fa6ee3d6fa5bf7::sucezmoi {
    struct SUCEZMOI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUCEZMOI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUCEZMOI>(arg0, 6, b"Sucezmoi", b"Transezmoi", b"eh oui allez merci", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/3f68920dacb65f9a5bed37fe96aeec85_3_d8cdc46481.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUCEZMOI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUCEZMOI>>(v1);
    }

    // decompiled from Move bytecode v6
}

