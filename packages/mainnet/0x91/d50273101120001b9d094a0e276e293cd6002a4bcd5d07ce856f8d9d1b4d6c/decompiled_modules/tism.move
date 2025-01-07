module 0x91d50273101120001b9d094a0e276e293cd6002a4bcd5d07ce856f8d9d1b4d6c::tism {
    struct TISM has drop {
        dummy_field: bool,
    }

    fun init(arg0: TISM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TISM>(arg0, 6, b"TISM", b"TISM MEME", b"just tism", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730952369807.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TISM>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TISM>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

