module 0x8b351c79ea20bd71ccb93fc00c25f6fdba387963c778d7442e62885dc5a6a509::horke {
    struct HORKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: HORKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HORKE>(arg0, 6, b"HORKE", b"Horke", b"bringing the spirit of laughter and togetherness to the crypto world. Powered by Sui's fast and efficient technology, Horke offers a fun experience while providing opportunities to grow alongside its community.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20250101_191238_43aca1977f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HORKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HORKE>>(v1);
    }

    // decompiled from Move bytecode v6
}

