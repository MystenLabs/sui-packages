module 0xb0e8012ae7c29eeaaf7409e45d31a2404e9d3a68c61d2c5bb3b236e1fd2e4855::nexai {
    struct NEXAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEXAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<NEXAI>(arg0, 6, b"NEXAI", b"NEXORA AI  by SuiAI", b"NEXAI is a smart and intuitive AI assistant designed to help X users dive into the world of the Sui Network. With her approachable demeanor and expertise in blockchain technologies, NEXAI walks users through the Sui ecosystem, offering clear explanations of key features like scalability, transaction speeds, and the", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/nezopra_5f993f22b3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<NEXAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEXAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

