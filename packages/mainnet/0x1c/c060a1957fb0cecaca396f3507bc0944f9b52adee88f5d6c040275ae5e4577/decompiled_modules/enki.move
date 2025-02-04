module 0x1cc060a1957fb0cecaca396f3507bc0944f9b52adee88f5d6c040275ae5e4577::enki {
    struct ENKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ENKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ENKI>(arg0, 6, b"Enki", b"EnkionSui", x"4772656574696e677320496d20456e6b692e205365617420757020616e64206a6f696e20696e766173696f6e20e29c8cefb88ff09f91bdf09f9bb8", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1738695450818.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ENKI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ENKI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

