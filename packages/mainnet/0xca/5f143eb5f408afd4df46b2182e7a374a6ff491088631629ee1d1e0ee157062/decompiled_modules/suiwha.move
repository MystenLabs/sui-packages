module 0xca5f143eb5f408afd4df46b2182e7a374a6ff491088631629ee1d1e0ee157062::suiwha {
    struct SUIWHA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIWHA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIWHA>(arg0, 9, b"SUIWHA", b"SUI Whale", b"I'am THE SUI WHALE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0017f35f-d610-404c-995f-71d4dcde6ffa.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIWHA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIWHA>>(v1);
    }

    // decompiled from Move bytecode v6
}

