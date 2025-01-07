module 0x264b1ad58f66eb8a940d141c6f02cb9ad5baeac20819aa7af583a6ac67b72199::jaw {
    struct JAW has drop {
        dummy_field: bool,
    }

    fun init(arg0: JAW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JAW>(arg0, 6, b"JAW", b"JABBERJAW", b"The ultimate meme coin making waves in the crypto ocean! Inspired by the iconic, lovable, and hilarious talking shark from the classic cartoon, Jabberjaw, this coin is here to bring fun, laughter, and financial fin-tasticness to the blockchain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_12_30_03_42_53_4e83a50dc2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JAW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JAW>>(v1);
    }

    // decompiled from Move bytecode v6
}

