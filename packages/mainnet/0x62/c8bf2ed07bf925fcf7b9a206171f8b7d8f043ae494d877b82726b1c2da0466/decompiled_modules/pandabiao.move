module 0x62c8bf2ed07bf925fcf7b9a206171f8b7d8f043ae494d877b82726b1c2da0466::pandabiao {
    struct PANDABIAO has drop {
        dummy_field: bool,
    }

    fun init(arg0: PANDABIAO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PANDABIAO>(arg0, 6, b"Pandabiao", b"Pandabiaocalls", b"OG Pandabiao", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0106_a6a14448ba.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PANDABIAO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PANDABIAO>>(v1);
    }

    // decompiled from Move bytecode v6
}

