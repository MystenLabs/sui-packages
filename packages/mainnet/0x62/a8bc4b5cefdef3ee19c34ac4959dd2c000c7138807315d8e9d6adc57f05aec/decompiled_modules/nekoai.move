module 0x62a8bc4b5cefdef3ee19c34ac4959dd2c000c7138807315d8e9d6adc57f05aec::nekoai {
    struct NEKOAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEKOAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<NEKOAI>(arg0, 6, b"NEKOAI", b"NEKOCHAIN AI by SuiAI", b"NEKO embodies the spirit of innovation, bridging the gap between AI, blockchain, and immersive gaming. It empowers a vibrant and inclusive digital economy, transforming how users interact with decentralized technologies..", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/neko_697d7b49ab.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<NEKOAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEKOAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

