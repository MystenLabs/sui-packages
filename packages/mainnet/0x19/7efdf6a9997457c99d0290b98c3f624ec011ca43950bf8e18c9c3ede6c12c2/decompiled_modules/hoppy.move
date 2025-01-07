module 0x197efdf6a9997457c99d0290b98c3f624ec011ca43950bf8e18c9c3ede6c12c2::hoppy {
    struct HOPPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOPPY>(arg0, 6, b"HOPPY", b"Hoppy The Rabbit", x"48617070792024484f50505920526162626974206f6e205355492c200a43726561746520676f6f6420766962657320616e64206e6f6e73746f7020686f7070696e67", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/R34_S_KQ_400x400_db15ad247e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOPPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HOPPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

