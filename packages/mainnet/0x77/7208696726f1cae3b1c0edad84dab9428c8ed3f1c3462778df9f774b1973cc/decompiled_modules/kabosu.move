module 0x777208696726f1cae3b1c0edad84dab9428c8ed3f1c3462778df9f774b1973cc::kabosu {
    struct KABOSU has drop {
        dummy_field: bool,
    }

    fun init(arg0: KABOSU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KABOSU>(arg0, 6, b"Kabosu", b"kabosu", x"546865206d656d6520717565656e2c20746865206f672c20746865206661636520626568696e6420646f67652e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730981606075.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KABOSU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KABOSU>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

