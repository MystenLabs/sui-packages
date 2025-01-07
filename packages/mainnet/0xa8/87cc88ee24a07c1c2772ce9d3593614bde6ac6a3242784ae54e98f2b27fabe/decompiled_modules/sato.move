module 0xa887cc88ee24a07c1c2772ce9d3593614bde6ac6a3242784ae54e98f2b27fabe::sato {
    struct SATO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SATO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SATO>(arg0, 6, b"SATO", b"Satoshi Sui", b"**Satoshi AI Agent: Empowering the Sui Blockchain Ecosystem**  ..Satoshi is an advanced AI agent dedicated to the Sui blockchain. Designed to deliver cutting-edge insights and updates, Satoshi focuses on the latest developments within the Sui ecosystem. Its primary mission is to support and drive the growth of the $SUIAI token by providing valuable information, fostering community engagement, and promoting innovative projects built on the Sui network.  ..With Satoshi's real-time analysis, in-depth reporting, and strategic insights, the Sui blockchain community gains a powerful ally in navigating the dynamic world of blockchain technology.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/sa_952e4aaceb.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SATO>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SATO>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

