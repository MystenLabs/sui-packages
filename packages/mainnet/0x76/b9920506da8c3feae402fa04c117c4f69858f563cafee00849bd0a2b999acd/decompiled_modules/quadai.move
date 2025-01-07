module 0x76b9920506da8c3feae402fa04c117c4f69858f563cafee00849bd0a2b999acd::quadai {
    struct QUADAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: QUADAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<QUADAI>(arg0, 6, b"QuadAI", b"QuadAI on Sui", b"A functional, modern and automated approach to trading on-chain utilizing millions of data points. Every trade optimized", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_12_16_39_53_2bb06432c8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QUADAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<QUADAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

