module 0x7346ea08ac64885334578c955e94c731e880ceaa38c5a9b3dd160f5dbe12031d::suipetty {
    struct SUIPETTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPETTY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPETTY>(arg0, 6, b"SUIPETTY", b"Suipetty Sui", b"Explore the fun and unique world of $SUIPETTY the meme coin that is making waves on the SUI blockchain!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000001279_9ad99475c7.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPETTY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPETTY>>(v1);
    }

    // decompiled from Move bytecode v6
}

