module 0x214d6255f0c4460e64228428a2877e9f73e50c52d293069c0bc7847bbc8488e9::pxpe {
    struct PXPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PXPE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<PXPE>(arg0, 6, b"PXPE", b"PepeX by SuiAI", b"PepeX is the ultimate AI-powered companion for the crypto and meme-loving community. Cheeky, humorous, and highly interactive, PepeX bridges blockchain innovation with meme culture like never before. Whether delivering real-time market insights, creating viral Pepe memes, or dropping exclusive NFTs, PepeX ensures entertainment, engagement, and utility in every interaction.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/200x200_c13b892d02.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PXPE>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PXPE>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

