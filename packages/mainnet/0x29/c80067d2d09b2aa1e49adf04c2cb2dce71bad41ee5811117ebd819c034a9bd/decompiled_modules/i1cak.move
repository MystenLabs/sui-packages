module 0x29c80067d2d09b2aa1e49adf04c2cb2dce71bad41ee5811117ebd819c034a9bd::i1cak {
    struct I1CAK has drop {
        dummy_field: bool,
    }

    fun init(arg0: I1CAK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<I1CAK>(arg0, 9, b"I1CAK", b"1Cak.com", b"Legendary meme sites", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c5d07f4d-ffdc-44fb-93a9-a04631a12d34.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<I1CAK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<I1CAK>>(v1);
    }

    // decompiled from Move bytecode v6
}

