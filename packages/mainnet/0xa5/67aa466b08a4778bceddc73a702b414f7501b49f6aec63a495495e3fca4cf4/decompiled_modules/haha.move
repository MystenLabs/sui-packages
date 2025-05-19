module 0xa567aa466b08a4778bceddc73a702b414f7501b49f6aec63a495495e3fca4cf4::haha {
    struct HAHA has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAHA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAHA>(arg0, 6, b"HAHA", b"hahaha", b"funniest meme on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibc5uygy2t7k6tk34tfodzgeoh7yjb3v2hupkd73wxmhjuy7dfxgm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAHA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<HAHA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

