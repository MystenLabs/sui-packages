module 0xac215d9b1b9ffe569da49157a7acbcbed5889d409721c5fdd72c66f55ba41f0a::testes {
    struct TESTES has drop {
        dummy_field: bool,
    }

    fun init(arg0: TESTES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TESTES>(arg0, 6, b"TESTES", b"TEST", b"GEGE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_08_07_22_59_46_b7dabf7563.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESTES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TESTES>>(v1);
    }

    // decompiled from Move bytecode v6
}

