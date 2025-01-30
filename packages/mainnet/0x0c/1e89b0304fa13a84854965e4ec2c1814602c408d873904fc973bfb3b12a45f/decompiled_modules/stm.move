module 0xc1e89b0304fa13a84854965e4ec2c1814602c408d873904fc973bfb3b12a45f::stm {
    struct STM has drop {
        dummy_field: bool,
    }

    fun init(arg0: STM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STM>(arg0, 6, b"Stm", b"Suitom", b"Suitom is the new token that promises to shake up the cryptocurrency market. With a dedicated community, Suitom is ready to soar. Suitom is based on an ultra-fast, scalable blockchain, enabling near-instan. Lead by the community.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_2663_19c21a5486.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STM>>(v1);
    }

    // decompiled from Move bytecode v6
}

