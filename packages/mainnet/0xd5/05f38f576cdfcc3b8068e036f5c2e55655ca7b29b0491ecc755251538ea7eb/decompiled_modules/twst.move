module 0xd505f38f576cdfcc3b8068e036f5c2e55655ca7b29b0491ecc755251538ea7eb::twst {
    struct TWST has drop {
        dummy_field: bool,
    }

    fun init(arg0: TWST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TWST>(arg0, 6, b"Twst", b"teat", b"test", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1737395035829.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TWST>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TWST>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

