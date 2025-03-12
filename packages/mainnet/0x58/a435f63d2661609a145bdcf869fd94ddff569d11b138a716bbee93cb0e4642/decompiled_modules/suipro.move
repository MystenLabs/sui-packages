module 0x58a435f63d2661609a145bdcf869fd94ddff569d11b138a716bbee93cb0e4642::suipro {
    struct SUIPRO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPRO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPRO>(arg0, 8, b"SUIPRO", b"SUIPRO", b"This is SUIPRO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://avatars.githubusercontent.com/u/56954475?v=4")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIPRO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPRO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

