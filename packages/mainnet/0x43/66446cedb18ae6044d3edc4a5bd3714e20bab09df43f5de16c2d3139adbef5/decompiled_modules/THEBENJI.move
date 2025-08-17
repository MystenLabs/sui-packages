module 0x4366446cedb18ae6044d3edc4a5bd3714e20bab09df43f5de16c2d3139adbef5::THEBENJI {
    struct THEBENJI has drop {
        dummy_field: bool,
    }

    fun init(arg0: THEBENJI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<THEBENJI>(arg0, 6, b"THE REAL BENJI", b"THEBENJI", b"A meme coin inspired by Benjamin Franklin, the ultimate money maker. Cool Benji combines historical swagger with modern crypto vibes. Stack BENJI to channel Franklin's financial genius and flex your wealth in the meme economy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://w3s.link/ipfs/bafkreicvf4va254dj5gmxbn7xptk2wzw2rwhawaps4vudavfbsgbvgtnsq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<THEBENJI>>(v0, @0x691c5d4f7bd7c39b39907d3ca01b8c2643c87de134766ca4f78be51e0a9fde1b);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<THEBENJI>>(v1);
    }

    // decompiled from Move bytecode v6
}

