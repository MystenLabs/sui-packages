module 0x71c3fa202af882458b1812a83b847fcfc0d05268046a65e76d6f10dea0207ed9::desciai {
    struct DESCIAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DESCIAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<DESCIAI>(arg0, 6, b"DESCIAI", b"DeSci AI Agent by SuiAI", b"DeSci Al Agent represents the future of decentralized scientific communication, where artificial intelligence becomes a key player in spreading knowledge about the latest advancements in biotech, genomics, and more.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/De_Sci_AI_d350101f66.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DESCIAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DESCIAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

