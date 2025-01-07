module 0xb5c52fa1cb30423a03f2abddc267e2458d5e011e2927ee7055f40ed7d08a9743::suiai {
    struct SUIAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIAI>(arg0, 6, b"SuiAI", b"Sui AI", b"SuiAI.fun is a launchpad for autonomous AI agents built on the Sui blockchain. It serves as a central platform that allows creators to deploy AI agents on-chain in just seconds. The platform provides users with the ability to discover, co-own, and interact with these agents, supporting the growth of AI applications and promoting a more accessible and collaborative environment within the ecosystem.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suag_logo_cdbe159638.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

