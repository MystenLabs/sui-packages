module 0x1f51d62a13c89299aef96eca9ac76d83fb8a57151ae6266433ce411e1fcc4f86::horke {
    struct HORKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: HORKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HORKE>(arg0, 6, b"HORKE", b"Horke", b"Horke is an exciting memecoin built on the Sui blockchain ecosystem, bringing the spirit of laughter and togetherness to the crypto world. Powered by Sui's fast and efficient technology, Horke offers a fun experience while providing opportunities to grow alongside its community. Horke isnt just about memes and entertainment; its about creating a strong community where everyone feels involved. Get ready to explore the potential of crypto in a unique and humorous way! Its slogan: \"Laugh, Hold, and Grow  Horke Your Way to the Moon!\"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20250101_191238_126cf79594.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HORKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HORKE>>(v1);
    }

    // decompiled from Move bytecode v6
}

