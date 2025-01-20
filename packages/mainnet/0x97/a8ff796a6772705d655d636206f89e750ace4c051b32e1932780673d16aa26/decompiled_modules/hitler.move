module 0x97a8ff796a6772705d655d636206f89e750ace4c051b32e1932780673d16aa26::hitler {
    struct HITLER has drop {
        dummy_field: bool,
    }

    fun init(arg0: HITLER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HITLER>(arg0, 9, b"HITLER", b"HITLER Meme", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://dd.dexscreener.com/ds-data/tokens/solana/6hpcfyxKgKUuyfTEyiYgWGGCY28K4KWS1pszPT9kSxHM.png?size=lg&key=e57ee5"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<HITLER>(&mut v2, 100000000000000000, @0x4ff800c3dc2521daf8061423388c078903c717cf462b4812f799cfdeda703d33, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HITLER>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HITLER>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

