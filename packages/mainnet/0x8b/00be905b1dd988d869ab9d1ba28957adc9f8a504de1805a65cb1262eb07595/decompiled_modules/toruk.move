module 0x8b00be905b1dd988d869ab9d1ba28957adc9f8a504de1805a65cb1262eb07595::toruk {
    struct TORUK has drop {
        dummy_field: bool,
    }

    fun init(arg0: TORUK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TORUK>(arg0, 6, b"Toruk", b"Toruk Makto", b"A tribute to Toruk Makto that saved the people in Avatar", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/toruk_makto_7a5cbf7934.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TORUK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TORUK>>(v1);
    }

    // decompiled from Move bytecode v6
}

