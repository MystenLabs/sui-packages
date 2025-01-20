module 0x5ab01f0aa14efb07ae0c5550e745289dd15e85fefd87e7152352ae03c8f866be::eric {
    struct ERIC has drop {
        dummy_field: bool,
    }

    fun init(arg0: ERIC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ERIC>(arg0, 9, b"ERIC", b"ERIC Meme", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://dd.dexscreener.com/ds-data/tokens/solana/YHJGAU32z4r83KGvjrsq1cGrTkQGgsj16GU2zY6pump.png?size=lg&key=ab7da3"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ERIC>(&mut v2, 100000000000000000, @0x4ff800c3dc2521daf8061423388c078903c717cf462b4812f799cfdeda703d33, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ERIC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ERIC>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

