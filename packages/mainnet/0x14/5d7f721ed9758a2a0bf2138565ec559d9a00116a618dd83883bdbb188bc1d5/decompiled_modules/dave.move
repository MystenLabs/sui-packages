module 0x145d7f721ed9758a2a0bf2138565ec559d9a00116a618dd83883bdbb188bc1d5::dave {
    struct DAVE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DAVE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DAVE>(arg0, 6, b"DAVE", b"Dark Vibes ", b"I like dark vibes", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730977764852.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DAVE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DAVE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

