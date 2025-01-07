module 0x9c5d722df47ba6952c9ffa29cf233ee7cdc5365e66ba60d0dac2e38047434400::testy {
    struct TESTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: TESTY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TESTY>(arg0, 6, b"Testy", b"Test", b"test", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/nb_1c947c06b2.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESTY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TESTY>>(v1);
    }

    // decompiled from Move bytecode v6
}

