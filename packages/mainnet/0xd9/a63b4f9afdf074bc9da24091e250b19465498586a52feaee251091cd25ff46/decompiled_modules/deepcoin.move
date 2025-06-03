module 0xd9a63b4f9afdf074bc9da24091e250b19465498586a52feaee251091cd25ff46::deepcoin {
    struct DEEPCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEEPCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<DEEPCOIN>(arg0, 6, b"DEEPCOIN", b"Deepcoin", b"Deepcoin is a digital currency designed for the deep web community, enabling secure and private transactions seamlessly. Dive into the world of anonymity with Deepcoin! [AI Meme - By SuiAI]", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/meme/Cigm56.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DEEPCOIN>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEEPCOIN>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

