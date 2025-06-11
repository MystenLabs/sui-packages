module 0xbb5ce634afb609cbabd70e73d57531436c410de26bc21d7806c00f942df88142::ndlp {
    struct NDLP has drop {
        dummy_field: bool,
    }

    fun init(arg0: NDLP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<NDLP>(arg0, 6, b"NDLP", b"NDLP WAL/SUI Momentum", b"This is the certificate token representing shares in NODO AI-powered Single Pool Liquidity Provision vault. This vault provides concentrated liquidity for WAL/SUI pair on Momentum with 0.20% fee tier. Visit nodo.xyz for more details.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://images.nodo.xyz/NDLP.svg"))), true, arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NDLP>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NDLP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<NDLP>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

