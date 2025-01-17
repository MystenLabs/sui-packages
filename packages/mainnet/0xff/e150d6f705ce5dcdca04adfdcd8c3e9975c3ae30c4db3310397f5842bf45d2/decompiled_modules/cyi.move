module 0xffe150d6f705ce5dcdca04adfdcd8c3e9975c3ae30c4db3310397f5842bf45d2::cyi {
    struct CYI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CYI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<CYI>(arg0, 6, b"CYI", b"CYI_Agent by SuiAI", b"The CYI token is the first DeFi-focused token, specifically designed to support the continuous training of the AI agent using curated DeFi and yield farming data, updated daily for optimal performance and insights", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/IMG_6864_8e10c7e18a.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CYI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CYI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

