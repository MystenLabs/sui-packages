module 0x996bd8dfb5a463bed213b5e73f4dbdc51820ec97aaa48dd7f05db14817b8e456::soat {
    struct SOAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOAT>(arg0, 6, b"SOAT", b"Seal Goat", b"its not a goat  its  a  $soat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/29c0956c2727620f33a6b05996baed00_f4bea94555.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SOAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

