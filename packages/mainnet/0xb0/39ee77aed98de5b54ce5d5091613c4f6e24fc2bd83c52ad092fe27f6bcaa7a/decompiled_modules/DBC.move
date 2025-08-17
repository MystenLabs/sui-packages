module 0xb039ee77aed98de5b54ce5d5091613c4f6e24fc2bd83c52ad092fe27f6bcaa7a::DBC {
    struct DBC has drop {
        dummy_field: bool,
    }

    fun init(arg0: DBC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DBC>(arg0, 6, b"DickButtCoin", b"DBC", b"The ultimate meme coin for DickButt enthusiasts! A hilarious and irreverent cryptocurrency celebrating the iconic DickButt meme. Join the fun, spread the laughs, and ride the wave of meme culture with DickButtCoin!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://w3s.link/ipfs/bafkreig5r2srzggivcd4qhpw2uftxxlz37mzed5khk6xsmaipyi65ozijm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DBC>>(v0, @0x82ea3f8d2475bae1d2aba484c46125fdb81e0f192172e398c2ee99d9813cea00);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DBC>>(v1);
    }

    // decompiled from Move bytecode v6
}

