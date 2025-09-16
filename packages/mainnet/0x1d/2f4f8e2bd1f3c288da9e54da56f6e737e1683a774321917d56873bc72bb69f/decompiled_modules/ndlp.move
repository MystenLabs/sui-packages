module 0x1d2f4f8e2bd1f3c288da9e54da56f6e737e1683a774321917d56873bc72bb69f::ndlp {
    struct NDLP has drop {
        dummy_field: bool,
    }

    fun init(arg0: NDLP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NDLP>(arg0, 8, b"tNDLP", b"Test NDLP LBTC/wBTC Momentum", b"This is the TEST certificate token representing shares in NODO Testing Vault. This vault provides concentrated liquidity for LBTC/wBTC pair on Momentum with 0.01% fee tier. Visit nodo.xyz for more details.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.nodo.xyz/NDLP.svg")), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NDLP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NDLP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

