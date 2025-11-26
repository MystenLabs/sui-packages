module 0x65659705a3d0b3b4397cd8fa0a63c19341791a7522f878d5f7935009c5b71ec0::yus {
    struct YUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: YUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YUS>(arg0, 9, b"yUS", b"yUS", b"This is the certificate token representing shares in NODO AI-powered Single Pool Liquidity Provision vault. This vault provides concentrated liquidity for US/USDC pair on Momentum with 0.25% fee tier. Visit nodo.xyz for more details.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.nodo.xyz/yus.png")), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YUS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YUS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

