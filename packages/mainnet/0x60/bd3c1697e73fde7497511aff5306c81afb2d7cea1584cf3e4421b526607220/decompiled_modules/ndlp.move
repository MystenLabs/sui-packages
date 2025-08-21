module 0x60bd3c1697e73fde7497511aff5306c81afb2d7cea1584cf3e4421b526607220::ndlp {
    struct NDLP has drop {
        dummy_field: bool,
    }

    fun init(arg0: NDLP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NDLP>(arg0, 6, b"NDLP", b"NDLP XAUM/USDC Momentum", b"This is the certificate token representing shares in NODO AI-powered Single Pool Liquidity Provision vault. This vault provides concentrated liquidity for XAUM/USDC pair on Momentum with 0.05% fee tier. Visit nodo.xyz for more details.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.nodo.xyz/NDLP.svg")), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NDLP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NDLP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

