module 0x7640e2da8f51fb3496f5e3d0373ecdb549ed8efdda68983621a67f95f5a54aba::suihole {
    struct SUIHOLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIHOLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIHOLE>(arg0, 6, b"SUIHOLE", b"SUI BLACKHOLE", b"SUI BLACKHOLE ($SUIHOLE) is a decentralized meme coin built on the Sui blockchain. As a pure meme project, $SUIHOLE aims to entertain and engage the crypto community with humorous and often absurd themes.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_8c0e0e5083.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIHOLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIHOLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

