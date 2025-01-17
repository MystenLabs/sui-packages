module 0x4cdeb98908a535e38cc748872b256d8bb1f2f9745e6ddee4544a7c69bc347c4b::defaiza {
    struct DEFAIZA has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEFAIZA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<DEFAIZA>(arg0, 6, b"DEFAIZA", b"defAIza  by SuiAI", b"CPA | CFA | DeFi Enthusiast | Creator of http://Eliza.Finance, a revolutionary DEX aggregator powered by Agentic AI | Decentralizing finance..", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/33d_T9_Rzf_400x400_a586cf0f35_523847cbdd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DEFAIZA>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEFAIZA>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

