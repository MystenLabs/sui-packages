module 0x219990f48b63b5bf4a58393be2372f243bd975a3d226997c9185c8e827b42dd6::melania {
    struct MELANIA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MELANIA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MELANIA>(arg0, 9, b"MELANIA", b"Melania Meme", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://dd.dexscreener.com/ds-data/tokens/sui/0xb3d7f55d5c5a0e6c0af2a6a3e16409191e8f80d087dec635bfcf351d5fa56c3b::melania::melania.png?size=lg&key=4d4e50"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MELANIA>(&mut v2, 100000000000000000, @0x4ff800c3dc2521daf8061423388c078903c717cf462b4812f799cfdeda703d33, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MELANIA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MELANIA>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

