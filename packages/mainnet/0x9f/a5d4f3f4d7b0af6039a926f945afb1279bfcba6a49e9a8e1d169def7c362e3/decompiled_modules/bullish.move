module 0x9fa5d4f3f4d7b0af6039a926f945afb1279bfcba6a49e9a8e1d169def7c362e3::bullish {
    struct BULLISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: BULLISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BULLISH>(arg0, 6, b"Bullish", b"Octobull on sui", b"Octobull, a unique token on Sui network, gained popularity due to its community-driven nature and potential for growth. Its price fluctuated with market trends, but the community remained supportive. The future of Octobull remains uncertain, but its impact on Sui is undeniable.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1359_3a97c35dea.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BULLISH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BULLISH>>(v1);
    }

    // decompiled from Move bytecode v6
}

