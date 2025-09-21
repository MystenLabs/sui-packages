module 0x8ddf6eb18a9ce9b7f56678f43a12f1a73905b16f5f8f72e0da6b486c2e087fa1::jury {
    struct JURY has drop {
        dummy_field: bool,
    }

    fun init(arg0: JURY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JURY>(arg0, 6, b"JURY", b"Cognitio Juris", b"Cognitio is a decentralized platform designed to combat misinformation and verify the authenticity of digital content, starting with internet memes.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeibjnyal5tjx4zifql4v3oa3booh37uvcfg5xix3rtt7yfrrmot5je")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JURY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<JURY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

