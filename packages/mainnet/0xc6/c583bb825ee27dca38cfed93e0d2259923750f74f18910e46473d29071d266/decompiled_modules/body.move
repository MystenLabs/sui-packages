module 0xc6c583bb825ee27dca38cfed93e0d2259923750f74f18910e46473d29071d266::body {
    struct BODY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BODY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BODY>(arg0, 9, b"BODY", b"BODY SUI", b"First In The World, I Launch Body Token For Body Development ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/73160a3323169c00297cb6ab2e4c7a37blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BODY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BODY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

