module 0x4cbbc4dc4dee9535fd5d149cef79440f2b8cbf7ce971ead49922318583bf4a6d::squi {
    struct SQUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SQUI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SQUI>(arg0, 6, b"SQUI", b"Square Head by SuiAI", b"SQUI is a ONE AIAgent of the Square Head NFT Collection", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Square_Head_20_1016a27c21.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SQUI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SQUI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

