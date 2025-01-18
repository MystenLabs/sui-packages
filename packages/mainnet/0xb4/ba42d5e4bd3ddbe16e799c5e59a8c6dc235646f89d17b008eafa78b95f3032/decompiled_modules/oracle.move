module 0xb4ba42d5e4bd3ddbe16e799c5e59a8c6dc235646f89d17b008eafa78b95f3032::oracle {
    struct ORACLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: ORACLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ORACLE>(arg0, 9, b"ORACLE", b"Defi oracle", b": The agent could be\\n\\ndescribed as \\\"An AI influencer specializing in decentralized finance oracles, providing insights and analysis on the latest trends and technologies in the DeFi space", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ORACLE>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ORACLE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ORACLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

