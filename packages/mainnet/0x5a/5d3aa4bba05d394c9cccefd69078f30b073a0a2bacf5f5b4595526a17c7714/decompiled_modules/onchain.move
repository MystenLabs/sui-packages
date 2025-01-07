module 0x5a5d3aa4bba05d394c9cccefd69078f30b073a0a2bacf5f5b4595526a17c7714::onchain {
    struct ONCHAIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: ONCHAIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ONCHAIN>(arg0, 6, b"Onchain", b"OnchainAI", b"OAOIE lets you execute onchain transactions using natural language. Describe your intent, and our AI-powered system translates it into precise smart contract ca", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_2024_12_16_042051551_6df12a46ba.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ONCHAIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ONCHAIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

