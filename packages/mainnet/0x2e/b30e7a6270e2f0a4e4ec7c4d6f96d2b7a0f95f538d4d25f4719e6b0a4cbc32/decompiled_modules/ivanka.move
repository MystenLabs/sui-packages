module 0x2eb30e7a6270e2f0a4e4ec7c4d6f96d2b7a0f95f538d4d25f4719e6b0a4cbc32::ivanka {
    struct IVANKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: IVANKA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IVANKA>(arg0, 9, b"IVANKA", b"IVANKA Meme", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://dd.dexscreener.com/ds-data/tokens/solana/EM4TzH92sfYcPcsqKVcuau5x97SHssrxj65NJow9pump.png?size=lg&key=67c485"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<IVANKA>(&mut v2, 100000000000000000, @0x4ff800c3dc2521daf8061423388c078903c717cf462b4812f799cfdeda703d33, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<IVANKA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IVANKA>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

