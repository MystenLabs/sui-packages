module 0x45b6393f421ee5d9eb22243754d88989767f6a47d1aafd215fe001b8f590181e::nekochainai {
    struct NEKOCHAINAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEKOCHAINAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<NEKOCHAINAI>(arg0, 6, b"NEKOCHAINAI", b"NEKOCHAIN AI by SuiAI", b"NEKO embodies the spirit of innovation, bridging the gap between AI, blockchain, and immersive gaming. It empowers a vibrant and inclusive digital economy, transforming how users interact with decentralized technologies.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/4dc21fbd405fedbdd678ac43a36d7004_2347b564b6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<NEKOCHAINAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEKOCHAINAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

