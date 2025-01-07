module 0x7f0c7c3ad0901611d9b17fe420d7d7b854060570c81828816bba33883a3a16f1::fume {
    struct FUME has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUME>(arg0, 6, b"FUME", b"Just Fuck Me", b"$FUME is a Sui meme token for all those days we became Dodgy Wankers and made those silly, but yet avoidable mistakes. On such days, it is only right that you say to yourself.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pfp_9796be010a.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FUME>>(v1);
    }

    // decompiled from Move bytecode v6
}

