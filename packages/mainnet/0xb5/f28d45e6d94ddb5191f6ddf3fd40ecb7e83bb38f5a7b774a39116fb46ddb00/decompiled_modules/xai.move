module 0xb5f28d45e6d94ddb5191f6ddf3fd40ecb7e83bb38f5a7b774a39116fb46ddb00::xai {
    struct XAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: XAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XAI>(arg0, 6, b"XAI", b"Fhenix AI", b"Fhenix AI is a cutting-edge decentralized intelligence platform that merges the power of autonomous AI agents with the transparency and security of blockchain technology", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreih53crj4svbwkj5gsduufbsy5h5gpcbnvzbbghmwcfahspedkjh4i")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<XAI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

