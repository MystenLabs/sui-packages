module 0x9565e80931c7c9ef49f84c56f8893195db42908cca0b5e648ce9e49762b5de8d::suivatar {
    struct SUIVATAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIVATAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIVATAR>(arg0, 6, b"SUIVATAR", b"SUIVATAR CAT", x"535549564154415220697320612066696374696f6e616c206361742063686172616374657220696e73706972656420627920746865206c6f6f6b206f66207468652063726561747572657320696e204176617461720a726561647920746f206c61756e6368206f6e2053554920434841494e2e20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_15_01_29_06_022f773570.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIVATAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIVATAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

