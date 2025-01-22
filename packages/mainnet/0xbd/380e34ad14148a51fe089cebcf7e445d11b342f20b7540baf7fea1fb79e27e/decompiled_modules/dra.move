module 0xbd380e34ad14148a51fe089cebcf7e445d11b342f20b7540baf7fea1fb79e27e::dra {
    struct DRA has drop {
        dummy_field: bool,
    }

    fun init(arg0: DRA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<DRA>(arg0, 6, b"DRA", b"DRAGON by SuiAI", b"Meme coin for fun. only goal is to become more valuable than $EAG. Make value through the power of community.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/1000018646_40e4edd27a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DRA>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DRA>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

