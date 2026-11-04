module 0x65a4bae2fc008492a6d7990f95bdf8a603285b1a616c725afea4f6204e0f88ec::will_the_us_invade_iran_before_2027_yes {
    struct WILL_THE_US_INVADE_IRAN_BEFORE_2027_YES has drop {
        dummy_field: bool,
    }

    fun init(arg0: WILL_THE_US_INVADE_IRAN_BEFORE_2027_YES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WILL_THE_US_INVADE_IRAN_BEFORE_2027_YES>(arg0, 0, b"WILL_THE_US_INVADE_IRAN_BEFORE_2027_YES", b"WILL_THE_US_INVADE_IRAN_BEFORE_2027 YES", b"WILL_THE_US_INVADE_IRAN_BEFORE_2027 YES position", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WILL_THE_US_INVADE_IRAN_BEFORE_2027_YES>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WILL_THE_US_INVADE_IRAN_BEFORE_2027_YES>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

