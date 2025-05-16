module 0xa85bd70efbda417839565124c0d259b4cda6bc8aaaf63ac1af17918aaf77cbe3::minz {
    struct MINZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: MINZ, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<MINZ>(arg0, 6, b"MINZ", b"Minzetta", b"Minzetta is a fun and exciting meme coin that aims to bring laughter and joy to its community through engaging memes and light-hearted content. [AI Meme - By SuiAI]", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/meme/r2H3Bp.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MINZ>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MINZ>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

