module 0x37ad3777cb77fa8fb7a4a3fe321acef06feacf4e12d2f94f290baec944e948b8::boboobob {
    struct BOBOOBOB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOBOOBOB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOBOOBOB>(arg0, 9, b"BOBOOBOB", b"BOOO", b"bobo.... ^^", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/a8b66ae742b218a1f8ec4c054ce57c06blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BOBOOBOB>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOBOOBOB>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

