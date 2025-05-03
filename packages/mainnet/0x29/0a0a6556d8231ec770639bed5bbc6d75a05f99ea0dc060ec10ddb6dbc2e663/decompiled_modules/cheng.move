module 0x290a0a6556d8231ec770639bed5bbc6d75a05f99ea0dc060ec10ddb6dbc2e663::cheng {
    struct CHENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHENG>(arg0, 6, b"CHENG", b"Cheng", b"Founder of Sui, Evan Cheng. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1746306512699.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHENG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHENG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

