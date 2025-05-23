module 0x4a6f58535dcc4f02a5f2bd795fc1989d4552e388595b17ab5558ae392739cfc8::attractioncoin {
    struct ATTRACTIONCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: ATTRACTIONCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<ATTRACTIONCOIN>(arg0, 6, b"ATTRACTIONCOIN", b"AttractionCoin", b"A memecoin about the Law of Attraction. [AI Meme - By SuiAI]", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/meme/S7FsLE.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ATTRACTIONCOIN>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ATTRACTIONCOIN>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

