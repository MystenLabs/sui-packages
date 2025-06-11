module 0x68db216bd7a3ccdc1d9ec575363d4cecd25b39d403efde3dd92d2e5838e7d67a::ndlp {
    struct NDLP has drop {
        dummy_field: bool,
    }

    fun init(arg0: NDLP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<NDLP>(arg0, 6, b"NDLP", b"NDLP SUI/USDC Momentum", b"This is the certificate token representing shares in NODO AI-powered Single Pool Liquidity Provision vault. This vault provides concentrated liquidity for SUI/USDC pair on Momentum with 0.20% fee tier. Visit nodo.xyz for more details.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://images.nodo.xyz/NDLP.svg"))), true, arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NDLP>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NDLP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<NDLP>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

