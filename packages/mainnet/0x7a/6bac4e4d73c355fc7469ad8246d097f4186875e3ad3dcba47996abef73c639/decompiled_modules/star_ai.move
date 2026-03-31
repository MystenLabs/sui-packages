module 0x7a6bac4e4d73c355fc7469ad8246d097f4186875e3ad3dcba47996abef73c639::star_ai {
    struct STAR_AI has drop {
        dummy_field: bool,
    }

    fun init(arg0: STAR_AI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STAR_AI>(arg0, 6, b"STAR AI", b"Star Ai Coin", b" ", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<STAR_AI>(&mut v2, 10000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<STAR_AI>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<STAR_AI>>(v2);
    }

    // decompiled from Move bytecode v6
}

