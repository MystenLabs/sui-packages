module 0xa99b8952d4f7d947ea77fe0ecdcc9e5fc0bcab2841d6e2a5aa00c3044e5544b5::navx {
    struct NAVX has drop {
        dummy_field: bool,
    }

    fun init(arg0: NAVX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NAVX>(arg0, 9, b"NAVX", b"NAVX Token", b"One-stop Liquidity Protocol on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://arweave.net/FNGKLRGBS7D4lXxsmz4_F-xkMQs9DIRsTQT_q0Nn-iI")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NAVX>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NAVX>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

