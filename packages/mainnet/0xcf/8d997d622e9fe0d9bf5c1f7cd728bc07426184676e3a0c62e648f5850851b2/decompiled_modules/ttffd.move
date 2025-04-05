module 0xcf8d997d622e9fe0d9bf5c1f7cd728bc07426184676e3a0c62e648f5850851b2::ttffd {
    struct TTFFD has drop {
        dummy_field: bool,
    }

    fun init(arg0: TTFFD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TTFFD>(arg0, 9, b"TTffd", b"adrhg", b"catu", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/631dc4d9656cd97dff67de5285b93553blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TTFFD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TTFFD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

