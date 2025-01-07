module 0x3b6648d4439f2c38d2c86d3d8eb91d6e534eca0ab19d7a4a100a5db1eb9cf283::sensei {
    struct SENSEI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SENSEI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SENSEI>(arg0, 6, b"Sensei", b"Sui Sensei", b"Happy to have you", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730957228732.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SENSEI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SENSEI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

