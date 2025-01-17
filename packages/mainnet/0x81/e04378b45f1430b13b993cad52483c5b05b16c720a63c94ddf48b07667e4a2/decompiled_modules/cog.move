module 0x81e04378b45f1430b13b993cad52483c5b05b16c720a63c94ddf48b07667e4a2::cog {
    struct COG has drop {
        dummy_field: bool,
    }

    fun init(arg0: COG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COG>(arg0, 6, b"COG", b"Cognitio IA", b"Cognitio: The Cognitive Decentralized Platform for Human-AI Collaboration. Cognitio is a cutting-edge decentralized platform that aims to revolutionize the way humans and artificial intelligence collaborate.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1737111562911.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

