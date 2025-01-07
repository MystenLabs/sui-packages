module 0xb82fa1fd206698cd2abe4a92af274e0404a162522bad1144b0d7a19ad79e60f4::dart {
    struct DART has drop {
        dummy_field: bool,
    }

    fun init(arg0: DART, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DART>(arg0, 6, b"DART", x"4441525420f09f8eaf", x"f09f8eaf20f09f8eaf20f09f8eaf", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731653243535.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DART>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DART>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

