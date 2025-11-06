module 0xc47195d8403a1ec0be2ecf854b83f0a5bc931354492a537893c7fbd95f717677::ndlp {
    struct NDLP has drop {
        dummy_field: bool,
    }

    fun init(arg0: NDLP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NDLP>(arg0, 9, b"tNDLP", b"Test NDLP SUI/MMT Momentum", b"This is the TEST certificate token representing shares in NODO Testing Vault. This vault provides concentrated liquidity for SUI/MMT pair on Momentum with 0.25% fee tier. Visit nodo.xyz for more details.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.nodo.xyz/NDLP.svg")), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NDLP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NDLP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

