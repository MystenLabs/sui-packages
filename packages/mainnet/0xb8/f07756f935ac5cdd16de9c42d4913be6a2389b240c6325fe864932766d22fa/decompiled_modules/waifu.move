module 0xb8f07756f935ac5cdd16de9c42d4913be6a2389b240c6325fe864932766d22fa::waifu {
    struct WAIFU has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAIFU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAIFU>(arg0, 6, b"WAIFU", b"WAIFU ", b"$WAIFU- fulfill your digital desires! Remember love from $WAIFU is REAL! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730952849630.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WAIFU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAIFU>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

