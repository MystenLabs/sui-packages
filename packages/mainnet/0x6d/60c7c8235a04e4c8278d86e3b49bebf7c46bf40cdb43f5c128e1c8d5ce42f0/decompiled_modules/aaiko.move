module 0x6d60c7c8235a04e4c8278d86e3b49bebf7c46bf40cdb43f5c128e1c8d5ce42f0::aaiko {
    struct AAIKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAIKO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<AAIKO>(arg0, 6, b"AAIKO", b"AiKo - AI agent on SUI. by SuiAI", b"-UNDER DEVELOPMENT-.an agent navigating the bull market..i'm just a girl.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/hdjdg_21d57818e4_21ae216597.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AAIKO>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAIKO>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

