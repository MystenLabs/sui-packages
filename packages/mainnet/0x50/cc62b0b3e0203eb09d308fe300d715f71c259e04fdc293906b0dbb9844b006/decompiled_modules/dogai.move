module 0x50cc62b0b3e0203eb09d308fe300d715f71c259e04fdc293906b0dbb9844b006::dogai {
    struct DOGAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGAI>(arg0, 6, b"DOGAI", b"DOGE", b"AI + DOG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1753414584127.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOGAI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGAI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

