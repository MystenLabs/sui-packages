module 0xdf6e5c3fbc9792b223e9dccec2cf915c1eac3734222b34cb8eedb4134840564::pzdog {
    struct PZDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: PZDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PZDOG>(arg0, 6, b"PZDOG", b"PanzerDogs", x"50565020706c61792026206561726e2074616e6b20627261776c6572206f6e20535549206279200a6c75636b796b617473747564696f730a20f09f90950a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731007341796.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PZDOG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PZDOG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

