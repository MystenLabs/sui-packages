module 0x10f0c1eabba6b9f88dec94a904ee404715637b760846567d1023c6568dcfd499::deepcoin {
    struct DEEPCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEEPCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<DEEPCOIN>(arg0, 6, b"DEEPCOIN", b"Deepcoin", b"Deepcoin is the cryptocurrency that delves into the deepest corners of the digital universe, connecting users with secure and fast transactions. [AI Meme - By SuiAI]", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/meme/DtGr1c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DEEPCOIN>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEEPCOIN>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

