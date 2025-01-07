module 0x1f7a765f56729b382a9619a21d4bd904ed0d600de805c748435c300a61345b12::babyponke {
    struct BABYPONKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABYPONKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABYPONKE>(arg0, 6, b"BabyPonke", b"Baby Ponke", b"Baby Ponke on Sui is a playful and community-driven token that brings the fun and excitement of the original Ponke meme to the Sui blockchain. Join the Ponke army and be part of a growing ecosystem of meme coins and NFTs.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_7047_d2acc49a90.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABYPONKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BABYPONKE>>(v1);
    }

    // decompiled from Move bytecode v6
}

