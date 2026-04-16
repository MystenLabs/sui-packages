module 0xe7af593f76b8fdac6f085c90c0803520e0d52d1b54358d67a6f1f99aee52dcd5::will_claude_4pt7_be_released_on_april_26_2026_no {
    struct WILL_CLAUDE_4PT7_BE_RELEASED_ON_APRIL_26_2026_NO has drop {
        dummy_field: bool,
    }

    fun init(arg0: WILL_CLAUDE_4PT7_BE_RELEASED_ON_APRIL_26_2026_NO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WILL_CLAUDE_4PT7_BE_RELEASED_ON_APRIL_26_2026_NO>(arg0, 0, b"WILL_CLAUDE_4PT7_BE_RELEASED_ON_APRIL_26_2026_NO", b"WILL_CLAUDE_4PT7_BE_RELEASED_ON_APRIL_26_2026 NO", b"WILL_CLAUDE_4PT7_BE_RELEASED_ON_APRIL_26_2026 NO position", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WILL_CLAUDE_4PT7_BE_RELEASED_ON_APRIL_26_2026_NO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WILL_CLAUDE_4PT7_BE_RELEASED_ON_APRIL_26_2026_NO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

