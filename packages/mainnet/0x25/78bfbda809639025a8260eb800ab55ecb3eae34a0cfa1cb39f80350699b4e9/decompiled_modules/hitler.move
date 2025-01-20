module 0x2578bfbda809639025a8260eb800ab55ecb3eae34a0cfa1cb39f80350699b4e9::hitler {
    struct HITLER has drop {
        dummy_field: bool,
    }

    fun init(arg0: HITLER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HITLER>(arg0, 9, b"HITLER", b"HITLER Meme", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://dd.dexscreener.com/ds-data/tokens/solana/6hpcfyxKgKUuyfTEyiYgWGGCY28K4KWS1pszPT9kSxHM.png?size=lg&key=e57ee5"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HITLER>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HITLER>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

