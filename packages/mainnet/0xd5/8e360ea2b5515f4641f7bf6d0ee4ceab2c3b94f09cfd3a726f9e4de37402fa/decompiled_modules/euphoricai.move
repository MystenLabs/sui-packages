module 0xd58e360ea2b5515f4641f7bf6d0ee4ceab2c3b94f09cfd3a726f9e4de37402fa::euphoricai {
    struct EUPHORICAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: EUPHORICAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EUPHORICAI>(arg0, 6, b"EUPHORICAI", b"Euphoric AI", b"EuphoricAI is a visionary fusion of artificial intelligence, electronic music, and blockchain technology.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250116_165201_603_4453fdf8ef.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EUPHORICAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EUPHORICAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

