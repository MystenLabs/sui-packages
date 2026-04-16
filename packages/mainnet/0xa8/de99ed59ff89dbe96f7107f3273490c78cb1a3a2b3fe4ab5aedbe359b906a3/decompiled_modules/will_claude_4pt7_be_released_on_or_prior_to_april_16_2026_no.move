module 0xa8de99ed59ff89dbe96f7107f3273490c78cb1a3a2b3fe4ab5aedbe359b906a3::will_claude_4pt7_be_released_on_or_prior_to_april_16_2026_no {
    struct WILL_CLAUDE_4PT7_BE_RELEASED_ON_OR_PRIOR_TO_APRIL_16_2026_NO has drop {
        dummy_field: bool,
    }

    fun init(arg0: WILL_CLAUDE_4PT7_BE_RELEASED_ON_OR_PRIOR_TO_APRIL_16_2026_NO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WILL_CLAUDE_4PT7_BE_RELEASED_ON_OR_PRIOR_TO_APRIL_16_2026_NO>(arg0, 0, b"WILL_CLAUDE_4PT7_BE_RELEASED_ON_OR_PRIOR_TO_APRIL_16_2026_NO", b"WILL_CLAUDE_4PT7_BE_RELEASED_ON_OR_PRIOR_TO_APRIL_16_2026 NO", b"WILL_CLAUDE_4PT7_BE_RELEASED_ON_OR_PRIOR_TO_APRIL_16_2026 NO position", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WILL_CLAUDE_4PT7_BE_RELEASED_ON_OR_PRIOR_TO_APRIL_16_2026_NO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WILL_CLAUDE_4PT7_BE_RELEASED_ON_OR_PRIOR_TO_APRIL_16_2026_NO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

