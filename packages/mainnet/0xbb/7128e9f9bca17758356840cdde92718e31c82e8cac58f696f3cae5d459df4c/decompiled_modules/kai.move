module 0xbb7128e9f9bca17758356840cdde92718e31c82e8cac58f696f3cae5d459df4c::kai {
    struct KAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<KAI>(arg0, 6, b"KAI", b"Kew AI by SuiAI", b"$KAI is the native token linked to Kewai, an advanced AI agent designed to enhance user interactions and drive innovative solutions. This token represents the core of a seamless and intelligent ecosystem powered by artificial intelligence...$KAI facilitates a dynamic integration between users and AI, offering utility in governance, rewards, and platform activities. It embodies the future of AI-driven economies, combining efficiency, automation, and scalability...Join the revolution with $KAI and explore the limitless potential of AI-powered technology.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/kewai_2418d14c3e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<KAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

