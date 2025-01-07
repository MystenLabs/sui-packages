module 0x228c89b1aeaf649c064c00d2ed3b6656dfb6111a7bc25a34d657b5da9554c1a2::chummy {
    struct CHUMMY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHUMMY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHUMMY>(arg0, 6, b"Chummy", b"Chummy Sui", b"meme on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731865062944.jfif")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHUMMY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHUMMY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

