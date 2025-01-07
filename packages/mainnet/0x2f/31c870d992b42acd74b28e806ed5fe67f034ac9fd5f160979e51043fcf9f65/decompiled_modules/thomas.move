module 0x2f31c870d992b42acd74b28e806ed5fe67f034ac9fd5f160979e51043fcf9f65::thomas {
    struct THOMAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: THOMAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<THOMAS>(arg0, 6, b"THOMAS", b"Thomas the goose", b"Thomas, known as the \"blind bisexual goose,\" became a celebrity in New Zealand thanks to his touching and unusual story.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_03_13_04_54_2_82278b4673.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<THOMAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<THOMAS>>(v1);
    }

    // decompiled from Move bytecode v6
}

