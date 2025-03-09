module 0xdb3a96be463ff9ce130f497c2de6ae63907ed2bb01cfe15c35e2862757d167e::moomoo {
    struct MOOMOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOOMOO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOOMOO>(arg0, 9, b"MooMoo", b"SuiMoo", b"SuiMoo is a fun emotional feedback.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/225d9bf1cc0f023fa1b41b24ca466d2ablob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOOMOO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOOMOO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

