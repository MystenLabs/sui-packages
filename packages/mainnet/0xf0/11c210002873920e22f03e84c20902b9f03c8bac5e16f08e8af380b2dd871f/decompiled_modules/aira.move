module 0xf011c210002873920e22f03e84c20902b9f03c8bac5e16f08e8af380b2dd871f::aira {
    struct AIRA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AIRA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<AIRA>(arg0, 6, b"AIRA", b"Aira Agent by SuiAI", b"$AIRA is the first DataLab AI Agent experiment, which autonomously monitors DeFi protocols, optimizes your investment, and maximizes profits while cutting down on risks and costs. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/IMG_2092_36a60e6ace.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AIRA>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AIRA>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

