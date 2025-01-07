module 0xdd9527576fc03852f7d6b1fa8a1a8cde9a33db1170456a95a2a54abac81c20b7::suishi {
    struct SUISHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISHI>(arg0, 6, b"SUISHI", b"Suishi", b"The food of choice in the land of SUI, Suishi loves it when you take a bite.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731957507542.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUISHI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISHI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

