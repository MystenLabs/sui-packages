module 0xb6cfc1387d90d4a67b1d1afafd928214716910f78e4b693f602a3826b3e9a9e2::desciai {
    struct DESCIAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DESCIAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DESCIAI>(arg0, 6, b"DeSciAI", b"DeSci AI Agent", b"DeSci Al Agent represents the future of decentralized scientific communication, where artificial intelligence becomes a key player in spreading knowledge about the latest advancements in biotech, genomics, and more.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1736001131477_84a366de47.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DESCIAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DESCIAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

