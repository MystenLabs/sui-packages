module 0xf9cbb7d20add01a6cbe1c5c892c0630992e11abf7b4b69b7cef0a217f996dead::jina {
    struct JINA has drop {
        dummy_field: bool,
    }

    fun init(arg0: JINA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JINA>(arg0, 9, b"jina", b"jina", b"313131331313 13r1313 3", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<JINA>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JINA>>(v2, @0x2c478b5f158e037cb21b3443a5a3512f6fee0b9a16d7a261baa00ddca69d6fc5);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JINA>>(v1);
    }

    // decompiled from Move bytecode v6
}

