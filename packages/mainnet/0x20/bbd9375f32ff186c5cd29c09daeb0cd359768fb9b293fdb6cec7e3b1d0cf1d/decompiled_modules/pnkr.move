module 0x20bbd9375f32ff186c5cd29c09daeb0cd359768fb9b293fdb6cec7e3b1d0cf1d::pnkr {
    struct PNKR has drop {
        dummy_field: bool,
    }

    fun init(arg0: PNKR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PNKR>(arg0, 6, b"PNKR", b"PunkRock", x"687474703a2f2f70756e6b726f636b6f6e7375692e6c6f6c0a68747470733a2f2f742e6d652f50554e4b524f434b5f535549", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_08_01_56_09_40be3a00d6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PNKR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PNKR>>(v1);
    }

    // decompiled from Move bytecode v6
}

