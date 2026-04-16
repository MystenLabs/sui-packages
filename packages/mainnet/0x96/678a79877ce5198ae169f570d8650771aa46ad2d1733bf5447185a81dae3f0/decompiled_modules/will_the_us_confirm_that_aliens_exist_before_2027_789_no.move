module 0x96678a79877ce5198ae169f570d8650771aa46ad2d1733bf5447185a81dae3f0::will_the_us_confirm_that_aliens_exist_before_2027_789_no {
    struct WILL_THE_US_CONFIRM_THAT_ALIENS_EXIST_BEFORE_2027_789_NO has drop {
        dummy_field: bool,
    }

    fun init(arg0: WILL_THE_US_CONFIRM_THAT_ALIENS_EXIST_BEFORE_2027_789_NO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WILL_THE_US_CONFIRM_THAT_ALIENS_EXIST_BEFORE_2027_789_NO>(arg0, 0, b"WILL_THE_US_CONFIRM_THAT_ALIENS_EXIST_BEFORE_2027_789_NO", b"WILL_THE_US_CONFIRM_THAT_ALIENS_EXIST_BEFORE_2027_789 NO", b"WILL_THE_US_CONFIRM_THAT_ALIENS_EXIST_BEFORE_2027_789 NO position", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WILL_THE_US_CONFIRM_THAT_ALIENS_EXIST_BEFORE_2027_789_NO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WILL_THE_US_CONFIRM_THAT_ALIENS_EXIST_BEFORE_2027_789_NO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

