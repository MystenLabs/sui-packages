module 0xf097dd0ea8ad34b6e4174092160ec16549f1b29cd53d676df325955c185ae8d1::aisui {
    struct AISUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: AISUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AISUI>(arg0, 6, b"AISUI", b"Artificial Sui", b"Artificial Sui could be an innovative cryptocurrency that leverages AI-driven liquidity mechanisms and decentralized governance. Built on the foundation of intelligent automation, it could redefine how transactions occur in blockchain ecosystems.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1749649333896.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AISUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AISUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

