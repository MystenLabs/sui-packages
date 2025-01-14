module 0xafec363b059ea455e2e88c3b0ebd907509252d39a65913bc17acf43a4a92fe4::suitube {
    struct SUITUBE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITUBE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SUITUBE>(arg0, 6, b"SUITUBE", b"SuiTube by SuiAI", b"The first AI-powered YouTube fork on the Sui blockchain! SuiTube curates the best Sui-related videos using advanced AI, reshares them with proper attribution, and rewards creators through decentralized monetization. Built for scalability, transparency, and community engagement, SuiTube combines cutting-edge AI with blockchain innovation to deliver the ultimate video experience for the Sui ecosystem.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Diseno_sin_titulo_2025_01_14_T185728_383_7237215a81.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUITUBE>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITUBE>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

