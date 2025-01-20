module 0xb61d3cc2340e530a8115ae39fe16dae52f1ee029fe52435acbbb1a184c3954ee::melania {
    struct MELANIA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MELANIA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MELANIA>(arg0, 9, b"MELANIA", b"Melania Meme", b"The Official Melania Meme on Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/sui/0xb3d7f55d5c5a0e6c0af2a6a3e16409191e8f80d087dec635bfcf351d5fa56c3b::melania::melania.png?size=lg&key=4d4e50")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MELANIA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<MELANIA>>(0x2::coin::mint<MELANIA>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<MELANIA>>(v2);
    }

    // decompiled from Move bytecode v6
}

