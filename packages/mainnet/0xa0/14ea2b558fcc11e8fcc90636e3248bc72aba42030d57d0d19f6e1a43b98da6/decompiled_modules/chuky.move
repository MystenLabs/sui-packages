module 0xa014ea2b558fcc11e8fcc90636e3248bc72aba42030d57d0d19f6e1a43b98da6::chuky {
    struct CHUKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHUKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHUKY>(arg0, 6, b"CHUKY", b"Chuky on Sui", b"$CHUKY is a cute little dog token on sui blockchain, full of ingenuity and magic. Small in size but with great strength, this smart dog is ready for adventure in the Sui Ocean. Bring CHUKY into your collection, enjoy the most charming Sui companion", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000001504_cb27ffcc4a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHUKY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHUKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

