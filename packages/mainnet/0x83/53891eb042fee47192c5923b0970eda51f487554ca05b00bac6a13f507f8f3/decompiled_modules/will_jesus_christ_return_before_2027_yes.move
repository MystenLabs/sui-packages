module 0x8353891eb042fee47192c5923b0970eda51f487554ca05b00bac6a13f507f8f3::will_jesus_christ_return_before_2027_yes {
    struct WILL_JESUS_CHRIST_RETURN_BEFORE_2027_YES has drop {
        dummy_field: bool,
    }

    fun init(arg0: WILL_JESUS_CHRIST_RETURN_BEFORE_2027_YES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WILL_JESUS_CHRIST_RETURN_BEFORE_2027_YES>(arg0, 0, b"WILL_JESUS_CHRIST_RETURN_BEFORE_2027_YES", b"WILL_JESUS_CHRIST_RETURN_BEFORE_2027 YES", b"WILL_JESUS_CHRIST_RETURN_BEFORE_2027 YES position", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WILL_JESUS_CHRIST_RETURN_BEFORE_2027_YES>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WILL_JESUS_CHRIST_RETURN_BEFORE_2027_YES>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

