module 0xe3cb361069159b136d654d62d8b844dfbea0549f7b824a43d0d66983bf5aa27b::ash {
    struct ASH has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASH>(arg0, 6, b"ASH", b"ASH ON SUI", b"ASH ON SUI WILL BE THE ICONIC POKEMON MEME TOKEN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_6765_83df7b467f.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ASH>>(v1);
    }

    // decompiled from Move bytecode v6
}

