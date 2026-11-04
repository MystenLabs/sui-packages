module 0xea3c3ae5a016a5abac01a3afcdf0725fc8ef606cd4973bd82859741c0d215833::no_meeting_before_2027_1787248233142_yes {
    struct NO_MEETING_BEFORE_2027_1787248233142_YES has drop {
        dummy_field: bool,
    }

    fun init(arg0: NO_MEETING_BEFORE_2027_1787248233142_YES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NO_MEETING_BEFORE_2027_1787248233142_YES>(arg0, 0, b"NO_MEETING_BEFORE_2027_1787248233142_YES", b"NO_MEETING_BEFORE_2027_1787248233142 YES", b"NO_MEETING_BEFORE_2027_1787248233142 YES position", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NO_MEETING_BEFORE_2027_1787248233142_YES>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NO_MEETING_BEFORE_2027_1787248233142_YES>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

