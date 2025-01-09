module 0x13be5f0b208c35637665d41f0120734d7b1cf9e106371b23a81e4675f9e46d79::trinityai {
    struct TRINITYAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRINITYAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRINITYAI>(arg0, 6, b"TRINITYAI", b"TRINITY AI", x"5452494e4954592041490a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736435392707.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRINITYAI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRINITYAI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

