module 0x17d6ada2da504985edf89d1230688cfd3d7703dd13388e9d29563f0cfa06a5e9::bhmt {
    struct BHMT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BHMT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BHMT>(arg0, 6, b"BHMT", b"Blue Hamster", b"Meme coin on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_9332_b559fcc641.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BHMT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BHMT>>(v1);
    }

    // decompiled from Move bytecode v6
}

