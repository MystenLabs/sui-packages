module 0x6289af11afe9a15b1a332dd919879f2407f9c86e3b7463b24c4784fcd6b4931a::scaxmas {
    struct SCAXMAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCAXMAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCAXMAS>(arg0, 6, b"SCAXMAS", b"ScaXmas", b"Lets celebrate Xmas with SCAXMAS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1734714309368.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SCAXMAS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCAXMAS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

