module 0x342b0b1ca306990940952b31bb5b56060e0def17bc55bb0b6ac9684a888b3e0a::hiphop {
    struct HIPHOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: HIPHOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HIPHOP>(arg0, 6, b"HIPHOP", b"Hip-Hop", b"Get ready to bounce into the vibrant world of $HIPHOP, the ultimate \"pure meme vitamin\" token that infuses fun and creativity into the crypto space! This token is designed for those who love to embrace the lighter side of cryptocurrency, where humor and innovation collide.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/hiphop_14b2605177.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HIPHOP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HIPHOP>>(v1);
    }

    // decompiled from Move bytecode v6
}

